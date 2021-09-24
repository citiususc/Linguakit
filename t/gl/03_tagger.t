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
use Test::More tests => 15;
use lib '.';


BEGIN {
    do 'tagger/gl/tagger-gl_exe.perl';
}


####################################################################################
# input data

my $sentences = [
    [
        'Galiza galiza NP00000', "é ser VSIP3S0", 'unha un DI0FS0 un PI0FS000',
        'unidade unidade NCFS000', 'territorial territorial AQ0CS0',
        "harmónica harmónica NCFS000 harmónico AQ0FS0",
        'de de NCMS000 de SPS00', 'formas forma NCFP000 formar VMIP2S0',
        'e e CC e NCMS000', 'cor cor NCFS000', ', , Fc',
        'perfeitamente perfeitamente UNK', 'diferenciada diferenciar VMP00SF',
        'de de NCMS000 de SPS00', 'o o DA0MS0 o PP3MSA00',
        'resto restar VMIP1S0 resto NCMS000', 'de de NCMS000 de SPS00',
        "Hespa\x{f1}a hespa\x{f1}a NP00000", '. . Fp',
        ''
    ],
];
my $expected_sentences = [
    [
        "Galiza galiza NP00000", "é ser VSIP3S0", "unha un DI0FS0",
        "unidade unidade NCFS000", "territorial territorial AQ0CS0",
        "harmónica harmónica NCFS000", "de de SPS00", "formas forma NCFP000",
        "e e CC", "cor cor NCFS000", ", , Fc",
        "perfeitamente perfeitamente RG", "diferenciada diferenciar VMP00SF",
        "de de SPS00", "o o DA0MS0", "resto resto NCMS000", "de de SPS00",
        "Hespaña hespaña NP00000", ". . Fp", ""
    ],
];

my $ambig_tokens = [
    [ # pos
        2, 3, 4, 5, 6, 7, 3, 6,
    ],
    [ # features
        [
            'amb_1_1_R_SP', 'amb_1_1_R_SP_carga', 'amb_2_1_R_NC',
            'amb_2_1_R_NC_carga', 'noamb_1_1_L_NP',
            'noamb_1_1_L_NP_carga'
        ],
        [
            'amb_1_1_R_NC', 'amb_1_1_R_NC_contra', 'amb_2_1_R_DA',
            'amb_2_1_R_DA_contra', 'amb_3_1_R_PP', 'amb_3_1_R_PP_contra',
            'amb_1_1_L_NC', 'amb_1_1_L_NC_contra'
        ],
        [
            'amb_1_1_R_NC', 'amb_1_1_R_NC_os', 'amb_2_1_R_VMS',
            'amb_2_1_R_VMS_os', 'amb_1_1_L_SP', 'amb_1_1_L_SP_os'
        ],
        [
            'amb_1_1_R_NC', 'amb_1_1_R_NC_recortes', 'amb_2_1_R_CC',
            'amb_2_1_R_CC_recortes', 'amb_1_1_L_DA', 'amb_1_1_L_DA_recortes'
        ],
        [
            'amb_1_1_R_AQ', 'amb_1_1_R_AQ_e', 'amb_2_1_R_NC',
            'amb_2_1_R_NC_e', 'amb_3_1_R_VMI', 'amb_3_1_R_VMI_e',
            'amb_1_1_L_NC', 'amb_1_1_L_NC_e'
        ],
        [
            'amb_1_1_R_NC', 'amb_1_1_R_NC_listas', 'amb_2_1_R_SP',
            'amb_2_1_R_SP_listas', 'amb_1_1_L_CC', 'amb_1_1_L_CC_listas'
        ],
        [
            'amb_1_1_R_VMN', 'amb_1_1_R_VMN_para', 'amb_2_1_R_VMS',
            'amb_2_1_R_VMS_para', 'noamb_1_1_L_VMI', 'noamb_1_1_L_VMI_para'
        ],
        [
            'noamb_1_1_R_NC', 'noamb_1_1_R_NC_súa', 'amb_1_1_L_DA',
            'amb_1_1_L_DA_súa'
        ]
    ],
    [ # categories
        ['VMI', 'VMM', 'NC'],
        ['SP', 'NC'],
        ['NC', 'DA', 'PP'],
        ['NC', 'VMS'],
        ['NC', 'CC'],
        ['AQ', 'NC', 'VMI'],
        ['VMI', 'NC', 'SP', 'VMM'],
        ['DP', 'VMI', 'PX', 'VMM'],
    ],
    [ # unk
        [], [], [], [], [], [], [], [],
    ],
];

my $expected_ambig_tokens = [
    "NC", "SP", "DA", "NC", "CC", "NC", "SP", "DP",
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
