package Getopt::ArgParse::Parser;

use Moo;

use Getopt::Long qw(GetOptionsFromArray);
use Text::Wrap;
use Scalar::Util qw(blessed);

use File::Basename ();
use Getopt::ArgParse::Namespace;

use constant {
    TYPE_UNDEF  => 0,
    TYPE_SCALAR => 1,
    TYPE_ARRAY  => 2,
    TYPE_COUNT  => 3,
    TYPE_PAIR	=> 4, # key=value pair
    TYPE_BOOL	=> 5,

    CONST_TRUE   => 1,
    CONST_FALSE  => 0,

    # Export these?
	ScalarArg => 'scalar',
	ArrayArg  => 'Array',
    PairArg   => 'Pair',
    CountArg  => 'Count',
    BoolArg   => 'Bool',

	# Internal
    ERROR_PREFIX => 'Getopt::ArgParse: ',
    PRINT_REQUIRED => 1,
    PRINT_OPTIONAL => 2,
};

# Allow customization
# default actions
my %Action2ClassMap = (
	'_store'       => 'Getopt::ArgParse::ActionStore',
    '_append'      => 'Getopt::ArgParse::ActionAppend',
    '_count'       => 'Getopt::ArgParse::ActionCount',
    # Not supported - Maybe in the future
    # '_help'        => 'Getopt::ArgParse::ActionHelp',
    # '_version'     => 'Getopt::ArgParse::ActionVersion',
);

my %Type2ConstMap = (
    ''        => TYPE_UNDEF(),
    'Scalar'  => TYPE_SCALAR(),
    'Array'   => TYPE_ARRAY(),
	'Count'   => TYPE_COUNT(),
    'Pair'    => TYPE_PAIR(),
    'Bool'    => TYPE_BOOL(),
);


sub _croak {
    die join('', @_, "\n");
}

# Program name. Default $0

has prog         => ( is => 'rw', required => 1, default => sub { File::Basename::basename($0) }, );

# short one
has help         => ( is => 'rw', required => 1, default => sub { '' }, );

# long one
has description  => ( is => 'rw', required => 1, default => sub { '' }, );

has epilog       => ( is => 'rw', required => 1, default => sub { '' }, );

has error_prefix => (is => 'rw', default => sub { ERROR_PREFIX() }, );

has aliases      => (is => 'ro', default => sub { [] }); # for subcommand only

# namespace() - Read/write
# Contains the parsed results.
has namespace => (
    is => 'rw',
    isa => sub {
        return undef unless $_[0]; # allow undef
        my $class = blessed $_[0];
        die 'namespace doesn\'t comform to the required interface'
            unless $class && $class->can('set_attr') && $class->can('get_attr');
    },
);

# parent - Readonly
has parents => (
    is => 'ro',
    isa => sub {
        my $parents = shift;
        for my $parent (@$parents) {
            my $parent_class = blessed $parent;
            die 'parent is not a Getopt::ArgParse::Parser'
                unless $parent_class && $parent_class->isa(__PACKAGE__);
        }
    },
    default => sub { [] },
);

# parser_configs - Read/write

# The configurations that will be passed to Getopt::Long::Configure(
# $self->parser_configs ) when parse_args is invoked.
has parser_configs => ( is => 'rw', required => 1, default => sub { [] }, );

# Behavioural properties
#
# Print usage message if help is no, by default. Turn this off by
# setting this to a false value
has print_usage_if_help => (is => 'ro', default => 1);

# internal properties

has _option_position => ( is => 'rw', required => 1, default => sub { 0 } );

# The current subcommand the same as namespace->current_command
has _command => ( is => 'rw');

# Sortby parameter.  Used to determine if sorting by 'position' or by 'name'
has sortby => ( 
        is => 'rw', 
        isa => sub {
            die "$_[0] is not valid: valid options are: name, position" unless ($_[0] eq 'position' or $_[0] eq 'name');
        },
        default => $_[0] || 'position'
);

sub BUILD {
    my $self = shift;

    $self->{-option_specs} = {};
    $self->{-position_specs} = {};

    $self->add_argument(
        '--help', '-h',
        type  => 'Bool',
        dest  => 'help',
        help  => 'show this help message and exit',
        reset => 1,
    );

    # merge
    for my $parent (@{$self->parents}) {
        $self->copy($parent);
    }
}

#
sub _check_parent {
    my $parent = shift;
    my $parent_class = blessed $parent;
    _croak 'Parent is not a Getopt::ArgParse::Parser'
        unless $parent_class && $parent_class->isa(__PACKAGE__);
}

sub copy {
    my $self = shift;
    my $parent = shift;

    _croak 'Parent is missing' unless $parent;
    _check_parent($parent);

    $self->copy_args($parent);
    $self->copy_parsers($parent);
}

