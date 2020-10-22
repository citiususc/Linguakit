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
use Test::More tests => 17;
use lib '.';

BEGIN {
    do 'tagger/es/splitter-es_exe.perl';
}

####################################################################################
# input data

my $tokens = [
    [
        'Vivo', 'en', 'Noruega', 'a', 'pesar', 'del', 'frío', '.', ''
    ],
    [
        'Algunos', 'empleados', 'trabajan', 'a', 'comisión', ',', 'ya',
        'sea', 'como', 'complemento', 'de', 'un', 'sueldo', 'o', 'en',
        'lugar', 'de', 'un', 'salario', 'fijo', '.', ''
    ],
    [
        'Suecia', ',', 'la', 'excepción', 'del', 'coronavirus', 'que',
        'confirma', 'el', 'gran', 'problema', 'de', 'la', 'UE', '.', ''
    ],
    [
        'Cómpralo', 'para', 'mejorar', 'y', 'transformar', 'tus', 'ensaladas',
        'favoritas', ',', 'y', 'siéntete', 'bien', 'al', 'dárselo', 'a',
        'tu', 'familia', '.', ''
    ],
    [
        'Úsalo', 'con', 'precaución', ',', 'ya', 'que', 'su', 'fórmula',
        'incluye', 'algunas', 'sustancias', 'químicas', '.', ''
    ],
    [
        '¡', 'Correos', 'a', 'un', 'lado', ',', 'tenemos', 'que', 'ir', 'a',
        'Correos', '!', ''
    ],
    [
        'Parádsela', '.', ''
    ],
];
my $expected_tokens = [
    [
        'Vivo', 'en', 'Noruega', 'a_pesar_de', 'el', 'frío', '.', ''
    ],
    [
        'Algunos', 'empleados', 'trabajan', 'a_comisión', ',', 'ya',
        'sea', 'como', 'complemento', 'de', 'un', 'sueldo', 'o',
        'en_lugar_de', 'un', 'salario', 'fijo', '.', ''
    ],
    [
        'Suecia', ',', 'la', 'excepción', 'de', 'el', 'coronavirus', 'que',
        'confirma', 'el', 'gran', 'problema', 'de', 'la', 'UE', '.', ''
    ],
    [
        'Compra', 'lo', 'para', 'mejorar', 'y', 'transformar', 'tus',
        'ensaladas', 'favoritas', ',', 'y', 'siente', 'te', 'bien', 'a',
        'el', 'dar', 'se', 'lo', 'a', 'tu', 'familia', '.', ''
    ],
    [
        'Usa', 'lo', 'con', 'precaución', ',', 'ya_que', 'su', 'fórmula',
        'incluye', 'algunas', 'sustancias', 'químicas', '.', ''
    ],
    [
        '¡', 'Corred', 'os', 'a', 'un', 'lado', ',', 'tenemos', 'que', 'ir',
        'a', 'Correos', '!', ''
    ],
    [
        'Parad', 'se', 'la', '.', ''
    ],
];

my $splitted_with_locs = [
    [
        'A', 'pesar', 'de', 'la', 'distancia', 'a', 'cada', 'paso', 'me',
        'escapo', 'a', 'el', 'campo', '.', ''
    ],
    [
        'Un', 'paso', 'importante', 'lo', 'constituye', 'la', 'creación', 'de',
        'el', 'nuevo', 'Ministerio', 'de', 'Ciencia', 'y', 'Tecnología', ',',
        'ya', 'que', 'supone', 'un', 'salto', 'adelante', 'en', 'las',
        'condiciones', 'de', 'la', 'actuación', 'pública', 'en',
        'investigación', '.', ''
    ],
];
my $expected_splitted_with_locs = [
    [
        'A_pesar_de', 'la', 'distancia', 'a_cada_paso', 'me', 'escapo',
        'a', 'el', 'campo', '.', ''
    ],
    [
        'Un', 'paso', 'importante', 'lo', 'constituye', 'la', 'creación', 'de',
        'el', 'nuevo', 'Ministerio_de_Ciencia_y_Tecnología', ',', 'ya_que',
        'supone', 'un', 'salto', 'adelante', 'en', 'las', 'condiciones', 'de',
        'la', 'actuación', 'pública', 'en', 'investigación', '.', ''
    ],
];
my $tokens_with_position = [
    [ 'Correos', 0 ],
    [ 'Correos', 7 ],
    [ 'actuación', 3 ],
    [ 'Bueu', 5 ],
];
my $expected_tokens_with_position = [
    0, 1, 0, 0,
];
###############################################################################


###############################################################################
# tests

can_ok('Splitter', 'splitter')
    or BAIL_OUT("failed to use Splitter::splitter");
can_ok('Splitter', 'join_locutions')
    or BAIL_OUT("failed to use Splitter::join_locutions");
can_ok('Splitter', 'is_entity')
    or BAIL_OUT("failed to use Splitter::is_entity");

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

# test function is_entity
for(my $i=0; $i < scalar @$tokens_with_position; $i++)
{
    is(Splitter::is_entity(
        $tokens_with_position->[$i][0], $tokens_with_position->[$i][1]),
        $expected_tokens_with_position->[$i],
        "test_tokens_ambiguous_with_entities"
    );
}
