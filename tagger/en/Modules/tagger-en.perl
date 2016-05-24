#!/usr/bin/perl
#!/usr/bin/perl

#PoS tagger
#autor: Pablo Gamallo
#Grupo ProlNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Desambigua os tags do ficheiro gerado por ner.perl

use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));

 #print STDERR "#$abs_path#\n";

open (MODEL, $abs_path."/model/train-en") or die "O ficheiro não pode ser aberto: $!\n";
binmode MODEL,  ':utf8';
my @train = <MODEL>;

##variabeis globais
my $w=1; ##mesma janela/window que no treino
my $Border = "(Fp|<blank>)";

my @cat_open = ("NN", "NNP", "VB", "RB", "JJ");

my $N;
my %PriorProb;
my %ProbCat;
my %featFreq;
my @unk;

sub tagger_en {
 my (@text) = @_ ;

 my @saida;
 my $result;
 #my $text;
 my $pos=0;
 my $s=0; #numero de frases
 my $tag;
 my @noamb;
 #my @unk;
 my @Token ;
 my @Tag;
 my @Lema;
 my %Tag;
 my %Lema;
 my @Feat;
 my @Cat;
 


#####################
#                   #
#    READING TRAIN  #
#                   #
#####################

my $count=0;
foreach  my $line (@train) {  ##leitura treino


   my $cat;
   my $prob; 
   my $feat;
   my $freq;
  
   $count++; 
   chomp $line;
   #$line = trim($line);
  
   ($N) = ($line =~ /<number\_of\_docs>([0-9]*)</) if ($count==1);

   if ($line =~ /<cat>/) { 
     (my $tmp) = $line =~ /<cat>([^<]*)</ ;
     #print STDERR "ProbCat: ---> #$tmp# \n";
     ($cat, $prob) = split (" ", $tmp);
     $ProbCat{$cat}=$prob ;
     #print STDERR "CAT: ---> #$cat# \n";

   }


    ($feat, $cat, $prob, $freq) = split(/ /, $line) if ($line !~ /<cat>/);
    
    $PriorProb{$cat}{$feat} = $prob if ($cat);
    $featFreq{$feat} = $freq;
    # print STDERR "CAT: ---> #$cat# ::: FEAT: #$feat# --  $featFreq{$feat}\n";
    #printf STDERR "<%7d>\r",$cont if ($cont++ % 100 == 0);
   
 }

###############################
#                             #
##INPUT: FRASE A ANALISAR######
#                             #
###############################
 #print STDERR "entrada: #@entrada#\n";
# $text = join ("",@text);

 #my @lines = split ('\n', $texto);
 #foreach my $line (@lines) {
 foreach my $line (@text) {
   if ($line !~ /\w/ || $line =~ /^[ ]$/) {next}
 
   (my @entry) = split (" ", $line);   
  
  if ($entry[2] !~ /^$Border$/) {
    $Token[$pos] = $entry[0];     
    my $i=1;
    while ($i<=$#entry) {
         $Lema[$pos] =  $entry[$i];
         $i++  ;
         $tag = $entry[$i];
         

         # ($Tag[$pos]) = $tag =~ /([A-Z][A-Z][A-Z]?)/ if ($tag =~ /^[VN]/);
         # ($Tag[$pos]) = $tag =~ /([A-Z][A-Z0-9]?)/ if ($tag !~ /^[VN]/);
          if ($tag =~ /^V/ || $tag =~ /^NNP/ ||  $tag =~ /^PRP/) {
            ($Tag[$pos]) = $tag =~ /([A-Z][A-Z][A-Z]?[A-Za-z\$]?)/;
          }
          else {
             ($Tag[$pos]) = $tag =~ /([A-Z][A-Za-z\$0-9]?)/ 
          }      

         $Tag{$pos}{$Tag[$pos]} = $tag ;
         $Lema{$pos}{$tag} = $Lema[$pos] ;

        if  ($#entry == 2 && $entry[2] ne "UNK") { ##identificar formas nao ambiguas nem desconhecidas (unk)
	    $noamb[$pos]=1;
           # print  "NOAMB: $entry[0] $entry[1] $entry[2]\n";
        }
        if  ($#entry == 2 && $entry[2] eq "UNK") { ##identificar formas  desconhecidas (unk)
	    $unk[$pos]=1;
        }

   

         $i++;
         #print STDERR "LEMA:: #$Token[$pos]# #$Lema{$pos}{$Tag[$pos]}# #$Tag[$pos]#\n"; 
       # print STDERR "----#$Tag[$pos]# --#$ProbCat{$Tag[$pos]}#\n";
    }
    
       ####REGRAS MORFOLOGICAS
             if  ($unk[$pos] && $Token[$pos] =~ /[\w]+ly$/) { ##se a forma e desconhecida acabada em -mente, RG
		 my  $cat = "RB";
                 $Tag{$pos}{$cat} = $cat;
                 $Lema{$pos}{$cat} = $Lema[$pos] ;
                 $unk[$pos]=0;
	     }
           
             elsif  ($unk[$pos] && $Token[$pos] =~ /[\w]+ing$/) { ##se a forma e desconhecida acabada em -ando, VMG
		 my  $cat = "VB";
                 $Tag{$pos}{$cat} = "VBG";
                 $Lema{$pos}{$cat} = $Lema[$pos] ; 
                 $unk[$pos]=0;
	     }
            # elsif  ($unk[$pos] && $Token[$pos] !~ /[áéíóú]/ && $Token[$pos] =~ /[\w]+[ai]d[ao](s)?$/) { ##se a forma e desconhecida acabada em -ado/ido, VMP
	#	 my  $cat = "VMP";
            #     $Tag{$pos}{$cat} = "VMP0000";
            #     $Lema{$pos}{$cat} = $Lema[$pos] ;
            #     $unk[$pos]=0;
	   #  }
          
            ####FIM REGRAS MORFOLOGICAS     
    $pos++;

  }
  
  else {
     $s++;
     ##guardar info da ultima forma da frase (Fp ou blank)
     (my @entry) = split (" ", $line);
     #print STDERR "LAST: #$line#\n";
     my $last_entry =  "$entry[0] $entry[1] $entry[2]";
     for ($pos=0;$pos<=$#Tag;$pos++) {
	 #print STDERR "TOKENS::: #$pos# -- #$Token[$pos]#\n";
	 if ($noamb[$pos]) {
             ###RESULTADO para nao ambiguas nem desconhecidas: 
	     #print "$Token[$pos] $Lema[$pos] $Tag{$pos}{$Tag[$pos]}\n";
             $result = "$Token[$pos] $Lema[$pos] $Tag{$pos}{$Tag[$pos]}";
             push (@saida, $result);
         }
         else {
	     if (!$unk[$pos]) { #se a forma e ambigua mas conhecida, utilizamos a lista de tags atribuida a forma
                # print STDERR "AMB: $Token[$pos]\n";
                foreach  my $cat (keys %{$Tag{$pos}}) {
                   #print STDERR "----#$cat# \n";
                      push (@Cat, $cat);
	        }
	     }

           

             else { #se a forma e desconhecida, utilizamos uma lista de tags de classes abertas
                foreach  my $cat (@cat_open) {
                   #print STDERR "UNK----#$cat# \n";
                      push (@Cat, $cat);
		}  

	     }     
           #buscar a informaçao das entradas ambiguas a direita (w=1)
            my $k=0;
            my $amb;
            if ($pos==0) {
	      for (my $j=1;$j<=$w;$j++) {
                 if ($noamb[$j]) {
		     $amb = "noamb";
		 }
                 else {
                    $amb = "amb";
		 }
                  my $feat;
                  foreach $feat (keys %{$Tag{$j}}) {
                      if (!$feat) {next}
                      $k++;
                      $feat = $amb . "_" . $k . "_" . $w . "_R_" . $feat;
                      my $new_token = lc $Token[$pos] ;
                      my $featL = $feat . "_" .  $new_token;
                      # print STDERR "FEATS:: ----#$feat#  #$Tag{$j}{$feat}# #$new_token# #$Token[$j]# \n";
                      push (@Feat, $feat);
                      push (@Feat, $featL);
		  }   
                  $feat = "noamb" . "_" . "1" . "_" . $w . "_L_" . "BEGIN";
                  push (@Feat, $feat);
                  $k=0;
		  $amb="";
	      }
            }

            elsif ($pos==$#Tag) {
                my $end=$#Tag-$w; 
		for (my $j=$#Tag-1;$j>=$end;$j--) {
                 if ($noamb[$j]) {
		     $amb = "noamb";
		 }
                 else {
                    $amb = "amb";
		 }
                 my $feat;
                  foreach  $feat (keys %{$Tag{$j}}) {
                      if (!$feat) {next}
                      $k++;
                      $feat =  $amb . "_" . $k . "_" . $w . "_L_" . $feat;
                      
                      #my $new_token = lc $Token[$pos] ;
                      my $new_token =  $Token[$pos] ;
                      my $featL = $feat . "_" .  $new_token;
                      # print STDERR "FEATS:: ----#$feat#  #$Tag{$j}{$feat}# #$new_token# #$Token[$j]# \n";
                     # print STDERR "OKKK----#$new_token# \n";
                      push (@Feat, $feat);
                      push (@Feat, $featL);
		  }
                  $feat = "noamb" . "_" . "1" . "_" . $w . "_R_" . "END";
                  push (@Feat, $feat);  
                  $k=0;
                  $amb="";
	      }  
            } 
	   else {
	     my $end=$pos+$w;
             #print STDERR "i=#$i#::: #$Cat# -- #$#Tag#\n";
             for (my $j=$pos+1;$j<=$end;$j++) {
		 if ($noamb[$j]) {
		     $amb = "noamb";
		 }
                 else {
                    $amb = "amb";
		 }
                 foreach my $feat (keys %{$Tag{$j}}) {
                      if (!$feat) {next}
		      $k++;
                      #print STDERR "FEATS:: ----#$feat#  #$Tag{$j}{$feat}# #$Token[$j]# \n";
                      $feat = $amb . "_" . $k . "_" . $w . "_R_" . $feat;
                      my $new_token =   $Token[$pos];
                      my $featL = $feat . "_" .  $new_token;
                        
                      # print STDERR "OKKK----#$new_token# #$feat#\n";
                      #print STDERR "----#$feat# \n";
                      push (@Feat, $feat);
                      push (@Feat, $featL);
		 }     
                 $k=0; 
                 $amb="";
	    }  
            $end=$pos-$w; 
            for (my $j=$pos-1;$j>=$end;$j--) {
                 if ($noamb[$j]) {
		     $amb = "noamb";
		 }
                 else {
                    $amb = "amb";
		 }
                foreach my $feat (keys %{$Tag{$j}}) {
		     if (!$feat) {next}
                     $k++;
                     $feat = $amb . "_" . $k . "_" . $w . "_L_" . $feat;
                     #my $new_token = lc $Token[$pos] ;
                     my $new_token =  $Token[$pos]; ;
                     my $featL = $feat . "_" . $new_token ;
                       #print STDERR "----#$feat# \n";
                      push (@Feat, $feat);
                      push (@Feat, $featL);
		}  
                $k=0;    
                $amb="";
	    }

                     
	 }

        $tag = classif ($pos, \@Feat, \@Cat);
        #print STDERR "RES:::::#$Token[$pos]# #$tag#\n";
	if ($unk[$pos]) {
            #$tag =~ s/^([^ ]+)/${1}00000/ if ($tag =~ /^[N]/);
           # $tag =~ s/^([^ ]+)/${1}0000/ if ($tag =~ /^[AV]/);
           
	    $Tag[$pos] = $tag;
            $Lema{$pos}{$Tag[$pos]} =  $Token[$pos]; ##colocar o mesmo token no lema para as desconhecidas
	}
	else {
           $Tag[$pos] = $Tag{$pos}{$tag} ;
	}
        ###RESULTADO:
        #print "$Token[$pos] $Lema[$pos] $Tag[$pos]\n";
       # print STDERR "-- #$Lema[$pos]# -- #$Tag[$pos]# -- #$Lema{$pos}{$Tag[$pos]}#\n";
        $result = "$Token[$pos] $Lema{$pos}{$Tag[$pos]} $Tag[$pos]";
        push (@saida, $result);   

        ##eliminar tags nao selecionados do token resultante para proximos processos
        foreach my $t (keys %{$Tag{$pos}}) {
	    if ($t ne $tag) {
              delete $Tag{$pos}{$t}; 
	    }
        }       

        undef @Feat;
        undef @Cat;      
       }
      }
      ###RESULTADO:
     # print "$last_entry\n";
      $result = "$last_entry";
      push (@saida, $result);    

      
      for ($pos=0;$pos<=$#Tag;$pos++) {
          
          delete $Tag{$pos}; 
          delete $Lema{$pos};
      }  

      #splice @Tag, 0, $#Tag ;
     
      undef (@Tag);
      undef (@Token);
      undef (@Lema);
      undef @noamb;
      undef @unk;
      $pos=0;
      #splice @Token, 0, $#Token ;
      #splice @Lema, 0, $#Lema ;
      #splice @noamb, 0, $#noamb ;
      #splice @unk, 0, $#unk ;       
     }
     
 } 
 print STDERR "number of sentences: #$s#\n";
 return @saida;
}


