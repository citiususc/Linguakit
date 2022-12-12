#!/usr/bin/env perl
use lib 'lib';
require linguakit_api;

linguakit_api::run("gl");
linguakit_api->to_app;