sub copy_args {
    my $self = shift;
    my $parent = shift;

    _croak 'Parent is missing' unless $parent;
    _check_parent($parent);

    $self->add_arguments( @{ $parent->{-pristine_add_arguments} } );
}

sub copy_parsers {
    my $self = shift;
    my $parent = shift;

    _croak 'Parent is missing' unless $parent;
    _check_parent($parent);

    if (exists $parent->{-subparsers}) {
        $self->add_subparsers(
            @{$parent->{-pristine_add_subparsers}->[0]}
        );

        for my $args (@{$parent->{-pristine_add_parser}}) {
            my $command = $args->[0];
            next if $command eq 'help';
            $self->add_parser(
                @$args,
               parents => [ $parent->{-subparsers}{-parsers}{$command} ],
            );
        }
    }
}

#
# subcommands
#
sub add_subparsers {
    my $self = shift;

    push @{$self->{-pristine_add_subparsers}}, [ @_ ];

    _croak $self->error_prefix .  'Incorrect number of arguments' if scalar(@_) % 2;

    my $args = { @_ };

    my $title       = (delete $args->{title} || 'subcommands') . ':';
    my $description = delete $args->{description} || '';

    _croak $self->error_prefix . sprintf(
        'Unknown parameters: %s',
        join(',', keys %$args)
    ) if keys %$args;

    if (exists  $self->{-subparsers}) {
        _croak $self->error_prefix . 'Subparsers already added';
    }

    $self->{-subparsers}{-title} = $title;
    $self->{-subparsers}{-description} = $description;
    $self->{-subparsers}{-alias_map} = {};

    my $hp = $self->add_parser(
        'help',
        help => 'display help information about ' . $self->prog,
    );

    $hp->add_arguments(
        [
            '--all', '-a',
            help => 'Show the full usage',
            type => 'Bool',
        ],
        [
            'command',
            help  => 'Show the usage for this command',
            dest  => 'help_command',
            nargs => 1,
        ],
    );

    return $self;
}

# $command, aliases => [], help => ''
sub add_parser {
    my $self = shift;

    _croak $self->error_prefix . 'add_subparsers() is not called first' unless $self->{-subparsers};

    my $command = shift;

    _croak $self->error_prefix . 'Subcommand is empty' unless $command;

    _croak $self->error_prefix .  'Incorrect number of arguments' if scalar(@_) % 2;

    if (exists $self->{-subparsers}{-parsers}{$command}) {
        _croak $self->error_prefix . "Subcommand $command already defined";
    }

    my $args = { @_ };

    my $parents = delete $args->{parents} || [];
    push @{ $self->{-pristine_add_parser} }, [ $command, %$args ];

    _croak $self->error_prefix . 'Add_subparsers() is not called first' unless $self->{-subparsers};

    my $help        = delete $args->{help} || '';
    my $description = delete $args->{description} || '';
    my $aliases     = delete $args->{aliases} || [];

    _croak $self->error_prefix . 'Aliases is not an arrayref'
        if ref($aliases) ne 'ARRAY';

    _croak $self->error_prefix . sprintf(
        'Unknown parameters: %s',
        join(',', keys %$args)
    ) if keys %$args;

    my $alias_map = {};

    for my $alias ($command, @$aliases) {
        if (exists $self->{-subparsers}{-alias_map}{$alias}) {
            _croak $self->error_prefix
                . "Alias=$alias already used by command="
                . $self->{-subparsers}{-alias_map}{$alias};
        }
    }

    $self->{-subparsers}{-alias_map}{$_} = $command for ($command, @$aliases);

    my $prog = $command;

    # $prog .= ' (' . join(', ', @$aliases) . ')' if @$aliases;

    $self->{-subparsers}{-aliases}{$command} = $aliases;
    return $self->{-subparsers}{-parsers}{$command} = __PACKAGE__->new(
        prog                => $prog,
        aliases             => $aliases, # subcommand
        help                => $help,
        parents			    => $parents,
        description         => $description,
        error_prefix        => $self->error_prefix,
        print_usage_if_help => $self->print_usage_if_help,
    );
}

sub get_parser { $_[0]->_get_subcommand_parser(@_) }

*add_arg = \&add_argument;

*add_args = \&add_arguments;

# add_arguments([arg_spec], [arg_spec1], ...)
# Add multiple arguments.
# Interface method
sub add_arguments {
    my $self = shift;

    $self->add_argument(@$_) for @_;

    return $self;
}

