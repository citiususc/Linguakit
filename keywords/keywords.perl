#!/usr/bin/perl


#
# It takes a tagged text as input and uses a reference corpus (2 million tokens) as argument, to select keywords by computing chi-square measure. 
#

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));

use Dancer::Logger::Console;

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';

##Portuguese resources
my $ref = $abs_path."/recursos/ref_pt";
open (REF_PT, $ref) or die "O ficheiro não pode ser aberto: $!\n";
binmode REF_PT, ':utf8';
my $stop = $abs_path."/recursos/stopwords_pt";
open (STOP_PT, $stop) or die "O ficheiro não pode ser aberto: $!\n";
binmode STOP_PT, ':utf8';

my @ref_pt = <REF_PT>;
my @stop_pt = <STOP_PT>;

##Spanish resources
my $ref = $abs_path."/recursos/ref_es";
open (REF_ES, $ref) or die "O ficheiro não pode ser aberto: $!\n";
binmode REF_ES, ':utf8';
my $stop = $abs_path."/recursos/stopwords_es";
open (STOP_ES, $stop) or die "O ficheiro não pode ser aberto: $!\n";
binmode STOP_ES, ':utf8';

my @ref_es = <REF_ES>;
my @stop_es = <STOP_ES>;

##Galician resources
my $ref = $abs_path."/recursos/ref_gl";
open (REF_GL, $ref) or die "O ficheiro não pode ser aberto: $!\n";
binmode REF_GL, ':utf8';
my $stop = $abs_path."/recursos/stopwords_gl";
open (STOP_GL, $stop) or die "O ficheiro não pode ser aberto: $!\n";
binmode STOP_GL, ':utf8';

my @ref_gl = <REF_GL>;
my @stop_gl = <STOP_GL>;

##English resources
my $ref = $abs_path."/recursos/ref_en";
open (REF_EN, $ref) or die "O ficheiro não pode ser aberto: $!\n";
binmode REF_EN, ':utf8';
my $stop = $abs_path."/recursos/stopwords_en";
open (STOP_EN, $stop) or die "O ficheiro não pode ser aberto: $!\n";
binmode STOP_EN, ':utf8';

my @ref_en = <REF_EN>;
my @stop_en = <STOP_EN>;


