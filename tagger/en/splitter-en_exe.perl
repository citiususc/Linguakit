#!/usr/bin/env perl

# ProLNat Tokenizer (provided with Sentence Identifier)
# autor: Grupo ProLNat@GE, CiTIUS
# Universidade de Santiago de Compostela

## In English, nothing is done (some splitting was made in tokens.perl)
package Splitter;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA######
#my $pron = "(ve|ll|s|re|m|d)";               # Antes do tagger só separa o genetivos dos nomes próprios        
###############################################
#my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";

sub splitter {
    my ($tokens) = @_;#<ref><list><string>
    my @saida = ();#<list><string>
    foreach my $token (@{$tokens}) {
		chomp $token;
		if ($token =~ /\n/) {
		    my @tokens = split ('\n', $token);

		    foreach my $t (@tokens) { ##no caso de haver saltos de linha to token
	#		 print STDERR "TOKEN: #$t#\n";
			if($pipe){#<ignore-line>
			    print "$t\n";#<ignore-line>
			}else{#<ignore-line>
			    push (@saida, $t); 	
			}#<ignore-line>

		    }
		}
		else{

		    if($pipe){#<ignore-line>
	       		print "$token\n";#<ignore-line>
		    }else{#<ignore-line>
       			push (@saida, $token); 	
		    }#<ignore-line>
		}
    }
   
		return \@saida;
}

#<ignore-block>
if($pipe){
	while (my $token = <STDIN>) {
	    chomp $token;
	    print "$token\n"; 
	} 
}
#<ignore-block>

