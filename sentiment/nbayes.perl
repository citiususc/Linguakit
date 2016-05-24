#!/usr/bin/perl

#ProLNat Sentiment Analysis 
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela



my $train = shift(@ARGV) ;
open (TRAIN, $train) or die "O ficheiro não pode ser aberto: $! ".$train."\n";

my $lex = shift(@ARGV) ;
open (LEX, $lex) or die "O ficheiro não pode ser aberto: $! ".$lex."\n";


#####################
#                   #
#    READING lexico  #
#                   #
#####################
$i=0;
while ($line = <LEX>) {   ##leitura treino
   $i++; 
   chomp $line;
   #$line = trim($line);
  
    ($word, $cat) = split ('\t', $line);
    $word = trim ($word);
    $cat = trim ($cat);
    $Lex{$word} .= $cat . "|";
    $PriorProb{$cat}{$word} = 0.1;
  # print STDERR "#$word# --  $Lex{$word}\n" ;
   
}

foreach $l (keys %Lex) {
 $positive=0;
 $negative=0;
 $none=0;   
 (@pols) = split ('\|', $Lex{$l});
    
    foreach $p (@pols) {
        #if ($p eq ""){next}
	#print STDERR "------------------ #$l# --- P=#$p#\n";
        $positive++ if ($p eq "POSITIVE");
        $negative++ if ($p eq "NEGATIVE");
        $none++ if ($p eq "NONE");
        $count++;
    }
   if ($positive > $negative) {
       $Lex{$l} = "POSITIVE";
       $Lex_contr{$l} = "NEGATIVE"; 
   }
   elsif ($negative > $positive) {
       $Lex{$l} = "NEGATIVE";
       $Lex_contr{$l} = "POSITIVE";
   }
   else {
     delete $Lex{$l}
   }
   #print STDERR "#$l# --  $Lex{$l}\n" ;
}


#####################
#                   #
#    READING TRAIN  #
#                   #
#####################

my $i=0;
while ($line = <TRAIN>) {   ##leitura treino
   $i++; 
   chomp $line;
   #$line = trim($line);
  
   ($N) = ($line =~ /<number\_of\_docs>([0-9]*)</) if ($i==1);

   if ($line =~ /<cat>/) { 
     ($tmp) = $line =~ /<cat>([^<]*)</ ;
     #print STDERR "ProbCat: ---> #$tmp# \n";
     ($cat, $prob) = split (" ", $tmp);
     $ProbCat{$cat}=$prob ;
    # print STDERR "CAT: ---> #$cat# \n";

   }

    if ($line =~ /<list>/) { 
       ($tmp) = $line =~ /<list>([^<]*)</ ;
       ($var, $list) = split (" ", $tmp);

       eval(qq{\$$var = "$list";}); 
       #print STDERR "#$var# -- #$list#\n";
    }


    ($feat, $cat, $prob, $freq) = split(/ /, $line) if ($line !~ /<cat>/ && $line !~ /<list>/);
    
    $PriorProb{$cat}{$feat} = $prob if ($cat && !$PriorProb{$cat}{$feat});
    $featFreq{$feat} = $freq;
    #print STDERR "CAT: ---> #$cat# -- #$prob# \n" ;
    $Pol{$feat} = $cat;
}


@entrada = <STDIN>; ##frase a analizar
#print STDERR "entrada: #@entrada#\n";
$analisado = join ("",@entrada);
#print STDERR "entrada: #$analisado#\n";
#print STDERR "$analisado";

