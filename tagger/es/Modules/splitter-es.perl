#!/usr/bin/perl

#ProLNat Tokenizer (provided with Sentence Identifier)
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Script que integra 2 funçoes perl: sentences e tokens


use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));


##ficheiros de recursos
open (VERB, $abs_path."/lexicon/verbos-es.txt") or die "O ficheiro não pode ser aberto: $!\n";
binmode VERB,  ':utf8';
my @verb = <VERB>;


##variaveis globais
##para sentences e tokens:
my $UpperCase = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜ]" ;
my $LowerCase = "[a-záéíóúàèìòùâêîôûñçü]" ;
my $Punct =  qr/[\,\;\«\»\“\”\'\"\&\$\#\=\(\)\<\>\!\¡\?\¿\\\[\]\{\}\|\^\*\-\€\·\¬\…]/;
my $Punct_urls = qr/[\:\/\~]/ ;

##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA###################
my $pron = "(me|te|se|le|les|la|lo|las|los|nos|os)"; 
###########################################################
#my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";



sub splitter {
 my (@text) = @_ ;
 
 my @saida;
 my %Verb;
 my $verb;

 ##lendo verbos
 foreach  $verb (@verb) { ##lendo as abreviaturas...
    chomp $verb;
    $Verb{$verb}++;
    $verb =~ s/ar$/ár/;
    $verb =~ s/er$/ér/;
    $verb =~ s/ir$/ír/;
    $Verb{$verb}++; 
   #print STDERR "TOKEN:: #$verb#\n";
   # if ($verb eq "proponer") {print "PROPONER: #$verb#\n";}
 }

 ##lendo entrada (tokens)
 for (my $i=0;$i<=$#text;$i++) {
   chomp $text[$i];
   my $token = $text[$i];  
   #print STDERR "TOKEN:: #$token\n";
   my $tmp1;
   my $tmp2;  
   my $found=0;;
###################separar verbos em infinitivo dos cliticos compostos oslo, noslo, selo, ... 
###FALTA TRATAR OS IMPERATIVOS!!!!! incluiremos em verbos-es.txt a lista de formas em imperativo!
 
 if ($token =~ /^(\w+r)(nos|os|se|te|me)(lo|los|las|los)$/i) {
   ($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w+r)(nos|os|se|te|me)(lo|los|las|los)$/i;
  
   #print STDERR "---#$verb# - - #$tmp1# - #$tmp2#\n";
   if ($Verb{lowercase($verb)}  && $token =~ /(ár|ér|ír)(nos|os|se|te|me)(lo|los|las|los)$/) {
  
      $verb =~ s/ár/ar/;
      $verb =~ s/ér/er/;
      $verb =~ s/ír/ir/; 
      push (@saida, $verb);
      push (@saida, $tmp1);
      push (@saida, $tmp2);
      $found=1
   }

  } 
  
################separar cliticos simples de verbos  em infinitivo ###FALTA TRATAR OS IMPERATIVOS!!!!!
  if (!$found && $token =~ /^(\w+r)($pron)$/i) {
   ($verb,$tmp1) =  $token =~ /^(\w+r)($pron)$/i;
  
   if ($Verb{lowercase($verb)}) {
      push (@saida, $verb);
      push (@saida, $tmp1);
     # print STDERR "---#$verb# - #$tmp1#\n";
      $found=1;
   } 
  }
  
##############separar o gerundio dos pronomes
    ##pronomes compostos
  if (!$found && $token =~ /^(\w+iéndo|\w+ándo)(nos|os|se|te|me)(lo|los|las|los)$/i) {
   ($verb,$tmp1,$tmp2 ) =  $token =~ /^(\w+iéndo|\w+ándo)(nos|os|se|te|me)(lo|los|las|los)$/i; 
  # if ($token =~ /(iéndo|ándo)(nos|os|se)(lo|los|las|los)$/) {
  
      $verb =~ s/iéndo$/iendo/;
      $verb =~ s/ándo$/ando/;
      push (@saida, $verb);
      push (@saida, $tmp1);
      push (@saida, $tmp2);
      $found=1
   }

   ##pronomes simples
   if (!$found && $token =~ /^(\w+iéndo|\w+ándo)($pron)$/i) {
      ($verb,$tmp1) =  $token =~ /^(\w+iéndo|\w+ándo)($pron)$/i;
     # print STDERR "1---#$verb# - #$tmp1#\n";
      $verb =~ s/iéndo$/iendo/;
      $verb =~ s/ándo$/ando/;
      push (@saida, $verb);
      push (@saida, $tmp1);
    # print STDERR "2---#$verb# - #$tmp1#\n";
      $found=1; 
  }

###############separar contraçoes nao ambiguas###########

  #del, al
   if (!$found && $token =~ /^[dD]el$/) {
     ($tmp1,$tmp2) =  $token =~ /^([dD]e)(l)$/; 
     push (@saida, $tmp1);
     push (@saida, "e" . $tmp2) if  $token =~ /^d/; 
     push (@saida, "E" . $tmp2) if  $token =~ /^D/; 
     $found=1;
   }
   elsif ($token =~ /^[aA]l$/) {
     ($tmp1,$tmp2) =  $token =~ /^([aA])(l)$/; 
     push (@saida, $tmp1);
     push (@saida, "e" . $tmp2) if  $token =~ /^a/; 
     push (@saida, "E" . $tmp2) if  $token =~ /^A/; 
     $found=1;
   }

   if (!$found) {
      push (@saida, $token); 
   }
   if ($i == $#text && $token eq "")  {
      push (@saida, ""); 
   }
 }


  return @saida;
} 
        
sub lowercase {
  my ($x) = @_ ;
  $x = lc ($x);
  $x =~  tr/ÁÉÍÓÚÇÑ/áéíóúçñ/;

  return $x;

} 