#
sub add_argument {
    my $self = shift;

    return unless @_; # mostly harmless
    #
    # FIXME: This is for merginng parent parents This is a dirty hack
    # and should be done properly by merging internal specs
    # and subcommand merging is missing
    #
    push @{ $self->{-pristine_add_arguments} }, [ @_ ];

    my ($name, $flags, $rest) = $self->_parse_for_name_and_flags([ @_ ]);

    _croak $self->error_prefix .  'Incorrect number of arguments' if scalar(@$rest) % 2;

    _croak $self->error_prefix .  'Empty option name' unless $name;

    my $args = { @$rest };

    my @flags = @{ $flags };

    ################
    # nargs - positional only
    ################
    ################
    # type
    ################
    my $type_name = delete $args->{type} || 'Scalar';
    my $type = $Type2ConstMap{$type_name} if exists $Type2ConstMap{$type_name};
    _croak $self->error_prefix . "Unknown type=$type_name" unless defined $type;

    my $nargs = delete $args->{nargs};

    if ( defined $nargs ) {
        _croak $self->error_prefix . 'Nargs only allowed for positional options' if @flags;

        if (   $type != TYPE_PAIR
            && $type != TYPE_ARRAY
            && $nargs ne '1'
            && $nargs ne '?'
        ) {
            $type = TYPE_ARRAY;
        }
    }

    if ($type == TYPE_COUNT) {
        $args->{action} = '_count' unless defined $args->{action};
        $args->{default} = 0 unless defined $args->{default};
    } elsif ($type == TYPE_ARRAY || $type == TYPE_PAIR) {
        $args->{action} = '_append' unless defined $args->{action};
    } else {
        # pass
    }

    ################
    # action
    ################
    my $action_name = delete $args->{action} || '_store';

    my $action = $Action2ClassMap{$action_name}
        if exists $Action2ClassMap{$action_name};

    $action = $action_name unless $action;

    {
        local $SIG{__WARN__};
        local $SIG{__DIE__};

        eval "require $action";

        _croak $self->error_prefix .  "Cannot load $action for action=$action_name" if $@;
    };

    ################
    # split
    ################
    my $split = delete $args->{split};
    if (defined $split && !$split && $split =~ /^ +$/) {
        _croak $self->error_prefix .  'Cannot use whitespaces to split';
    }

    if (defined $split && $type != TYPE_ARRAY && $type != TYPE_PAIR) {
        _croak $self->error_prefix .  'Split only for Array and Pair';
    }

    ################
    # default
    ################
    my $default;
    if (exists $args->{default}) {
        my $val = delete $args->{default};

        if (ref($val) eq 'ARRAY') {
            $default = $val;
        } elsif (ref($val) eq 'HASH') {
            _croak $self->error_prefix .  'HASH default only for type Pair'
                if $type != TYPE_PAIR;
            $default = $val;
        } else {
            $default = [ $val ];
        }

        if ($type != TYPE_PAIR) {
            if ($type != TYPE_ARRAY && scalar(@$default) > 1) {
                _croak $self->error_prefix . 'Multiple default values for scalar type: $name';
            }
        }
    }

    ################
    # choices
    ################
    my $choices = delete $args->{choices} || undef;
    if (   $choices
        && ref($choices) ne 'CODE'
        && ref($choices) ne 'ARRAY' )
    {
        _croak $self->error_prefix .  "Must provide choices in an arrayref or a coderef";
    }

    my $choices_i = delete $args->{choices_i} || undef;

    if ($choices && $choices_i) {
        _croak $self->error_prefix . 'Not allow to specify choices and choices_i';
    }

    if (   $choices_i
        && ref($choices_i) ne 'ARRAY' )
    {
        _croak $self->error_prefix .  "Must provide choices_i in an arrayref";
    }

    ################
    # required
    ################
    my $required = delete $args->{required} || '';

    if ($type == TYPE_BOOL || $type == TYPE_COUNT) {
        $required = ''; # TYPE_BOOL and TYPE_COUNT will already have default values
    }

    ################
    # help
    ################
    my $help = delete $args->{help} || '';

    ################
    # metavar
    ################
    my $metavar = delete $args->{metavar} || uc($name);

    $metavar = ''
        if $type == TYPE_BOOL
            || $action_name eq '_count';

    ################
    # dest
    ################
    my $dest = delete $args->{dest} || $name;
    $dest =~ s/-/_/g; # option-name becomes option_name

    if (@flags) {
        while (my ($d, $s) = each %{$self->{-option_specs}}) {
            if ($dest ne $d) {
                for my $f (@flags) {
                   _croak $self->error_prefix .  "Flag $f already used for a different option ($d)"
                        if grep { $f eq $_ } @{$s->{flags}};
                }
            }
        }

        if (exists $self->{-position_specs}{$dest}) {
            _croak $self->error_prefix . "Option dest=$dest already used by a positional argument";
        }
    } else {
        if (exists $self->{-option_specs}{$dest}) {
            _croak $self->error_prefix . "Option dest=$dest already used by an optional argument";
        }
    }

    # never modify existing ones so that the parent's structure will
    # not be modified
    my $spec = {
        name      => $name,
        flags     => \@flags,
        action    => $action,
        nargs     => $nargs,
        split     => $split,
        required  => $required || '',
        type      => $type,
        default   => $default,
        choices   => $choices,
        choices_i => $choices_i,
        dest      => $dest,
        metavar   => $metavar,
        help      => $help,
        position  => $self->{-option_position}++, # sort order
        groups    => [ '' ],
    };

    my $specs;
    if (@flags) {
        $specs = $self->{-option_specs};
    } else {
        $specs = $self->{-position_specs};
    }

    # reset
    if (delete $args->{reset}) {
        $self->namespace->set_attr($spec->{dest}, undef) if $self->namespace;
        delete $specs->{$spec->{dest}};
    }

    _croak $self->error_prefix . sprintf(
        'Unknown spec: %s',
        join(',', keys %$args)
    ) if keys %$args;

    # type check
    if (exists $specs->{$spec->{dest}}) {
        _croak $self->error_prefix . sprintf(
            'Redefine option %s without reset',
            $spec->{dest},
        );
    }

    # override
    $specs->{$spec->{dest}} = $spec;

    # specs changed, need to force to resort specs by groups
    delete $self->{-groups} if $self->{-groups};

    # Return $self for chaining, $self->add_argument()->add_argument()
    # or use add_arguments
    return $self;
}

