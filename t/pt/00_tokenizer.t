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
    do 'tagger/pt/tokens-pt_exe.perl';
}

####################################################################################
# input data

my @sentences = (
    "Macy's é uma rede de lojas de departamentos fundada em Nova Iorque.",
    "A empresa Galo D'Ouro está presente no segmento de bares e lanchonetes.",
);
my $expected_sentences = [
    [
        "Macy's", 'é', 'uma', 'rede', 'de', 'lojas', 'de', 'departamentos',
        'fundada', 'em', 'Nova', 'Iorque', '.', ''
    ],
    [
        'A', 'empresa', 'Galo', "D'Ouro", 'está', 'presente', 'no', 'segmento', 'de', 'bares', 'e', 'lanchonetes', '.', ''
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
