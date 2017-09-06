#!/usr/bin/env perl

#ProLNat Tokenizer (provided with Sentence Identifier)
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela

package Store;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
use Storable qw(store retrieve freeze thaw dclone);
#<ignore-block>

# Absolute path 
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(__FILE__);#<ignore-line>

my $lex = $abs_path."/lexicon/lex_stored";#<ignore-line>

###########################################################

##cargando o lexico freeling e mais variaveis globais
my %Entry=();#<hash><string>
my $Entry;#<ref><hash><string>
my %Lex=();#<hash><integer>
my $Lex;#<ref><hash><integer>
my %StopWords=();#<hash><string>
my $StopWords;#<ref><hash><string>
my %Noamb=();#<hash><boolean>
my $Noamb;#<ref><hash><boolean>


#<ignore-block>
if (-e $lex) {
	my $arrayref = retrieve($lex); 
	$Entry = $arrayref->[0];
	$Lex = $arrayref->[1];
	$StopWords =  $arrayref->[2];
	$Noamb =  $arrayref->[3];
}else{
#<ignore-block>

	##ficheiros de recursos
	my $LEX;#<file>
	open ($LEX, $abs_path."/lexicon/dicc.src") or die "O ficheiro dicc não pode ser aberto: $!\n";
	binmode $LEX,  ':utf8';#<ignore-line>

	while (my $line = <$LEX>) {#<string>
		
		chomp $line;
		#print STDERR "#$line#\n";
		my @entry = split (" ", $line);#<array><string>
		my $token = $entry[0];#<string>

		(my $entry) = ($line =~ /^[^ ]+ ([\w\W]+)$/);#<string>
		$Entry{$token} = $entry;
		my $i=1;#<integer>
		while ($i<=$#entry) {
			my $lemma =  $entry[$i];#<string>
			$i++  ;
			my $tag =  $entry[$i];#<string>
			#$Lex{$token}{$lemma} = $tag;
			$Lex{$token}++;
			$StopWords{$token} = $tag if ($tag =~ /^(P|SP|R|D|I|C)/);
			$i++;
			#print STDERR "-->#$token#\n";
		}
		if ($#entry == 2 && $entry[2] =~ /^NP/) { ##identificar formas nao ambiguas que sao nomes proprios
			$Noamb{$token}=1;
			#print  "NOAMB: $entry[0] $entry[1] $entry[2]\n";
		} 
	}
	close $LEX;
	$Entry = \%Entry;
	$Lex = \%Lex;
	$StopWords = \%StopWords;
	$Noamb = \%Noamb;
	store [$Entry, $Lex, $StopWords, $Noamb],  $lex;#<ignore-line>
}#<ignore-line>

sub read{
	return($Entry, $Lex, $StopWords, $Noamb);
}


