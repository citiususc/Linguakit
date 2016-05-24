#!/usr/bin/perl

# ProLNat Tokenizer (provided with Sentence Identifier)
# autor: Grupo ProLNat@GE, CiTIUS
# Universidade de Santiago de Compostela

# Inglês > com base na versão de português

# Script que integra 2 funçoes perl: sentences e tokens

use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));

do $abs_path.'/Modules/tokens-en.perl';

#####EXECUTANDO AS FUNÇOES:
my @sentences = <STDIN>;
#my $sentences = join("",@sentences);
my @tokens = tokens(@sentences);
#print STDERR @tokens;
my $saida = join ("\n", @tokens);
$saida =~ s/\n\n/\n/g;
print "$saida\n";
###########
