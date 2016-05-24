#!/usr/bin/perl

# O GERADOR DE 6-GRAMAS
#lê um texto taggeado com TreeTagger
#escreve quatro lemas taggeados por linha (4gramas)

#$ling = shift(@ARGV);

#open (INPUT, "tokens.txt") or die "O ficheiro não pode ser aberto: $!\n";
#open (OUTPUT, ">bigramas.txt");

$prev1 = "#";
$prev2 = "#";
$prev3 = "#";
$prev4 = "#";
$prev5 = "#";
while ($line = <STDIN>) {
      chop($line);
      ($token, $tag, $lema) = split (" ", $line);
      #$lema = "$lema\#$ling";
      $tagged = "$token\_$tag";


      print "$prev1 $prev2 $prev3 $prev4 $prev5 $tagged\n";
      $prev1 = $prev2;
      $prev2 = $prev3;
      $prev3 = $prev4;
      $prev4 = $prev5;
      $prev5 = $tagged;
}


#print STDERR "foi gerado o ficheiro de 4gramas\n";
