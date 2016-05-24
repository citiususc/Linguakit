#!/usr/bin/perl

#Separador de frases
#autor: Pablo Gamallo
#Grupo ProlNat@GE, CITIUS
#Universidade de Santiago de Compostela


# SEPARA FRASES IDENTIFICANDO O PONTO FINAL

use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));


sub normalizer {
  my ($str) = @_ ;

  my @saida;

  $str = lc $str;

  $str =~ s/a[a]+/a/g;
  $str =~ s/e[e]+/e/g;
  $str =~ s/i[i]+/i/g;
  $str =~ s/o[o]+/o/g;
  $str =~ s/u[u]+/u/g;
 
  $str =~ s/ q / que /g;
  $str =~ s/ x / por /g;
  $str =~ s/ d / de /g;
  $str =~ s/ x / por /g;
  $str =~ s/ xq / porque /g;

  ##emoticon
  $str =~ s/\:\)/ EMOT_POS /g;
  $str =~ s/\:\-\)/ EMOT_POS /g;
  $str =~ s/\;\-\)/ EMOT_POS /g;
  $str =~ s/\;\)/ EMOT_POS /g;
  $str =~ s/\:o\)/ EMOT_POS /g;
  $str =~ s/\:\]/ EMOT_POS /g;
  $str =~ s/\:\>/ EMOT_POS /g;
  $str =~ s/\:\-D/ EMOT_POS /g;
  $str =~ s/\:D/ EMOT_POS /g;

  $str =~ s/[xX:][dD][D]*/ EMOT_POS /g;

  $str =~ s/\:\(/ EMOT_NEG /g;
  $str =~ s/\:\-\(/ EMOT_NEG /g;
  $str =~ s/\:\[/ EMOT_NEG /g;
  $str =~ s/\:\-\[/ EMOT_NEG /g;

  $str =~ s/\bj[aei]\b/ EMOT_POS /g;
  $str =~ s/j[aei]j[aei][ja]*/ EMOT_POS /g;
  $str =~ s/haha[ha]*/ EMOT_POS /g;
 

  my $patron_url = qr/(?:\s|^|\W)(news|http|https|ftp|ftps):\/\/[^\s\n]*/ ;
  my $patron_referencia_o_hashtag = qr/(?:\s|^|\"|\“)(@|#)[^\s\n]*/ ;

  $str =~ s/\"//g;

  $str =~ s/^\s*(.*\S)\s*$/$1/;
  $str =~ s/\]\]$//;
  $str =~ s/!\[CDATA\[//;

  $str =~ s/$patron_url/ /g ;
  # borrar las referencias y los hashtags
  $str =~ s/$patron_referencia_o_hashtag/ /g ;
   # eliminar puntos de las siglas
  $str =~ s/([A-Z])\.([A-Z])/$1$2/g;

  push (@saida, $str);

  return @saida;
}


