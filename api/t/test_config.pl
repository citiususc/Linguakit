#!/usr/bin/env perl

# Tests for the Linguakit API
# 
# Copyright (c) 2021 Grupo ProLNat@GE, CITIUS
# 
# This library is free software; you can redistribute it and/or modify
# it under the GNU GENERAL PUBLIC LICENSE v3 terms.

use warnings;
use strict;
use Plack::Test;
use HTTP::Request;

our $default_module = "tagger";
our $default_submodule = "";

sub send_request
{
    my $input = shift || "";
    my $module = shift || $default_module;
    my $submodule = shift || $default_submodule;

    my $test = Plack::Test->create(linguakit_api->to_app);
    my $headers = ['Content-Type' => 'application/json; charset=UTF-8'];
    my $url = "http://127.0.0.1:3000/v2.0/$module";

    my $data = encode_json({text => $input, output => $submodule});
    my $request = HTTP::Request->new('POST', $url, $headers, $data);

    return $test->request($request);
}

1;
