package Getopt::ArgParse::ActionCount;

use strict;
use warnings;
use Carp;

sub apply {
    my $self = shift;

    my ($spec, $namespace, $values) = @_;

    $values ||= [];

    my $v = $namespace->get_attr($spec->{dest}) || 0;

    $namespace->set_attr( $spec->{dest}, $v + scalar(@$values) );

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
