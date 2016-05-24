#!/usr/bin/perl

#Separador de frases
#autor: Grupo ProlNat@GE, CITIUS
#Universidade de Santiago de Compostela


# SEPARA FRASES IDENTIFICANDO O PONTO FINAL

#use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));


do $abs_path.'/Modules/normalizer-en.perl';




##lançando funçoes:
my @texto = <STDIN>;
my $texto = join("",@texto);
my @sentences = normalizer($texto);
my $saida = join("\n",@sentences);
print "$saida";
###########