sub keywords {

my ($lang, $th, $analizado) = @_ ;

#my $th=100; ##number of keywords retrieved
my @saida;
my @ref;
my @stop;
my %POS;
my %NEG;
my %Keys;
my $NEG=0;
my $POS=0;
my $N=0;
my @keywords;
my %TOKEN;

#my $analizado = analyzer($lang, $texto);
if ($lang eq "pt") {
   @ref = @ref_pt;
   @stop = @stop_pt; 
}
elsif ($lang eq "es") {
   @ref = @ref_es;
   @stop = @stop_es; 
}
elsif ($lang eq "gl") {
   @ref = @ref_gl;
   @stop = @stop_gl; 
}
elsif ($lang eq "en") {
   @ref = @ref_en;
   @stop = @stop_en; 
}

my $logger = Dancer::Logger::Console->new;
 #  $logger -> debug("REF: #@ref# -- #$lang#");
####Reading file with stopwords and NP errors

chomp $stop[0];
($tmp, $ErrosNP) = split ('\t', $stop[0]);
$ErrosNP =~ s/ /\|/g;
#print STDERR "#$ErrosNP#\n";

chomp $stop[1];
($tmp, $Stopwords) = split ('\t', $stop[1]);
$Stopwords =~ s/ /\|/g;

####Reading file with reference or language model

foreach $line (@ref) {
  chomp $line;
  ($lemma, $cat, $freq) = split(/ /, $line);
  $cat =~ s/^J$/A/;
  $NEG{$cat}{$lemma} = $freq;
  $NEG += $freq;
   my $logger = Dancer::Logger::Console->new;
   #$logger -> debug("REF: #$lemma#");
  #print STDERR "LEMMA:#$lemma#\n";
}

######reading input file
(@texto) = split ('\n', $analizado);

foreach $line (@texto) {
  chomp $line;
  #$line = trim($_);
  #print STDERR "LINE:#$line#\n";
  ($token, $lemma, $tag) = split(/ /, $line);
  $lemma = $token if ($tag =~ /^NP/ || $tag =~ /^NNP/);
  next if ($token =~ /^($ErrosNP)(s?)$/ && ($tag =~ /^NP/ || $tag =~ /^NNP/) );
  next if ($lemma =~ /^($Stopwords)$/);
  next if ($lemma =~ /([0-9]+)/) ;
  
  if ( $tag =~ /^V|^N|^AQ|^JJ/) {
    # print STDERR "TAG: #$tag#\n";
    if  ( $tag =~ /^NC/ || $tag =~ /^NN$/ || $tag =~ /^NNS$/) {
        $tag =~ s/^N[^ ]+$/N/;
    }
    elsif ( $tag =~ /^NP00G00/) {
        $tag =~ s/^N[^ ]+$/LOCAL/;
    }
    elsif ( $tag =~ /^NP00SP0/) {
        $tag =~ s/^N[^ ]+$/PERS/;
    }
    elsif ( $tag =~ /^NP00O00/) {
        $tag =~ s/^N[^ ]+$/ORG/;
    }
    elsif ( $tag =~ /^NP00V00/) {
        $tag =~ s/^N[^ ]+$/MISC/;
    }
    elsif ( $tag =~ /^NP00000/ ||  $tag =~ /^NP/ || $tag =~ /^NNP/ ) {
        $tag =~ s/^N[^ ]+$/ENTITY/;
    }
    else {
     $tag =~ s/^([A-Z])[^\s]*/$1/;
     $tag =~ s/^J/A/; ##changing english tag for adjective (J) by usual tag "A"
    }
    $POS{$tag}{$lemma}++;
    $token =~ s/_/ /g;
    $lemma =~ s/_/ /g;
    $TOKEN{$tag}{$lemma}{$token}++;
  }
  #$DF{$word}++ ;
  $POS++
}

$N=$POS+$NEG;

#my $th=(($POS*5/100))+5; ##number of keywords retrieved
#my $th=100;
foreach $cat (keys %POS) {
  foreach $w (keys %{$POS{$cat}}) {
     $a = $POS{$cat}{$w};
     $b = $NEG{$cat}{$w} if ($NEG{$cat}{$w});
     $b = 0 if (!$NEG{$cat}{$w});
     $c = $POS - $a;
     $d = $N - $a - $b - $c;

    # print STDERR "a=$a - b=$b - c=$c - d=$d - d2=$d2 - N=$N\n";


    ##chi-square segundo o artigo chines
     $numerador = $N * ( (($a*$d) - ($b*$c)) **2);
     $denominador = ($a+$c)*($b+$d)*($a+$b)*($c+$d);
     $chiSquare = $numerador / $denominador if ($denominador >0);

      $tag =~ s/^J/A/; ##changing english tag for adjective (J) by usual tag "A"
      $Keys{$w, $cat} = $chiSquare; 
      #print STDERR "#$w# -- #$cat#\n";
  }

}


my $i=0;
foreach $k (sort {$Keys{$b} <=>
                  $Keys{$a} }
                    keys %Keys ) {
     $i++;
    #print STDERR "#$k#\n";
     $chiSquare = $Keys{$k}; 
     my ($w, $cat) = split (/$;/o, $k);    
    # ($w, $cat) = ('\|', $k);
     if ($i<=$th) {
         $w =~ s/_/ /g;  
	 $saida = "$w\t$chiSquare\t$cat";
         push (@keywords, $saida);  
     } 
     else {
       last
     }
}



return @keywords;

}

sub trim {    #remove all leading and trailing spaces
  my ($str) = @_[0];

  $str =~ s/^\s*(.*\S)\s*$/$1/;
  #$str =~ s/[\“]//g";
  return $str;
}

sub colour {    #remove all leading and trailing spaces
  my ($cat) = @_[0];
  my $result;
   
  if ($cat =~ /^A/) {
      $result = "red";
  }
  elsif ($cat =~ /^N/) {
      $result = "blue";
  }
  elsif ($cat =~ /^V/) {
      $result = "green";
  }

  return $result;
}


