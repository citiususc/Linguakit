#!/usr/bin/perl

#IDENTIFICA SE UM TEXTO E ESPANHOL OU GALEGO 

#le um ficheiro a identificar (pipe) que foi previamente tokenizado
#le um ficheiro com todos os lexicons disponiveis. O formato é "token ling"

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';


my $lexicon = shift(@ARGV);
open (L, $lexicon) or die "O ficheiro não pode ser aberto: $!\n";

my $suffix = shift(@ARGV);
open (S, $suffix) or die "O ficheiro não pode ser aberto: $!\n";

my $ling_def="en";

my $Separador = "[\.\,\;\:\«\»\"\&\%\+\=\$\#\(\)\<\>\!\¡\?\¿\\[\\]]" ;

my $i=1;
my $term="";
my $suffix="";
my $ling="";
my %Rank;
my %Lex;
my %Peso;
my %Suffix;

while (my $line = <L>) {
  
   chomp $line;
  ($term, $ling) = split ("\t", $line);

   if (!defined $Lex{$ling}) {
       $i=1;
   }
   $Rank{$ling}{$term} = $i;
   $Lex{$ling}{$term} = $term;
   $i++;
  #print STDERR "#$term# #$ling#\n";
}


while (my $line = <S>) {
   chomp $line;
  ($suffix, $ling) = split ("\t", $line);

   $Suffix{$ling}{$suffix}++;
  # $Lex{$ling}{$suffix} = $term;
  #print STDERR "#$suffix# #$ling#\n";
}

my $found=0;
while (my $line = <STDIN>) {
   chomp $line;
   my $token = $line;
   ##change uppercase to lowercase:
   $token = lc ($token);
   if ($token !~ /$Separador/) {
       foreach $ling (keys %Lex) {
        #if ($Lex{$ling}{$token} =~ /^$token$/i) {
         if (defined $Lex{$ling}{$token}) {
           $Peso{$ling} += $i - $Rank{$ling}{$token} ;
           # print STDERR "lex: #$ling# :: #$token# #$Peso{$ling}# #$i# # $Rank{$ling}{$token} # \n";
           $found=1;
         } 
           
         else {
           
	   foreach $s (keys %{$Suffix{$ling}}) {
                 #print STDERR "lex: #$ling# :: #$token# #$Peso{$ling}# #$s# \n";
                 if ($token =~ /$s$/) {
                     $Peso{$ling} += $i - ($i/2) ;
                     #print STDERR "lex: #$ling# :: #$token# #$Peso{$ling}# #$i# \n";
                   
		 }
	   }
	 }
      }
    }

}

#print STDERR "esp = $esp || gal = $gal\n";

##default:
if (!$found){
  print $ling_def 
}
else {
 my $First=0;
 foreach $ling (sort {$Peso{$b} <=>
                      $Peso{$a} }
                      keys %Peso ) {
    if (!$First) {
      print $ling;
      $First=1;
  
    }
 }
}

   



