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

# Absolute path
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(__FILE__);#<ignore-line>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

# ficheiros de recursos
my $LOC;#<file>
open($LOC, $abs_path."/lexicon/locutions.txt") or die "Unable to open file locutions.txt: $!\n";
binmode $LOC, ':utf8';#<ignore-line>


##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA######
#my $pron = "(ve|ll|s|re|m|d)";               # Antes do tagger só separa o genetivos dos nomes próprios        
###############################################
#my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";

my @Loc;#<list><string>
while(<$LOC>){#<string>
    chomp;
    if(/^\s*#/ or /^\s*$/) { next; }
    my ($token, $lemma, $tag) = split/ /;
    $token =~ s/_/ /g;
    push(@Loc, $token);
}
close $LOC;

sub join_locutions {
    my $text = shift;#<ref><list>
    my $input = join(" ", @$text);#<string>

    for my $loc (sort { length $b <=> length $a } @Loc)
    {
        while($input =~ /\b($loc)\b/i)
        {
            my $pos = $-[0];
            my $match = $1;

            ($match = $1) =~ s/ /_/g;
            substr($input, $pos, length($match), $match);
        }
    }
    return [split(/ /, $input), ''];
}

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
   
	return join_locutions(\@saida);
}

#<ignore-block>
if($pipe){
	while (my $token = <STDIN>) {
	    chomp $token;
	    print "$token\n"; 
	} 
}
#<ignore-block>

