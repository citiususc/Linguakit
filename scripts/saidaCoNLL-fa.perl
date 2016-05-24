#!/usr/bin/perl

#A PARTIR DA SAIDA -fa DO PARSER, GERA A SAIDA FORMATO CONLL

$DepLex = "<|>|lex" ;

while ($line = <STDIN>) {

   if ( ($CountLines % 100) == 0) {;
       printf  STDERR "- - - processar linha:(%6d) - - -\r",$CountLines;
   }
   $CountLines++;

   $head="";
   $dep="";
   $rel="";
   $cat_h="";
   $cat_d="";
   $cat_r="";
   $ref_h="";
   $ref_d="";
   $ref_r="";

   chomp $line;

   if ($line =~ /^SENT::/) {
     $line =~ s/^SENT::(\<)?//;
     #$line =~ s/\>//;

     (@listaTags) = split (" ", $line);
   }
  
 
   elsif ($line  =~ /^\-\-\-/) {
      for ($i=0;$i<=$#listaTags;$i++) {
        #print STDERR "#$i# --- #$listaTags[$i]#\n";
        $listaTags[$i] = ConvertCharLarge($listaTags[$i]);    
         
        $j=$i+1;  
        if (defined  $Deps{$i} ) {   
          $Heads{$i}++;
          $Deps="";
          $Deps_lex="";
          $found=0;
	  foreach $r (keys %{$Deps{$i}}) {
           # print STDERR "$r\n";
            if ($Deps{$i}{$r} !~ /^($DepLex)$/ ) {
             
                  $Deps = $r;
                  $found=1
	       
            }
            else{
		$Deps_lex = $r;
            }
	   }
	  if (!$found) {
	      $Deps = $Deps_lex;
              #print STDERR "--------------DEP: $Deps\n";
	  }
          print "$j\t$Tokens{$i}\t$Deps\t$Cats{$i}\t$Heads{$i}\t$Args{$i}\t$Rels{$i}\n";  
	      
        }  
        elsif (defined $Roots{$i}) {
	  $Roots="";
          $Roots_lex="";
          $found=0;
	  foreach $r (keys %{$Roots{$i}}) {
            #print STDERR "$r\n";
            if ($Roots{$i}{$r} !~ /^($DepLex)$/ ) {
             
                  $Roots = $r;
                  $found=1,
                  #print STDERR "--------------DEP: $Tokens{$i}-- $Roots{$i}{$r}\n";
	       
            }
            else{
		$Roots_lex = $r;
            }
	   }
	  if (!$found) {
	      $Roots = $Roots_lex;
              
	  }
           print "$j\t$Tokens{$i}\t$Roots\t$Root_cats{$i}\t0\t$Args{$i}\tROOT\n";
         }
         
         else {
           ($token, $tag, $ref) = split ("_", $listaTags[$i]);
           # $listaTags[$i] = ConvertCharLarge($listaTags[$i]);

           ($lema) = ($listaTags[$i] =~ /lemma:([^ <>|]+)/);
           $listaTags[$i] =~ s/^</Fz2/ ;
          #  $args = "<lemma:$lema|token:$token|>";
           ($args) = ($listaTags[$i] =~ /(<[^ ]+>)/);
           # print STDERR "#$token# :: #$args# --- #$listaTags[$i]#\n";
           $args = ReConvertCharLarge($args);

           if ($tag =~ /^SENT/) {
	     $tag =~ s/>//;
             print "$j\t$token\t$token\t$tag\t_\t$args\t_\n";  
           }
	   else {
             $lema = ReConvertChar($lema);
             print "$j\t$token\t$lema\t$tag\t_\t$args\t_\n";
           }
         }    

      }

      for ($i=0;$i<=$#listaTags;$i++) {
         delete $listaTags[$i];
         delete $Deps{$i};
         delete $Cats{$i};
         delete $Heads{$i};
         delete $Rels{$i};
	 delete $Roots{$i};
         delete $Root_cats{$i};

         delete $Tokens{$i};
         delete $Args{$i};

       }
  
   }
    
 
   elsif  ($line =~ /^\(/) {

     #tiramos as parenteses da dependencia
     $line =~ s/^\(//;
     $line =~ s/\)$//;
    
     #nao tomamos em conta as dependencias semanticas
     if ($line !~ /\-SEM/ ) {
   
      ($rel, $head, $dep) = split('\;', $line);

    
      ($head,$cat_h,$ref_h) = split ("_", $head);
      ($dep,$cat_d,$ref_d) = split ("_", $dep);
      if ($rel =~ /_/) {
        ($rel,$cat_r,$ref_r) = split ("_", $rel);
        ($rel_name, $rel) = split ("/", $rel);

        $Deps{$ref_d}{$dep} = $rel_name ;
	$Heads{$ref_d} = $ref_r;
	$Rels{$ref_d} = "Term" ;
	$Cats{$ref_d} = $cat_d ;
        
        $Deps{$ref_r}{$rel} = $rel_name ;
	$Heads{$ref_r} = $ref_h;
	$Rels{$ref_r} = $rel_name ;
	$Cats{$ref_r} = $cat_r ;
	
        $Roots{$ref_h}{$head} = $rel_name;
	$Root_cats{$ref_h} = $cat_h ;
      }
    
      else {
       $Deps{$ref_d}{$dep} = $rel ; 
       $Heads{$ref_d} = $ref_h  ;
       $Rels{$ref_d} = $rel  ;
       $Cats{$ref_d} = $cat_d ;

       $Roots{$ref_h}{$head} = $rel ;
       $Root_cats{$ref_h} = $cat_h ;
      }
     }
  
 }

  elsif  ($line =~ /^HEAD::|^DEP::|^REL::/) {

       #if  ($line =~ /^HEAD/) {

         ($token) = ($line =~ /token:([^ _<>|]+)\|/); 
         ($args) = ($line =~ /(<[^ _<>]+>)/); 
         ($temp) = ($line =~ /::([^ <>]+)</); 
         ($tmp,$tmp,$pos) = split ("_", $temp);
         #$rel = $Rels{$pos};
         $Tokens{$pos} = $token;
         $Args{$pos} = $args;
         #$Tok{$pos}{$Head_token} = $rel ; 
        # print STDERR "$line\nH == ##$token## - ($args) ##$Token{$pos}## ###$pos### ---$temp$---\n";

  }

} 


##funcions especias para tratar os caracteres problematicos: "|", "<", ">"

sub ConvertChar {

    my ($string) = @_ ;

    $string =~ s/\>/\*Fz1\*/g; 
    $string =~ s/\</\*Fz2\*/g;
    $string =~ s/\|/\*Fz\*/g;

   return $string;

}

sub ConvertCharLarge {

    my ($string) = @_ ;

    $string =~ s/\\>/\*Fz1\*/g; 
    $string =~ s/tok\\>/token:\*Fz1\*/g; 
    $string =~ s/lemma:\\</lemma:\*Fz2\*/g;
    $string =~ s/token:\\</token:\*Fz2\*/g; 
    $string =~ s/lemma:\\\|/lemma:\*Fz\*/g;
    $string =~ s/token:\\\|/token:\*Fz\*/g; 
   # print STDERR "+++ $string\n";

   return $string;

}

sub ReConvertCharLarge {

    my ($string) = @_ ;

    $string =~ s/lemma:\*Fz1\*/lemma:\\>/g; 
    $string =~ s/lemma:\*Fz2\*/lemma:\\</g; 
    $string =~ s/lemma:\*Fz\*/lemma:\\|/g; 
    $string =~ s/token:\*Fz1\*/token:\\>/g; 
    $string =~ s/token:\*Fz2\*/token:\\</g; 
    $string =~ s/token:\*Fz\*/token:\\|/g; 
    

    return $string;
}

sub ReConvertChar {

    my ($string) = @_ ;

    $string =~ s/\*Fz1\*/\\>/g; 
    $string =~ s/\*Fz2\*/\\</g; 
    $string =~ s/\*Fz\*/\\|/g; 
    

    return $string;
}

