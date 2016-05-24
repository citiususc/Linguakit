#!/usr/bin/perl

#GERA UMA LISTA DE TRIGRAMAS "EXPR VALUE PADRAO" 
#lê um ficheiro com N-gramas etiquetados e filtrados 
#2 parametros: 
  ## medida (fr, chi, scp, log, mi) 
  ## frequencia minima da expressao 

#use lib "./galeXtra-3.0";
#use categorias ;

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';


$measure = shift(@ARGV);
$fr = shift(@ARGV);



$CountLines=0;
while ($line = <>) {
    $p1 = "";
    $p2 = "";
    $p3 = "";
    $p4 = "";
    $p5 = "";
    $p6 = "";
    $tag1 = "";
    $tag2 = "";
    $tag3 = "";
    $tag4 = "";
    $tag5 = "";
    $tag6 = "";



    chomp($line);
    ($p1, $p2, $p3, $p4, $p5, $p6) = split(" ", $line);

 #   if ( ($CountLines % 100) == 0) {;
#       printf  STDERR "- - - processar linha:(%6d) - - -\r",$CountLines;
 #   }
 #   $CountLines++;

  #  print STDERR "#$line# ------- #$p1# -- #$p2# -- #$p3#\n";

    if ($p1 =~ /\_/) {
         ($p1, $tag1) = split ('\_', $p1);
         if ( Prep($tag1) ) {
            $IsPrep{$p1}++;
           # print STDERR "$p1, $tag1\n";
	 }
          if  (Adj($tag1)) {
            $IsMod{$p1}++;
            #print STDERR "adj: $p1, $tag1\n";
          }


         if  (Nome($tag1)) {
            $IsName{$p1}++;
            #print STDERR "name: $p1, $tag1\n";
	  }

        if  (Pcle($tag1)) {
            $IsPcle{$p1}++;
            #print STDERR "pcle: $p1, $tag1\n";
	}

        if  (Verbo($tag1)) {
            $IsVerb{$p1}++;
            #print STDERR "verb: $p1, $tag1\n";
	}

     }


      if ($p2 =~ /\_/) {
         ($p2, $tag2) = split ('\_', $p2);
         if ( Prep($tag2) ) {
            $IsPrep{$p2}++;
           # print STDERR "$p2, $tag2\n";
	 }

         if  (Nome($tag2)) {
            $IsName{$p2}++;
            #print STDERR "name: $p2, $tag2\n";
	  }

         if  (Adj($tag2)) {
            $IsMod{$p2}++;
            #print STDERR "adj: $p2, $tag2\n";
	  }

          if  (Pcle($tag2)) {
            $IsPcle{$p2}++;
            #print STDERR "pcle: $p2, $tag2\n";
	  }

          if  (Verbo($tag2)) {
            $IsVerb{$p2}++;
            #print STDERR "verb: $p2, $tag2\n";
	  }

     }

     if ($p3 =~ /\_/) {
         ($p3, $tag3) = split ('\_', $p3);
         if ( Prep($tag3) ) {
            $IsPrep{$p3}++;
            #print STDERR "$p3, $tag3\n";
	 }

         if  (Nome($tag3)) {
            $IsName{$p3}++;
            #print STDERR "name: $p3, $tag3\n";
	  }

         if  (Adj($tag3)) {
            $IsMod{$p3}++;
            #print STDERR "adj: $p3, $tag3\n";
	  }

     }

       if ($p4 =~ /\_/) {
         ($p4, $tag4) = split ('\_', $p4);
         if ( Prep($tag4) ) {
            $IsPrep{$p4}++;
           # print STDERR "$p4, $tag4\n";
	 }

         if  (Nome($tag4)) {
            $IsName{$p4}++;
            #print STDERR "name: $p4, $tag4\n";
	  }

         if  (Adj($tag4)) {
            $IsMod{$p4}++;
            #print STDERR "adj: $p4, $tag4\n";
	  }

     }

      if ($p5 =~ /\_/) {
         ($p5, $tag5) = split ('\_', $p5);
         if ( Prep($tag5) ) {
            $IsPrep{$p5}++;
           # print STDERR "$p5, $tag5\n";
	 }

         if  (Nome($tag5)) {
            $IsName{$p5}++;
            #print STDERR "name: $p5, $tag5\n";
	  }

         if  (Adj($tag5)) {
            $IsMod{$p5}++;
            #print STDERR "adj: $p5, $tag5\n";
	  }

     }

      if ($p6 =~ /\_/) {
         ($p6, $tag6) = split ('\_', $p6);
         if ( Prep($tag6) ) {
            $IsPrep{$p6}++;
           # print STDERR "$p6, $tag6\n";
	 }

         if  (Nome($tag6)) {
            $IsName{$p6}++;
            #print STDERR "name: $p6, $tag6\n";
	  }

         if  (Adj($tag6)) {
            $IsMod{$p6}++;
            #print STDERR "adj: $p6, $tag6\n";
	  }

     }


###### Corpus Size:
     $N++;

####### counting single words:
     $Wfreq{$p1}++;



###PADRAO VERB-PCLE
     if ( ((defined $IsVerb{$p1}) && defined $IsPcle{$p2}) ){
            $VPCLE{$p1,$p2}++;

     }



###PADRAO NOUN-ADJ
     if ( ((defined $IsName{$p1}) && defined $IsMod{$p2}) ){
            $NA{$p1,$p2}++;

     }

###PADRAO ADJ-NOUN
     if ( ((defined $IsName{$p2}) && defined $IsMod{$p1}) ){
            $AN{$p1,$p2}++;

     }

###PADRAO NOUN-NOUN
     if ( ((defined $IsName{$p1}) && defined $IsName{$p2}) ){
            $NN{$p1,$p2}++;

     }


###PADRAO NOUN-PREP-NOUN
     if ( ((defined $IsName{$p1}) && defined $IsPrep{$p2}) && (defined $IsName{$p3}) ){
            $NPN{$p1,$p2,$p3}++;

     }


    delete $IsPrep{$p1};
    delete $IsPrep{$p2};
    delete $IsPrep{$p3};
    delete $IsPrep{$p4};
    delete $IsPrep{$p5};
    delete $IsPrep{$p6};

    delete $IsName{$p1};
    delete $IsName{$p2};
    delete $IsName{$p3};
    delete $IsName{$p4};
    delete $IsName{$p5};
    delete $IsName{$p6};

    delete $IsMod{$p1};
    delete $IsMod{$p2};
    delete $IsMod{$p3};
    delete $IsMod{$p4};
    delete $IsMod{$p5};
    delete $IsMod{$p6};



}

