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

##variaveis globais
##para sentences e tokens:
my $UpperCase = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜ]" ;
my $LowerCase = "[a-záéíóúàèìòùâêîôûñçü]" ;
my $Punct =  qr/[\,\;\«\»\“\”\'\"\&\$\#\=\(\)\<\>\!\¡\?\¿\\\[\]\{\}\|\^\*\€\·\¬\…]/;
my $Punct_urls = qr/[\:\/\~]/ ;

##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA###################
#my $pron = "(me|te|se|le|les|la|lo|las|los|nos|os)"; 
###########################################################
my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";



sub tokens {
  my (@sentences) = @_ ;
 
  my $token;
  my @saida;

  ###puntuaçoes compostas
  my $susp = "3SUSP012";
  my $duplo1 = "2DOBR111";
  my $duplo2 = "2DOBR222";
  my $duplo3 = "2DOBR333";
  my $duplo4 = "2DOBR444";

  ##pontos e virgulas entre numeros
  my $dot_quant = "44DOTQUANT77";
  my $comma_quant = "44COMMQUANT77";
  my $quote_quant = "44QUOTQUANT77";
  
 #(my @sentences) = split ('\n', $texto);
  
  foreach my $sentence (@sentences) {
     chomp $sentence;
     $sentence =~ s/[ ]*$//;

     #substituir puntuaçoes 
     $sentence =~ s/\.\.\./ $susp /g ;
     $sentence =~ s/\<\</ $duplo1 /g ;
     $sentence =~ s/\>\>/ $duplo2 /g ;
     $sentence =~ s/\'\'/ $duplo3 /g ;
     $sentence =~ s/\`\`/ $duplo4 /g ;
     
     $sentence =~ s/([0-9]+)\.([0-9]+)/$1$dot_quant$2 /g ;
     $sentence =~ s/([0-9]+)\,([0-9]+)/$1$comma_quant$2 /g ;
     $sentence =~ s/([0-9]+)\'([0-9]+)/$1$quote_quant$2 /g ;

      #print STDERR "#$sentence#\n";
      $sentence =~ s/($Punct)/ $1 /g ;
      #print STDERR "2#$sentence#\n";
      $sentence =~ s/($Punct_urls)(?:[\s\n]|$)/ $1 /g  ; 

      ##hypen - no fim de palavra ou no principio:
      $sentence =~ s/(\w)- /$1 - /g  ;
      $sentence =~ s/ -(\w)/ - $1/g  ;
      $sentence =~ s/(\w)-$/$1 -/g  ;
      $sentence =~ s/^-(\w)/- $1/g  ;

      $sentence =~ s/\.$/ \. /g  ; ##ponto final
       
     my @tokens = split (" ", $sentence);    
     foreach $token (@tokens) {
        $token =~ s/^[\s]*//;
        $token =~ s/[\s]*$//;
        $token =~ s/$susp/\.\.\./;
        $token =~ s/$duplo1/\<\</;
        $token =~ s/$duplo2/\>\>/;
        $token =~ s/$duplo3/\'\'/;
        $token =~ s/$duplo4/\`\`/;
        $token =~ s/$dot_quant/\./;
        $token =~ s/$comma_quant/\,/;
        $token =~ s/$quote_quant/\'/;

          #print STDERR "#$token#\n";
          push (@saida, $token);
	  #print "$token\n";
      }
      #print STDERR "#$sentence#\n";
     # print "\n";
     push (@saida, "\n") ;
 
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
  elsif ($p =~ /^(\<\<|«)/) {
         $result = "Fra"; 
  }
   elsif ($p =~ /^(\>\>|»)/) {
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
