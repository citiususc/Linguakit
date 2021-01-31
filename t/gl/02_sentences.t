#!/usr/bin/env perl

# Unit tests for Linguakit
#
# Copyright (c) 2021 ProLNat - CiTIUS (USC)
#
# This library is free software; you can redistribute it and/or modify
# it under the same terms as Perl 5 itself.
#
# For more information see the "Perl Artistic License",
# which should have been distributed with your copy of Perl.
# Try the command "perldoc perlartistic" or see
# http://perldoc.perl.org/perlartistic.html .

use warnings;
use strict;
use utf8;
use open ':std', ':encoding(utf8)';
use Test::More tests => 3;
use lib '.';

BEGIN {
    do 'tagger/gl/sentences-gl_exe.perl';
}

####################################################################################
# input data

my $sentences = [
    ["Pois a min paréceme que hai un nivel moi bo. Supoño que tamén haberá lugares máis baratos."],
];

my $expected_sentences = [
    ["Pois a min paréceme que hai un nivel moi bo.",
     "Supoño que tamén haberá lugares máis baratos."],
];
###############################################################################


###############################################################################
# tests

can_ok('Sentences', 'sentences')
    or BAIL_OUT("failed to use Sentences::sentences");

# test function sentences
ok(scalar @{Sentences::sentences([""])} == 0, "test_empty_sentence_returns_zero_tokens");
for(my $i=0; $i < scalar @$sentences; $i++)
{
    is_deeply(
        Sentences::sentences($sentences->[$i]),
        $expected_sentences->[$i],
        "test_sentence_segmentation"
    );
}