sub _parse_for_name_and_flags {
    my $self = shift;
    my $args = shift;

    my ($name, @flags);
  FLAG:
    while (my $flag = shift @$args) {
        if (substr($flag, 0, 1) eq '-') {
            push @flags, $flag;
        } else {
            unshift @$args, $flag;
            last FLAG;
        }
    }

    # It's a positional argument spec if there are no flags
    $name = @flags ? $flags[0] : shift(@$args);
    $name =~ s/^-+//g;

    return ( $name, \@flags, $args );
}

#
# parse_args([@_])
#
# Parse @ARGV if called without passing arguments. It returns an
# instance of ArgParse::Namespace upon success
#
# Interface

sub parse_args {
    my $self = shift;

    my @argv = scalar(@_) ? @_ : @ARGV;

    $self->{-saved_argv} = \@ARGV;
    @ARGV = ();

    my @option_specs = sort {
        $a->{position} <=> $b->{position}
    } values %{$self->{-option_specs}};

    my @position_specs = sort {
        $a->{position} <=> $b->{position}
    } values %{$self->{-position_specs}};

    $self->{-argv} = \@argv;
    # We still want to continue even if @argv is empty to allow:
    #  - namespace initialization
    #  - default values asssigned
    #  - post checks applied, e.g. required check

    $self->namespace(Getopt::ArgParse::Namespace->new) unless $self->namespace;

    my $parsed_subcmd;
    $self->namespace->set_attr(current_command => undef);

    # If the first argument is a subcommand, it will parse for the
    # subcommand
    if (exists $self->{-subparsers} && scalar(@argv) && defined($argv[0]) && substr($argv[0], 0, 1) ne '-') {
        # Subcommand must appear as the first argument
        # or it will parse as the top command
        my $cmd = shift @argv;
        my $subparser = $self->_get_subcommand_parser($cmd);
        _croak $self->error_prefix
            . sprintf("%s is not a %s command. See help", $cmd, $self->prog)
                unless $subparser;

        $parsed_subcmd = $self->_parse_subcommand($self->_command => $subparser);

        $self->namespace->set_attr(current_command => $self->_command);
    }

    if (!$parsed_subcmd) {
        $self->_parse_optional_args(\@option_specs) if @option_specs;
        $self->_parse_positional_args(\@position_specs) if @position_specs;

        if ($self->print_usage_if_help() && $self->namespace->get_attr('help')) {
            $self->print_usage();
            exit(0);
        }
    } else {
        if ($self->print_usage_if_help() && $self->_command() eq 'help') {
            if ($self->namespace->get_attr('help_command')) {
                $self->print_command_usage();
                exit(0);
            } else {
                $self->print_usage();
                exit(0);
            }
        }
    }

    # Return value
    return $self->namespace;
}

sub _get_subcommand_parser {
    my $self = shift;
    my $alias = shift;

    return unless $alias;

    my $command = $self->{-subparsers}{-alias_map}{$alias}
        if exists $self->{-subparsers}{-alias_map}{$alias};

    return unless $command;

    $self->_command($command);
    # The subcommand parser must exist if the alias is mapped
    return $self->{-subparsers}{-parsers}{$command};
}

sub _parse_subcommand {
    my $self = shift;
    my ($cmd, $subparser) = @_;

    $subparser->namespace($self->namespace);
    $subparser->parse_args(@{$self->{-argv}});

    $self->{-argv} = $subparser->{-argv};

    return 1;
}

