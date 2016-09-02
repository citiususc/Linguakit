#!/usr/bin/perl -w

##Entrada: saida do Freeling
##Saida: entrada do parsingCascataByRegularExpressions.perl


## Lexemas gramaticais especiais:
$AUX="(have|avoir|ter|haber|haver)";
$COP="(be|être|ser)";


$Pos=0;
$FoundFinal=0;
while (<>) {
   chomp($_);

   if ($_ eq "" && $FoundFinal) {
      next
   }
   ##se hai um final de linha sem ponto final. So tem sentido com --flush
   elsif ($_ eq "" && !$FoundFinal) {
      # $Pos++;
       print "\.\tlemma:\.|tag:SENT|pos:$Pos|token:\.|\n";
       $FoundFinal=1;
       $Pos=0;
   }
 
   else {
     #troca do simbolo de composicao tipico de Freeling
     s/\_/\@/g ;

     ($token, $lemma, $tag) = split(" ", $_);
     if (!$token || !$lemma || !$tag) {next}
    ## reiniciar valor de FoundFinal
     if ($Pos==0) {
        $FoundFinal=0;
     }
   ##correcçoes ad hoc de problemas de etiquetaçao:

   if ( ($lemma =~ /^pol[oa](s?)$/) && ($tag =~ /^SP/) ) {
           $lemma = "por"
   }


    #se temos um NP (nome proprio), colocar a forma no lema (para conservar a maiuscula)
     #se temos um possível nome próprio (desconhecido ou composto), colocar a forma no lemma (para conservar a maiuscula)
   if ( ($token =~ /\&/) || ($tag =~ /^NP/) ) {
         $lemma = $token;
   }
  

 ##tag conversion:
 #mudar tags:
  # if ($tag =~ /^VIRG/) {
   #   $tag = "COMMA"
  # }

   ##pronomes:
  ##dates
   if ($tag eq "W") {
       $lemma =~ s/[\[\]]//g;
       $lemma =~ s/\:/\,/g;
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "DATE";
       $Exp{"number"} = "S";        
   }
 
   if ($tag =~ /^PRP$/) {
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
 
  elsif ($tag =~ /^PRP\$$/) {
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

   } 


  elsif ($tag =~ /^W/) {
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

   } 
      
     ##conjunctions:
    elsif ($tag =~ /^CC/) {
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "CONJ";
      
    }

    elsif ( ($lemma =~ /^that$/ || $lemma =~ /@/) && $tag =~ /^IN/ ) {
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "CONJ";
       $Exp{"type"} = "S";
     }      
  
    ##interjections:
    elsif ($tag =~ /^UH/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "I";
       $Exp{"type"} = 0;
      
    }

   ##numbers
   elsif ($tag =~  /^(CD|Z)/) {
      # $lemma = "\@card\@";
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
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


   elsif ($tag =~ /^RB/) {
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

   elsif ($tag =~ /(^DT$|^PDT$|^PP\$$)/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "DT";
       $Exp{"type"} = 0;
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
       if ($tag =~ /^VBN/) {
        $Exp{"mode"} = "P";
       }
      
       elsif ($tag =~ /^VBG$/) {
        $Exp{"mode"} = "G";
       }
       else {
          $Exp{"mode"} = 0; 
       }
       if ($tag =~ /^VBD/) {
        $Exp{"tense"} = "S";
	$Exp{"person"} = 0;
	$Exp{"number"} = 0;
	$Exp{"gender"} = 0;
       }
       elsif ($tag =~ /^VBZ/) {
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
   #elsif  ($token eq "!")  {
       
  #     $Exp{"lemma"} = $lemma;
  #     $Exp{"token"} = $token;
  #     $Exp{"tag"} =  "Fat";
 #  }

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
   # elsif  ($token eq "?")  {
  #     
   #    $Exp{"lemma"} = $lemma;
  #     $Exp{"token"} = $token;
   #    $Exp{"tag"} =  "Flt";
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
       $FoundFinal=1;
   }
   else {
      $Exp{"lemma"} = $lemma;
      $Exp{"token"} = $token;
      $Exp{"tag"} =  $tag;
   }

  

   ##Colocar a posicao em todos:
     if ($token !~ /^\.$|^\?$|^\!$/) {
       $Exp{"pos"} =  $Pos;
       $Pos++;
    }   

#   if   ($Exp{"tag"} =~ /^Fra$|^Frc$|Fe$/) {

 #  }
 #  else {
       print "$token\t" ;
       foreach $attrib (sort keys %Exp) {
	   print "$attrib:$Exp{$attrib}|" ;
           delete $Exp{$attrib};
       }
       print "\n";
  # }

 }
}