#print STDERR "fim leitura das ocurrencias em 6gramas\n";


if ($measure =~ /(^-scp$|^-log$|^-chi$|^-mi$|^-cooc$)/ ) {
  $measure =~ s/^-//;
  @measure = $measure ;
  #print STDERR "$measure[0]\n";


  ##bigramas

  foreach $key (sort keys %VPCLE) {
     ($p1, $p2) = split (/$;/o, $key);
     if ($VPCLE{$p1,$p2}>=$fr) {

       $exp = $p1 . "@" . $p2 . "_" . "V-PCLE"; 
       $Dico{$exp} =  $measure[0] ($VPCLE{$p1,$p2}, $Wfreq{$p1}, $Wfreq{$p2} ) ;
     
      # print STDERR "VPCLE: $p1-$p2\n";
    }
  }


  foreach $key (sort keys %NA) {
     ($p1, $p2) = split (/$;/o, $key);
     if ($NA{$p1,$p2}>=$fr) {

       $exp = $p1 . "@" . $p2  . "_" . "N-A" ;
       $Dico{$exp} =  $measure[0]($NA{$p1,$p2}, $Wfreq{$p1}, $Wfreq{$p2} ) ;
        
         #print STDERR "NA: $p1-$p2\n";
     }
   
  }

  foreach $key (sort keys %AN) {
     ($p1, $p2) = split (/$;/o, $key);
     if ($AN{$p1,$p2}>=$fr) {

         $exp = $p1 . "@" . $p2  . "_" . "A-N";
         $Dico{$exp} = $measure[0] ($AN{$p1,$p2}, $Wfreq{$p1}, $Wfreq{$p2} ) ;
          #print STDERR "AN: $p1-$p2\n";
        
     }
  }


  foreach $key (sort keys %NN) {
     ($p1, $p2) = split (/$;/o, $key);
     if ($NN{$p1,$p2}>=$fr) {

         $exp = $p1 . "@" . $p2  . "_" . "N-N";
         $Dico{$exp} = $measure[0] ($NN{$p1,$p2}, $Wfreq{$p1}, $Wfreq{$p2} ) ;
        # print STDERR "NN: $p1-$p2\n";
        
    }
  }


  ## trigramas


  foreach $key (sort keys %NPN) {
     ($p1, $p2, $p3) = split (/$;/o, $key);
     if ($NPN{$p1,$p2,$p3}>=$fr) {
          
          $exp = $p1 . "@" . $p2 . "@" . $p3  . "_" . "N-P-N";
          $Dico{$exp} =  $measure[0] ($NPN{$p1,$p2,$p3}, $Wfreq{$p1}, $Wfreq{$p3} ) ;
          #print STDERR "NPN: $p1-$p2-$p3\n";
        
     }
  }


 ##imprimir resultados com valores ordenados:
  foreach $expr (sort {$Dico{$b} <=>
                      $Dico{$a} }
                      keys %Dico ) {
        ($mw, $cat) =  split ("_", $expr) ;
         $mw =~ s/@/ /g;
        print "$mw\t$Dico{$expr}\t$cat\n";
  }


}



