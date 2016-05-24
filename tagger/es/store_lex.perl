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

my $output = $abs_path."/lexicon/lex_stored";



###########################################################

##cargando o lexico freeling e mais variaveis globais
my %Entry;
my %Lex;
my %StopWords;
my %Noamb;
while (my $line = <LEX>) {
    
    chomp $line;
    #print STDERR "#$line#\n";
    (my @entry) = split (" ", $line);
    my $token = $entry[0];
    
    (my $entry) = ($line =~ /^[^ ]+ ([\w\W]+)$/);
    $Entry{$token} = $entry;
    my $i=1;
    while ($i<=$#entry) {
        my $lemma =  $entry[$i];
        $i++  ;
        my $tag =  $entry[$i];
	#$Lex{$token}{$lemma} = $tag;
        $Lex{$token}++;
        $StopWords{$token} = $tag if ($tag =~ /^(P|SP|R|D|I|C)/);
        $i++;
       # print STDERR "-->#$token#\n";
    }
    if  ($#entry == 2 && $entry[2] =~ /^NP/) { ##identificar formas nao ambiguas que sao nomes proprios
	    $Noamb{$token}=1;
           # print  "NOAMB: $entry[0] $entry[1] $entry[2]\n";
    } 
}

store [\%Entry, \%Lex, \%StopWords, \%Noamb],  $output;
