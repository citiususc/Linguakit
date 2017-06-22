#!/usr/bin/env perl

#Separador de frases
#autor: Grupo ProlNat@GE, CITIUS
#Universidade de Santiago de Compostela


# SEPARA FRASES IDENTIFICANDO O PONTO FINAL

package Normalizer;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

# Absolute path 
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(__FILE__);#<ignore-line>


sub normalizer {
	my ($str) = @_ ;#<string>
	my @saida=();#<list><string> 

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


	my $patron_url = qr/(?:\s|^|\W)(news|http|https|ftp|ftps):\/\/[^\s\n]*/;#<string>
	my $patron_referencia_o_hashtag = qr/(?:\s|^|\"|\“)(@|#)[^\s\n]*/;#<string>

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
	return \@saida;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	normalizer(\@lines);
}
#<ignore-block>