sub log {

     local ($joint) = @_[0];
     local ($w1) = @_[1];
     local ($w2) = @_[2];

     $a = $joint;
     $b = $w1 - $a;
     $c = $w2 - $a;
     $d = $N - $a - $b -$c;

    if ($a > 0  && $b>0 && $c>0 && $d>0) {  
     $baux = ($b==0)?0:($b*log($b));
     $caux = ($c==0)?0:($c*log($c));

     $result = $a*log($a)             +
              $baux                  +
              $caux                  +
              $d*log($d)             +
              $N*log($N)             -
              ($a+$c)*log($a+$c)     -
              ($a+$b)*log($a+$b)     -
              ($b+$d)*log($b+$d)     -
              ($c+$d)*log($c+$d);

    }
    return $result;
} 

sub chi {

     local ($joint) = @_[0];
     local ($w1) = @_[1];
     local ($w2) = @_[2];

     $a = $joint;
     $b = $w1 - $a;
     $c = $w2 - $a;
     $d = $N - $a - $b -$c;


    $chi_a = (( ($a+$b)*($a+$c)/$N - $a )**2)/$a;
    $chi_b = ($b==0)?0:(( ($a+$b)*($b+$d)/$N - $b )**2)/$b;
    $chi_c = ($c==0)?0:(( ($c+$d)*($a+$c)/$N - $c )**2)/$c;
    $chi_d = (( ($c+$d)*($b+$d)/$N - $d )**2)/$d;

    $result =   $chi_a + $chi_b + $chi_c + $chi_d;

    
    return $result;
} 

sub mi {

     local ($joint) = @_[0];
     local ($w1) = @_[1];
     local ($w2) = @_[2];

     $a = $joint;
    
     
     $result =  log($N * ( $a / ($w1 * $w2) ) )/log(2);
  
     return $result;
} 


sub scp {

     local ($joint) = @_[0];
     local ($w1) = @_[1];
     local ($w2) = @_[2];

     $a = $joint;
    
     
     $result = ( ($a * $a) / ($w1 * $w2) );
  
     return $result;
} 

   
sub cooc {

     local ($joint) = @_[0];
     local ($w1) = @_[1];
     local ($w2) = @_[2];
    
       
     return $joint;
} 

   
##Linguistic functions:

sub Prep {
  my ($x) = @_;
  my $result=0;
  if ( ($x =~ /PRP/) || ($x =~ /PREP/) || 
       ($x eq "PDEL") || ($x eq "IN") || ($x eq "TO") ||
       ($x =~ /^SP/) ) {
     $result = 1;
  }
  return $result;
}


sub Nome {
  my ($x) = @_;
  my $result=0;
  if ($x =~ /^N/)  {
     $result = 1;
  }
  return $result;
}

sub Verbo {
  my ($x) = @_;
  my $result=0;
  if ($x =~ /^V/ || $x =~ /^MD/)  {
     $result = 1;
  }
  return $result;
}

sub VPP {
  my ($x) = @_;
  my $result=0;
  if ( ($x =~ /^VMP/) || ($x =~ /^VBP/))  {
     $result = 1;
  }
  return $result;
}


sub Adj {
  my ($x) = @_;
  my $result=0;
  if ( ($x =~ /ADJ/) || ($x eq "JJ") || ($x =~ /AQ/)) {
     $result = 1;
  }
  return $result;
}
 

sub Num {
  my ($x) = @_;
  my $result=0;
  if ($x =~ /CARD/)  {
     $result = 1;
  }
  return $result;
}

sub Mod {
  my ($x) = @_;
  my $result=0;
  if ( ($x =~ /ADJ/) || ($x eq "JJ") || 
       ($x =~ /ADV/) || ($x =~ /^RB/) ||
       ($x =~ /AQ/) ){
     $result = 1;
  }
  return $result;
}


sub Adv {
  my ($x) = @_;
  my $result=0;
  if ( ($x =~ /ADV/) || ($x =~ /^RB/) ) {
     $result =1 
  }
   return $result;
}

sub Pcle {
  my ($x) = @_;
  my $result=0;
  if ($x =~ /^RP/)  {
     $result =1 
  }
   return $result;
}

