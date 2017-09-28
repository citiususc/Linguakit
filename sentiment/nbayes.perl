#!/usr/bin/env perl

#ProLNat Sentiment Analysis 
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela
package Nbayes;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

# Absolute path 
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(__FILE__);#<ignore-line>

my %Lex=();#<hash><string>
my %Lex_contr=();#<hash><string>
my %ProbCat=();#<hash><string>
my %PriorProb=();#<hash><hash><double>
my %featFreq=();#<hash><integer>
my %list=();#<hash><string>
my $N=1;#<integer>
my $total=0;#<integer>
my $peso_total=0;#<double>
my $result=0;#<double>

sub load{
	my ($lang) = @_;#<string>

	my $TRAIN;#<file>
	open ($TRAIN, $abs_path."/$lang/train_$lang") or die "O ficheiro não pode ser aberto: $! $lang/train_$lang\n";
	binmode $TRAIN,  ':utf8';#<ignore-line>

	my $LEX;#<file>
	open ($LEX, $abs_path."/$lang/lex_$lang") or die "O ficheiro não pode ser aberto: $! $lang/lex_$lang\n";
	binmode $LEX,  ':utf8';#<ignore-line>


	#####################
	#                   #
	#    READING lexico #
	#                   #
	#####################
	while (my $line = <$LEX>) {   #<string>#leitura treino
		chomp $line;

		my ($word, $cat) = split ('\t', $line);#<string>
		$word = trim ($word);
		$cat = trim ($cat);
		$Lex{$word} .= $cat . "|";
		$PriorProb{$cat}={} if (!defined $PriorProb{$cat});
		$PriorProb{$cat}{$word} = 0.1;
		#print STDERR "#$word# --  $Lex{$word}\n" ;
	}

	foreach my $l (keys %Lex) {
		my $positive=0;#<integer>
		my $negative=0;#<integer>
		my $none=0;#<integer>
		my @pols = split ('\|', $Lex{$l});#<array><string>

		foreach my $p (@pols) {
			#print STDERR "------------------ #$l# --- P=#$p#\n";
			$positive++ if ($p eq "POSITIVE");
			$negative++ if ($p eq "NEGATIVE");
			$none++ if ($p eq "NONE");
		}

		if ($positive > $negative) {
			$Lex{$l} = "POSITIVE";
			$Lex_contr{$l} = "NEGATIVE"; 
		}elsif ($negative > $positive) {
			$Lex{$l} = "NEGATIVE";
			$Lex_contr{$l} = "POSITIVE";
		}else {
			delete $Lex{$l};
		}
		#print STDERR "#$l# --  $Lex{$l}\n" ;
	}


	#####################
	#                   #
	#    READING TRAIN  #
	#                   #
	#####################
	($N) = (<$TRAIN> =~ /<number\_of\_docs>([0-9]*)</);
	while (my $line = <$TRAIN>) { #<string>#leitura treino
		chomp $line;

		if ($line =~ /<cat>/) { 
			my ($tmp) = $line =~ /<cat>([^<]*)</;#<string>
			#print STDERR "ProbCat: ---> #$tmp# \n";
			my ($cat, $prob) = split (" ", $tmp);#<string>
			$ProbCat{$cat}=$prob ;
			#print STDERR "CAT: ---> #$cat# \n";
		}elsif ($line =~ /<list>/) { 
			my ($tmp) = $line =~ /<list>([^<]*)</;#<string>
			my ($var, $list) = split (" ", $tmp);#<string>
			$list{$var} = $list;
			#print STDERR "#$var# -- #$list#\n";
		}else{
			my ($feat, $cat, $prob, $freq) = split(qr/ /, $line);#<string>
			if($cat){
				$PriorProb{$cat} = {} if (!defined $PriorProb{$cat});
				$PriorProb{$cat}{$feat} = $prob if (!$PriorProb{$cat}{$feat});
			}
			$featFreq{$feat} = $freq;
			#print STDERR "CAT: ---> #$cat# -- #$prob# \n" ;
		}
	}

}


