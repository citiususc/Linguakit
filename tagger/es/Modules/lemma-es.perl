#!/usr/bin/perl

#ProLNat NER 
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela

use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
use open qw(:std :utf8);
use Storable qw(store retrieve freeze thaw dclone);

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));


##ficheiros de recursos
my $lex = $abs_path."/lexicon/lex_stored" ;

my $arrayref = retrieve($lex); 
my $Entry = $arrayref->[0];
my $Lex = $arrayref->[1];
my $StopWords =  $arrayref->[2];
my $Noamb =  $arrayref->[3];

##lexico de formas ambiguas
open (AMB, $abs_path."/lexicon/ambig.txt") or die "O ficheiro de palavras ambiguas não pode ser aberto: $!\n";
binmode AMB,  ':utf8';


#print STDERR "$abs_path\n";
##variaveis globais
##para sentences e tokens:
my $UpperCase = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜ]" ;
my $LowerCase = "[a-záéíóúàèìòùâêîôûñçü]" ;
my $Punct =  qr/[\,\;\«\»\“\”\'\"\&\$\#\=\(\)\<\>\!\¡\?\¿\\\[\]\{\}\|\^\*\€\·\¬\…\-\+]/;
my $Punct_urls = qr/[\:\/\~]/ ;
my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";


##carregando palavras ambiguas
my %Ambig;
while (my $t = <AMB>) {
    $t = Trim ($t);
    $Ambig{$t}++;
}

sub lemma_es {
  my (@text) = @_ ;

  my $N=10;
  my $saida;
  my @saida;

  ######################info dependente da língua!!!####################################################################################
  my $cifra = "(dos|tres|catro|cinco|seis|siete|ocho|nueve|diez|cien|mil)";  ##hai que criar as cifras básicas: once, doce... veintidós, treinta y uno...
  ######################info dependente da língua!!!####################################################################################

  my $SEP = "_";
 # my @tokens;
  my %Tag;
  my $Candidate;
  my $Nocandidate;
  #my $ContarCandidatos=0;
  my $linhaFinal;
  my $token;
    

 # print STDERR "TEXT: #@text#\n";
  my $text = join("",@text)  ;  
   #print STDERR "TEXT: #$text#\n";
  (my @tokens) = split ('\n', $text);
 
  for (my $i=0; $i<=$#tokens; $i++) {
      
      chomp $tokens[$i];
      #print STDERR "TOK1: #$tokens[$i]# -- I=#$i# --#$#tokens#\n";  
          ##marcar fim de frase
      $Tag{$tokens[$i]} = "";
      my $lowercase = lowercase ($tokens[$i] ); 
      # print STDERR "TOK1: #$tokens[$i]# -- I=#$i# --#$#tokens#\n";
      if  ($tokens[$i] =~ /^[ ]*$/) {
          $tokens[$i] = "#SENT#";
      }
       #print STDERR "TOK2: #$tokens[$i]# -- I=#$i# --#$#tokens#\n";
     # print STDERR "---- $tokens[$i]\n";
        my $k = $i - 1 ;
        my $j = $i + 1;
         
         
         ####CADEA COM TODAS PALAVRAS EM MAIUSCULA
         if   ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$j] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$j])} ) {
               $Tag{$tokens[$i]} = "UNK"; ##identificamos cadeas de tokens so em maiusculas e estao no dicionario
                
                 
         }
         elsif   ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$k] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$k])} &&
                  ($tokens[$j] =~ /^(\#SENT\#|\<blank\>|\"|\»|\”|\.|\-|\s|\?|\!)$/ || $i == $#tokens ) ) { ##ultimo token de uma cadea com so maiusculas
             $Tag{$tokens[$i]} = "UNK";        
      
         }
         
         ####CADEAS ENTRE ASPAS com palavras que começam por maiuscula 
       elsif   ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /[\"\»\”\']/) {
             
             # print STDERR  "#$tokens[$i]# --- #$tokens[$k]#\n";
	      $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] ;  
              $i = $i + 1; 
              $tokens[$i] = $Candidate;
                                
       }
       elsif   ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /[\"\»\”\']/) {
             
              #print STDERR  "#$tokens[$i]# --- #$tokens[$k]#\n";
	      $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP . $tokens[$i+2] ;   
              $i = $i + 2;
              $tokens[$i] = $Candidate;
                            
       }
       elsif   ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /[\"\»\”\']/) {
                $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3];   
                $i = $i + 3;   
                $tokens[$i] = $Candidate;           
       }
       elsif   ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /^$UpperCase/ && $tokens[$i+5] =~ /[\"\»\”\']/) {
                $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3] . $SEP . $tokens[$i+4];   
                $i = $i + 4;   
                $tokens[$i] = $Candidate;           
       }
       elsif   ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /^$UpperCase/  && $tokens[$i+5] && $tokens[$i+6] =~ /[\"\»\”\']/) {
                $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3] . $SEP . $tokens[$i+4] . $SEP . $tokens[$i+5];   
                $i = $i + 5;   
                $tokens[$i] = $Candidate;           
       }

      
        ###Palavras que começam por maiúscula e nao estao no dicionario com maiusculas
        elsif ( $tokens[$i] =~ /^$UpperCase/ && $Noamb->{$tokens[$i]} ) { ##começa por maiúscula e e um nome proprio nao ambiguo no dicionario
	    $Tag{$tokens[$i]} = "NP00000";
	}
	#elsif   ( ($tokens[$i] =~ /^$UpperCase/) &&  !$Lex->{$lowercase} && 
        elsif    ($tokens[$i] =~ /^$UpperCase/ &&  !$StopWords->{$lowercase} &&
                  $tokens[$k] !~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡|\?|\!|\:|\`\`)$/ && $tokens[$k] !~ /^\.\.\.$/  && $i>0 ) { ##começa por maiúscula e nao vai a principio de frase
                 $Tag{$tokens[$i]} = "NP00000";
               #print  STDERR "1TOKEN::: ##$i## --  ##$tokens[$i]## - - #$Tag{$tokens[$i]}# --  prev:#$tokens[$k]# --  post:#$tokens[$j]#\n" if ($tokens[$i] eq "De");
                
         }
        ## elsif   ( ($tokens[$i] =~ /^$UpperCase/ &&  !$Lex->{$lowercase} &&
           elsif   ( ($tokens[$i] =~ /^$UpperCase/ &&  !$StopWords->{$lowercase} &&
                   $tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡|\?|\!|\:|\`\`)$/) || ($i==0) ) { ##começa por maiúscula e vai a principio de frase 
	       # $token = lowercase ($tokens[$i]);
                # print STDERR "2TOKEN::: lowercase: #$lowercase# -- token: #$tokens[$i]# --  token_prev: #$tokens[$k]# --  post:#$tokens[$j]#--- #$Tag{$tokens[$i]}#\n" if ($tokens[$i] eq "De");       
                if (!$Lex->{$lowercase} || $Ambig{$lowercase}) {
		   # print STDERR "--AMBIG::: #$lowercase#\n";
                  $Tag{$tokens[$i]} = "NP00000"; 
                   # print STDERR "OKKKK::: lowercase: #$lowercase# -- token: #$tokens[$i]# --  token_prev: #$tokens[$k]#  --  post:#$tokens[$j]#\n" ;       
		}
                #print STDERR "##$tokens[$i]## -  #$tokens[$k]#\n" if ($tokens[$i] eq "De");
           }
          
      
     ## if   ( $tokens[$i] =~ /^$UpperCase$LowerCase+/ && ($StopWords->{$lowercase} && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡)$/) || ($i==0)) ) {   }##se em principio de frase a palavra maiuscula e uma stopword, nao fazemos nada
 
        if   ( ($tokens[$i] =~ /^$UpperCase$LowerCase+/ && $Lex->{$lowercase} &&  !$Ambig{$lowercase}) && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡|\?|\!|\:|\`\`)$/ || $i==0) ) {  
        
          #print  STDERR "1TOKEN::: ##$lowercase## // #!$Ambig{$lowercase}# - - #$Tag{$tokens[$i]}# --  #$tokens[$k]#\n" ;      
    
        }##se em principio de frase a palavra maiuscula e está no lexico sem ser ambigua, nao fazemos nada

          ##se não lhe foi assigado o tag NP, entao UNK (provisional)
        if   (! $Tag{$tokens[$i]}) {
              $Tag{$tokens[$i]} = "UNK" ; 
	}

          ##se é UNK (é dizer nao é NP), entao vamos buscar no lexico
        if ($Tag{$tokens[$i]} eq "UNK") {
	     $token = lowercase ($tokens[$i]);
              #print STDERR "2--: $tokens[$i] - $Tag{$tokens[$i]}\n";
             if ($Lex->{$token}) {
		 $Tag{$tokens[$i]} = $Entry->{$token};
                #  print STDERR "3--: $tokens[$i] - $Tag{$tokens[$i]}\n";
	     }
	     
          }
          elsif ($Tag{$tokens[$i]} eq "NP00000") {
              $token = lowercase ($tokens[$i]); 
          }

         
         ##os numeros, medidas e datas #USAR O FICHEIRO QUANTITIES.DAT##################

         ##CIFRAS OU NUMEROS
         if ($tokens[$i] =~ /[0-9]+/ || $tokens[$i] =~ /^$cifra$/) {
	        $token = $tokens[$i];
                $Tag{$tokens[$i]} = "Z"; 
	  }         


        
          #agora etiquetamos os simbolos de puntuaçao
          if ($tokens[$i] eq "\.") {
	        $token = "\.";
                $Tag{$tokens[$i]} = "Fp"; 
	  }
         
          elsif ($tokens[$i] eq "#SENT#" && $tokens[$i-1] ne "\." && $tokens[$i-1] ne "<blank>" ){
               # print STDERR "--- #$tokens[$i]# #$tokens[$i-1]#\n";
	        $tokens[$i] = "<blank>";
	        $token = "<blank>";
                $Tag{$tokens[$i]} = "Fp"; 
	  }
          
     
         elsif ($tokens[$i] =~ /^$Punct$/ || $tokens[$i] =~ /^$Punct_urls$/ || 
            $tokens[$i] =~ /^(\.\.\.|\`\`|\'\'|\<\<|\>\>|\-\-)$/ ) {
            $Tag{$tokens[$i]} = punct ($tokens[$i]);
            $token = $tokens[$i]; 
           #print STDERR "token: #$token# -- #$tokens[$i]# -- #$Tag{$tokens[$i]}# \n";
	 }
         
         ##as linhas em branco eliminam-se 
         if ($tokens[$i] eq  "#SENT#") {
           next
	 }

        
        ##parte final..
        $Tag{$tokens[$i]} = $token . " " . $Tag{$tokens[$i]} if ( $Tag{$tokens[$i]} =~ /^(UNK|F|NP|Z|W)/  );
       # print "$tokens[$i] $Tag{$tokens[$i]}\n";
         $saida  = "$tokens[$i] $Tag{$tokens[$i]}";
         push (@saida, $saida);

         ##caso especial: final de texto sem puntuaçao
        if ($i == $#tokens && $tokens[$i] ne "\.") {
	   $saida = "<blank> <blank> Fp";
           push (@saida, $saida);
        }


        $Tag{$tokens[$i]} = "";
        #$i += $adiantar if ($adiantar); ##adiantar o contador se foram encontradas expressoes compostas
        
     }

  return @saida;
}


###OUTRAS FUNÇOES

sub punct {
   my ($p) = @_ ;
   my $result;
  
   if ($p eq "\.") {
         $result = "Fp"; 
   }
   elsif ($p eq "\,") {
         $result = "Fc"; 
   }
   elsif ($p eq "\:") {
         $result = "Fd"; 
   }
   elsif ($p eq "\;") {
         $result = "Fx"; 
   }
   elsif ($p =~ /^(\-|\-\-)$/) {
         $result = "Fg"; 
   } 
   elsif ($p =~ /^(\'|\"|\`\`|\'\')$/) {
         $result = "Fe"; 
  }
  elsif ($p eq "\.\.\.") {
         $result = "Fs"; 
   }
  elsif ($p =~ /^(\<\<|«|\“)/) {
         $result = "Fra"; 
  }
   elsif ($p =~ /^(\>\>|»|\”)/) {
         $result = "Frc"; 
  }
  elsif ($p eq "\%") {
         $result = "Ft"; 
  }
  elsif ($p =~ /^(\/|\\)$/) {
         $result = "Fh"; 
  }
  elsif ($p eq "\(") {
         $result = "Fpa"; 
  }
  elsif ($p eq "\)") {
         $result = "Fpt"; 
  }
  elsif ($p eq "\¿") {
         $result = "Fia"; 
  } 
  elsif ($p eq "\?") {
         $result = "Fit"; 
  }
   elsif ($p eq "\¡") {
         $result = "Faa"; 
  }
  elsif ($p eq "\!") {
         $result = "Fat"; 
  }
  elsif ($p eq "\[") {
         $result = "Fca"; 
  } 
  elsif ($p eq "\]") {
         $result = "Fct"; 
  }
  elsif ($p eq "\{") {
         $result = "Fla"; 
  } 
  elsif ($p eq "\}") {
         $result = "Flt"; 
  }
  elsif ($p eq "\…") {
         $result = "Fz"; 
  }
  elsif ($p =~ /^[\+\*\#\&]$/) {
         $result = "Fz"; 
  }


  return $result;
}


sub lowercase {
  my ($x) = @_ ;
  $x = lc ($x);
  $x =~  tr/ÁÉÍÓÚÇÑ/áéíóúçñ/;

  return $x;

} 
sub Trim {
  my ($x) = @_ ;

  $x =~ s/^[\s]*//;  
  $x =~ s/[\s]$//;  

  return $x
}
       