sub classif {
 my $pos = @_[0];
 my @F = @{$_[1]};
 my @C = @{$_[2]};

 my $result;
 

#########################################
#                                       #
#       Classification                  #
#                                       #
#########################################

  
 my %found;
 my $smooth = 1/$N ;
 my $cat_restr;
 my $feat_restr;
 my $n; 
 my $cat;
 my $feat;
 my %PostProb;

##Para cada cat, construir os cat_restr em funçao do numero de features ambiguos
 #foreach $cat (@C) {
  # foreach $feat (@F) {
  #   ($n)  = $feat =~ /^[a-z]+\_([0-9]+)/;
  #   $cat_restr = $cat . "_" . $n; 
  #   push (@CAT_RESTR, $cat_restr);
  # }
 #}


 #my $Normalizer=0;
 my %count;
 foreach $cat (@C) {
  if (!$cat) {next}
  $count{$cat}++;
 
  $PostProb{$cat}  = $ProbCat{$cat};
  #print STDERR "----#$cat_restr# #$ProbCat{$cat}#\n";
  $found{$cat}=0;
  foreach $feat_restr (@F) {
       
       ($feat) = $feat_restr =~ /^[a-z]+\_[0-9]+\_[0-9]\_([RL]\_[^ ]+)/;
       #print STDERR "FEAT: #$cat# - #$feat#\n";
       
       if (!$featFreq{$feat}) { 
          #print STDERR "NOFREQ----#$cat# - #$feat#\n" ;
           next;
       }    
       
       
        $PriorProb{$cat}{$feat}  = $smooth if ($PriorProb{$cat}{$feat}  ==0 ) ; 
        if (rules_neg ($cat, $feat)) {
          $PriorProb{$cat}{$feat}  = 0;  
          #print STDERR "RULES:: ----#$cat# - #$feat# PriorProb=#$PriorProb{$cat}{$feat}# \n";
        }
        elsif (!$unk[$pos] && rules_pos ($cat, $feat)) {
          $PriorProb{$cat}{$feat}  = 1;  
          #print STDERR "RULES:: ----#$cat# - #$feat# PriorProb=#$PriorProb{$cat}{$feat}# \n";
        }
        $found{$cat}=1; 

        $PostProb{$cat} = $PostProb{$cat} * $PriorProb{$cat}{$feat};
        
            
       #print STDERR "----#$cat# - #$feat# PriorProb#$PriorProb{$cat}{$feat}# PostProb#$PostProb{$cat}#  -- featFreq:#$featFreq{$feat}# N=#$N#  \n";
      #}
  }
 
  $PostProb{$cat} =  $PostProb{$cat} * $ProbCat{$cat} ;
  $PostProb{$cat} = 0 if (!$found{$cat});  
  
  #$Normalizer +=   $PostProb{$cat} 
  #print STDERR "----#$cat# $PostProb{$cat} \n";
 }

 my $First=0;
 foreach my $c (sort {$PostProb{$b} <=>
                      $PostProb{$a} }
                      keys %PostProb ) {
    if (!$First) {
         my $score = $PostProb{$c};
	  # print STDERR "$c\t$score\n";
	  $result = "$c";
          $First=1;
    }
 }
  # print STDERR "RES:::: #$result#\n";
 return $result;
 
}


sub rules_neg {    #regras lexico-sintacticas negativas
    my ($cat, $feat) = @_ ;
    my $result;

    ##impedir o 'that' pronome após verbo
    if ($cat =~ /^PRP/ && ($feat eq "L_VB_that" || $feat eq "L_VBd_that") ) {
     $result = 1;
    }

     #impedir artigo final de frase ou seguido de preposiçao ou de conjunção
    elsif ($cat =~ /^DT/ && ($feat eq "R_END" || $feat eq "R_IN" || $feat eq "R_CC") ) {
     $result = 1;
    }

   # elsif ($cat =~ /^NN/ && $feat eq "L_F_one"  ) {
     #$result = 1;
    #}
   
   
   return $result;

}
sub rules_pos {    #regras lexico-sintacticas positivas
    my ($cat, $feat) = @_ ;
    my $result;

   
    ##se hai um adverbio negativo diante dum verbo
    #if ($cat =~ /^RN/   && $feat =~ /R_V/  ) {
    # $result = 1;
    #}
   
   return $result;

}

sub trim {    #remove all leading and trailing spaces
  my ($str) = @_[0];

  $str =~ s/^\s*(.*\S)\s*$/$1/;
  return $str;
}

