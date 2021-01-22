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
use Test::More tests => 41;
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
    [
        'Cruzó', 'la', 'puerta', 'para', 'acompañarle', 'a', 'la', 'calle',
        'y', 'oírle', 'contar', 'su', 'historia', '.', ''
    ],
    [
        'Pensó', 'en', 'irse', 'muchas', 'veces', '.', ''
    ],
    [
        'Pero', 'como', 'tampoco', 'quería', 'ser', 'grosera', 'cerrándome',
        'la', 'puerta', 'o', 'yéndose', 'a', 'otra', 'habitación', ',', 'su',
        'murmullo', 'me', 'siguió', 'alcanzando', '.', ''
    ],
    [
        'La', 'melancolía', 'generalizada', 'estaba', 'a', 'punto', 'de',
        'contagiárseles', 'a', 'las', 'ovejas', '.', ''
    ],
    [
        'El', 'fango', 'iba', 'pegándoseles', 'a', 'las', 'suelas', 'mientras',
        'correteaban', 'de', 'aquí', 'para', 'allá', '.', ''
    ],
    [
        'Se', 'aproximó', 'a', 'las', 'ventanas', 'de', 'la', 'mansión,',
        'zambulléndose', 'en', 'la', 'dulce', 'y', 'triste', 'melodía', 'del',
        'estudio', '.', ''
    ],
    [
        'Luego', 'envíalos', 'de', 'vuelta', 'a', 'Nueva', 'York', 'en', 'una',
        'maldita', 'ambulancia', '.', ''
    ],
    [
        'Coge', 'sus', 'pertenencias', 'personales', 'de', 'su', 'mesa', ',',
        'mételas', 'en', 'una', 'caja', 'y', 'envíasela', 'a', 'su', 'casa',
        'esta', 'misma', 'mañana', '.', ''
    ],
    [
        'Lleváoslo', 'a', 'su', 'dormitorio', 'y', 'vigiladle', 'bien', '.', ''
    ],
    [
        'Agradezcámoselo', 'entonces', 'a', 'los', 'presentes', 'y',
        'dejémoslo', 'así', '.', ''
    ],
    [
        'Llévatelos', 'lejos', 'de', 'aquí', 'y', 'ponlos', 'a', 'salvo',
        '.', ''
    ],
    [
        'Repartíoslas', 'y', 'que', 'cada', 'medio', 'publique',
        'varias', '.', ''
    ],
    [
        'Pues', 'déjala', 'tú', 'a', 'ella', ',', 'acaba', 'con', 'esta',
        'tortura', 'de', 'una', 'vez', 'y', 'daos', 'la', 'oportunidad',
        'de', 'ser', 'felices', '.', ''
    ],
    [
        'Madres', 'del', 'mundo', 'uníos', ',', 'sonreíos', 'y', 'olvidaos',
        'de', 'los', 'deberes', 'maternales', 'por', 'un', 'día', '.'
    ],
    [
        'Me', 'tocaba', 'exigirle', 'su', 'historia', ',', 'oírsela', 'y',
        'debía', 'además', 'transmitírselo', 'a', 'los', 'otros', '.', ''
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
    [
        'Cruzó', 'la', 'puerta', 'para', 'acompañar', 'le', 'a', 'la',
        'calle', 'y', 'oír', 'le', 'contar', 'su', 'historia', '.', ''
    ],
    [
        'Pensó', 'en', 'ir', 'se', 'muchas', 'veces', '.', ''
    ],
    [
        'Pero', 'como', 'tampoco', 'quería', 'ser', 'grosera', 'cerrando',
        'me', 'la', 'puerta', 'o', 'yendo', 'se', 'a', 'otra', 'habitación',
        ',', 'su', 'murmullo', 'me', 'siguió', 'alcanzando', '.', ''
    ],
    [
        'La', 'melancolía', 'generalizada', 'estaba', 'a_punto_de',
        'contagiar', 'se', 'les', 'a', 'las', 'ovejas', '.', ''
    ],
    [
        'El', 'fango', 'iba', 'pegando', 'se', 'les', 'a', 'las', 'suelas',
        'mientras', 'correteaban', 'de', 'aquí', 'para', 'allá', '.', ''
    ],
    [
        'Se', 'aproximó', 'a', 'las', 'ventanas', 'de', 'la', 'mansión,',
        'zambullendo', 'se', 'en', 'la', 'dulce', 'y', 'triste', 'melodía',
        'de', 'el', 'estudio', '.', ''
    ],
    [
        'Luego', 'envía', 'los', 'de', 'vuelta', 'a', 'Nueva', 'York', 'en',
        'una', 'maldita', 'ambulancia', '.', ''
    ],
    [
        'Coge', 'sus', 'pertenencias', 'personales', 'de', 'su', 'mesa', ',',
        'mete', 'las', 'en', 'una', 'caja', 'y', 'envía', 'se', 'la', 'a',
        'su', 'casa', 'esta', 'misma', 'mañana', '.', ''
    ],
    [
        'Llevad', 'os', 'lo', 'a', 'su', 'dormitorio', 'y', 'vigilad', 'le',
        'bien', '.', ''
    ],
    [
        'Agradezcamos', 'se', 'lo', 'entonces', 'a', 'los', 'presentes', 'y',
        'dejemos', 'lo', 'así', '.', ''
    ],
    [
        'Lleva', 'te', 'los', 'lejos', 'de', 'aquí', 'y', 'pon', 'los', 'a',
        'salvo', '.', ''
    ],
    [
        'Repartid', 'os', 'las', 'y', 'que', 'cada', 'medio', 'publique',
        'varias', '.', ''
    ],
    [
        'Pues', 'deja', 'la', 'tú', 'a', 'ella', ',', 'acaba', 'con', 'esta',
        'tortura', 'de', 'una', 'vez', 'y', 'dad', 'os', 'la', 'oportunidad',
        'de', 'ser', 'felices', '.', ''
    ],
    [
        'Madres', 'de', 'el', 'mundo', 'unid', 'os', ',', 'sonreíd', 'os',
        'y', 'olvidad', 'os', 'de', 'los', 'deberes', 'maternales', 'por',
        'un', 'día', '.', ''
    ],
    [
        'Me', 'tocaba', 'exigir', 'le', 'su', 'historia', ',', 'oír', 'se',
        'la', 'y', 'debía', 'además', 'transmitir', 'se', 'lo', 'a', 'los',
        'otros', '.', ''
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
    [ 'oídos', 1 ],
    [ 'Vela', 1 ],
    [ 'correos', 2 ]
];
my $expected_tokens_with_position = [
    0, 1, 0, 0, 1, 1, 0
];
my $tokens_to_be_accented = [
    'contrapon', 'entredi', 'sé', 'ANTEPON', 'Subyaz'
];
my $expected_tokens_to_be_accented = [
    'contrapón', 'entredí', 'sé', 'ANTEPÓN', 'Subyáz'
];
###############################################################################


###############################################################################
# tests

can_ok('Splitter', 'splitter')
    or BAIL_OUT("failed to use Splitter::splitter");
can_ok('Splitter', 'join_locutions')
    or BAIL_OUT("failed to use Splitter::join_locutions");
can_ok('Splitter', 'is_ambiguous')
    or BAIL_OUT("failed to use Splitter::is_ambiguous");
can_ok('Splitter', 'accent_last_vowel')
    or BAIL_OUT("failed to use Splitter::accent_last_vowel");

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

# test function is_ambiguous
for(my $i=0; $i < scalar @$tokens_with_position; $i++)
{
    is(Splitter::is_ambiguous(
        $tokens_with_position->[$i][0], $tokens_with_position->[$i][1]),
        $expected_tokens_with_position->[$i],
        "test_tokens_ambiguous"
    );
}

# test function accent_last_vowel
for(my $i=0; $i < scalar @$tokens_to_be_accented; $i++)
{
    is(Splitter::accent_last_vowel(
        $tokens_to_be_accented->[$i]),
        $expected_tokens_to_be_accented->[$i],
        "test_tokens_to_be_accented"
    );
}
