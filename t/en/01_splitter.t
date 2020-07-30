#!/usr/bin/env perl

# Unit tests for Linguakit
#
# Copyright (c) 2020 ProLNat - CiTIUS (USC)
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
use Test::More tests => 6;
use lib '.';

BEGIN {
    do 'tagger/en/splitter-en_exe.perl';
}

####################################################################################
# input data

my $tokens = [
    [
        'Finally', 'the', 'UN', 'has', 'appointed', 'someone', 'who', 'knows',
        'what', "she\n's", 'talking', 'about', '.', ''
    ],
];
my $expected_tokens = [
    [
        'Finally', 'the', 'UN', 'has', 'appointed', 'someone', 'who', 'knows',
        'what', 'she', '\'s', 'talking', 'about', '.', ''
    ],
];

my $splitted_with_locs = [
    [
        'That', 'setting', 'can', 'be', 'changed', 'later', 'on', 'as', 'you',
        'are', 'scanning', '.', ''
    ],
    [
        'Instead', 'of', 'writing', 'data', 'directly', 'to', 'the', 'platter',
        ',', 'files', 'are', 'saved', 'to', 'a', 'flash', 'buffer', '.', ''
    ],
];
my $expected_splitted_with_locs = [
    [
        'That', 'setting', 'can', 'be', 'changed', 'later_on', 'as', 'you',
        'are', 'scanning', '.', ''
    ],
    [
        'Instead_of', 'writing', 'data', 'directly', 'to', 'the', 'platter',
        ',', 'files', 'are', 'saved', 'to', 'a', 'flash', 'buffer', '.', ''
    ],
];
###############################################################################


###############################################################################
# tests

can_ok('Splitter', 'splitter')
    or BAIL_OUT("failed to use Splitter::splitter");
can_ok('Splitter', 'join_locutions')
    or BAIL_OUT("failed to use Splitter::join_locutions");

# test function splitter
ok(scalar @{Splitter::splitter([])} == 1, "test_empty_sentence_returns_one_token");
for(my $i=0; $i < scalar @$tokens; $i++)
{
    is_deeply(
        Splitter::splitter($tokens->[$i]),
        $expected_tokens->[$i],
        "test_splitter_with_tokens"
    );
}

# test function join_locutions
for(my $i=0; $i < scalar @$splitted_with_locs; $i++)
{
    is_deeply(Splitter::join_locutions(
        $splitted_with_locs->[$i]),
        $expected_splitted_with_locs->[$i],
        "test_splitted_tokens_with_locs"
    );
}
