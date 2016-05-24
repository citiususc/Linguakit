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


do $abs_path.'/Modules/sentences-es.perl';



my $line;
my @sentences;
my $saida;

##lançando funçoes:

while ($line = <STDIN>) {
  chomp $line;
  if (!$line) {next}
  @sentences = sentences($line);
  $saida = join("\n",@sentences);
  print "$saida" ;
}
###########

