package Getopt::ArgParse::Namespace;

use Carp;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $real_class = ref $class || $class;

    my $self = {};

    bless $self, $real_class;
}

sub set_attr {
    my $self = shift;
    my ($dest, $values) = @_;

    $self->{'-values'}{$dest} = $values;
}

sub get_attr {
    my $self = shift;
    my ($dest) = @_;

    confess "Must provide $dest" unless $dest;

    return $self->{'-values'}{$dest} if  exists $self->{'-values'}{$dest};

    return undef;
}

our $AUTOLOAD;

sub AUTOLOAD {
    my $sub = $AUTOLOAD;

    (my $dest = $sub) =~ s/.*:://;

    my $self = shift;

    if ( exists $self->{'-values'}{$dest} ) {
        my $values = $self->{'-values'}{$dest};
        if (ref($values) eq 'ARRAY') {
            return wantarray ? @$values : $values;
        } elsif (ref($values) eq 'HASH') {
            return wantarray ? %$values : $values;
        } else {
            return $values;
        }
    } else {
        croak "unknown option: $dest";
    }
}

sub DESTROY { }

1;

=head1 AUTHOR

Mytram <mytram2@gmail.com> (original author)

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Mytram.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
