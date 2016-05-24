#!/usr/bin/perl -w

##Entrada: saida do Freeling
##Saida: entrada do parser


$Pos=0;
$FoundFinal=0;
while (<>) {
   chomp($_);

   if ($_ eq "" && $FoundFinal) {
      next;
   }

   ##se hai um final de linha sem ponto final. So tem sentido com --flush
   elsif ($_ eq "" && !$FoundFinal) {
      # $Pos++;
       print "\.\tlemma:\.|tag:SENT|pos:$Pos|token:\.|\n";
       $FoundFinal=1;
       $Pos=0;

   }

   else {
     #troca do simbolo de composicao tipico de Freeling polo que vai ser usado polo parser
     s/\_/\@/g ;

     ($token, $lemma, $tag) = split(" ", $_);

     ## reiniciar valor de FoundFinal
     if ($Pos==0) {
        $FoundFinal=0;
      }
   ##correcçoes ad hoc de problemas de etiquetaçao:

   if ( ($lemma =~ /^pol[oa](s?)$/) && ($tag =~ /^SP/) ) {
           $lemma = "por"
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
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "PRO";
       $Exp{"type"} = $tmp[1];
       $Exp{"person"} = $tmp[2];
       $Exp{"gender"} = $tmp[3];
       $Exp{"number"} = $tmp[4];
         if (defined $tmp[5]) {
         $Exp{"case"} = $tmp[5];
       }  
       else {
         $Exp{"case"} = 0
       }  
       if (defined $tmp[6]) {
         $Exp{"possessor"} = $tmp[6];
       } 
       else {
         $Exp{"possessor"} = 0
       }   
       if (defined $tmp[7]) {  
         $Exp{"politeness"} = $tmp[7];    
       }
       else {
         $Exp{"politeness"} = 0
       }  
    }

     ##conjunctions:
    elsif ($tag =~ /^C/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "CONJ";
       $Exp{"type"} = $tmp[1];
      
    }
  
    ##interjections:
    elsif ($tag =~ /^I/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  $tmp[0];
       $Exp{"type"} = 0;
      
    }

   ##numbers
   elsif ($tag =~  /^Z/) {
   #    $lemma = "\@card\@";
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "CARD";
       $Exp{"number"} = "P";
       $Exp{"person"} = 0;
       $Exp{"gender"} = 0;
      # $Exp{"type"} = $tmp[1];
         
       
   }

   elsif ($tag =~ /^A/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "ADJ";
       $Exp{"type"} = $tmp[1];
       $Exp{"degree"} = $tmp[2];
       $Exp{"gender"} = $tmp[3];
       $Exp{"number"} = $tmp[4];
       $Exp{"function"} = $tmp[5];
       #print STDERR "$tmp[1] - $tmp[2] - $tmp[3] - $tmp[4] - $tmp[5]\n"   
   }


   elsif ($tag =~ /^R/) {
      (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "ADV";
       $Exp{"type"} = $tmp[1];
     
   }


   elsif ($tag =~ /^SP/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "PRP";
       $Exp{"type"} = $tmp[1];
      
   }


   elsif ($tag =~ /^N/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "NOUN";
       $Exp{"type"} = $tmp[1];
       $Exp{"gender"} = $tmp[2];
       $Exp{"number"} = $tmp[3];
       $Exp{"person"} = 3;

   }

   elsif ($tag =~ /^D/) {
       (@tmp) = split ("", $tag);
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "DT";
       $Exp{"type"} = $tmp[1];
       $Exp{"person"} = $tmp[2];
       $Exp{"gender"} = $tmp[3];
       $Exp{"number"} = $tmp[4];
       $Exp{"possessor"} = $tmp[5];
        
   }

  

 ##mudar tags nos verbos:
   elsif ($tag =~ /^V/) {

       (@tmp) = split ("", $tag);
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
    #if   ( ($tag =~ /^Fat/) || ($tag =~ /^Fit/) ||
     #	   ($tag =~ /^Fp/) ) {
     #      $tag = "SENT";
    #}

    ##final de frase (.)
    elsif  ($tag =~ /^Fp$|^Fit$|^Fat$/)  {
       
       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  "SENT";
       $Exp{"pos"} =  $Pos;
       $Pos=0;
       $FoundFinal=1;

   }

   elsif  ($tag =~ /^F/)  {

       $Exp{"lemma"} = $lemma;
       $Exp{"token"} = $token;
       $Exp{"tag"} =  $tag;
   }

   else {
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
#   if   ( ($tag =~ /^Fra/) || ( $tag =~ /^Frc/) || 
 #         ($tag eq "Fe") ) {
 #  }
  # else {
       print "$token\t" ;
       foreach $attrib (sort keys %Exp) {
	   print "$attrib:$Exp{$attrib}|" ;
           delete $Exp{$attrib};
       }
       print "\n";
  # }


 }
}


##as conjunçoes seguem a ser CS (subord) e CC (coordenada)
