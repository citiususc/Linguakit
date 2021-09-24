#!/usr/bin/env perl

# Unit tests for Linguakit
#
# Copyright (c) 2021 ProLNat - CiTIUS (USC)
#
# This library is free software; you can redistribute it and/or modify
# it under the GNU GENERAL PUBLIC LICENSE v3 terms.

use warnings;
use strict;
use utf8;
use open ':std', ':encoding(utf8)';
use Test::More tests => 9;
use lib '.';


BEGIN {
    do 'tagger/en/tagger-en_exe.perl';
}


####################################################################################
# input data

my $sentences = [
    [
        'Mrs mrs NNP', '. . Fp', 'Dalloway dalloway NNP',
        'said said JJ say VBD say VBN sayyid NNS ', 'she she PRP ',
        'would would MD ', 'buy buy NN buy VB ', 'the the DT ',
        'flowers flower NNS flower VBZ ', 'herself herself PRP ', '. . Fp'
    ],
];
my $expected_sentences = [
    [
        'Mrs mrs NNP', '. . Fp', '', 'Dalloway dalloway NNP', 'said say VBD',
        'she she PRP', 'would would MD', 'buy buy VB', 'the the DT',
        'flowers flower NNS', 'herself herself PRP', '. . Fp', ''
    ],
];

my $ambig_tokens = [
    [ # pos
        4, 6,
    ],
    [ # features
        [
            'noamb_1_1_R_DT', 'noamb_1_1_R_DT_buy', 'noamb_1_1_L_MD',
            'noamb_1_1_L_MD_buy'
        ],
        [
            'noamb_1_1_R_PR', 'noamb_1_1_R_PR_flowers', 'noamb_1_1_L_DT',
            'noamb_1_1_L_DT_flowers'
        ],
    ],
    [ # categories
        ['VB', 'NN'],
        ['VBZ', 'NN'],
    ],
    [ # unk
        [], [],
    ],
];

my $expected_ambig_tokens = [
    "VB", "NN",
];

###############################################################################

###############################################################################
# tests

can_ok('Tagger', 'tagger')
    or BAIL_OUT("failed to use Tagger::tagger");
can_ok('Tagger', 'classif')
    or BAIL_OUT("failed to use Splitter::classif");
can_ok('Tagger', 'rules_neg')
    or BAIL_OUT("failed to use Splitter::rules_neg");
can_ok('Tagger', 'rules_pos')
    or BAIL_OUT("failed to use Splitter::rules_pos");
can_ok('Tagger', 'trim')
    or BAIL_OUT("failed to use Splitter::trim");

# test function tagger
ok(scalar @{Tagger::tagger(['<blank> <blank> Fp', ''])} == 2, "test_empty_sentence_returns_two_tokens");
for(my $i=0; $i < scalar @$sentences; $i++)
{
    is_deeply(
        Tagger::tagger($sentences->[$i]),
        $expected_sentences->[$i],
        "test_tagger_with_sentences"
    );
}

# test function classif
for(my $i=0; $i < scalar @{$ambig_tokens->[0]}; $i++)
{
    is_deeply(Tagger::classif(
        $ambig_tokens->[0][$i],
        $ambig_tokens->[1][$i],
        $ambig_tokens->[2][$i],
        $ambig_tokens->[3][$i],
        ),
        $expected_ambig_tokens->[$i],
        "test_classif"
    );
}