my @lines = split ('\n', $analisado);
my $previous = "";
my $LEX="";
my $default_value = "NONE";
my $POS_EMOT=0;
my $NEG_EMOT=0;
#my $th = 0.0001;
foreach my $line (@lines){
       if ($line !~ /\w/) {next}
       ($token, $lemma, $tag) = split (" ", $line);
       #$lemma = normalize ($lemma);
      # print STDERR "#$token# - #$lemma# - #$tag#\n" ;

        if ($token eq "EMOT_POS") { ##Contar os emoticons positivos
 	       $POS_EMOT++;
               #print STDERR "LEX:#$lemma#\n";
             
        }
        elsif ($token eq "EMOT_NEG") { ##Contar os emoticons positivos
 	       $NEG_EMOT++;
              # print STDERR "NEG-EMOT:#$lemma#\n";
       }

       if ($tag =~ /^([FI])/) {
	     
              $previous="";
              #$previous2="";
              
       }
       elsif ($tag =~ /^(V|N|AQ|R|JJ)/ && $lemma !~ /^($light_words)$/) {
          
           if ($Lex{$lemma}) { ##Contar os lemas da frase de entrada que estao no léxico.
 	       $LEX++;
               $lemma_orig=$lemma;
              
              # print STDERR "LEX:#$lemma#\n";
           }

           if ($Lex{$lemma} && $tag =~ /^(AQ|JJ)/ && $previous =~ /^($quant_adj)$/ ) { ##muy bonito
               $lemma = $previous . "_" . $lemma;
             
	       #print STDERR "#$lemma# #$previous# #$previous2# \n";
                if ($previous2 =~ /^($neg_noun)$/ && $lemma =~ /^$quant_adj\_/) { ##no muy bonito
                   $lemma = $previous2 . "_" . $lemma;
                   $PriorProb{$Lex_contr{$lemma_orig}}{$lemma} =  $PriorProb{$Lex{$lemma_orig}}{$lemma_orig}  if ($Lex{$lemma_orig});
                   $PriorProb{$Lex{$lemma_orig}}{$lemma} =  0 if ($Lex{$lemma_orig});
                   push (@A, $lemma);
                   $Compound{$lemma}++;
                  # print STDERR "LEM:#$lemma# - #$lema_orig# -- #$Lex_contr{$lemma_orig}#\n";
                   
		}
	       else { 
                    $PriorProb{$Lex{$lemma_orig}}{$lemma} =  $PriorProb{$Lex{$lemma_orig}}{$lemma_orig}  if ($Lex{$lemma_orig});
                   # $PriorProb{$Lex{$lemma_orig}}{$lemma} =  0 if ($Lex{$lemma_orig});
                    $Compound{$lemma}++;
                    push (@A, $lemma);
                   
	       }
	   }
         

	   elsif ($Lex{$lemma} && $tag =~ /(^N|^AQ|^JJ)/ && $previous =~ /^($neg_noun)$/) { ##no bonito
                print STDERR "LEM:#$lemma# - #$lemma_orig# #Previous: #$previous#\n";
               $lemma = $previous . "_" . $lemma;
               $PriorProb{$Lex_contr{$lemma_orig}}{$lemma} =  $PriorProb{$Lex{$lemma_orig}}{$lemma_orig}  if ($Lex{$lemma_orig});
               $PriorProb{$Lex{$lemma_orig}}{$lemma} =  0 if ($Lex{$lemma_orig});
               $Compound{$lemma}++;
               push (@A, $lemma);
                #print STDERR "LEM:#$lemma# - #$lemma_orig# #Previous: #$previous# -- #$Lex_contr{$lemma_orig}# --- #$PriorProb{$Lex_contr{$lemma_orig}}{$lemma}# -- #$PriorProb{$Lex{$lemma_orig}}{$lemma}#\n";
              #print STDERR "LEMMA COM NEG: #$lemma#\n";
	   }
         
           elsif ($Lex{$lemma} && $tag =~ /^V/ && $previous =~ /^($neg_verb)$/) { #no me gusta
               $lemma = $previous . "_" . $lemma;
              #print STDERR "VERB COM NEG: #$lemma#\n";
               $PriorProb{$Lex_contr{$lemma_orig}}{$lemma} =  $PriorProb{$Lex{$lemma_orig}}{$lemma_orig}  if ($Lex{$lemma_orig});
               $PriorProb{$Lex{$lemma_orig}}{$lemma} =  0 if ($Lex{$lemma_orig});
               $Compound{$lemma}++;
               push (@A, $lemma);
	   }
           
           else {
               push (@A, $lemma);
	   }
           $previous2=$previous;
           $previous=$lemma;
           
         # print STDERR "Lemma-previous: #$lemma# -- #$previous#\n";
	   
       }
       
} 



 
  #########################################
  #                                       #
  #       Classification                  #
  #                                       #
  #########################################
 

if ($POS_EMOT > $NEG_EMOT){ #if there is more positive emoticons: positive
     #$logger -> debug("OKKKK: POS : #$POS_EMOT# - NEG: #$NEG_EMOT#"); 
   exit (print "POSITIVE\t1\n");
}
elsif ($POS_EMOT < $NEG_EMOT){#if there is more negative emoticons: negative
    #$logger -> debug("OKKKK: NEG"); 
   exit (print "NEGATIVE\t1\n");
}
elsif (!$LEX) {
     exit (print "$default_value\t1\n"); #if there is no lemma from the polartity lexicon: NONE.
}

my $smooth = 1/$N;
my $Normalizer = 0;
foreach $cat (keys %PriorProb) {
  if (!$cat) {next}
  $PostProb{$cat}  = $ProbCat{$cat};
 # print STDERR "ProbCat:#$cat# - #$ProbCat{$cat}#\n";
  $found{$cat}=0;
  foreach $word (@A) {
      #if (!$featFreq{$word} ||  $PriorProb{$cat}{$word} <= $th) {next} ;
      if (!$featFreq{$word} &&  !$Compound{$word} && !$Lex{$word}) {next};
     # print STDERR " priorprob-$word:#$PriorProb{$cat}{$word}#\n";
      $PriorProb{$cat}{$word}  = $smooth if ($PriorProb{$cat}{$word}  ==0) ;
    
       $found{$cat}=1; 
       $PostProb{$cat} = $PostProb{$cat} * $PriorProb{$cat}{$word};
       #print STDERR "----#$cat# - #$word# PriorProb#$PriorProb{$cat}{$word}# PostProb#$PostProb{$cat}#\n";
  }
 
  $PostProb{$cat} =  $PostProb{$cat} * $ProbCat{$cat} ;
  $PostProb{$cat} = 0 if (!$found{$cat});
  $Normalizer +=   $PostProb{$cat};
   #print STDERR "PROB: #$cat# -  PostProb#$PostProb{$cat}#  ProbCat#$ProbCat{$cat}#\n";
}
$found=0;
foreach $c (keys %PostProb) {
   #print STDERR "$c - #$PostProb{$c}#\n" if ($c);
   $PostProb{$c} = $PostProb{$c} / $Normalizer;
   $found=1 if ($found{$c});
}
my $First=0;

if (!$found) {
print "$default_value\t1\n"; 
}
else {
 foreach $c (sort {$PostProb{$b} <=>
                      $PostProb{$a} }
                      keys %PostProb ) {
    if (!$First) {
      print "$c\t$PostProb{$c}\n";
      $First=1;
  
    }
 }
}


sub trim {    #remove all leading and trailing spaces
  local ($str) = @_[0];

  $str =~ s/^\s*(.*\S)\s*$/$1/;
  return $str;
}

