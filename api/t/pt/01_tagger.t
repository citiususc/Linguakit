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
linguakit_api::run();

####################################################################################
# FIXTURES
#
# input data
my $sentences = [
    "Ali, caminhando devagar, falando baixo, o cónego consultava o coadjutor sobre a carta de Amaro Vieira."
];
my $tagger_expected = [
    [
        "Ali ali NCMS000",", , Fc","caminhando caminhar VMG0000","devagar devagar RG",", , Fc","falando falar VMG0000","baixo baixo NCMS000",", , Fc","o o DA0MS0","cónego cónego NCMS000","consultava consultar VMII3S0","o o DA0MS0","coadjutor coadjutor NCMS000","sobre sobre SPS00","a o DA0FS0","carta carta NCFS000","de de SPS00","Amaro amaro NP00000","Vieira vieira NP00000",". . Fp",""
    ],
];
my $ner_expected = [
    [
        "Ali ali NCMS000",", , Fc","caminhando caminhar VMG0000","devagar devagar RG",", , Fc","falando falar VMG0000","baixo baixo NCMS000",", , Fc","o o DA0MS0","cónego cónego NCMS000","consultava consultar VMII3S0","o o DA0MS0","coadjutor coadjutor NCMS000","sobre sobre SPS00","a o DA0FS0","carta carta NCFS000","de de SPS00","Amaro_Vieira amaro_vieira NP00000",". . Fp",""
    ],
];
my $nec_expected = [
    [
        "Ali ali NCMS000",", , Fc","caminhando caminhar VMG0000","devagar devagar RG",", , Fc","falando falar VMG0000","baixo baixo NCMS000",", , Fc","o o DA0MS0","cónego cónego NCMS000","consultava consultar VMII3S0","o o DA0MS0","coadjutor coadjutor NCMS000","sobre sobre SPS00","a o DA0FS0","carta carta NCFS000","de de SPS00","Amaro_Vieira amaro_vieira NP00SP0",". . Fp",""
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
