package Getopt::ArgParse::ActionStore;

use strict;
use warnings;
use Carp;

use Getopt::ArgParse::Parser;

sub apply {
    my $self = shift;

    my ($spec, $namespace, $values) = @_;
    $values ||= [];

    return sprintf(
        '%s can only have one value',
        $spec->{dest},
    ) if @$values > 1;

    if ($spec->{type} == Getopt::ArgParse::Parser::TYPE_BOOL) {
        # If there is default true or false
        my $default = $spec->{default} || [ 0 ];

        if (@$values) {
             # Negate the default if the arg appears on the command
             # line
            $namespace->set_attr($spec->{dest}, !$default->[0]);
        } else {
            $namespace->set_attr($spec->{dest}, $default->[0]);
        }

        # make no_arg available
        $namespace->set_attr( 'no_' . $spec->{dest}, !$namespace->get_attr($spec->{dest}) );

        return;
    }

    # Don't set it to undef. We may operate on a namespace with this
    # attr already set. In that case we don't want to override it.
    return unless @$values;

    my $v = $values->[0];

    $namespace->set_attr($spec->{dest}, $v);

    return '';
}

1;

=head1 AUTHOR

Mytram <mytram2@gmail.com> (original author)

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Mytram.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
