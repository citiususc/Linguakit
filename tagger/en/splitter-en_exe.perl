#!/usr/bin/perl

# ProLNat Tokenizer (provided with Sentence Identifier)
# autor: Grupo ProLNat@GE, CiTIUS
# Universidade de Santiago de Compostela

## In English, nothing is done (some splitting was made in tokens.perl)

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
#my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";


#sub splitter {
while (my $token = <STDIN>) {
   print $token;    
 
} 

