#!/usr/bin/perl -w

####################O lema de CARD e o numeros e nao @card@


##Entrada: saida do TreeTagger ingles
##Saida: entrada do parsingCascataByRegularExpressions.perl

$Max = 5;
$UpperCase = "[A-Z\301\311\315\323\332\307\303\325\302\312\324\300\310ÑÇ]" ;
#$LowerCase = "[a-záéíóúàèìòùçãõñ]" ;

## Lexemas gramaticais especiais:
$AUX="(have|avoir|haber|haver)";
$COP="(be|be/have|être|ser)";

$Prep="(of|de)" ;

$Pos=0;
$i=0;
while (<>) {
   chop($_);
   $_ =~ s/[\*\+]+/-/g;

   if ($_ eq "" || $_ =~ /^<[\w\W]*>$/ || $_ !~ /\t/ )  {
      next
   }

  else {

     ($token, $tag, $lemma, $tmp) = split("\t", $_);

   ##correcçoes ad hoc de problemmas de etiquetaçao:

   if ( ($lemma =~ /^pol[oa](s?)$/) && ($tag =~ /^PRP/) ) {
           $lemma = "por"
   }
   $lemma =~ s/[\|\/]/-/ ;
   $tag =~ s/\:/;/;
   
   ##correçao no ingles: that _ IN that:
     #print STDERR "LEMA: #$lemma# - #$tmp#\n";
   if (defined $tmp) {
      if ($tmp eq "that") {
       $tag = $lemma;
       $lemma = $tmp;
      }
   } 

   ##interjeçoes, forein words, etc. desconhecidos poderiam ser nomes proprios:
    if ( ($tag =~ /^UH$/ || $tag =~ /^[()]$/ || $tag =~ /^LS$/ || $tag =~ /^FW$/ || $tag =~ /^POS/) && $lemma =~ /<unknown>/ && $token  =~ /^$UpperCase/ ) {
        $tag = "NP";
    }
     

   #se temos um possível nome próprio (desconhecido ou composto), colocar a forma no lemma (para conservar a maiuscula)
   if ($lemma =~ /<unknown>/ ) {
         $lemma = $token;
   }
   if ($lemma =~ /^$UpperCase/) {       
         $lemma = lc ($lemma);        
   }


  if ($tag ne "SENT"){
      $Token[$i] = $token;
      $Lemma[$i] = $lemma;  
      $Tag[$i] = $tag;
      $i++
  }
  else {
   $Token[$i] = "\.";
   $Lemma[$i] = "\.";
   $Tag[$i] = "SENT";

   for ($i=0;$i<=$#Token;$i++) {
    $token = $Token[$i] ;
    $lemma = $Lemma[$i];  
    $tag =  $Tag[$i] ;

   ##########BEGIN NER########### 
    if ($Tag[$i]  =~ /^NP/  && $Token[$i] =~ /^$UpperCase/ && $i < $#Token) {
     $j= $i + 1;
     $m=0;
     $found=0;
     $count=0;
     while (!$found && $count<=$Max && defined $Tag[$j] )  {
	 if ($Tag[$j]  !~ /^NP/ && $Lemma[$j] !~ /^$Prep$/) {
	     $found=1;
	 }
         else {
             $m = $j+1;
	     if ($Tag[$j] =~ /^NP/ && $Token[$j] =~ /^$UpperCase/ || 
                ($Lemma[$j] =~ /^$Prep$/ && $Tag[$m] =~ /^NP/ ) )  {
                 $token .= "&" .  $Token[$j] ;
                 $lemma .= "&" .  $Lemma[$j] ;
                 $i++;
                 $j++;
                 $count++;
	      }
	      else {
		 $found=1;
	     }
         }
      }
     ##########END NER########### 
    }
     

##adverbios
    if ($tag =~ /^RB/) {
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "ADV";
       if ($tag =~ /R$/) {
          $Exp{"degree"} = "A";
       }
       elsif ($tag =~ /S$/) {
          $Exp{"degree"} = "S";
       }
       else {
          $Exp{"degree"} = 0;  
       }
     
   }


   ##pronomes:
   
   elsif ($tag =~ /^PP$/) {
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

   } 
   elsif ($tag =~ /^W/) {
      $Exp{"lemma"} = $lemma;
      $Exp{"token"} = $token;
      $Exp{"tag"} =  "PRO";
      if ($tag eq "WDT" || $tag eq "WP") {
        $Exp{"type"} = "W"
      }
      else {
        $Exp{"type"} = 0;
      }
      $Exp{"person"} = 3;
      $Exp{"gender"} = 0;
      $Exp{"number"} = 0;
      $Exp{"case"} = 0;    
      $Exp{"possessor"} = 0;    
      $Exp{"politeness"} = 0;

   } 
      
     ##conjunctions:
    elsif ($tag =~ /^CC/) {
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "CONJ";
      
    }

    elsif ( $lemma =~ /^that$/ && $tag =~ /^IN/ ) {
	#print STDERR "OKKK\n";
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "CONJ";
       $Exp{"type"} = "S";
     }      
  
   
   ##numbers
   elsif ($tag =~  /^CD/) {
   #    $lemma = "\@card\@";
       (@tmp) = split ("", $tag);
       ##se nao queremos usar @card@:
       if ($token =~ /[0-9]/) {
         $Exp{"lemma"} = $token 
       }
       else {
        $Exp{"lemma"} = $lemma
       }
     # se queremos usar @card@: 
       #$Exp{"lemma"} = $token;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "CARD";
       $Exp{"number"} = "P";
       $Exp{"person"} = 0;         
       $Exp{"gender"} = 0;         
       
   }


    elsif ($tag =~ /^JJ/) {
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "ADJ";
       $Exp{"type"} = 0;
       
       if ($tag =~ /R$/) {
          $Exp{"degree"} = "A";
       }
       elsif ($tag =~ /S$/) {
          $Exp{"degree"} = "S";
       }
       else {
          $Exp{"degree"} = 0;  
       }
       $Exp{"gender"} = 0;
       $Exp{"number"} = 0;
       $Exp{"function"} = 0;
   }


   elsif ($tag =~ /(^IN$|^TO$)/) {
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "PRP";
       $Exp{"type"} = 0;
      
   }


   elsif ($tag =~ /^N/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "NOUN";
       if ($tag =~ /^NP$/) {
          $Exp{"type"} = "P";
          $Exp{"number"} = "S";
       }
       elsif  ($tag =~ /^NPS/)  {
           $Exp{"type"} = "P" ;
           $Exp{"number"} = "P";
       }
       if ($tag =~ /^NN$/) {
          $Exp{"type"} = "C";
          $Exp{"number"} = "S";
       }
       elsif  ($tag =~ /^NNS/)  {
           $Exp{"type"} = "C" ;
           $Exp{"number"} = "P";
       }
       $Exp{"gender"} = 0;
       $Exp{"person"} = 3;

   }

    elsif ($tag =~ /^SYM$/) {
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "NOUN";
       $Exp{"type"} = "P";
       $Exp{"number"} = "S";
       $Exp{"gender"} = 0;
       $Exp{"person"} = 3;
     }
    
    
   
   elsif ($tag =~ /(^DT$|^PDT$|^PP\$$)/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "DT";
       if ($tag =~ /^PP\$$/) {
         $Exp{"type"} = "P";
       }
       else{
         $Exp{"type"} = 0;
       }
       $Exp{"person"} = 0;
       $Exp{"gender"} = 0;
       $Exp{"number"} = 0;
       $Exp{"possessor"} = 0;
        
   }

  ##mudar tags nos verbos:
   elsif ($tag =~ /(^V|^MD$)/) {

       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "VERB";
       if  ($lemma =~ /^$AUX$/) {
         $Exp{"type"} = "A";
       }
       elsif ($lemma =~ /^$COP$/) {
          $Exp{"type"} = "S";
       }
       else {
          $Exp{"type"} = 0; 
       }
       if ($tag =~ /^V[VB]N/) {
        $Exp{"mode"} = "P";
       }
      
       elsif ($tag =~ /^V[VB]G$/) {
        $Exp{"mode"} = "G";
       }
       else {
          $Exp{"mode"} = 0; 
       }
       if ($tag =~ /^V[VB]D/) {
        $Exp{"tense"} = "S";
	$Exp{"person"} = 0;
	$Exp{"number"} = 0;
	$Exp{"gender"} = 0;
       }
       elsif ($tag =~ /^V[VB]Z/) {
        $Exp{"tense"} = "P";
        $Exp{"person"} = 3;
        $Exp{"number"} = 0;
	$Exp{"gender"} = 0;
       }
       else {
         $Exp{"tense"} = 0;
         $Exp{"person"} = 0;
         $Exp{"number"} = 0;
         $Exp{"gender"} = 0;
       }
   }

     ##simbolos puntuacao:
  #   elsif  ($token eq "!")  {
       
  #     $Exp{"lemma"} = $lemma;
  #     $Exp{"token"} = $token;
  #     $Exp{"tag"} =  "Fat";
  # }

   elsif  ($token eq "¡")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Faa";
   }

   elsif  ($token eq ",")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fc";
   }
   elsif  ($token eq "\[")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fca";
   }
   elsif  ($token eq "\]")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fct";
   }
   elsif  ($token eq "\:" || $lemma eq "\:")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fd";
   } 
   elsif  ($token eq "\"")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fe";
   }
   elsif  ($token eq "-")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fg";
   }
   elsif  ($token eq "\/")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fh";
   }
   elsif  ($token eq "¿")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fia";
   } 
 #   elsif  ($token eq "?")  {
       
  #     $Exp{"lemma"} = $lemma;
  #     $Exp{"token"} = $token;
  #     $Exp{"tag"} =  "Flt";
  # } 
   elsif  ($token eq "{")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fla";
   } 
    elsif  ($token eq "}")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Flt";
   } 
   elsif  ($token eq "(")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fpa";
   } 
   elsif  ($token eq ")")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fpt";
   } 
   elsif  ($token eq "\«")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fra";
   } 
   elsif  ($token eq "\»")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Frc";
   } 
   elsif  ($token eq "\.\.\.")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fs";
   } 
   elsif  ($token eq "%")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Ft";
   }  
   elsif  ($token eq "\;")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fx";
   } 

   elsif  ($token eq "[+-=]")  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "Fz";
   }
 
   
   ##particulas
   elsif  ($tag =~ /^RP$/)  {
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "PCLE";
   }

    ##final de frase (.)
   elsif ($token =~ /^\.$|^\?$|^\!$/) {
   # print STDERR "--$lemma -- $tag\n";       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "SENT";
       $Exp{"pos"} =  $Pos;
       $Pos=0;
   }
   else {
      $Exp{"lemma"} = $lemma;
      $Exp{"token"} = $token;
      $Exp{"tag"} =  $tag;
   }

  
  
   ##Colocar a posi¿ao em todos:
     if ($token !~ /^\.$|^\?$|^\!$/) {
       $Exp{"pos"} =  $Pos;
       $Pos++;
    }

 #  if   ($Exp{"tag"} =~ /^Fra$|^Frc$|Fe$/) {

  # }
 #  else {
    print "$token\t" ;
    foreach $attrib (sort keys %Exp) {
       print "$attrib:$Exp{$attrib}|" ;
       delete $Exp{$attrib};
    }
    print "\n";
  # }
   }
   for ($i=0;$i<=$#Token;$i++){
       delete $Token[$i];
       delete $Lemma[$i];
       delete $Tag[$i];
   }
   $i=0;
  }

 }
}


##as conjunçoes seguem a ser CS (subord) e CC (coordenada)
