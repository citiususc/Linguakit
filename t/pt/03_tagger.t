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
use Test::More tests => 11;
use lib '.';


BEGIN {
    do 'tagger/pt/tagger-pt_exe.perl';
}


####################################################################################
# input data

my $sentences = [
    [
        'Ali ali NCMS000 ali RG', ', , Fc', 'caminhando caminhar VMG0000',
        'devagar devagar RG', ', , Fc', 'falando falar VMG0000',
        'baixo baixo AQ0MS0 baixo NCMS000 baixo RG baixar VMIP1S0', ', , Fc',
        'o o DA0MS0 o NCMS000 o PD0MS000 o PP3MSA00', 'cónego cónego NCMS000',
        'consultava consultar VMII1S0 consultar VMII2S0 consultar VMII3S0',
        'o o DA0MS0 o NCMS000 o PD0MS000 o PP3MSA00',
        'coadjutor coadjutor AQ0MS0 coadjutor NCMS000',
        'sobre sobre NCMS000 sobre SPS00 sobrar VMM03S0 sobrar VMSP1S0 sobrar VMSP3S0',
        'a o DA0FS0 a NCMS000 o PD0FS000 o PP3FSA00 a SPS00',
        'carta carta NCFS000 cartar VMIP3S0 cartar VMM02S0', 'de de SPS00',
        'Amaro amaro NP00000', 'Vieira vieira NP00000', '. . Fp', ''
    ],
];
my $expected_sentences = [
    [
        'Ali ali NCMS000', ', , Fc', 'caminhando caminhar VMG0000',
        'devagar devagar RG', ', , Fc', 'falando falar VMG0000',
        'baixo baixo NCMS000', ', , Fc', 'o o DA0MS0',
        'cónego cónego NCMS000', 'consultava consultar VMII3S0',
        'o o DA0MS0', 'coadjutor coadjutor NCMS000', 'sobre sobre SPS00',
        'a o DA0FS0', 'carta carta NCFS000', 'de de SPS00',
        'Amaro amaro NP00000', 'Vieira vieira NP00000', '. . Fp', ''
    ],
];

my $ambig_tokens = [
    [ # pos
        6, 8, 11, 13,
    ],
    [ # features
        [
            'noamb_1_1_R_F', 'noamb_1_1_R_F_baixo', 'noamb_1_1_L_VMG',
            'noamb_1_1_L_VMG_baixo'
        ],
        [
            'noamb_1_1_R_NC', 'noamb_1_1_R_NC_o', 'noamb_1_1_L_F',
            'noamb_1_1_L_F_o'
        ],
        [
            'amb_1_1_R_NC', 'amb_1_1_R_NC_o', 'amb_2_1_R_AQ', 'amb_2_1_R_AQ_o',
            'amb_1_1_L_VMI', 'amb_1_1_L_VMI_o'
        ],
        [
            'amb_1_1_R_SP', 'amb_1_1_R_SP_sobre', 'amb_2_1_R_NC',
            'amb_2_1_R_NC_sobre', 'amb_3_1_R_PD', 'amb_3_1_R_PD_sobre',
            'amb_4_1_R_DA', 'amb_4_1_R_DA_sobre', 'amb_5_1_R_PP',
            'amb_5_1_R_PP_sobre', 'amb_1_1_L_NC', 'amb_1_1_L_NC_sobre'
        ],
    ],
    [ # categories
        ['AQ', 'NC', 'VMI', 'RG'],
        ['PD', 'DA', 'PP', 'NC'],
        ['NC', 'PP', 'DA', 'PD'],
        ['NC', 'SP', 'VMS', 'VMM'],
    ],
    [ # unk
        [], [], [], [],
    ],
];

my $expected_ambig_tokens = [
    "NC", "DA", "DA", "SP",
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
