#!/usr/bin/perl



# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
use open qw(:std :utf8);

my @Pos;
my @Token;
my @Lemma;
my @Tag;
my @Head;
my @Args;
my @Dep;
my %Const_dep;
my %Const_tag;
my %Const;
my %Head;
my %Unit;

my $source="";
my $l=1 ;
my $Subj;
my $Dobj;
my $Dobj2;
my $DobjCompl;
my $Circ;

my $l=1; ##number of words per sentence

sub triples {
  my ($lang, $analisado) = @_ ;
 
  my  (@analisado) = split ('\n', $analisado);

  my @saida;

  #print STDERR "ANA: #@analisado#\n";
  my $Border="SENT";


  my $pos;
  my $token;
  my $lemma;
  my $tag;
  my $thead;
  my $args;
  my $dep;
  my $Size;
 
  my $k=1; ##number of sentences
  
  foreach my $line (@analisado) {
    chomp($line);
  

   if ($line ne "") {

   ($pos, $token, $lemma, $tag, $head, $args, $dep) = split("\t", $line);

   #print STDERR "LINE: #$line# -- $pos\n";
   $args =~ s/</(/;
   $args =~ s/>/)/;
  
   ##No caso de haver NEC:
   if ($args =~ /nec:/) {
      my ($class) = ($args =~ /nec:([A-Z0-9]+)/);
     
      $tag = $tag . $class if ($class);
     
   }

  #print STDERR "#$tag#\n";
   ##construimos os vectores da oracao
   if ($tag !~  /^$Border$/) {
     if ($dep !~ /[\<\>]/) { ##saltar dependencias lexicais
     
     $dep =~ s/(Creg|Iobj|DobjPrep)/Circ/; ##normalizar complementos preposicionais...
     $dep =~ s/(Atr)/Dobj/;

     $Pos[$l] = $pos ;
     if ($lemma =~ /@/) {
       $Token[$l] = $lemma ;
     }
     else {
       $Token[$l] = $token ;
     }
     $Lemma[$l] = $lemma ;
     $Tag[$l] = $tag ;
     $Head[$l] = $head ;
     $Args[$l] = $args ;
     $Dep[$l] = $dep ;

    ##construimos os hashes de head-dependent
     if ($head != 0 ) {
      $Const_dep{$head}{$l} = $dep ;
      $Const_tag{$head}{$l} = $tag ;
     }
     $Const{$head}{$l}++  ;
     

  
     ##construir as unidades a partir dos head
     $Unit{$head}{$l}++ ;## if ($Tag[$l] !~ /^F/); ##nao tomar em conta os simbolos de punctuaçao
     $Unit{$head}{$head}++;

     ##construir a oracao fonte:
     $source .= "$Token[$l] ";

    }

    $l++;

   }

   elsif ($tag =~  /^$Border$/) {

     $source .= "$token" ;
     $Size = $l;

     #$k++;
    ### print "sentence\t$k\t$source\n";  ####IMPRIMIR SENTENCE NUMA VERSAO MAIS ELABORADA
   
      ##expansao das unidades e niveis de organizacao
      for ($i=0;$i<=$Size;$i++) {
           if (defined $Unit{$i}) {
              # print STDERR "Head: $i## \n";
             foreach $const (keys %{$Unit{$i}}) {
                # print STDERR "Head: $i## -- Const: ###$const###\n";
               
               ##TRATAR AS COORDINAÇOES!!! O CONST (coordenado) HERDA OS CONSTITUINTES DO HEAD (coordenador)
		if ($Dep[$const] =~ /Coord/ && $Tag[$const] =~ /^V/) { 
                   $Unit{$const}{$const}++ ;
		   if ($const eq $i){next}
                  #print STDERR "--COORD1: Const1:#$Lemma[$const]# -- Const2:#$Lemma[$const2]# -- Head:#$Lemma[$i]#\n"; 
                   foreach my $const2 (keys %{$Const{$i}}) {
                      # print STDERR "--COORD2: Const1:#$Lemma[$const]# -- Const2:#$Lemma[$const2]# -- Head:#$Lemma[$i]# Dep: $Dep[$const2]\n"; 
                       if ($Dep[$const2] !~ /Coord|Punct/ ) {
                           
			   $Unit{$const}{$const2}++ ;
                           $Const_dep{$const}{$const2} = $Dep[$const2];
                           Expand ($const2, $const) ;
                          # print STDERR "--COORD3: Const1:#$Lemma[$const]# -- Const2:#$Lemma[$const2]# -- Head:#$Lemma[$i]#\n"; 
		       }
		   }
                } 
   
                ##FIM DA COORDINAÇAO
 
                else {
                  $Unit{$i}{$const}++;
                  Expand ($const, $i) ;
		}
	     }
          }
	  else {
             $Unit{$i}{$i}++ 
	  }
              
         
	   
      }
     ##Construir unidades (cat fun e level) a partir dos head


     foreach $head (sort keys %Unit) {
         if ($head eq "_" || $head == 0 || $Tag[$head] !~ /VERB/) {
	     next;
         }
        
        my $result;
        my $result_token;
        my $result_lemma;
        foreach my $const (sort { $a <=> $b } keys %{$Unit{$head}}) {
	     if ($Const_dep{$head}{$const} =~ /Subj/)   {
                # print STDERR "Subj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --  TAG-HEAD::$Tag[$Head[$head]] \n";
                 if (relative ($const) && $Tag[$Head[$head]] =~ /^N/) { ##se o sujeito e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
                    $Subj =  $Head[$head]; 
                    #print STDERR "REL-Subj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
		 }
                 elsif (relative ($const) && $Tag[$Head[$head]] =~ /^CONJ/ && $Tag[$Head[$Head[$head]]] =~ /^N/ ) { ##se o sujeito e uma relativa coordinada, entao buscamos o nome que modifica a conjunçao coordinada
                    $Subj =  $Head[$Head[$head]]; 
                    #print STDERR "REL-Subj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
		 }
                 else {
                    $Subj = $const if ($Tag[$const] !~ /^PRO/ || $Args[$const] !~ /type:[RW]/);
                   #print STDERR "REL-Subj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
		 }
	     }
             ###subordinadas  de sujeito
             # print STDERR "const:#$Lemma[$const]-$Tag[$const]# - head:#$Lemma[$head]-$Tag[$head]#  - dep:#$Const_dep{$head}{$const}#\n";
           #  if ($Tag[$Head[$head]] =~ /^NOUN/ && $Const_dep{$Head[$head]}{$head}  =~ /^AdjnR/ && $Tag[$head] =~ /^VERB/ )   {
              # if ($Tag[$Head[$const]] =~ /^NOUN/ && $Const_dep{$head}{$const}  =~ /^AdjnR/ && $Tag[$const] =~ /^VERB/ )   {
		 #$Const_dep{$head}{$const} = "SubjL";
            #        $Subj =  $Head[$head]; 
                    # print STDERR "----------SUBJ: $Lemma[$Head[$head]] -- const:#$Lemma[$const]-$Tag[$const]# - head:#$Lemma[$head]-$Tag[$head]#  - dep:#$Const_dep{$Head[$head]}{$head}#\n";
	     #}

             if ($Const_dep{$head}{$const} =~ /Dobj[LR]/)   {
                # print STDERR "Dobj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
                  if (relative ($const) && $Tag[$Head[$head]] =~ /^N/) { ##se o sujeito e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
                    $Dobj =  $Head[$head]; 
		 }
                 else {
                    $Dobj = $const  if ($Tag[$const] !~ /^PRO/ || $Args[$const] !~ /type:[RW]/);
		 }

	     } 
             if ($Const_dep{$head}{$const} =~ /Dobj2R/)   {
                # print STDERR "Dobj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
                  if (relative ($const) && $Tag[$Head[$head]] =~ /^N/) { ##se o sujeito e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
                    $Dobj2 =  $Head[$head]; 
		 }
                 else {
                    $Dobj2 = $const  if ($Args[$const] !~ /type:[RW]/);
		 }

	     } 

             if ($Const_dep{$head}{$const} =~ /DobjCompl/)   {
                 #print STDERR "Dobj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
                  if (relative ($const) && $Tag[$Head[$head]] =~ /^N/) { ##se o sujeito e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
                    $DobjCompl =  $Head[$head]; 
		 }
                 else {
                    $DobjCompl = $const if ($Tag[$const] !~ /^PRO/ || $Args[$const] !~ /type:[RW]/);
		 }

	     } 
             if ($Const_dep{$head}{$const} =~ /Circ/)   {
                 #print STDERR "Circ: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
                 $Circ .= $const . "|" if ($Tag[$const] !~ /^PRO/ || $Args[$const] !~ /type:[RW]/);
	     }

                    
         }


############################################################################################
#                   construir tripletas com relaçoes verbais                               #
############################################################################################

     my $subj; 
     my $dobj;
     my $circ;
     my	$pred;
     my $subj_l;
     my $dobj_l;
     my $circ_l;
     my $pred_l;
     
    #print STDERR "++++++ Subj: HEAD###$Token[$Subj]### -- Circ: HEAD###$Token[$Circ]### --Dobj: HEAD###$Token[$Dobj]###  \n";
         ##SUBJ-PRED-CIRC
         if ($Subj && $Circ && !$Dobj) {
         #print STDERR "Subj-CIRC: #$source#\n";
	  (my @Circ) = split ('\|', $Circ) ;
          foreach my $CircN (@Circ) {
           ##SUBJ 
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
              #print STDERR "-- Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# -- CircN=#$CircN# -- Subj=#$Subj#\n";
	      if (relative ($const) || apposition($const) || subordin($const)) {last}
              $subj =   $subj . " " . $Token[$const]; 
              ##lemas e tags:
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($const != $Subj) ;
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $Subj) ; ##marcamos o head
           }

           ##PRED
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
             # print STDERR "-- PRED: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
	       if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
               #if ($const eq $head ||  ($Dep[$const] =~ /VSpec/ && $Const{$head}{$const} ) )  {
		   $pred =   $pred .  " " . $Token[$const];
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head); 
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $head) ; ##marcamos o head
	       }
           }

           ##CIRC
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$CircN}}) {
             # print STDERR "-- Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
               if (relative ($const) || apposition($const) || subordin($const)) {last}
	       if ($CircN eq $const && $Tag[$CircN] =~ /^PRP/) { ###colocar a prep do circ no predicate
		   $pred = $pred . " " . $Token[$const];
		   $pred_l = $pred_l . " " . $Lemma[$const]  . "_" . $Tag[$const] ;
	       }
	       else {
                 $circ =   $circ .  " " . $Token[$const] ;   
                 $circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($CircN != $Head[$const]);
                 $circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const]  . "-H" if  ($CircN == $Head[$const]);         
               }
            }
            
	    $subj = trim ($subj);
            $circ = trim ($circ);
	    $pred = trim ($pred);
            $subj_l = trim ($subj_l);
            $circ_l = trim ($circ_l);
	    $pred_l = trim ($pred_l);

	    $result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$circ";
            $result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$circ_l";

	   my $saida = building_result ($k, $result_token);
           push (@saida, $saida);
         # print STDERR "SAIDA: #$k# -- #$result_token# -- sub:#$subj# -- circ:#$circ#\n";
           
	    $result="";
       	    $subj="";
	    $circ="";
	    $pred="";
            $subj_l="";
	    $circ_l="";
	    $pred_l="";
	  }
	 }

           ##SUBJ-PRED-CDIR2-CDIR
        if ($Subj && $Dobj && $Dobj2) {

          ##SUBJ 
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
              #print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
              if (relative ($const) || apposition($const) || subordin($const)) {last}
              $subj =   $subj . " " . $Token[$const]; 
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Subj) ; 
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Subj) ; ##marcamos o head
         
           }
             ##PRED
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
              #print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
	       if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
               #if ($const eq $head ||  ($Dep[$const] =~ /VSpec/ && $Const{$head}{$const} ) )  {
		   $pred =   $pred .  " " . $Token[$const];
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head); 
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H"  if  ($const == $head) ; ##marcamos o head
	       }
           }

          ##CDIR (dentro do pred!!)
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj}}) {
              #print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
              if (relative ($const) || apposition($const) || subordin($const) ) {last};

              $pred =   $pred . " " . $Token[$const] ; 
              $pred_l = $pred_l . " " . $Lemma[$const] . " " . $Tag[$const]  ;
            }

           ##CDIR2
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj2}}) {
              #print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
               if (relative ($const) || apposition($const)  || subordin($const)) {last}
	      
                 $circ =   $circ .  " " . $Token[$const] ;   
                 $circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($CircN != $Head[$const]);
                 $circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const]  . "-H" if  ($CircN == $Head[$const]);         
               }
            
            
	    $subj = trim ($subj);
            $circ = trim ($circ);
	    $pred = trim ($pred);
            $subj_l = trim ($subj_l);
            $circ_l = trim ($circ_l);
	    $pred_l = trim ($pred_l);

	    $result_token =  "$subj" .  "\t" . "$pred" . " "  . "to" . "\t" . "$circ";
            $result_lemma =  "$subj_l" .  "\t" . "$pred_l"  . " " . "to_PRP" . "\t" . "$circ_l";
            
           my $saida = building_result ($k, $result_token);
           push (@saida, $saida);
	   # print "t-extraction\t$k\t$result_token\n";
	   # print "s-extraction\t$k\t$result_lemma\n";

	    $result="";
       	    $subj="";
	    $circ="";
	    $pred="";
            $subj_l="";
	    $circ_l="";
	    $pred_l="";
	  }

        ##SUBJ-PRED-CDIR
        if ($Subj && $Dobj) {

        #print STDERR "Subj-DOBJ: #source#\n";

             ##SUBJ 
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
              #print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
              if (relative ($const) || apposition($const) || subordin($const)) {last}
              $subj =   $subj . " " . $Token[$const]; 
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Subj) ; 
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Subj) ; ##marcamos o head
         
           }
           ##PRED
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
              #print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
	      # if ($const eq $head || ($Dep[$const] =~ /VSpec/ &&  ($Const{$head}{$const} || $Const{$head}{$Head[$const]}) ) )  {
	       if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
        	   $pred =   $pred .  " " . $Token[$const];
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head) ;    
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $head) ; ##marcamos o head
	       }
           }
           ##CDIR
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj}}) {
              #print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
              if (relative ($const) || apposition($const) || subordin($const)) {last};

              ##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
              $dobj =   $dobj . " " . $Token[$const]; 
              $dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Dobj) ;
              $dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Dobj) ; ##marcamos o head
            }
            
	    $subj = trim ($subj);
            $dobj = trim ($dobj);
            $pred = trim ($pred);
            $subj_l = trim ($subj_l);
            $dobj_l = trim ($dobj_l);
	    $pred_l = trim ($pred_l);

            $result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$dobj";
            $result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$dobj_l";

           my $saida = building_result ($k, $result_token);
           push (@saida, $saida);

                       
	    $subj="";
	    $dobj="";
	    $pred="";
            $subj_l="";
	    $dobj_l="";
	    $pred_l="";
	 }
          
	    ##SUBJ-PRED-CDIRCOMPLETIVA
        if ($Subj && $DobjCompl) {

             ##SUBJ 
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
              #print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
              if (relative ($const) || apposition($const)  || subordin($const)) {last}
              $subj =   $subj . " " . $Token[$const]; 
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Subj) ; 
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Subj) ; ##marcamos o head
         
           }
           ##PRED
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
              #print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
	      # if ($const eq $head || ($Dep[$const] =~ /VSpec/ &&  ($Const{$head}{$const} || $Const{$head}{$Head[$const]}) ) )  {
	       if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
        	   $pred =   $pred .  " " . $Token[$const];
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head) ;    
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $head) ; ##marcamos o head
	       }
           }
           ##CDIR
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$DobjCompl}}) {
              #print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
              if (relative ($const) || apposition($const) || subordin($const) ) {last};

              ##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
              $dobj =   $dobj . " " . $Token[$const]; 
              $dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Dobj) ;
              $dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Dobj) ; ##marcamos o head
            }
            
	    $subj = trim ($subj);
            $dobj = trim ($dobj);
            $pred = trim ($pred);
            $subj_l = trim ($subj_l);
            $dobj_l = trim ($dobj_l);
	    $pred_l = trim ($pred_l);

            $result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$dobj";
            $result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$dobj_l";
            
           my $saida = building_result ($k, $result_token);
           push (@saida, $saida);

       	  
            $subj="";
	    $dobj="";
	    $pred="";
            $subj_l="";
	    $dobj_l="";
	    $pred_l="";
	 }


          ##SUBJ-PRED-CDIR-CIRC
         if ($Subj && $Circ && $Dobj) {
	  (my @Circ) = split ('\|', $Circ) ;
          foreach my $CircN (@Circ) {
           ##SUBJ 
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
              #print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
	      if (relative ($const) || apposition($const)  || subordin($const)) {last}
              $subj =   $subj . " " . $Token[$const]; 
              ##lemas e tags:
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($const != $Subj) ;
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $Subj) ; ##marcamos o head
           }


           ##PRED
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
              #print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
	       if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
               #if ($const eq $head ||  ($Dep[$const] =~ /VSpec/ && $Const{$head}{$const} ) )  {
		   $pred =   $pred .  " " . $Token[$const];
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head); 
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $head) ; ##marcamos o head
	       }
           }

          ##CDIR (dentro do pred!!)
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj}}) {
              #print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
              if (relative ($const) || apposition($const) || subordin($const) ) {last};

              ##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
              $pred =   $pred . " " . $Token[$const]; 
              $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  
            }

           ##CIRC
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$CircN}}) {
              #print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
               if (relative ($const) || apposition($const)  || subordin($const)) {last}
	       if ($CircN eq $const && $Tag[$CircN] =~ /^PRP/) { ###colocar a prep do circ no predicate
		   $pred = $pred . " " . $Token[$const];
		   $pred_l = $pred_l . " " . $Lemma[$const]  . "_" . $Tag[$const] ;
	       }
	       else {
                 $circ =   $circ .  " " . $Token[$const] ;   
                 $circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($CircN != $Head[$const]);
                 $circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const]  . "-H" if  ($CircN == $Head[$const]);         
               }
            }
            
	    $subj = trim ($subj);
            $circ = trim ($circ);
	    $pred = trim ($pred);
            $subj_l = trim ($subj_l);
            $circ_l = trim ($circ_l);
	    $pred_l = trim ($pred_l);

	    $result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$circ";
            $result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$circ_l";

           my $saida = building_result ($k, $result_token);
           push (@saida, $saida);
	 

	    $result="";
       	    $subj="";
	    $circ="";
	    $pred="";
            $subj_l="";
	    $circ_l="";
	    $pred_l="";
	  }
	 }
          

  ##SUBJ-PRED-CDIR-CDIRCOMPL
         if ($Subj && $DobjCompl && $Dobj) {
	 
           ##SUBJ 
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
              #print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
	      if (relative ($const) || apposition($const)  || subordin($const)) {last}
              $subj =   $subj . " " . $Token[$const]; 
              ##lemas e tags:
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($const != $Subj) ;
              $subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $Subj) ; ##marcamos o head
           }


           ##PRED
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
              #print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
	       if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
               #if ($const eq $head ||  ($Dep[$const] =~ /VSpec/ && $Const{$head}{$const} ) )  {
		   $pred =   $pred .  " " . $Token[$const];
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head); 
                   $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $head) ; ##marcamos o head
	       }
           }

          ##CDIR (dentro do pred!!)
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj}}) {
              #print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
              if (relative ($const) || apposition($const)  || subordin($const)) {last};

              ##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
              $pred =   $pred . " " . $Token[$const]; 
              $pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  
            }

           ##CDIRCompl
           foreach my $const  (sort { $a <=> $b } keys %{$Unit{$DobjCompl}}) {
              #print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
              if (relative ($const) || apposition($const)  || subordin($const)) {last};

              ##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
              $dobj =   $dobj . " " . $Token[$const]; 
              $dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Dobj) ;
              $dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Dobj) ; ##marcamos o head
            }
            
	    $subj = trim ($subj);
            $dobj = trim ($dobj);
	    $pred = trim ($pred);
            $subj_l = trim ($subj_l);
            $dobj_l = trim ($dobj_l);
	    $pred_l = trim ($pred_l);

	    $result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$dobj";
            $result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$dobj_l";
            
            my $saida = building_result ($k, $result_token);
            push (@saida, $saida);
            	    

	    $result="";
       	    $subj="";
	    $dobj="";
	    $pred="";
            $subj_l="";
	    $dobj_l="";
	    $pred_l="";
	  }
          
	 
         $Circ="";
         $Subj=0;
         $Dobj=0;
         $DobjCompl=0; 
         $Dobj2=0;


     }
     $k++;
     Initialize();

   }

  }
    
 }
 return @saida;
}




