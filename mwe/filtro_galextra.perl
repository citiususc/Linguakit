#!/usr/bin/env perl

##Toma como entrada a saída do PoS tagger e devolve um texto etiquetado com algumas modificaçoes: verbos compostos, elimina determinantes e pronomes, etc.
package FiltroGalExtra;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

sub filtro{

	my @saida=();#<list><string>
	my ($lines) = @_;#<ref><list><string>

	for my $line (@{$lines}){
		chomp($line);

		if ($line eq "") {
			next;
		}else {
			#troca o simbolo de composicao:
			$line =~ s/\_/\&/g;
			my @line = split(" ", $line);#<array><string> 
			
			if(@line < 3){
				next;
			}
			my ($pal, $lema, $tag) = @line;#<string>
    
			#mudar tags de numero e adv
			if ($tag && $tag =~  /^Z/) {
				$tag = "CARD";
				$lema = "\@card\@";
			}

			if ($tag && $tag =~ /^R/) {
				$tag = "ADV";
			}

			##fora artigos e encliticos e aspas
			if   ( ($tag =~ /^D/) || ( $tag =~ /^PP/) || ( $tag =~ /^P0/) ||  ($tag eq "Fe") ) {
			}
			##correcçoes ad hoc de problemas de etiquetaçao:
			elsif ( ($lema =~ /^pol[oa](s?)$/) && ($tag =~ /^SP/) ) {
				$lema = "por" ;
				if($pipe){#<ignore-line>
					printf ("%s\t%s\t%s\n", $pal, $tag, $lema);#<ignore-line>
				}else{#<ignore-line>
					push(@saida, "$pal\t$tag\t$lema");
				}#<ignore-line>
			}
			##colocar a forma do nome proprio como lema
			elsif ($tag =~ /^NP/) {
				if($pipe){#<ignore-line>
					printf ("%s\t%s\t%s\n", $pal, $tag, $pal);#<ignore-line>
				}else{#<ignore-line>
					push(@saida, "$pal\t$tag\t$pal");
				}#<ignore-line>
			}
			else {
				if($pipe){#<ignore-line>
					printf ("%s\t%s\t%s\n", $pal, $tag, $lema);#<ignore-line>
				}else{#<ignore-line>
					push(@saida, "$pal\t$tag\t$lema");
				}#<ignore-line>
			} 
		}
	}
	return \@saida;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	filtro(\@lines);
}
#<ignore-block>
