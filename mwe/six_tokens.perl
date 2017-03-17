#!/usr/bin/perl

# O GERADOR DE 6-GRAMAS
#lê um texto taggeado
#escreve seis lemas taggeados por linha (6gramas)
package SixTokens;

use strict;#<ignore-line> 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use open qw(:std :utf8);

{#<main>
	my $prev1 = "#";#<string>
	my $prev2 = "#";#<string>
	my $prev3 = "#";#<string>
	my $prev4 = "#";#<string>
	my $prev5 = "#";#<string>
	while (my $line = <STDIN>) {#<string>
		chop($line);
		my ($token, $tag, $lema) = split (" ", $line);#<string>
		#$lema = "$lema\#$ling";
		my $tagged = "$token\_$tag";#<string>


		print "$prev1 $prev2 $prev3 $prev4 $prev5 $tagged\n";
		$prev1 = $prev2;
		$prev2 = $prev3;
		$prev3 = $prev4;
		$prev4 = $prev5;
		$prev5 = $tagged;
	}
}

#print STDERR "foi gerado o ficheiro de 4gramas\n";