##########Funcoes###############

sub building_result {
  my ($idf, $res_tok) = @_ ;
 
  my $saida  =   "SENTID_$idf\t$res_tok\n";
  #my $saida  =   "s-extraction\t$k\t$result_lemma\n";

  return $saida;

}

sub Expand {

    my ($c, $h) = @_ ;

    if (defined $Unit{$c} ) {
    #print STDERR "FUNC: ---$c---$h-- ### CONST: ---$c ---- $sub_c\n";
       foreach $sub_c (keys %{$Unit{$c}}) {
	 if ($sub_c != $c && !defined $Unit{$h}{$sub_c} ) {
         #if ($sub_c != $c) {
               #print STDERR "FUNC: ---$c---$h-- ### CONST: ---$c ---- $sub_c\n";
                $Unit{$h}{$sub_c}++;
                Expand ($sub_c, $h) ;
	 }
	}
     }

    else {
     return 1
   }
}



sub trim {
    my ($x) = @_ ;

    $x =~ s/^[\s]*//;
    $x =~ s/[\s]*$//;
    $x =~ s/[\s]*\,$//;
    $x =~ s/[\s]*\,\_Fc$//;
    $x =~ s/[\s]*\"\_Fe$//;
    $x =~ s/^\"\_Fe//; 
    $x =~ s/^\"//; 

    return $x;
}
sub relative {
    my ($x) = @_ ;

   #if ($Tag[$x] =~ /^(PR|W[PD])/ || ( $Tag[$x] =~ /^IN/ &&  $Lemma[$x] eq "that") ) { ##erro do freeling-en que trata sempre 'that' como IN
    if ($Tag[$x] =~ /^PRO/ && $Args[$x] =~ /type:[RW]/ ) {
     # foreach my $y (keys %{$Const_tag{$x}}) {
      #       print STDERR "REL:: #$Tag[$x]#  -- #$Tag[$y]#\n";
       #     if ($Tag[$y] =~ /^DT/) {
	#	return 0;
	 #   }
     #}
     return 1;
  }  
  else {
    return 0;
  }
}

