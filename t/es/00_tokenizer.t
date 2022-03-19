#!/usr/bin/env perl

# Unit tests for Linguakit
#
# Copyright (c) 2022 ProLNat - CiTIUS (USC)
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
use Test::More tests => 4;
use lib '.';

BEGIN {
    do 'tagger/es/tokens-es_exe.perl';
}

####################################################################################
# input data

my @sentences = (
    "Esto es todo lo malo que le pasa a tu cuerpo cuando comes una hamburguesa de McDonald's o Burger King.",
    "El bar Galo D'Ouro, en la calle La Conga, sigue vigente tras más de cuatro décadas.",
);
my $expected_sentences = [
    [
        'Esto', 'es', 'todo', 'lo', 'malo', 'que', 'le', 'pasa', 'a', 'tu', 'cuerpo', 'cuando', 'comes', 'una', 'hamburguesa', 'de', "McDonald's", 'o', 'Burger', 'King', '.', ''
    ],
    [
        'El', 'bar', 'Galo', "D'Ouro", ',', 'en', 'la', 'calle', 'La', 'Conga', ',', 'sigue', 'vigente', 'tras', 'más', 'de', 'cuatro', 'décadas', '.', ''
    ],
];

###############################################################################


###############################################################################
# tests

can_ok('Tokens', 'tokens')
    or BAIL_OUT("failed to use Tokens::tokens");

# test function tokens
ok(scalar @{Tokens::tokens([])} == 0, "test_empty_sentence_returns_no_tokens");
for(my $i=0; $i < scalar @sentences; $i++)
{
    is_deeply(
        Tokens::tokens([$sentences[$i]]),
        $expected_sentences->[$i],
        "test_tokenizer_with_sentences"
    );
}
