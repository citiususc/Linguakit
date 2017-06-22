#!/usr/bin/env perl

#ProLNat Tokenizer (provided with Sentence Identifier)
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Script que armazena dous hashes no ficheiro comprimido ./lexicon/split_store
package StoreSplit;

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

my $split = $abs_path."/lexicon/split_stored";#<ignore-line>

###########################################################

my %Verb=();#<hash><boolean>
my $Verb;#<ref><hash><boolean>
my %NonVerb=();#<hash><boolean>
my $NonVerb;#<ref><hash><boolean>

#<ignore-block>
if (-e $split) {
	my $arrayref = retrieve($split); 
	$NonVerb = $arrayref->[0];
	$Verb = $arrayref->[1];
}else{
#<ignore-block>

	##ficheiros de recursos
	my $LEX;#<file>
	open ($LEX, $abs_path."/lexicon/dicc.src") or die "O ficheiro dicc não pode ser aberto: $!\n";
	binmode $LEX,  ':utf8';#<ignore-line>

	while (my $line = <$LEX>) {#<string>
		chomp $line;
		my ($forma) = ($line =~ /^([^ ]+)/);#<string>
		if ($line =~ /V[MSA]/) {
			$Verb{$forma} = 1;
		}else {
			$NonVerb{$forma} = 1;
		}
	}
	close $LEX;
	$Verb = \%Verb;
	$NonVerb = \%NonVerb;
	store [$NonVerb, $Verb],  $split;#<ignore-line>
}#<ignore-line>

sub read{
	return($NonVerb, $Verb);
}
