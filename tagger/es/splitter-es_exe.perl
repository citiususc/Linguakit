#!/usr/bin/perl

#ProLNat Tokenizer (provided with Sentence Identifier)
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Script que integra 2 funçoes perl: sentences e tokens


use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));

do $abs_path.'/Modules/splitter-es.perl';
#do '/home/gamallo/ProlnatTools/es/Modules/splitter-es.perl';



#####EXECUTANDO AS FUNÇOES:
my @tokens = <STDIN>;
#print "Tok: #@tokens#";
my @saida = splitter(@tokens);
#print "SAI: #@saida#";
my $saida = join("\n",@saida);
print "$saida";
###########





