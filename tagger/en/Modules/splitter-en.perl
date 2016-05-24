#!/usr/bin/perl

# ProLNat Tokenizer (provided with Sentence Identifier)
# autor: Grupo ProLNat@GE, CiTIUS
# Universidade de Santiago de Compostela

# Script que integra 2 funções perl: sentences e tokens

use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));

##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA######
#my $pron = "(ve|ll|s|re|m|d)";               # Antes do tagger só separa o genetivos dos nomes próprios        
###############################################
my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";

sub splitter {
    my (@text) = @_ ;
    
    my @saida;
    
    ##lendo entrada (tokens)
    for (my $i=0;$i<=$#text;$i++) {
	chomp $text[$i];
	my $token = $text[$i];  

	# Split

#	$token =~ s/^àquela$/a aquela/g;
#	$token =~ s/\baonde\b/a onde$1/g;
#	$token =~ s/\bestoutra\b/este outra/g;    

	##splitting tokens:
	if ($token =~ / / ) {
	    (my @tokens) = split (" ", $token) ;
	    foreach my $tok (@tokens) {
		push (@saida, $tok);
	    }
	}
	else {
	    push (@saida, $token); 
	}
    }    
    return @saida;
} 

sub lowercase {
    my ($x) = @_ ;
    $x = lc ($x);
    $x =~  tr/ÁÉÍÓÚÇÑ/áéíóúçñ/;
    
    return $x;    
} 