sub subordin {
    my ($x) = @_ ;

   #if ($Tag[$x] =~ /^(PR|W[PD])/ || ( $Tag[$x] =~ /^IN/ &&  $Lemma[$x] eq "that") ) { ##erro do freeling-en que trata sempre 'that' como IN
    if ($Tag[$x] =~ /^VERB/ &&  $Tag[$Head[$x]] =~ /^NOUN/ && $Const_dep{$Head[$x]}{$x} =~ /^Adjn/) {
    return 1;
  }  
  else {
    return 0;
  }
}

sub apposition {
    my ($x) = @_ ;
    my $found=0;
   
    if ($Tag[$x] =~ /^(Fc|Fpa|Fca)/  && $Dep[$Head[$x]] =~ /AdjnR/ && $Tag[$Head[$x]] =~ /^(NOUN|ADJ)/ ) { ##se aparece uma virgula e a cabeça e um nome/adj como modificador (Adjn), entao é uma aposiçao nominal

      return 1;
    } 
   elsif ($Tag[$x] =~ /^(Fc|Fpa|Fca)/) { ##se aparece uma vírgula no constituinte, paramos! 
         
         return 1;
   }
   else {
    return 0;
  }
}

sub Initialize {
   my $i=0 ;
   my $x="";
  for ($i=0;$i<=$#Pos;$i++) {
    delete $Pos[$i];
    delete $Token[$i];
    delete $Lemma[$i] ;
    delete $Tag[$i] ;
    delete $Head[$i] ;
   # delete $currentHeads[$i];
    delete $Args[$i] ;
    delete $Dep[$i] ;
  }

   foreach $x (keys %Const_dep) {
       delete $Const_dep{$x}
   }
   foreach $x (keys %Const_tag) {
      delete $Const_tag{$x}
   }
   foreach $x (keys %Unit) {
      delete $Unit{$x}
   }
   foreach $x (keys %Const) {
      delete $Const{$x}
   }
  
  $source="";
  $l=1 ;
  $Subj=0;
  $Dobj=0;
  $Dobj2=0;
  $DobjCompl=0;
  $Circ="";
 
  return 1
}


