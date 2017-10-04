#!/usr/bin/env perl

##Entrada: saida do Freeling
##Saida: entrada do parsingCascataByRegularExpressions.perl

package AdapterFreeling;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

## Lexemas gramaticais especiais:
my $AUX = "(have|avoir|ter|haber|haver)";#<string>
my $COP = "(be|être|ser)";#<string>


my $Pos = 0;#<integer>
my $FoundFinal=0;#<boolean>

sub adapter {

	my @saida=();#<list><string>
	my ($text) = @_;#<ref><list><string>
	my %Exp = ();#<hash><string>
	my $out="";#<string>

	foreach my $line (@{$text}) {
		chomp $line;
		
		if ($line eq "" && $FoundFinal) {
			next;
		}elsif ($line eq "" && !$FoundFinal) {##se hai um final de linha sem ponto final. So tem sentido com --flush
			# $Pos++;
			$out = "\.\tlemma:\.|tag:SENT|pos:$Pos|token:\.|\n";
			$FoundFinal = 1;
			$Pos = 0;
		} else {
			#troca do simbolo de composicao tipico de Freeling
			$line =~ s/\_/\@/g;

			my @tmp = split(" ", $line);#<array><string>
			if (@tmp < 3) {
				next;
			}
			my ($token, $lemma, $tag) = @tmp;#<string>

			## reiniciar valor de FoundFinal
			if ($Pos==0) {
				$FoundFinal = 0;
			}
			##correcçoes ad hoc de problemas de etiquetaçao:

			if ( ($lemma =~ /^pol[oa](s?)$/) && ($tag =~ /^SP/) ) {
				$lemma = "por";
			}

			#se temos um NP (nome proprio), colocar a forma no lema (para conservar a maiuscula)
			#se temos um possível nome próprio (desconhecido ou composto), colocar a forma no lemma (para conservar a maiuscula)
			if ( ($token =~ /\&/) || ($tag =~ /^NP/) ) {
				$lemma = $token;
			}
	  
			##tag conversion:
			#mudar tags:
			#if ($tag =~ /^VIRG/) {
				#$tag = "COMMA"
			#}

			##pronomes:
			##dates
			if ($tag eq "W") {
				$lemma =~ s/[\[\]]//g;
				$lemma =~ s/\:/\,/g;
				#my @tmp = split ("", $tag);
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "DATE";
				$Exp{"person"} = 0;
				$Exp{"gender"} = 0;
				$Exp{"number"} = 0;     
			}
	 
			elsif ($tag =~ /^PRP$/) {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "PRO";
				$Exp{"type"} = "P";
				$Exp{"person"} = 0;
				$Exp{"gender"} = 0;
				$Exp{"number"} = 0;
				$Exp{"case"} = 0;    
				$Exp{"possessor"} = 0;    
				$Exp{"politeness"} = 0;
			} elsif ($tag =~ /^PRP\$$/) {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "PRO";
				$Exp{"type"} = "X";
				$Exp{"person"} = 0;
				$Exp{"gender"} = 0;
				$Exp{"number"} = 0;
				$Exp{"case"} = 0;    
				$Exp{"possessor"} = 0;    
				$Exp{"politeness"} = 0;
			} elsif ($tag =~ /^W/) {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "PRO";
				$Exp{"type"} = "W";
				$Exp{"person"} = 3;
				$Exp{"gender"} = 0;
				$Exp{"number"} = 0;
				$Exp{"case"} = 0;    
				$Exp{"possessor"} = 0;    
				$Exp{"politeness"} = 0;
			} elsif ($tag =~ /^CC/) { ##conjunctions:
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "CONJ";
			} elsif ( ($lemma =~ /^that$/ || $lemma =~ /@/) && $tag =~ /^IN/ ) {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "CONJ";
				$Exp{"type"} = "S";
			} elsif ($tag =~ /^UH/) { ##interjections:
				#my @tmp = split ("", $tag);
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "I";
				$Exp{"type"} = 0;
			} elsif ($tag =~  /^(CD|Z)/) { ##numbers
				#$lemma = "\@card\@";
				#my @tmp = split ("", $tag);
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "CARD";
				$Exp{"number"} = "P";
				$Exp{"person"} = 0;         
				$Exp{"gender"} = 0;         
			} elsif ($tag =~ /^JJ/) {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "ADJ";
				$Exp{"type"} = 0;   
				if ($tag =~ /R$/) {
					$Exp{"degree"} = "A";
				} elsif ($tag =~ /S$/) {
					$Exp{"degree"} = "S";
				} else {
					$Exp{"degree"} = 0;  
				}
				$Exp{"gender"} = 0;
				$Exp{"number"} = 0;
				$Exp{"function"} = 0;
			} elsif ($tag =~ /^RB/) {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "ADV";
				if ($tag =~ /R$/) {
					$Exp{"degree"} = "A";
				} elsif ($tag =~ /S$/) {
					$Exp{"degree"} = "S";
				} else {
					$Exp{"degree"} = 0;  
				}
			} elsif ($tag =~ /(^IN$|^TO$)/) {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "PRP";
				$Exp{"type"} = 0;
			} elsif ($tag =~ /^N/) {
				#my @tmp = split ("", $tag);
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "NOUN";
				if ($tag =~ /^NP$/) {
					$Exp{"type"} = "P";
					$Exp{"number"} = "S";
				} elsif  ($tag =~ /^NPS/)  {
					$Exp{"type"} = "P" ;
					$Exp{"number"} = "P";
				}

				if ($tag =~ /^NN$/) {
					$Exp{"type"} = "C";
					$Exp{"number"} = "S";
				} elsif  ($tag =~ /^NNS/)  {
					$Exp{"type"} = "C" ;
					$Exp{"number"} = "P";
				}
				$Exp{"gender"} = 0;
				$Exp{"person"} = 3;
			} elsif ($tag =~ /(^DT$|^PDT$|^PP\$$)/) {
				#my @tmp = split ("", $tag);
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "DET";
				$Exp{"type"} = 0;
				$Exp{"person"} = 0;
				$Exp{"gender"} = 0;
				$Exp{"number"} = 0;
				$Exp{"possessor"} = 0;

			} elsif ($tag =~ /(^V|^MD$)/) { ##mudar tags nos verbos:
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "VERB";
				if  ($lemma =~ /^$AUX$/) {
					$Exp{"type"} = "A";
				} elsif ($lemma =~ /^$COP$/) {
					$Exp{"type"} = "S";
				} else {
					$Exp{"type"} = 0; 
				}

				if ($tag =~ /^VBN/) {
					$Exp{"mode"} = "P";
				} elsif ($tag =~ /^VBG$/) {
					$Exp{"mode"} = "G";
				} else {
					$Exp{"mode"} = 0; 
				}
				
				if ($tag =~ /^VBD/) {
					$Exp{"tense"} = "S";
					$Exp{"person"} = 0;
					$Exp{"number"} = 0;
					$Exp{"gender"} = 0;
				} elsif ($tag =~ /^VBZ/) {
					$Exp{"tense"} = "P";
					$Exp{"person"} = 3;
					$Exp{"number"} = 0;
					$Exp{"gender"} = 0;
				} else {
					$Exp{"tense"} = 0;
					$Exp{"person"} = 0;
					$Exp{"number"} = 0;
					$Exp{"gender"} = 0;
				}
			} #elsif  ($token eq "!")  { ##simbolos puntuacao:
				#$Exp{"lemma"} = $lemma;
				#$Exp{"token"} = $token;
				#$Exp{"tag"} =  "Fat";
			#}
			elsif  ($token eq "¡")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Faa";
			} elsif  ($token eq ",")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fc";
			} elsif  ($token eq "\[")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fca";
			} elsif  ($token eq "\]")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fct";
			} elsif  ($token eq "\:" || $lemma eq "\:")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fd";
			} elsif  ($token eq "\"")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fe";
			} elsif  ($token eq "-")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fg";
			} elsif  ($token eq "\/")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fh";
			} elsif  ($token eq "¿")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fia";
			} #elsif  ($token eq "?")  {
				#$Exp{"lemma"} = $lemma;
				#$Exp{"token"} = $token;
				#$Exp{"tag"} =  "Flt";
			#} 
			elsif  ($token eq "{")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fla";
			} elsif  ($token eq "}")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Flt";
			} elsif  ($token eq "(")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fpa";
			} elsif  ($token eq ")")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fpt";
			} elsif  ($token eq "\«")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fra";
			} elsif  ($token eq "\»")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Frc";
			} elsif  ($token eq "\.\.\.")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fs";
			} elsif  ($token eq "%")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Ft";
			} elsif  ($token eq "\;")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fx";
			} elsif  ($token eq "[+-=]")  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "Fz";
			} elsif  ($tag =~ /^RP$/)  { ##particulas
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "PCLE";
			}elsif  ($tag =~ /^Fp$|^Fit$|^Fat$/)  {##final de frase (.)
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "SENT";
				$Exp{"pos"} =  $Pos;
				$Pos=0;
				$FoundFinal=1;
			} elsif  ($tag =~ /^F/)  {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  $tag;
			} else {
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  $tag;
			}
			##Colocar a posicao em todos:
			if ($token !~ /^\.$|^\?$|^\!$/) {
				$Exp{"pos"} =  $Pos;
				$Pos++;
			}   

			#if($Exp{"tag"} =~ /^Fra$|^Frc$|Fe$/) {

			#}
			#else {
			$out = "$token\t";
			foreach my $attrib (sort keys %Exp) {
				$out .= "$attrib:$Exp{$attrib}|";
				delete $Exp{$attrib};
			}

			if($pipe){#<ignore-line>
				print("$out\n");#<ignore-line>
			}else{#<ignore-line>
				push(@saida,$out)
			}#<ignore-line>
			#}
		}
	}
	return \@saida;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	adapter(\@lines);
}
#<ignore-block>

