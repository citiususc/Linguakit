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
		} elsif ($line eq "" && !$FoundFinal) {##se hai um final de linha sem ponto final. So tem sentido com --flush
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

			###Transformamos datas-W eliminando caracteres conflitivos: 
			if ($tag eq "W") {
				$lemma =~ s/:/@/g;
				$lemma =~ s/[\[\]]//g;
			} 

			#se temos um NP (nome proprio), colocar a forma no lema (para conservar a maiuscula)

			if ($tag =~ /^NP/) {
				$lemma = $token;
			}

			##tag conversion:

			##pronouns:
			if ($tag =~ /^P/) {
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "PRO";
				$Exp{"type"} = $tmp[1];
				$Exp{"person"} = $tmp[2];
				$Exp{"gender"} = $tmp[3];
				$Exp{"number"} = $tmp[4];
				if (@tmp > 5) {
					$Exp{"case"} = $tmp[5];
				} else {
					$Exp{"case"} = 0
				} 
				if (@tmp > 6) {
					$Exp{"possessor"} = $tmp[6];
				} else {
					$Exp{"possessor"} = 0
				} 
				if (@tmp > 7) {  
					$Exp{"politeness"} = $tmp[7];    
				} else {
					$Exp{"politeness"} = 0
				}  
			} elsif ($tag =~ /^C/) { ##conjunctions:
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "CONJ";
				$Exp{"type"} = $tmp[1];
			} elsif ($tag =~ /^I/) { ##interjections:
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  $tmp[0];
				$Exp{"type"} = 0;
			} elsif ($tag =~  /^Z/) { ##numbers
				#$lemma = "\@card\@";
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "CARD";
				$Exp{"number"} = "P";
				$Exp{"person"} = 0;
				$Exp{"gender"} = 0;
				# $Exp{"type"} = $tmp[1];
			} elsif ($tag =~  /^W/) { ##dates
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "DATE";
				$Exp{"number"} = 0;
				$Exp{"person"} = 0;
				$Exp{"gender"} = 0;
				#$Exp{"type"} = $tmp[1];
			} elsif ($tag =~ /^A/) {
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "ADJ";
				$Exp{"type"} = $tmp[1];
				$Exp{"degree"} = $tmp[2];
				$Exp{"gender"} = $tmp[3];
				$Exp{"number"} = $tmp[4];
				$Exp{"function"} = $tmp[5];
				#print STDERR "$tmp[1] - $tmp[2] - $tmp[3] - $tmp[4] - $tmp[5]\n"   
			} elsif ($tag =~ /^R/) {
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "ADV";
				$Exp{"type"} = $tmp[1];
			} elsif ($tag =~ /^SP/) {
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "PRP";
				$Exp{"type"} = $tmp[1];
			} elsif ($tag =~ /^N/) {
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "NOUN";
				$Exp{"type"} = $tmp[1];
				$Exp{"gender"} = $tmp[2];
				$Exp{"number"} = $tmp[3];
				$Exp{"person"} = 3;
			} elsif ($tag =~ /^D/) {
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "DET";
				$Exp{"type"} = $tmp[1];
				$Exp{"person"} = $tmp[2];
				$Exp{"gender"} = $tmp[3];
				$Exp{"number"} = $tmp[4];
				$Exp{"possessor"} = $tmp[5];
			} elsif ($tag =~ /^V/) { ##mudar tags nos verbos:
				my @tmp = split ("", $tag);#<array><string>
				$Exp{"lemma"} = $lemma;
				$Exp{"token"} = $token;
				$Exp{"tag"} =  "VERB";
				$Exp{"type"} = $tmp[1];
				$Exp{"mode"} = $tmp[2];
				$Exp{"tense"} = $tmp[3];
				$Exp{"person"} = $tmp[4];
				$Exp{"number"} = $tmp[5];
				$Exp{"gender"} = $tmp[6];
			}
			##finais de frase (!?.)
			#if(($tag =~ /^Fat/) || ($tag =~ /^Fit/) || ($tag =~ /^Fp/) ) {
				#$tag = "SENT";
			#}
			elsif  ($tag =~ /^Fp$|^Fit$|^Fat$/)  {##final de frase (.)
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

			##Colocar a posiçao em todos:
			if  ($tag !~ /^Fp$|^Fit$|^Fat$/)  {
				$Exp{"pos"} =  $Pos;
				$Pos++; 
			}

			##(pre-processing) removing quotation marks:
			##(fazer mais cousas deste tipo num pre-processo...)
			#if( ($tag =~ /^Fra/) || ( $tag =~ /^Frc/) ||  ($tag eq "Fe") ) {
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

##as conjunçoes seguem a ser CS (subord) e CC (coordenada)

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	adapter(\@lines);
}
#<ignore-block>
