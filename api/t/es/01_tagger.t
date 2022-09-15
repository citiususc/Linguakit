# Tests for the Linguakit API
# 
# Copyright (c) 2021 Grupo ProLNat@GE, CITIUS
# 
# This library is free software; you can redistribute it and/or modify
# it under the GNU GENERAL PUBLIC LICENSE v3 terms.

use strict;
use warnings;
use utf8;
use Test::More tests => 5;
use JSON;

use lib '.';
use lib 'api/lib';

require 'api/t/test_config.pl';
require linguakit_api;
linguakit_api::run("es");

####################################################################################
# FIXTURES
#
# input data
my $sentences = [
    "El día que lo iban a matar, Santiago Nasar se levantó a las 5.30 de la mañana para esperar el buque en que llegaba el obispo.",
];
my $tagger_expected = [
    [
        "El el DA0MS0","día día NCMS000","que que PR0CN000","lo lo PP3MSA00","iban ir VMII3P0","a a SPS00","matar matar VMN0000",", , Fc","Santiago santiago NP00000","Nasar nasar NP00000","se se P03CN000","levantó levantar VMIS3S0","a a SPS00","las el DA0FP0","5.30 5.30 Z","de de SPS00","la el DA0FS0","mañana mañana NCMS000","para para SPS00","esperar esperar VMN0000","el el DA0MS0","buque buque NCMS000","en en SPS00","que que PR0CN000","llegaba llegar VMII3S0","el el DA0MS0","obispo obispo NCMS000",". . Fp",""
    ],
];
my $ner_expected = [
    [
        "El el DA0MS0","día día NCMS000","que que PR0CN000","lo lo PP3MSA00","iban ir VMII3P0","a a SPS00","matar matar VMN0000",", , Fc","Santiago_Nasar santiago_nasar NP00000","se se P03CN000","levantó levantar VMIS3S0","a a SPS00","las el DA0FP0","5.30 5.30 NC00000","de de SPS00","la el DA0FS0","mañana mañana NCMS000","para para SPS00","esperar esperar VMN0000","el el DA0MS0","buque buque NCMS000","en en SPS00","que que PR0CN000","llegaba llegar VMII3S0","el el DA0MS0","obispo obispo NCMS000",". . Fp",""
    ],
];
my $nec_expected = [
    [
        "El el DA0MS0","día día NCMS000","que que PR0CN000","lo lo PP3MSA00","iban ir VMII3P0","a a SPS00","matar matar VMN0000",", , Fc","Santiago_Nasar santiago_nasar NP00SP0","se se P03CN000","levantó levantar VMIS3S0","a a SPS00","las el DA0FP0","5.30 5.30 NC00000","de de SPS00","la el DA0FS0","mañana mañana NCMS000","para para SPS00","esperar esperar VMN0000","el el DA0MS0","buque buque NCMS000","en en SPS00","que que PR0CN000","llegaba llegar VMII3S0","el el DA0MS0","obispo obispo NCMS000",". . Fp",""
    ],
];
###############################################################################


###############################################################################
# tests

my $response = send_request();
ok($response->is_success, 'test_post_tagger_endpoint')
    or BAIL_OUT("failed POST request to /tagger");

# empty sentence
is_deeply(
    $response->content,
    encode_json(["<blank> <blank> Fp",""]),
    'test_port_tagger_empty_sentence'
);

# tagger
for(my $i=0; $i < scalar @$sentences; $i++)
{
    my $response = send_request($sentences->[$i], "tagger", "");
    is_deeply(
        $response->content,
        encode_json($tagger_expected->[$i]),
        'test_post_tagger_sentence'
    );
}

# ner
for(my $i=0; $i < scalar @$sentences; $i++)
{
    my $response = send_request($sentences->[$i], "tagger", "ner");
    is_deeply(
        $response->content,
        encode_json($ner_expected->[$i]),
        'test_post_ner_sentence'
    );
}

# nec
for(my $i=0; $i < scalar @$sentences; $i++)
{
    my $response = send_request($sentences->[$i], "tagger", "nec");
    is_deeply(
        $response->content,
        encode_json($nec_expected->[$i]),
        'test_post_nec_sentence'
    );
}
