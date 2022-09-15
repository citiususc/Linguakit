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
linguakit_api::run("en");

####################################################################################
# FIXTURES
#
# input data
my $sentences = [
    "Mrs. Dalloway said she would buy the flowers herself."
];
my $tagger_expected = [
    [
        "Mrs mrs NNP",". . Fp","","Dalloway dalloway NNP","said say VBD","she she PRP","would would MD","buy buy VB","the the DT","flowers flower NNS","herself herself PRP",". . Fp",""
    ],
];
my $ner_expected = [
    [
        "Mrs mrs NNP",". . Fp","","  ","Dalloway dalloway NNP","said say VBD","she she PRP","would would MD","buy buy VB","the the DT","flowers flower NNS","herself herself PRP",". . Fp",""
    ],
];
my $nec_expected = [
    [
        "Mrs mrs NP00V00",". . Fp","","  ","Dalloway dalloway NP00V00","said say VBD","she she PRP","would would MD","buy buy VB","the the DT","flowers flower NNS","herself herself PRP",". . Fp",""
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