#
# After each call of parse_args(), call this to retrieve any
# unconsumed arguments
# Interface call
#
sub argv {
    @{ $_[0]->{-argv} || [] };
}

sub _parse_optional_args {
    my $self = shift;
    my $specs = shift;
    my $options   = {};
    my $dest2spec = {};

    for my $spec ( @$specs ) {
        my @values;
        $dest2spec->{$spec->{dest}} = $self->_get_option_spec($spec);
        if (    $spec->{type} == TYPE_ARRAY
             || $spec->{type} == TYPE_COUNT
             || $spec->{type} == TYPE_PAIR
             || $spec->{type} == TYPE_SCALAR
         ) {
            my @values;
            $options->{ $dest2spec->{$spec->{dest}} } = \@values;
        } else {
            my $value;
            $options->{ $dest2spec->{$spec->{dest}} } = \$value;
        }
    }

    Getopt::Long::Configure( @{ $self->parser_configs });

    my (@warns, $result);

    eval {
        local $SIG{__WARN__} = sub { push @warns, @_ };
        local $SIG{__DIE__};

        $result = GetOptionsFromArray( $self->{-argv}, %$options );

        1;
    };

    # die on errors
    _croak $self->error_prefix, $@ if $@;

    _croak $self->error_prefix, @warns if @warns;

    _croak $self->error_prefix, 'Failed to parse for options' if !$result;

    Getopt::Long::Configure('default');

    $self->_post_parse_processing($specs, $options, $dest2spec);

    $self->_apply_action($specs, $options, $dest2spec);

    $self->_post_apply_processing($specs, $options, $dest2spec);
}

sub _parse_positional_args {
    my $self = shift;
    my $specs = shift;

    # short-circuit it if it's for help
    return if $self->namespace->get_attr('help');

    my $options   = {};
    my $dest2spec = {};

    for my $spec (@$specs) {
        $dest2spec->{$spec->{dest}} = $spec->{dest};
        my @values = ();
        # Always assigne values to an option
        $options->{$spec->{dest}} = \@values;
    }

  POSITION_SPEC:
    for my $spec (@$specs) {
        my $values = $options->{$spec->{dest}};

        if ($spec->{type} == TYPE_BOOL) {
            _croak $self->error_prefix .  'Bool not allowed for positional arguments';
        }

        my $number = 1;
        my $nargs = defined $spec->{nargs} ? $spec->{nargs} : 1;
        if (defined $spec->{nargs}) {
            if ($nargs eq '?') {
                $number = 1;
            } elsif ($nargs eq '+') {
                _croak $self->error_prefix . "Too few arguments: narg='+'" unless @{$self->{-argv}};
                $number = scalar @{$self->{-argv}};
            } elsif ($nargs eq '*') { # remainder
                $number = scalar @{$self->{-argv}};
            } elsif ($nargs !~ /^\d+$/) {
                _croak $self->error_prefix .  'Invalid nargs:' . $nargs;
            } else {
                $number = $nargs;
            }
        }

        push @$values, splice(@{$self->{-argv}}, 0, $number) if @{$self->{-argv}};

        # If no values, let it pass for required checking
        # If there are values, make sure there is the right number of
        # values
        if (scalar(@$values) && scalar(@$values) != $number) {
            _croak($self->error_prefix . sprintf(
                    'Too few arguments for %s: expected:%d,actual:%d',
                    $spec->{dest}, $number, scalar(@$values),
                )
            );
        }
    }

    $self->_post_parse_processing($specs, $options, $dest2spec);

    $self->_apply_action($specs, $options, $dest2spec);

    $self->_post_apply_processing($specs, $options, $dest2spec);
}

