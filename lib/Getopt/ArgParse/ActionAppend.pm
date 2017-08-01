package Getopt::ArgParse::ActionAppend;

use strict;
use warnings;
use Carp;

use Getopt::ArgParse::Parser;

sub apply {
    my $self = shift;

    my ($spec, $namespace, $values) = @_;

    my $v = $namespace->get_attr( $spec->{dest} );

    if ($spec->{type} == Getopt::ArgParse::Parser::TYPE_PAIR) {
        $v = {} unless defined $v;

        for my $pair (@$values) {
            my ($key, $val) = %$pair;
            $v->{$key} = $val;
        }

    } else {
        $v = [] unless defined $v;
        push @$v, @$values;
    }

    $namespace->set_attr( $spec->{dest}, $v );

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