sub nbayes{

	my ($text) = @_;#<ref><list><string>

	my $previous = "";#<string>
	my $previous2;#<string>
	my $LEX="";#<string>
	my $default_value = "NONE";#<string>
	my $POS_EMOT=0;#<integer>
	my $NEG_EMOT=0;#<integer>
	my %Compound=();#<hash><boolean>
	my @A=();#<list><string>
	my $lines="";#string
	


	foreach my $line (@{$text}) {
		chomp $line;
	
		if ($line !~ /\w/) {next;}
		my ($token, $lemma, $tag) = split (" ", $line);#<string>
		#print STDERR "#$token# - #$lemma# - #$tag#\n" ;
		$token =~ s/<blank>/ /;
		$lines .= $token . " ";
		if ($token eq "EMOT_POS") { ##Contar os emoticons positivos
			$POS_EMOT++;
			#print STDERR "LEX:#$lemma#\n";
		} elsif ($token eq "EMOT_NEG") { ##Contar os emoticons positivos
			$NEG_EMOT++;
			# print STDERR "NEG-EMOT:#$lemma#\n";
		}

		if ($tag =~ /^([FI])/) {
			$previous="";
		} elsif ($tag =~ /^(V|N|AQ|R|JJ)/ && $lemma !~ /^($list{'light_words'})$/) {   
			my $lemma_orig;#<string>
			if ($Lex{$lemma}) { ##Contar os lemas da frase de entrada que estao no léxico.
				$LEX++;
				$lemma_orig=$lemma;
				#print STDERR "LEX:#$lemma#\n";
			}
			if ($Lex{$lemma} && $tag =~ /^(AQ|JJ)/ && $previous =~ /^($list{'quant_adj'})$/ ) { ##muy bonito
				$lemma = $previous . "_" . $lemma;
				#print STDERR "#$lemma# #$previous# #$previous2# \n";
				if ($previous2 =~ /^($list{'neg_noun'})$/ && $lemma =~ /^$list{'quant_adj'}\_/) { ##no muy bonito
					$lemma = $previous2 . "_" . $lemma;
					$PriorProb{$Lex_contr{$lemma_orig}}{$lemma} =  $PriorProb{$Lex{$lemma_orig}}{$lemma_orig}  if ($Lex{$lemma_orig});
					$PriorProb{$Lex{$lemma_orig}}{$lemma} =  0 if ($Lex{$lemma_orig});
					push (@A, $lemma);
					$Compound{$lemma}=1;
					#print STDERR "LEM:#$lemma# - #$lema_orig# -- #$Lex_contr{$lemma_orig}#\n";
				} else { 
					$PriorProb{$Lex{$lemma_orig}}{$lemma} =  $PriorProb{$Lex{$lemma_orig}}{$lemma_orig}  if ($Lex{$lemma_orig});
					# $PriorProb{$Lex{$lemma_orig}}{$lemma} =  0 if ($Lex{$lemma_orig});
					$Compound{$lemma}=1;
					push (@A, $lemma);
				}
			} elsif ($Lex{$lemma} && $tag =~ /(^N|^AQ|^JJ)/ && $previous =~ /^($list{'neg_noun'})$/) { ##no bonito
				#print STDERR "LEM:#$lemma# - #$lemma_orig# #Previous: #$previous#\n";
				$lemma = $previous . "_" . $lemma;
				$PriorProb{$Lex_contr{$lemma_orig}}{$lemma} =  $PriorProb{$Lex{$lemma_orig}}{$lemma_orig}  if ($Lex{$lemma_orig});
				$PriorProb{$Lex{$lemma_orig}}{$lemma} =  0 if ($Lex{$lemma_orig});
				$Compound{$lemma}=1;
				push (@A, $lemma);
				#print STDERR "LEM:#$lemma# - #$lemma_orig# #Previous: #$previous# -- #$Lex_contr{$lemma_orig}# --- #$PriorProb{$Lex_contr{$lemma_orig}}{$lemma}# -- #$PriorProb{$Lex{$lemma_orig}}{$lemma}#\n";
				#print STDERR "LEMMA COM NEG: #$lemma#\n";
			} elsif ($Lex{$lemma} && $tag =~ /^V/ && $previous =~ /^($list{'neg_verb'})$/) { #no me gusta
				$lemma = $previous . "_" . $lemma;
				#print STDERR "VERB COM NEG: #$lemma#\n";
				$PriorProb{$Lex_contr{$lemma_orig}}{$lemma} =  $PriorProb{$Lex{$lemma_orig}}{$lemma_orig}  if ($Lex{$lemma_orig});
				$PriorProb{$Lex{$lemma_orig}}{$lemma} =  0 if ($Lex{$lemma_orig});
				$Compound{$lemma}=1;
				push (@A, $lemma);
			} else {
				push (@A, $lemma);
			}
			$previous2 = $previous;
			$previous = $lemma;
			#print STDERR "Lemma-previous: #$lemma# -- #$previous#\n";
		}    
	} 


	#########################################
	#                                       #
	#       Classification                  #
	#                                       #
	#########################################
 

	if ($POS_EMOT > $NEG_EMOT){ #if there is more positive emoticons: positive
		$total++;
		$peso_total += 1;
		return "$lines\tPOSITIVE\t1";
	} elsif ($POS_EMOT < $NEG_EMOT){#if there is more negative emoticons: negative
		$total++;
		$peso_total -= 1;
		return "$lines\tNEGATIVE\t1";
	} elsif (!$LEX) {
	        $total++;
		return "$lines\t$default_value\t1"; #if there is no lemma from the polartity lexicon: NONE.
	}

	my $smooth = 1/$N;#<double>
	my $Normalizer = 0;#<double>
	my %PostProb=();#<hash><double>
	my %found=();#<hash><boolean>
	my $found;#<boolean>

	foreach my $cat (keys %PriorProb) {
		if (!$cat) { next;}
		$PostProb{$cat}  = $ProbCat{$cat};
		#print STDERR "ProbCat:#$cat# - #$ProbCat{$cat}#\n";
		$found{$cat}=0;
		foreach my $word (@A) {
			#if (!$featFreq{$word} ||  $PriorProb{$cat}{$word} <= $th) {next} ;
			if (!$featFreq{$word} &&  !$Compound{$word} && !$Lex{$word}) { next;};
			#print STDERR " priorprob-$word:#$PriorProb{$cat}{$word}#\n";
			$PriorProb{$cat}{$word}  = $smooth if ($PriorProb{$cat}{$word}  ==0) ;
			$found{$cat}=1; 
			$PostProb{$cat} = $PostProb{$cat} * $PriorProb{$cat}{$word};
			#print STDERR "----#$cat# - #$word# PriorProb#$PriorProb{$cat}{$word}# PostProb#$PostProb{$cat}#\n";
		}
 
		if ($found{$cat}){
			$PostProb{$cat} =  $PostProb{$cat} * $ProbCat{$cat};
		} else{
			$PostProb{$cat} = 0;
		}
		$Normalizer +=   $PostProb{$cat};
		#print STDERR "PROB: #$cat# -  PostProb#$PostProb{$cat}#  ProbCat#$ProbCat{$cat}#\n";
	}
	$found=0;
	foreach my $c (keys %PostProb) {
		#print STDERR "$c - #$PostProb{$c}#\n" if ($c);
		$PostProb{$c} = $PostProb{$c} / $Normalizer if ($Normalizer);
		$found=1 if ($found{$c});
	}

	if (!$found) {
	        $total++;
		return "$lines\t$default_value\t1"; 
	} else {
		foreach my $c (sort {$PostProb{$b} <=> $PostProb{$a} } keys %PostProb ) {
		        #$total++;
			if ($c eq "POSITIVE") {
			    $peso_total += $PostProb{$c};
			    $total++;
			}
			elsif ($c eq "NEGATIVE") {
			    $peso_total -= $PostProb{$c};
			    $total++;
			}
			return "$lines\t$c\t$PostProb{$c}";
		}
	}
	
}

sub end {
    #print STDERR "total=#$total# -- peso=#$peso_total#\n";
    my $c=0;#<doubled>
    if ($total == 1 && $peso_total == 0) {
	   return "TOTAL\tNONE\t1\n"; 
    }
    else {
        $result = $peso_total / $total;
	
	if ($peso_total >= 0) {
	   $c = "POSITIVE"
	}
	elsif ($peso_total <= 0) {
	   $c = "NEGATIVE"
	}
	else {
	   $c = "NONE"
	}
	$result = abs ($result);
	return "TOTAL\t$c\t$result\n";
    }
}

#<ignore-block>
if($pipe){
	my $lang = shift(@ARGV);
	load($lang);
	my @lines=<STDIN>;
	print nbayes(\@lines);
}
#<ignore-block>

sub trim {    #remove all leading and trailing spaces
	my $str = $_[0];#<string>

	$str =~ s/^\s*(.*\S)\s*$/$1/;
	return $str;
}