#
sub _post_parse_processing {
    my $self         = shift;
    my ($option_specs, $options, $dest2spec) = @_;

    #
    for my $spec ( @$option_specs ) {
        my $values = $options->{ $dest2spec->{$spec->{dest}} };

        if (defined($values)) {
            if (ref $values eq 'SCALAR') {
                if (defined($$values)) {
                    $values = [ $$values ];
                } else {
                    $values = [];
                }
            }
        } else {
            $values = [];
        }

        $options->{ $dest2spec->{$spec->{dest}} } = $values;

        # default
        if (!defined($self->namespace->get_attr($spec->{dest}))
                && scalar(@$values) < 1
                && defined($spec->{default}) )
        {
            if ($spec->{type} == TYPE_COUNT) {
                $self->namespace->set_attr($spec->{dest}, @{$spec->{default}});
            } elsif ($spec->{type} == TYPE_BOOL) {
                $self->namespace->set_attr($spec->{dest}, @{$spec->{default}});
            } elsif ($spec->{type} == TYPE_PAIR) {
                $self->namespace->set_attr($spec->{dest}, $spec->{default});
            } else {
                push @$values, @{$spec->{default}};
            }
        }

        # split and expand
        # Pair are processed here as well
        if ( my $delimit = $spec->{split} ) {
            my @expanded;
            for my $v (@$values) {
                push @expanded,
                    map {
                        $spec->{type} == TYPE_PAIR ? { split('=', $_) } : $_
                    } split($delimit, $v);
            }

            $options->{ $dest2spec->{$spec->{dest} } } = \@expanded;
        } else {
            # Process PAIR only
            if ($spec->{type} == TYPE_PAIR) {
                $options->{ $dest2spec->{$spec->{dest} } }
                    = [ map { { split('=', $_) } } @$values ];
            }
        }

        # choices
        if ( $spec->{choices} ) {
            if (ref($spec->{choices}) eq 'CODE') {
                for my $v (@$values) {
                    $spec->{choices}->($v);
                }
            } else {
                my %choices =
                    map { defined($_) ? $_ : '_undef' => 1 }
                    @{$spec->{choices}};

              VALUE:
                for my $v (@$values) {
                    my $k = defined($v) ? $v : '_undef';
                    next VALUE if exists $choices{$k};

                    _croak $self->error_prefix . sprintf(
                        "Option %s value %s not in choices: [ %s ]",
                        $spec->{dest}, $v, join( ', ', @{ $spec->{choices} } ),
                    );
                }
            }
        }

        if ( $spec->{choices_i} ) {
            my %choices =
                    map { defined($_) ? uc($_) : '_undef' => 1 }
                    @{$spec->{choices_i}};

          VALUE:
            for my $v (@$values) {
                my $k = defined($v) ? uc($v) : '_undef';
                next VALUE if exists $choices{$k};

                _croak $self->error_prefix . sprintf(
                    "Option %s value %s not in choices: [ %s ] (case insensitive)",
                    $spec->{dest}, $v, join( ', ', @{ $spec->{choices_i} } ),
                );
            }
        }
    }

    return '';
}

sub _apply_action {
    my $self = shift;
    my ($specs, $options, $dest2spec) = @_;

   for my $spec (@$specs) {
        # Init
        # We want to preserve already set attributes if the namespace
        # is passed in.
        #
        # This is because one may want to load configs from a file
        # into a namespace and then use the same namespace for parsing
        # configs from command line.
        #
        $self->namespace->set_attr($spec->{dest}, undef)
            unless defined($self->namespace->get_attr($spec->{dest}));

        my $error = $spec->{action}->apply(
            $spec,
            $self->namespace,
            $options->{ $dest2spec->{$spec->{dest}} },
            $spec->{name},
        );

        _croak $self->error_prefix . $error if $error;
    }

    return '';
}

sub _post_apply_processing {
    my $self = shift;
    my ($specs, $options, $dest2spec) = @_;

    #
    # required is checked after applying actions
    # This is because required checking is bypassed if help is on
    #
    for my $spec (@$specs) {
        my $v = $self->namespace->get_attr($spec->{dest});

        # required
        if ( $spec->{required} && not $self->namespace->get_attr('help') ) {
            my $has_v;
            if ($spec->{type} == TYPE_ARRAY) {
                $has_v = @$v;
            } elsif ($spec->{type} == TYPE_PAIR) {
                $has_v = scalar(keys %$v);
            } else {
                $has_v = defined $v;
            }

            _croak $self->error_prefix . sprintf("Option %s is required\n", $spec->{dest}) unless $has_v;
        }
    }
}

# interface
sub print_usage {
    my $self = shift;

    my $usage = $self->format_usage();

    print STDERR $_, "\n" for @$usage;
}

# interface
sub print_command_usage {
    my $self = shift;
    my $command = shift
        || $self->namespace->get_attr('help_command')
        || $self->namespace->get_attr('current_command'); # running help command

    my $usage = $self->format_command_usage($command);
    if ($usage) {
        print STDERR $_, "\n" for @$usage;
    } else {
        print STDERR
            $self->error_prefix,
            sprintf('No help for %s. See help', $self->namespace->get_attr('help_command')),
            "\n";
    }
}

