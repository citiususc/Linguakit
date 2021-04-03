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
use open ':std', ':encoding(utf8)';
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
my $IMP;#<file>
open ($IMP, $abs_path."/lexicon/imperativos-es.txt") or die "O ficheiro verbos-es não pode ser aberto: $!\n";
binmode IMP,  ':utf8';#<ignore-line>
my $LOC;#<file>
open($LOC, $abs_path."/lexicon/locutions.txt") or die "O ficheiro locutions.txt não pode ser aberto: $!\n";
binmode $LOC, ':utf8';#<ignore-line>

##variaveis globais
my $DEBUG = 0;#<bool>

##para sentences e tokens:
my $UpperCase = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜ]";#<string>
my $LowerCase = "[a-záéíóúàèìòùâêîôûñçü]";#<string>
my $Punct =  qr/[\,\;\«\»\“\”\'\"\&\$\#\=\(\)\<\>\!\¡\?\¿\\\[\]\{\}\|\^\*\-\€\·\¬\…]/;#<string>
my $Punct_urls = qr/[\:\/\~]/;#<string>

##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA###################
my $pron = "(me|te|se|le|les|la|lo|las|los|nos|os)";#<string>
my $ambig_ents = "|Correos|";#<string>
my $ambig_forms = "|pétalos|oídos|velas|vela|velo|velos|vele|veles|";#<string>
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

my %Imp;#<hash><integer>
while(my $verb = <$IMP>){#<string>
	chomp $verb;
	$Imp{$verb}++;
	#if ($verb eq "comer") {print "PROPONER: #$verb#\n";}
	#print STDERR "TOKEN:: #$verb#\n";
}
close $IMP;

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
	my @saida=();#<list><string>
	my $index=0;#<integer>

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

		# exceptions
		if(is_ambiguous($token, $index)) {
			if($pipe){#<ignore-line>
				print "$token\n";#<ignore-line>
			}else{#<ignore-line>
				push (@saida, $token);
			}#<ignore-line>
			next;
		}

		if ($token =~ /^(\w+r)(nos|os|se|te|me)(lo|la|las|los)$/i or $token =~ /^(\w+r)se(me|te|le|nos|os|les)$/i ) {
			print STDERR "rule #0: infinitive + 2 clitics\n" if($DEBUG);
			($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w+r)(nos|os|se|te|me)(lo|la|las|los|me|te|le|nos|os|les)$/i;
			#print STDERR "---#$verb# - - #$tmp1# - #$tmp2#\n";
			if ($Verb{lowercase($verb)}  && $token =~ /(ár|ér|ír)(nos|os|se|te|me)(lo|la|las|los|me|te|le|nos|os|les)$/) {
				# print STDERR "----> $verb\n#$tmp1#\n#$tmp2#\n";
				$verb =~ s/ár/ar/;
				$verb =~ s/ér/er/;
				if($verb !~ /[aeo]ír$/) {
					$verb =~ s/ír/ir/;
				}

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
		#imperativo 2 pessoa plural
		if (!$found && ( $token =~ /^(\w+?[áéí]os)(lo|la|las|los)$/i || $token =~ /^(\w+?d)(nos|se|te|me)(lo|la|las|los)$/i)
			    && $token =~ /[áéíóú]/ ) {
		    print STDERR "rule #1: second plural + 2 clitics\n" if($DEBUG);
		    if ( $token =~ /^(\w+?[áéí]os)(lo|la|las|los)$/i) {
			    ($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w+?[áéí])(os)(lo|la|las|los)$/i;
			    $verb =~ s/$/d/;
		    }
		    elsif ($token =~ /^(\w+?d)(nos|se|te|me)(lo|la|las|los)$/i) {
			    ($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w+?d)(nos|se|te|me)(lo|la|las|los)$/i;
		    }
		    my $orig = $verb;
		    ($verb = $orig) =~ y/áéíóúÁÉÍÓÚ/aeiouAEIOU/;
		    #print STDERR "OK----> #$verb#\n#$tmp1#\n#$tmp2#\n";
		    if ($Imp{lowercase($verb)} or $Imp{lowercase($orig)}) {
		        if($Imp{lowercase($orig)}) {
		            $verb = $orig;
		        }
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

		#imperativo 2 pessoa singular: cómetelo
			#print STDERR "----> #$token# #$found#\n";
		if (!$found && $token =~ /^(\w+?)(nos|os|se|te|me)(lo|la|las|los)$/i && $token =~ /[áéíóú]/i) {
		    print STDERR "rule #2: second singular + 2 clitics\n" if($DEBUG);
		    if ($token =~ /nos(lo|la|las|los)$/i) {
			($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w+?)(nos)(lo|la|las|los)$/i;
		    }
		    else{
			($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w+?)(os|se|te|me)(lo|la|las|los)$/i;
		    }

			my $orig = $verb;
			($verb = $orig) =~ y/áéíóúÁÉÍÓÚ/aeiouAEIOU/;
			#print STDERR "OK----> #$verb#\n#$tmp1#\n#$tmp2#\n";
			if ($Imp{lowercase($verb)} or $Imp{lowercase($orig)}) {
				if($Imp{lowercase($orig)}) {
					$verb = $orig;
				}

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
		#imperativo: 1 pessoa plural
		if (!$found &&  $token =~ /^(\w+mo(s)?)(nos|os|se|te|me)(lo|la|las|los)$/i  && $token =~ /[áéíóú]/ ) {
		     if ($token =~ /(nos|se)(lo|la|las|los)$/i) {
		    print STDERR "rule #3: first plural + 2 clitics\n" if($DEBUG);
			($verb,$tmp1,$tmp2) =  $token =~ /^(\w+mo)(nos|se)(lo|la|las|los)$/i;
			$verb =~ s/$/s/;
		    }
		    else {
			($verb,$tmp1,$tmp2) =  $token =~ /^(\w+mos)(nos|os|se|te|me)(lo|la|las|los)$/i;
		    }
		    $verb =~ y/áéíóú/aeiou/;
			#print STDERR "OK----> #$verb#\n#$tmp1#\n#$tmp2#\n";
		    if ($Imp{lowercase($verb)}) {

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

		#imperativo: 3 pessoa plural
		if (!$found &&  $token =~ /^(\w+n)(nos|os|se|te|me)(lo|la|las|los)$/i  && $token =~ /[áéíóú]/ ) {
		    print STDERR "rule #4: third plural + 2 clitics\n" if($DEBUG);
		    if ($token =~ /nos(lo|la|las|los)$/i) {
			 ($verb,$tmp1,$tmp2) =  $token =~ /^(\w+mos)(nos|os|se|te|me)(lo|la|las|los)$/i;
		    }
		    $verb =~ y/áéíóú/aeiou/;
			#print STDERR "OK----> #$verb#\n#$tmp1#\n#$tmp2#\n";
		    if ($Imp{lowercase($verb)}) {

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


		################separar cliticos simples de verbos  em infinitivo
		if (!$found && $token =~ /^(\w*[aeií]r)($pron)$/i) {
			print STDERR "rule #5: infinitive + 1 clitics\n" if($DEBUG);
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
		##imperativo 2 pessoa singular: cómelo
		if (!$found && $token =~ /^(\w+?)($pron)$/i && $token =~ /[áéíóú]/i && $token !~ /mosnos$/) { ##nom separar séase (de "o seáse")
		    print STDERR "rule #6: second singular + 1 clitics\n" if($DEBUG);

		    if ($token =~ /nos$/i) {
			($verb,$tmp1) =  $token =~ /^(\w+?)(nos)$/i;
		    }
		    else {
			($verb,$tmp1) =  $token =~ /^(\w+?)($pron)$/i;
		    }

		    my $orig = $verb;
		    ($verb = $orig) =~ y/áéíóúÁÉÍÓÚ/aeiouAEIOU/;
		    #print STDERR "----#$verb# #$tmp1#\n";
		    if ($Imp{lowercase($verb)} or $Imp{lowercase($orig)}) {
			     if($Imp{lowercase($orig)}) {
					$verb = $orig;
				}
				if($pipe){#<ignore-line>
					print "$verb\n$tmp1\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida, $verb);
					push (@saida, $tmp1);
				}#<ignore-line>
				$found=1;
			}
		}
        ##imperativo 2 pessoa singular monosilabos com 1 clítico (vete, dale) e compostos (propónle, deshazlo)
        if (!$found && $token =~ /^(esta|prevé|ve|\w*di|da|\w*yaz|\w*pon|\w*ven|\w*ten|\w*haz)(lo|la|los|las|le|les|me|te|nos)$/i) {
            $verb = $1;
            $tmp1 = $2;
            print STDERR "rule #7: second singular + 1 clitics\n" if($DEBUG);

            if($verb =~ /\w+?(di|pon|ven|ten|sta)$/) {
                $verb =~ s/($1)/accent_last_vowel($1)/e;
            }

            if ($Imp{lowercase($verb)}) {
                if($pipe) {#<ignore-line>
                    print "$verb\n$tmp1\n";#<ignore-line>
                } else {
                    push (@saida, $verb);
                    push (@saida, $tmp1);
                }#<ignore-line>
                $found=1;
            }
        }

		##imperativo 2 pessoa plural: comedlo, arrodillaos
		if (!$found && $token =~ /^(\w+?[aeí]|i[rd])(os)$/i) {
            $verb = $1;
            $tmp1 = $2;
            print STDERR "rule #8: second plural + 1 clitics\n" if($DEBUG);

            my $orig = $verb;
            if($verb =~ /^i[rd]$/i) {
                $verb = "id";
            } else {
                ($verb = $orig) =~ y/íÍ/iI/;
			    $verb .= "d";
			    $orig .= "d";
            }
			if ($Imp{lowercase($verb)} or $Imp{lowercase($orig)}) {
                if($Imp{lowercase($orig)}) {
                    $verb = $orig;
                }

				if($pipe){#<ignore-line>
					print "$verb\n$tmp1\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida, $verb);
					push (@saida, $tmp1);
				}#<ignore-line>
				$found=1;
			}
		}
		if (!$found && $token =~ /^(\w+[aei]d)(me|te|se|le|les|la|lo|las|los|nos)$/i) {
			print STDERR "rule #9: second plural + 1 clitics\n" if($DEBUG);
			($verb,$tmp1) =  $token =~ /^(\w+[aei]d)(me|te|se|le|les|la|lo|las|los|nos)$/i;

			#print STDERR "----#$verb# #$tmp1#\n" if ($Verb{$verb});
		    if ($Imp{lowercase($verb)}) {

				if($pipe){#<ignore-line>
					print "$verb\n$tmp1\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida, $verb);
					push (@saida, $tmp1);
				}#<ignore-line>
				$found=1;
			}
		}

		##imperativo 1 pessoa plural: comámoslo, comámonos
		if (!$found && $token =~ /^(\w+mo(s)?)($pron)$/i && $token =~ /[áéíóú]/) {
		    print STDERR "rule #10: first plural + 1 clitics\n" if($DEBUG);
		    if ($token =~ /nos$/i) {
			($verb,$tmp1) =  $token =~ /^(\w+mo)(nos)$/i;
			$verb =~ s/$/s/;
			#print STDERR "----#$verb# #$tmp1#\n";
		    }
		    else {
			($verb,$tmp1) =  $token =~ /^(\w+mos)($pron)$/i;
		    }
		    $verb =~ y/áéíóú/aeiou/;
		    #print STDERR "----#$verb# #$tmp1#\n";
		    if ($Imp{lowercase($verb)}) {

				if($pipe){#<ignore-line>
					print "$verb\n$tmp1\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida, $verb);
					push (@saida, $tmp1);
				}#<ignore-line>
				$found=1;
			}
		}

		##imperativo 3 pessoa plural: cómanlo, véanlo
		if (!$found && (($token =~ /^(\w+n)($pron)$/i && $token =~ /[áéíóú]/) or $token =~ /^(den|esten)($pron)$/i)) {
		    print STDERR "rule #11: third plural + 1 clitics\n" if($DEBUG);
		    ($verb,$tmp1) =  $token =~ /^(\w+n)($pron)$/i;
		    $verb =~ y/áéíóú/aeiou/;
            if($verb =~ /(esten)$/) {
                $verb =~ s/($1)/accent_last_vowel($1)/e;
            }

			#print STDERR "----#$verb# #$tmp1#\n" if ($Verb{$verb});
		    if ($Imp{lowercase($verb)}) {

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
		if (!$found && $token =~ /^(\w*[iyñlh]éndo|\w+ándo)(nos|os|se|te|me)(lo|la|las|los)$/i or $token =~ /^(\w*[iyñlh]éndo|\w+ándo)se(me|te|le|nos|os|les)$/i) {
			print STDERR "rule #12: gerund + 2 clitics\n" if($DEBUG);
			($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w*[yiñlh]éndo|\w+ándo)(nos|os|se|te|me)(lo|la|las|los|me|te|le|nos|os|les)$/i;
			#if ($token =~ /(iéndo|ándo)(nos|os|se)(lo|la|las|los)$/) {

			$verb =~ s/([iyñlh])éndo$/$1endo/;
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
		if (!$found && $token =~ /^(\w*[iyñlh]éndo|\w+ándo)($pron)$/i) {
			print STDERR "rule #13: gerund + 1 clitics\n" if($DEBUG);
			($verb,$tmp1) =  $token =~ /^(\w*[yiñlh]éndo|\w+ándo)($pron)$/i;
			#print STDERR "1---#$verb# - #$tmp1#\n";
			$verb =~ s/([iyñlh])éndo$/$1endo/;
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

		if($index == 0) {
			# when starting with punctuation, don't increment index
			if($token !~ /^\p{P}+$/) {
				$index++;
			}
		} else {
			$index++;
		}
	}

	return join_locutions(\@saida);
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

sub is_ambiguous {
	my $token = quotemeta(shift);
	my $index = shift;

	if ($index > 0 and $ambig_ents =~ /\|$token\|/) {
		return 1;
	}
	if ($ambig_forms =~ /\|$token\|/i) {
		return 1;
	}
	return 0;
}

sub accent_last_vowel {
    my $token = shift;
    my $len = length($token);

    return $token if ($token =~ /[áéíóú]/i);
    while($len > 0)
    {
        my $letter = substr($token, ($len - 1), 1);
        if($letter =~ /[aeiou]/i)
        {
            $letter =~ y/aeiouAEIOU/áéíóúÁÉÍÓÚ/;
            substr($token, ($len - 1), 1, $letter);
            return $token;
        }
        $len--;
    }
    return $token;
}
