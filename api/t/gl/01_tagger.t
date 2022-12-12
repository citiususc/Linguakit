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
linguakit_api::run("gl");

####################################################################################
# FIXTURES
#
# input data
my $sentences = [
    "Galiza é unha unidade territorial harmónica de formas e cor, perfeitamente diferenciada do resto de España.",
];
my $tagger_expected = [
    [
        "Galiza galiza NP00000","é ser VSIP3S0","unha un DI0FS0","unidade unidade NCFS000","territorial territorial AQ0CS0","harmónica harmónica NCFS000","de de SPS00","formas forma NCFP000","e e CC","cor cor NCFS000",", , Fc","perfeitamente perfeitamente RG","diferenciada diferenciar VMP00SF","de de SPS00","o o DA0MS0","resto resto NCMS000","de de SPS00","España españa NP00000",". . Fp",""
    ],
];
my $ner_expected = [
    [
        "Galiza galiza NP00000","é ser VSIP3S0","unha un DI0FS0","unidade unidade NCFS000","territorial territorial AQ0CS0","harmónica harmónica NCFS000","de de SPS00","formas forma NCFP000","e e CC","cor cor NCFS000",", , Fc","perfeitamente perfeitamente RG","diferenciada diferenciar VMP00SF","de de SPS00","o o DA0MS0","resto resto NCMS000","de de SPS00","España españa NP00000",". . Fp",""
    ],
];
my $nec_expected = [
    [
        "Galiza galiza NP00G00","é ser VSIP3S0","unha un DI0FS0","unidade unidade NCFS000","territorial territorial AQ0CS0","harmónica harmónica NCFS000","de de SPS00","formas forma NCFP000","e e CC","cor cor NCFS000",", , Fc","perfeitamente perfeitamente RG","diferenciada diferenciar VMP00SF","de de SPS00","o o DA0MS0","resto resto NCMS000","de de SPS00","España españa NP00G00",". . Fp",""
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
