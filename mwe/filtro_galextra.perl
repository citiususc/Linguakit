#!/usr/bin/perl -w

##Toma como entrada a saída do FreeLing e devolve um texto etiquetado com algumas modificaçoes: verbos compostos, elimina determinantes e pronomes, etc.


while (<>) {
   chop($_);

   if ($_ eq "") {
      next
   }
  
  else {
     #troca o simbolo de composicao:
     s/\_/\&/g ;
     ($pal, $lema, $tag) = split(" ", $_);

      if (!$pal || !$lema || !$tag) {next}     
        #mudar tags de numero e adv
        if ($tag && $tag =~  /^Z/) {
            $tag = "CARD";
            $lema = "\@card\@";
        }
            

       if ($tag && $tag =~ /^R/) {
         $tag = "ADV";
       }
       
    
     

       ##fora artigos e encliticos e aspas
       if   ( ($tag =~ /^D/) || ( $tag =~ /^PP/) || ( $tag =~ /^P0/) ||  ($tag eq "Fe") ) {
        }
         ##correcçoes ad hoc de problemas de etiquetaçao:
       
       elsif ( ($lema =~ /^pol[oa](s?)$/) && ($tag =~ /^SP/) ) {
           $lema = "por" ;
           printf "%s\t%s\t%s\n", $pal, $tag, $lema;
         }
        
        ##colocar a forma do nome proprio como lema
       elsif ($tag =~ /^NP/) {
         printf "%s\t%s\t%s\n", $pal, $tag, $pal;
       }

        else {
         printf "%s\t%s\t%s\n", $pal, $tag, $lema;
       }
    
   }
 }
