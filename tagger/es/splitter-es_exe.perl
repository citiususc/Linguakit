#!/usr/bin/env perl

#ProLNat Tokenizer (provided with Sentence Identifier)
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Script que integra 2 funçoes perl: sentences e tokens
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

##ficheiros de recursos
my $VERB;#<file>
open ($VERB, $abs_path."/lexicon/verbos-es.txt") or die "O ficheiro verbos-es não pode ser aberto: $!\n";
binmode VERB,  ':utf8';#<ignore-line>


##variaveis globais
##para sentences e tokens:
my $UpperCase = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜ]";#<string>
my $LowerCase = "[a-záéíóúàèìòùâêîôûñçü]";#<string>
my $Punct =  qr/[\,\;\«\»\“\”\'\"\&\$\#\=\(\)\<\>\!\¡\?\¿\\\[\]\{\}\|\^\*\-\€\·\¬\…]/;#<string>
my $Punct_urls = qr/[\:\/\~]/;#<string>

##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA###################
my $pron = "(me|te|se|le|les|la|lo|las|los|nos|os)";#<string>
###########################################################
#my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";

my %Verb;#<hash><integer>
while(my $verb = <$VERB>){#<string>
	chomp $verb;
	$Verb{$verb}++;
	#if ($verb eq "comer") {print "PROPONER: #$verb#\n";}
	$verb =~ s/ar$/ár/;
	$verb =~ s/er$/ér/;
	$verb =~ s/ir$/ír/;
	$Verb{$verb}++; 
	#print STDERR "TOKEN:: #$verb#\n";
}
close $VERB;

sub splitter {

	my ($tokens) = @_;#<ref><list><string>
	my @saida=();#<list><string>
	
	foreach my $token (@{$tokens}){#<string>
		chomp $token;
	
		##lendo verbos

		##lendo entrada (tokens)
		#for (my $i=0;$i<=$#text;$i++) {
			#chomp $text[$i];
			#my $token = $text[$i];  
		#print STDERR "TOKEN:: #$token\n";
		my $verb;#<string>
		my $tmp1;#<string>
		my $tmp2;#<string>
		my $found=0;#<boolean>
		###################separar verbos em infinitivo dos cliticos compostos oslo, noslo, selo, ... 
		###FALTA TRATAR OS IMPERATIVOS!!!!! incluiremos em verbos-es.txt a lista de formas em imperativo!
		
		if ($token =~ /^(\w+r)(nos|os|se|te|me)(lo|los|las|los)$/i) {
			($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w+r)(nos|os|se|te|me)(lo|los|las|los)$/i;

			#print STDERR "---#$verb# - - #$tmp1# - #$tmp2#\n";
			if ($Verb{lowercase($verb)}  && $token =~ /(ár|ér|ír)(nos|os|se|te|me)(lo|los|las|los)$/) {
				# print STDERR "----> $verb\n#$tmp1#\n#$tmp2#\n";
				$verb =~ s/ár/ar/;
				$verb =~ s/ér/er/;
				$verb =~ s/ír/ir/; 

				if($pipe){#<ignore-line>
					print "$verb\n$tmp1\n$tmp2\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida, $verb);
					push (@saida, $tmp1);
					push (@saida, $tmp2);
				}#<ignore-line>
				$found=1;
			}

		} 
		
		################separar cliticos simples de verbos  em infinitivo ###FALTA TRATAR OS IMPERATIVOS!!!!!
		if (!$found && $token =~ /^(\w+r)($pron)$/i) {
			($verb,$tmp1) =  $token =~ /^(\w+r)($pron)$/i;
			#print STDERR "----#$verb# #$tmp1#\n" if ($Verb{$verb});
			if ($Verb{lowercase($verb)}) {
				
				if($pipe){#<ignore-line>
					print "$verb\n$tmp1\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida, $verb);
					push (@saida, $tmp1);
				}#<ignore-line>    
				$found=1;
			} 
		}
  
		##############separar o gerundio dos pronomes
		##pronomes compostos
		if (!$found && $token =~ /^(\w+iéndo|\w+ándo)(nos|os|se|te|me)(lo|los|las|los)$/i) {
			($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w+iéndo|\w+ándo)(nos|os|se|te|me)(lo|los|las|los)$/i; 
			#if ($token =~ /(iéndo|ándo)(nos|os|se)(lo|los|las|los)$/) {

			$verb =~ s/iéndo$/iendo/;
			$verb =~ s/ándo$/ando/;
			
			if($pipe){#<ignore-line>
				print "$verb\n$tmp1\n$tmp2\n";#<ignore-line> 
			}else{#<ignore-line> 
				push (@saida, $verb);
				push (@saida, $tmp1);
				push (@saida, $tmp2);
			}#<ignore-line> 
			$found=1;
		}

		##pronomes simples
		if (!$found && $token =~ /^(\w+iéndo|\w+ándo)($pron)$/i) {
			($verb,$tmp1) =  $token =~ /^(\w+iéndo|\w+ándo)($pron)$/i;
			#print STDERR "1---#$verb# - #$tmp1#\n";
			$verb =~ s/iéndo$/iendo/;
			$verb =~ s/ándo$/ando/;

			if($pipe){#<ignore-line>
				print "$verb\n$tmp1\n";#<ignore-line> 
			}else{#<ignore-line> 
				push (@saida, $verb);
				push (@saida, $tmp1);
			}#<ignore-line> 
			#print STDERR "2---#$verb# - #$tmp1#\n";
			$found=1; 
		}

		###############separar contraçoes nao ambiguas###########

		#del, al
		if (!$found && $token =~ /^[dD]el$/) {
			($tmp1,$tmp2) =  $token =~ /^([dD]e)(l)$/; 
			
			if($pipe){#<ignore-line>
				print "$tmp1\n";#<ignore-line>
				print "e" . "$tmp2\n"   if  $token =~ /^d/;#<ignore-line>
				print "E" . "$tmp2\n"   if  $token =~ /^D/;#<ignore-line>
			}else{#<ignore-line> 
				push (@saida, $tmp1);
				push (@saida, "e" . $tmp2) if  $token =~ /^d/; 
				push (@saida, "E" . $tmp2) if  $token =~ /^D/;
			}#<ignore-line> 
			$found=1;
		}elsif ($token =~ /^[aA]l$/) {
			($tmp1,$tmp2) =  $token =~ /^([aA])(l)$/; 
			
			if($pipe){#<ignore-line>
				print "$tmp1\n";#<ignore-line>
				print "e" . "$tmp2\n"   if  $token =~ /^a/;#<ignore-line>
				print "E" . "$tmp2\n"   if  $token =~ /^A/;#<ignore-line>
			}else{#<ignore-line>
				push (@saida, $tmp1);
				push (@saida, "e" . $tmp2) if  $token =~ /^a/; 
				push (@saida, "E" . $tmp2) if  $token =~ /^A/;	
			}#<ignore-line>
			$found=1;
		}

		if (!$found) {
			if($pipe){#<ignore-line>
				print "$token\n";#<ignore-line>
			}else{#<ignore-line>
				push (@saida, $token);
			}#<ignore-line>
		}
		#if ($i == $#text && $token eq "")  {
			#push (@saida, "");
			#print "\n"; 
		#}
	}
	return \@saida;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	splitter(\@lines);
}
#<ignore-block>

sub lowercase {
	my ($x) = @_ ;#<string>
	$x = lc ($x);
	$x =~  tr/ÁÉÍÓÚÇÑ/áéíóúçñ/;

	return $x;
} 

        