# Interface
sub format_usage {
    my $self = shift;

    $self->_sort_specs_by_groups() unless $self->{-groups};

    my $old_wrap_columns = $Text::Wrap::columns;

    my @usage;

    my $aliases = $self->aliases;
    my $prog = $self->prog;
    $prog .= ' (' . join(', ', @$aliases) . ')' if @$aliases;
    if( $self->help ) {
    push @usage, wrap('', '', $prog. ': ' . $self->help);
        push @usage, '';
    }

    my ($help, $option_string) =  $self->_format_group_usage();
    $Text::Wrap::columns = 80;

    my $header = sprintf(
        'usage: %s %s',
        $self->prog, $option_string
    );

    push @usage, wrap('', '', $header);

    if ($self->description) {
        my @lines = split("\n", $self->description);

        my @paragraphs;

        my $para = '';
        for my $line (@lines) {
            if ($line =~ /^\s*$/) {
                push @paragraphs, $para;
                $para = '';
            } else {
                $para .= ( $para ? ' ' : '' ) . $line;
            }
        }

        push @paragraphs, $para;
        for (@paragraphs) {
            push @usage, '';
            push @usage, wrap('', '', $_);
        }
    }

    push @usage, @$help;

    if (exists $self->{-subparsers}) {
        push @usage, '';
        push @usage, wrap('', '', $self->{-subparsers}{-title});
        push @usage, wrap('', '', $self->{-subparsers}{-description}) if $self->{-subparsers}{-description};

        my $max = 12;

        for my $command ( keys  %{$self->{-subparsers}{-parsers}} ) {
            my $len = length($command);
            $max = $len if $len > $max;
        }

        for my $command ( sort keys  %{$self->{-subparsers}{-parsers}} ) {
            my $parser = $self->{-subparsers}{-parsers}{$command};
            my $tab_head = ' ' x ( $max + 2 );

            my @desc = split("\n", wrap('', '', $parser->help));
            my $desc = (shift @desc) || '';
            $_ = $tab_head . $_ for @desc;
            push @usage, sprintf("  %-${max}s    %s", $command, join("\n", $desc, @desc));
        }
    }

    push @usage, '', wrap('', '', $self->epilog) if $self->epilog;

    $Text::Wrap::columns = $old_wrap_columns; # restore to original

    return \@usage;
}

sub format_command_usage {
    my $self = shift;
    my $alias = shift;

    my $subp = $self->_get_subcommand_parser($alias);
    return '' unless $subp;

    return $subp->format_usage();
}

# FIXME: Maybe we should remove this grouping thing
sub _sort_specs_by_groups {
    my $self = shift;

    my $specs = $self->{-option_specs};

    for my $dest ( keys %{ $specs } ) {
        for my $group ( @{ $specs->{$dest}{groups} } ) {
            push @{ $self->{-groups}{$group}{-option} }, $specs->{$dest};
        }
    }

    $specs = $self->{-position_specs};

    for my $dest ( keys %{ $specs } ) {
        for my $group ( @{ $specs->{$dest}{groups} } ) {
            push @{ $self->{-groups}{$group}{-position} }, $specs->{$dest};
        }
    }
}

# This funtion finds the help argument and moves it 
# to the front of the optional parameters
sub _move_help_after_required
{
    my @option_spec = @_;
    my ($help, $i);

    $i=0;
    foreach my $element (@option_spec)
    {
        if ($element->{'position'} == 0)
        {
            $help = splice @option_spec, $i, 1;
            last;
        }
        $i++;
    }

    $i=0;
    foreach my $element (@option_spec)
    {
        if (!$element->{required})
        {
            splice @option_spec, $i, 0, $help;
            last;
        }
        $i++;
    }
    return @option_spec;
}

sub _format_group_usage {
    my $self = shift;
    my $group = '';

    unless ($self->{-groups}) {
        $self->_sort_specs_by_groups();
    }

    my $old_wrap_columns = $Text::Wrap::columns;
    $Text::Wrap::columns = 80;

    my @usage;

    my @option_specs;
# When doing a sort by name, it puts all required parameters
# first sorted by name, then all optional parameters sorted by name
    if ($self->sortby eq 'name')
    {
        @option_specs = sort {
            ($b->{required} cmp $a->{required} || $a->{name} cmp $b->{name})
        } @{ $self->{-groups}{$group}{-option} || [] };
        @option_specs = _move_help_after_required(@option_specs);
    }
    elsif($self->sortby eq 'position')
    {
        @option_specs = sort {
            ($b->{required} cmp $a->{required} || $b->{position} <=> $a->{position} )
        } @{ $self->{-groups}{$group}{-option} || [] };
        @option_specs = _move_help_after_required(@option_specs);
    }
    

    my @flag_items = map {
            ($_->{required} ? '' : '[')
            . join('|', @{$_->{flags}})
            . ($_->{required} ? '' : ']')
    } @option_specs;

    my @position_specs = sort {
        $a->{position} <=> $b->{position}
    } @{ $self->{-groups}{$group}{-position} || [] };

    my @position_items = map {
              ($_->{required} ? '' : '[')
            .  $_->{metavar}
            . ($_->{required} ? '' : ']')
    } @position_specs;

    my @subcommand_items = ('<command>', '[<args>]') if exists $self->{-subparsers};

    if ($group) {
        push @usage, wrap('', '', $group . ': ' . ($self->{-group_description}{$group} || '')  );
    }

    # named arguments are arguments preceded by a hyphen as optional
    # vs. positional are too confusing.
    for my $spec_name ( [ \@position_specs, 'positional' ], [ \@option_specs, 'named' ]) {
        my ($specs, $spec_name) = @$spec_name;
        for my $type_name ( [ PRINT_REQUIRED, 'required'], [ PRINT_OPTIONAL, 'optional'] ) {
            my ($type, $type_name) = @$type_name;
            my $output = $self->_format_usage_by_spec($specs, $type);
            if (@$output) {
                push @usage, '';
                # Start a section: e.g. required positional arguments:
                push @usage, sprintf('%s %s arguments:', $type_name, $spec_name);
                push @usage, @$output;
            }
        }
    }

    $Text::Wrap::columns = $old_wrap_columns; # restore to original

    return ( \@usage, join(' ', @position_items, @flag_items, @subcommand_items) ) ;
}

