#!/usr/bin/env perl

# ProLNat Tokenizer (provided with Sentence Identifier)
# autor: Grupo ProLNat@GE, CiTIUS
# Universidade de Santiago de Compostela

## In English, nothing is done (some splitting was made in tokens.perl)
package Splitter;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA######
#my $pron = "(ve|ll|s|re|m|d)";               # Antes do tagger só separa o genetivos dos nomes próprios        
###############################################
#my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";

sub splitter {
	return $_[0];
}

#<ignore-block>
if($pipe){
	while (my $token = <STDIN>) {
		print $token; 
	} 
}
#<ignore-block>

