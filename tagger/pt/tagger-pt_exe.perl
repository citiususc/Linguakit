#!/usr/bin/perl

#ProLNat NER 
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela



use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));

do $abs_path.'/Modules/tagger-pt.perl';


#####EXECUTANDO AS FUNÇOES:
my @ner = <STDIN>;
my @tagged = tagger_pt(@ner);
my $saida = join("\n",@tagged);
print "$saida";
###########

