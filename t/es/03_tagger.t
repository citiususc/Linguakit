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
use Test::More tests => 12;
use lib '.';


BEGIN {
    do 'tagger/es/tagger-es_exe.perl';
}


####################################################################################
# input data

my $sentences = [
    [
        'El el DA0MS0', 'día día NCMS000', 'que que CS que PR0CN000',
        'lo el DA0NS0 lo PP3CNA00 lo PP3MSA00', 'iban ir VMII3P0',
        'a a NCFS000 a SPS00', 'matar matar VMN0000', ', , Fc',
        'Santiago santiago NP00000', 'Nasar nasar NP00000',
        'se se P00CN000 se P03CN000 se PP3CN000', 'levantó levantar VMIS3S0',
        'a a NCFS000 a SPS00', 'las el DA0FP0 lo PP3FPA00', '5.30 5.30 Z',
        'de de SPS00', 'la el DA0FS0 lo PP3FSA00',
        'mañana mañana NCFS000 mañana NCMS000 mañana RG',
        'para para SPS00 parar VMIP3S0 parar VMM02S0 parir VMM03S0 parir VMSP1S0 parir VMSP3S0',
        'esperar esperar VMN0000', 'el el DA0MS0', 'buque buque NCMS000',
        'en en SPS00', 'que que CS que PR0CN000',
        'llegaba llegar VMII1S0 llegar VMII3S0', 'el el DA0MS0',
        'obispo obispo NCMS000', '. . Fp',
        ''
    ],
];
my $expected_sentences = [
    [
        'El el DA0MS0', 'día día NCMS000', 'que que PR0CN000', 
        'lo lo PP3MSA00', 'iban ir VMII3P0', 'a a SPS00',
        'matar matar VMN0000', ', , Fc', 'Santiago santiago NP00000',
        'Nasar nasar NP00000', 'se se P03CN000', 'levantó levantar VMIS3S0',
        'a a SPS00', 'las el DA0FP0', '5.30 5.30 Z', 'de de SPS00',
        'la el DA0FS0', 'mañana mañana NCMS000', 'para para SPS00',
        'esperar esperar VMN0000', 'el el DA0MS0', 'buque buque NCMS000',
        'en en SPS00', 'que que PR0CN000', 'llegaba llegar VMII3S0',
        'el el DA0MS0', 'obispo obispo NCMS000', '. . Fp', ''
    ],
];

my $ambig_tokens = [
    [ # pos
        2, 3, 5, 10, 17,
    ],
    [ # features
        [
            'amb_1_1_R_DA', 'amb_1_1_R_DA_que', 'amb_2_1_R_PP',
            'amb_2_1_R_PP_que', 'noamb_1_1_L_NC', 'noamb_1_1_L_NC_que'
        ],
        [
            'noamb_1_1_R_VMI', 'noamb_1_1_R_VMI_lo', 'amb_1_1_L_PR',
            'amb_1_1_L_PR_lo'
        ],
        [
            'noamb_1_1_R_VMN', 'noamb_1_1_R_VMN_a', 'noamb_1_1_L_VMI',
            'noamb_1_1_L_VMI_a'
        ],
        [
            'noamb_1_1_R_VMI', 'noamb_1_1_R_VMI_se', 'noamb_1_1_L_NP',
            'noamb_1_1_L_NP_se'
        ],
        [
            'amb_1_1_R_VMS', 'amb_1_1_R_VMS_mañana', 'amb_2_1_R_VMM',
            'amb_2_1_R_VMM_mañana', 'amb_3_1_R_SP', 'amb_3_1_R_SP_mañana',
            'amb_4_1_R_VMI', 'amb_4_1_R_VMI_mañana', 'amb_1_1_L_DA',
            'amb_1_1_L_DA_mañana'
        ],
    ],
    [ # categories
        ['PR', 'CS'],
        ['DA', 'PP'],
        ['SP', 'NC'],
        ['PP', 'P0'],
        ['RG', 'NC'],
    ],
    [ # unk
        [], [], [], [], [],
    ],
];

my $expected_ambig_tokens = [
    "PR", "PP", "SP", "P0", "NC",
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
