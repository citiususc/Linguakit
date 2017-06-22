#!/usr/bin/env perl

# O GERADOR DE 6-GRAMAS
#lê um texto taggeado
#escreve seis lemas taggeados por linha (6gramas)
package SixTokens;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

sub sixTokens{

	my @saida=();#<list><string>
	my ($lines) = @_;#<ref><list><string>

	my $prev1 = "#";#<string>
	my $prev2 = "#";#<string>
	my $prev3 = "#";#<string>
	my $prev4 = "#";#<string>
	my $prev5 = "#";#<string>

	for my $line (@{$lines}){
		chomp($line);

		my ($token, $tag, $lema) = split (" ", $line);#<string>
		#$lema = "$lema\#$ling";
		my $tagged = "$token\_$tag";#<string>

		if($pipe){#<ignore-line>
			print ("$prev1 $prev2 $prev3 $prev4 $prev5 $tagged\n");#<ignore-line>
		}else{#<ignore-line>
			push(@saida, "$prev1 $prev2 $prev3 $prev4 $prev5 $tagged");
		}#<ignore-line>
		
		$prev1 = $prev2;
		$prev2 = $prev3;
		$prev3 = $prev4;
		$prev4 = $prev5;
		$prev5 = $tagged;
	}
	return \@saida;
}

#print STDERR "foi gerado o ficheiro de 4gramas\n";

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	sixTokens(\@lines);
}
#<ignore-block>