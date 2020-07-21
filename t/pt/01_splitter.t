#!/usr/bin/env perl

# Unit tests for Linguakit
#
# Copyright (c) 2020 ProLNat - CiTIUS (USC)
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
use Test::More tests => 10;
use lib '.';

BEGIN {
    do 'tagger/pt/splitter-pt_exe.perl';
}

####################################################################################
# input data

my $tokens = [
    [
        'A', 'partir', 'disso', ',', 'sistematizou', 'sua', 'vocação', 'para',
        'estudos', 'de', 'natureza', 'social', 'e', 'para', 'a', 'análise',
        'das', 'manifestações', 'artísticas', '.', ''
    ],
    [
        'Os', 'Estados', 'devem', 'notificar', 'as', 'disposições',
        'correspondentes', 'àqueloutras', 'previstas', 'no', 'regulamento',
        'à', 'Comissão', ''
    ],
    [
        'Algumas', 'vezes', ',', 'é', 'mais', 'eficaz', 'o', 'conhecido',
        'ditado', 'aparentemente', 'contraditório', 'dos', 'gregos',
        'antigos', '"', 'devagar', 'se', 'vai', 'ao', 'longe',
        '"', '.', ''
    ],
];
my $expected_tokens = [
    [
        'A_partir_de', 'isso', ',', 'sistematizou', 'sua', 'vocação', 'para',
        'estudos', 'de', 'natureza', 'social', 'e', 'para', 'a', 'análise',
        'de', 'as', 'manifestações', 'artísticas', '.', ''
    ],
    [
        'Os', 'Estados', 'devem', 'notificar', 'as', 'disposições',
        'correspondentes', 'a', 'aquelas', 'outras', 'previstas', 'em', 'o',
        'regulamento', 'a', 'a', 'Comissão', ''
    ],
    [
        'Algumas', 'vezes', ',', 'é', 'mais', 'eficaz', 'o', 'conhecido',
        'ditado', 'aparentemente', 'contraditório', 'de', 'os', 'gregos',
        'antigos', '"', 'devagar', 'se', 'vai', 'a_o_longe',
        '"', '.', ''
    ],
];

my $splitted_with_locs = [
    [
        'Apesar', 'de', 'a', 'derrota', 'dentro', 'de', 'casa', ',', 'o',
        'Juventude', 'ainda', 'não', 'beijou', 'a', 'lona', '.', ''
    ],
    [
        'Um', 'presente', 'é', 'algo', 'que', 'é', 'dado', 'de', 'graça',
        '.', ''
    ],
    [
        'Este', 'mecanismo', 'opera', 'mediante', 'a', 'isolação', 'de', 'ar',
        'morno', 'dentro', 'de', 'uma', 'estrutura', 'de', 'modo', 'que', 'o',
        'calor', 'não', 'é', 'perdido', 'pela', 'convecção', '.', ''
    ],
    [
        'Além', 'de', 'as', 'informações', 'que', 'você', 'decide', 'submeter',
        ',', 'nossos', 'sistemas', 'são', 'programados', 'para', 'recolher',
        'certas', 'informações', 'pessoais', '.', ''
    ],
];
my $expected_splitted_with_locs = [
    [
        'Apesar_de', 'a', 'derrota', 'dentro', 'de', 'casa', ',', 'o',
        'Juventude', 'ainda', 'não', 'beijou', 'a', 'lona', '.', ''
    ],
    [
        'Um', 'presente', 'é', 'algo', 'que', 'é', 'dado', 'de_graça', '.', ''
    ],
    [
        'Este', 'mecanismo', 'opera', 'mediante', 'a', 'isolação', 'de', 'ar',
        'morno', 'dentro', 'de', 'uma', 'estrutura', 'de_modo_que', 'o',
        'calor', 'não', 'é', 'perdido', 'pela', 'convecção', '.', ''
    ],
    [
        'Além_de', 'as', 'informações', 'que', 'você', 'decide', 'submeter',
        ',', 'nossos', 'sistemas', 'são', 'programados', 'para', 'recolher',
        'certas', 'informações', 'pessoais', '.', ''
    ],
];
###############################################################################


###############################################################################
# tests

can_ok('Splitter', 'splitter')
    or BAIL_OUT("failed to use Splitter::splitter");
can_ok('Splitter', 'join_locutions')
    or BAIL_OUT("failed to use Splitter::join_locutions");

# test function splitter
ok(scalar @{Splitter::splitter([])} == 1, "test_empty_sentence_returns_one_token");
for(my $i=0; $i < scalar @$tokens; $i++)
{
    is_deeply(
        Splitter::splitter($tokens->[$i]),
        $expected_tokens->[$i],
        "test_splitter_with_tokens"
    );
}

# test function join_locutions
for(my $i=0; $i < scalar @$splitted_with_locs; $i++)
{
    is_deeply(Splitter::join_locutions(
        $splitted_with_locs->[$i]),
        $expected_splitted_with_locs->[$i],
        "test_splitted_tokens_with_locs"
    );
}
