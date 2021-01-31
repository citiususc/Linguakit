#!/usr/bin/env perl

# Unit tests for Linguakit
#
# Copyright (c) 2021 ProLNat - CiTIUS (USC)
#
# This library is free software; you can redistribute it and/or modify
# it under the same terms as Perl 5 itself.
#
# For more information see the "Perl Artistic License",
# which should have been distributed with your copy of Perl.
# Try the command "perldoc perlartistic" or see
# http://perldoc.perl.org/perlartistic.html .

use warnings;
use strict;
use utf8;
use open ':std', ':encoding(utf8)';
use Test::More tests => 2;
use lib '.';

BEGIN {
    do 'tagger/en/sentences-en_exe.perl';
}

####################################################################################
# input data

###############################################################################


###############################################################################
# tests

can_ok('Sentences', 'sentences')
    or BAIL_OUT("failed to use Sentences::sentences");

# test function sentences
ok(scalar @{Sentences::sentences([""])} == 0, "test_empty_sentence_returns_zero_tokens");
