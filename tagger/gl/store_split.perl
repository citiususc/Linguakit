#!/usr/bin/perl

#ProLNat Tokenizer (provided with Sentence Identifier)
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Script que armazena dous hashes no ficheiro comprimido ./lexicon/lex_store


use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
use Storable qw(store retrieve freeze thaw dclone);

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));



##ficheiros de recursos
open (LEX, $abs_path."/lexicon/dicc.src") or die "O ficheiro não pode ser aberto: $!\n";
binmode LEX,  ':utf8';

my $output = $abs_path."/lexicon/split_stored";



###########################################################



my %Verb;
my %NonVerb;
while (my $line = <LEX>) {
    chomp $line;
    my ($forma) = ($line =~ /^([^ ]+)/);
    if ($line =~ /V[MSA]/) {
     $Verb{$forma}++;
    }
    else {
     $NonVerb{$forma}++;
    }
 }

store [\%NonVerb, \%Verb],  $output;
