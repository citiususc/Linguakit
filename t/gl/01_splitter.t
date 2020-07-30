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
use Test::More tests => 11;
use lib '.';

BEGIN {
    do 'tagger/gl/splitter-gl_exe.perl';
}

####################################################################################
# input data

my $tokens = [
    [
        'A', 'pesar', 'deles', 'levouse', 'a', 'cabo', 'o', 'proxecto', '.', ''
    ],
    [
        'De', 'tanto', 'darlle', 'voltas', 'aos', 'nomes', 'a', 'eito', ',',
        'non', 'sería', 'en', 'absoluto', 'de', 'estrañar', '.', '', 
    ],
    [
        'O', 'irmanciño', 'entrou', ',', 'deuche', 'unha', 'malleira', 'e', 'colleuchas', '?', ''
    ],
    [
        'Meu', 'fillo', 'aproboumas', 'todas', '.', ''
    ],
    [
        'Onte', 'estiven', 'nun', 'concerto', 'na', 'Casa', 'das', 'Crechas', '.', ''
    ],
];
my $expected_tokens = [
    [
        'A_pesar_de', 'eles', 'levou', 'se', 'a', 'cabo', 'o', 'proxecto', '.', ''
    ],
    [
        'De', 'tanto', 'dar', 'lle', 'voltas', 'a', 'os', 'nomes', 'a_eito',
        ',', 'non', 'sería', 'en', 'absoluto', 'de', 'estrañar', '.', '', 
    ],
    [
        'O', 'irmanciño', 'entrou', ',', 'deu', 'che', 'unha', 'malleira', 'e', 'colleu', 'che', 'as', '?', ''
    ],
    [
        'Meu', 'fillo', 'aprobou', 'me', 'as', 'todas', '.', ''
    ],
    [
        'Onte', 'estiven', 'en', 'un', 'concerto', 'en', 'a', 'Casa', 'de', 'as', 'Crechas', '.', ''
    ],
];

my $splitted_with_locs = [
    [
        'Semella', 'que', 'este', 'país', 'vive', 'a', 'berros', '.', ''
    ],
    [
        'Eles', 'desenvolveron', 'un', 'pan', 'de', 'trigo', 'sen', 'fermento',
        ',', 'e', 'tamén', 'un', 'tipo', 'de', 'queixo', 'a', 'partir', 'de',
        'animais', 'alimentados', 'con', 'pasto', '.', ''
    ],
    [
        'Falou', 'lles', 'a', 'Gandalf', 'e', 'ós', 'demais', 'a', 'modo', ',',
        'con', 'palabras', 'cheas', 'de', 'desprezo', 'e', 'odio', ',', 'e',
        'amosou', 'lles', 'a', 'modo', 'de', 'proba', 'as', 'pezas', 'de',
        'roupa', 'que', 'lle', 'confiscaron', 'a', 'Frodo', 'en', 'a', 'torre',
        'de', 'Cirith', 'Ungol', '.', ''

    ]
];
my $expected_splitted_with_locs = [
    [
        'Semella', 'que', 'este', 'país', 'vive', 'a_berros', '.', ''
    ],
    [
        'Eles', 'desenvolveron', 'un', 'pan', 'de', 'trigo', 'sen', 'fermento',
        ',', 'e', 'tamén', 'un', 'tipo', 'de', 'queixo', 'a_partir_de',
        'animais', 'alimentados', 'con', 'pasto', '.', ''
    ],
    [
        'Falou', 'lles', 'a', 'Gandalf', 'e', "ós", 'demais', 'a_modo', ',',
        'con', 'palabras', 'cheas', 'de', 'desprezo', 'e', 'odio', ',', 'e',
        'amosou', 'lles', 'a_modo_de', 'proba', 'as', 'pezas', 'de', 'roupa',
        'que', 'lle', 'confiscaron', 'a', 'Frodo', 'en', 'a', 'torre', 'de',
        'Cirith', 'Ungol', '.', ''
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