sub _format_usage_by_spec {
    my $self       = shift;
    my $specs      = shift;
    my $print_type = shift;

    return unless $specs;

    my @usage;
    my $max = 10;
    my @item_help;

  SPEC: for my $spec ( @$specs ) {
        next SPEC if    ($print_type == PRINT_OPTIONAL &&  $spec->{'required'})
                     || ($print_type == PRINT_REQUIRED && !$spec->{'required'});

        my $item = $spec->{metavar};

        if (@{$spec->{flags}}) {
            $item = sprintf(
                "%s %s",
                join(', ',  @{$spec->{flags}}),
                $spec->{metavar},
            );
        }
        my $len = length($item);
        $max = $len if $len > $max;

        # generate default string
        my $default = '';
        my $values = [];

        if (defined $spec->{default}) {
            if (ref $spec->{default} eq 'HASH') {
                while (my ($k, $v) = each %{$spec->{default}}) {
                    push @$values, "$k=$v";
                }
            } elsif (ref $spec->{default} eq 'ARRAY') {
                $values = $spec->{default};
            } else {
                $values = [ $spec->{default} ];
            }
        }

        if (@$values) {
            $default = 'Default: ' . join(', ', @$values);
        }

        # generate choice string
        my $choices;
        my $case = '';

        if ($spec->{choices} && ref $spec->{choices} ne 'CODE') {
            $choices = $spec->{choices};
            $case = 'case sensitive';
        } elsif ($spec->{choices_i}) {
            $choices = $spec->{choices_i};
            $case = 'case insensitive';
        } else {
            $choices = undef;
        }

        my $choice_str = '';
        if ($choices) {
            $choice_str = 'Choices: [' . join(', ', @$choices) . '], ' . $case . "\n";
        }

        push @item_help, [
            $item,
            ($spec->{required} ? ' ' : '?'),
            join("\n", ($spec->{help} || 'This is option ' . $spec->{dest}), $choice_str . $default),
        ];
    }

    my $format = "  %-${max}s    %s %s";
    $Text::Wrap::columns = 60;
    for my $ih (@item_help) {
        my $item_len = length($ih->[0]);
        # The prefixed whitespace in subsequent lines in the wrapped
        # help string
        my $sub_tab = " " x ($max + 4 + 4 + 2);
        my @help = split("\n", wrap('', '', $ih->[2]));

        my $help = (shift @help) || '' ;      # head
        $_ = $sub_tab . $_ for @help;         # tail

        push @usage, sprintf($format, $ih->[0], $ih->[1], join("\n", $help, @help));
    }

    return \@usage;
}

# translate option spec to the one accepted by
# Getopt::Long::GetOptions
sub _get_option_spec {
    my $self = shift;
    my $spec  = shift;

    my @flags = @{ $spec->{flags} };
    $_ =~ s/^-+// for @flags;
    my $name = join('|', @flags);
    my $type = 's';
    my $desttype = '';

    my $optional_flag = '='; # not optional

    if ($spec->{type} == TYPE_SCALAR) {
        $desttype = '@';
    } elsif ($spec->{type} == TYPE_ARRAY) {
        $desttype = '@';
    } elsif ($spec->{type} == TYPE_PAIR) {
        $desttype = '@';
    } elsif ($spec->{type} == TYPE_UNDEF) {
        $optional_flag = ':';
    } elsif ($spec->{type} == TYPE_BOOL) {
        $type = '';
        $optional_flag = '';
        $desttype = '';
    } elsif ($spec->{type} == TYPE_COUNT) {
        # pass
        $type = '';
        $optional_flag = '';
        $desttype = '+';
    } else {
        # pass
        # should never be here
        _croak $self->error_prefix . 'Unknown type:' . ($spec->{type} || 'undef');
    }

    my $repeat = '';

    my $opt = join('', $name, $optional_flag, $type, $repeat, $desttype);

    return $opt;
}

1;

__END__

=head1 AUTHOR

Mytram <mytram2@gmail.com> (original author)

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by Mytram.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut


