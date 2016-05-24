#!/usr/bin/perl

#GERA OS CONTEXTOS, AS PALAVRAS E AS FREQUENCIAS 
#lê o resultado do parsing: dependencias. 

#use progs::funcoes::categorias



$CountDep=0;

while ($line = <STDIN>) {

   if ($line !~ /^SENT::/) {

     if ( ($CountLines % 100) == 0) {;
       printf  STDERR "- - - processar linha:(%6d) - - -\r",$CountLines;
     }
     $CountLines++;

     $rel="";
     $head="";
     $dep="";
     $cat_h="";
     $cat_d="";
     $cat_r="";

     chop($line);

     #tiramos as parenteses da dependencia
     $line =~ s/^\(//;
     $line =~ s/\)$//;
    # print STDERR "$line\n";

    ($rel, $head, $dep) = split('\;', $line);

    ($head,$cat_h) = split ("_", $head);
    ($dep,$cat_d) = split ("_", $dep);
    if ($rel =~ /_/) {
        ($rel, $cat_r) = split ("_", $rel);
    }





##REGRA  NOUN-PREP-NOUN 

     if ( ($cat_r =~ /^PRP|POS/) && ($cat_h =~ /^N/) && ($cat_d =~ /^N/) ){
          $conRight{$head,$rel,$dep}++;
     }

##REGRA  VERB-PREP-NOUN 

     elsif ( ($cat_r  =~ /^PRP/) && ($cat_h =~ /^V/) && ($cat_d =~ /^N/) ){
          $VconRight{$head,$rel,$dep}++;
     }

##REGRA  NOUN-NOUN (linguas romances) 

     elsif ( ($rel eq "AdjnR") && ($cat_h =~ /^N/) && ($cat_d =~ /^N/) ){
          $NRight{$head,$dep}++;
     }

##REGRA  NOUN-NOUN (ingles) 

     elsif ( ($rel eq "AdjnL") && ($cat_h =~ /^N/) && ($cat_d =~ /^N/) ){
          $NRight{$head,$dep}++;
     }



##REGRAS NOUN-ADJ, ADJ-NOUN

     elsif ( ($rel eq "AdjnR") && ($cat_h =~ /^N/) && ($cat_d =~ /^ADJ/) ){
          $Right{$head,$dep}++;
     }

     elsif ( ($rel eq "AdjnL") && ($cat_h =~ /^N/) && ($cat_d =~ /^ADJ/) ){
          $Left{$head,$dep}++;
     }
     ##se o dependente e um cardinal, colocar a etiqueta para reduzir o numero de contextos diferentes
     elsif ( ($rel eq "AdjnL") && ($cat_h =~ /^N/) && ($cat_d =~ /^CARD/) ){
          $Left{$head,$cat_d}++;
     }



##REGRA  VERB-NOUN

     elsif ( ($rel eq "Robj") && ($cat_h =~ /^V/) && ($cat_d =~ /^N/) ){
          $VRight{$head,$dep}++;
     }

     ##participios com left object sao associados aos right objects...
     elsif ( ($rel eq "Lobj") && ($cat_h =~ /^VERBP/) && ($cat_d =~ /^N/) ){
          $VRight{$head,$dep}++;
     }


##REGRA  NOUN-VERB

     elsif ( ($rel eq "Lobj") && ($cat_h =~ /^V/) && ($cat_d =~ /^N/) ){
          $VLeft{$head,$dep}++;
     }

   }

}





print STDERR "fim leitura do ficheiro de entrada -- hashes carregados em memoria\n";


foreach $key (sort keys %conRight) {
  ($p1, $p2, $p3) = split (/$;/o, $key);
     if ($conRight{$p1,$p2,$p3}>0) {
       printf "%s_down_%s %s %d\n", $p2, $p1, $p3 , $conRight{$p1,$p2,$p3};
       print STDERR "trigram: $p1-$p2-$p3\n";
        printf "%s_up_%s %s %d\n", $p2, $p3, $p1, $conRight{$p1,$p2,$p3};
     }

}


foreach $key (sort keys %NRight) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($NRight{$p1,$p2}>0) {
       printf "modN_down_%s %s %d\n", $p1, $p2, $NRight{$p1,$p2} ;
       print STDERR "bigram: $p1-modN-$p2\n";
        printf "modN_up_%s %s %d\n", $p2, $p1, $NRight{$p1,$p2} ;
     }

}


foreach $key (sort keys %Right) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($Right{$p1,$p2}>0) {
       printf "Rmod_down_%s %s %d\n", $p1, $p2, $Right{$p1,$p2} ;
       print STDERR "bigram: $p1-$p2\n";
        printf "Rmod_up_%s %s %d\n", $p2, $p1, $Right{$p1,$p2} ;
     }

}


foreach $key (sort keys %Left) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($Left{$p1,$p2}>0) {
       printf "Lmod_down_%s %s %d\n", $p1, $p2, $Left{$p1,$p2} ;
       print STDERR "bigram: $p1-$p2\n";
       printf "Lmod_up_%s %s %d\n", $p2, $p1, $Left{$p1,$p2} ;
     }

}


foreach $key (sort keys %VconRight) {
  ($p1, $p2, $p3) = split (/$;/o, $key);
     if ($VconRight{$p1,$p2,$p3}>0) {
       printf "iobj&%s_down_%s %s %d\n", $p2, $p1, $p3, $VconRight{$p1,$p2,$p3};
       print STDERR "verb-trigrama: $p1-$p2-$p3\n";
        printf "iobj&%s_up_%s %s %d\n", $p2, $p3, $p1, $VconRight{$p1,$p2,$p3};
     }

}


foreach $key (sort keys %VRight) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($VRight{$p1,$p2}>0) {
       printf "Robj_down_%s %s %d\n", $p1, $p2,  $VRight{$p1,$p2} ;
       print STDERR "bigram: $p1-$p2\n";
        printf "Robj_up_%s %s %d\n", $p2, $p1, $VRight{$p1,$p2} ;
     }

}

foreach $key (sort keys %VLeft) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($VLeft{$p1,$p2}>0) {
       printf "Lobj_down_%s %s %d\n", $p1, $p2, $VLeft{$p1,$p2} ;
       print STDERR "bigram: $p1-$p2\n";
        printf "Lobj_up_%s %s %d\n", $p2, $p1, $VLeft{$p1,$p2};
     }

}

print  STDERR "o ficheiro de contextos - palavra - freq  foi gerado\n";
