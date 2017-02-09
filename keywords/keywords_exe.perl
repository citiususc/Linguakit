#!/usr/bin/env perl


#
# It takes a tagged text as input and uses a reference corpus (2 million tokens) as argument, to select keywords by computing chi-square measure. 
#
package Keywords;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

# Absolute path 
use Cwd 'abs_path';#<ignore-line>
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(abs_path($0));#<ignore-line>

##Portuguese resources
my ($REF_PT, $STOP_PT);#<file>
open ($REF_PT, $abs_path."/recursos/ref_pt") or die "O ficheiro ref_pt não pode ser aberto: $!\n";
binmode $REF_PT, ':utf8';#<ignore-line>
open ($STOP_PT, $abs_path."/recursos/stopwords_pt") or die "O ficheiro stopwords_pt não pode ser aberto: $!\n";
binmode $STOP_PT, ':utf8';#<ignore-line>

my @ref_pt = <$REF_PT>;#<array><string>
my @stop_pt = <$STOP_PT>;#<array><string>

##Spanish resources
my ($REF_ES, $STOP_ES);#<file>
open ($REF_ES, $abs_path."/recursos/ref_es") or die "O ficheiro ref_es não pode ser aberto: $!\n";
binmode $REF_ES, ':utf8';#<ignore-line>
open ($STOP_ES, $abs_path."/recursos/stopwords_es") or die "O ficheiro stopwords_es não pode ser aberto: $!\n";
binmode $STOP_ES, ':utf8';#<ignore-line>

my @ref_es = <$REF_ES>;#<array><string>
my @stop_es = <$STOP_ES>;#<array><string>

##Galician resources
my ($REF_GL, $STOP_GL);#<file>
open ($REF_GL, $abs_path."/recursos/ref_gl") or die "O ficheiro ref_gl não pode ser aberto: $!\n";
binmode $REF_GL, ':utf8';#<ignore-line>
open ($STOP_GL, $abs_path."/recursos/stopwords_gl") or die "O ficheiro stopwords_gl não pode ser aberto: $!\n";
binmode $STOP_GL, ':utf8';#<ignore-line>

my @ref_gl = <$REF_GL>;#<array><string>
my @stop_gl = <$STOP_GL>;#<array><string>

##English resources
my ($REF_EN, $STOP_EN);#<file>
open ($REF_EN, $abs_path."/recursos/ref_en") or die "O ficheiro ref_en não pode ser aberto: $!\n";
binmode $REF_EN, ':utf8';#<ignore-line>
open ($STOP_EN, $abs_path."/recursos/stopwords_en") or die "O ficheiro stopwords_en não pode ser aberto: $!\n";
binmode $STOP_EN, ':utf8';#<ignore-line>

my @ref_en = <$REF_EN>;#<array><string>
my @stop_en = <$STOP_EN>;#<array><string>

#<ignore-block>
if($pipe){
	my $lang=shift(@ARGV);
	my $th=100;
	my @tagged = <STDIN>;
	keywords($lang, $th, \@tagged);
}
#<ignore-block> 

sub keywords {

	my $lang = $_ [0];#<string>
	my $th = $_ [1];#<string>
	my $texto = $_ [2];#<ref><array><string>

	my @saida=();#<list><string>
	my $ref;#<ref><array><string>
	my $stop;#<ref><array><string>
	my %POS=();#<hash><hash><integer>
	my %NEG=();#<hash><hash><integer>
	my %Keys=();#<hash><double>
	my $NEG=0;#<integer>
	my $POS=0;#<integer>
	my $N=0;#<integer>
	my %TOKEN;#<ignore-line>

	if ($lang eq "pt") {
		$ref = \@ref_pt;
		$stop = \@stop_pt; 
	}elsif ($lang eq "es") {
		$ref = \@ref_es;
		$stop = \@stop_es; 
	}elsif ($lang eq "gl") {
		$ref = \@ref_gl;
		$stop = \@stop_gl; 
	}elsif ($lang eq "en") {
		$ref = \@ref_en;
		$stop = \@stop_en; 
	}

	####Reading file with stopwords and NP errors

	chomp $stop->[0];
	my ($tmp, $ErrosNP) = split ('\t', $stop->[0]);#<string>
	$ErrosNP =~ s/ /\|/g;
	#print STDERR "#$ErrosNP#\n";

	chomp $stop->[1];
	my ($tmp, $Stopwords) = split ('\t', $stop->[1]);#<string>
	$Stopwords =~ s/ /\|/g;

	####Reading file with reference or language model

	foreach my $line (@{$ref}) {
		chomp $line;
		my ($lemma, $cat, $freq) = split(qr/ /, $line);#<string>
		$cat =~ s/^J$/A/;
		$NEG{$cat} = {} if (!defined($NEG{$cat}));
		$NEG{$cat}{$lemma} = $freq;
		$NEG += $freq;
	}

	######reading input file
	foreach my $line (@{$texto}) {
		chomp $line;
		#print STDERR "LINE:#$line#\n";
		my ($token, $lemma, $tag) = split(qr/ /, $line);#<string>
		$lemma = $token if ($tag =~ /^NP/ || $tag =~ /^NNP/);
		next if ($token =~ /^($ErrosNP)(s?)$/ && ($tag =~ /^NP/ || $tag =~ /^NNP/));
		next if ($lemma =~ /^($Stopwords)$/);
		next if ($lemma =~ /([0-9]+)/) ;

		if ( $tag =~ /^V|^N|^AQ|^JJ/) {
			#print STDERR "TAG: #$tag#\n";
			if  ( $tag =~ /^NC/ || $tag =~ /^NN$/ || $tag =~ /^NNS$/) {
				$tag =~ s/^N[^ ]+$/N/;
			}elsif ( $tag =~ /^NP00G00/) {
				$tag =~ s/^N[^ ]+$/LOCAL/;
			}elsif ( $tag =~ /^NP00SP0/) {
				$tag =~ s/^N[^ ]+$/PERS/;
			}elsif ( $tag =~ /^NP00O00/) {
				$tag =~ s/^N[^ ]+$/ORG/;
			}elsif ( $tag =~ /^NP00V00/) {
				$tag =~ s/^N[^ ]+$/MISC/;
			}elsif ( $tag =~ /^NP00000/ ||  $tag =~ /^NP/ || $tag =~ /^NNP/ ) {
				$tag =~ s/^N[^ ]+$/ENTITY/;
			}else {
				$tag =~ s/^([A-Z])[^\s]*/$1/;
				$tag =~ s/^J/A/; ##changing english tag for adjective (J) by usual tag "A"
			}
			$POS{$tag} = {} if (!defined($POS{$tag}));
			$POS{$tag}{$lemma}++;
			$token =~ s/_/ /g;#<ignore-line>
			$lemma =~ s/_/ /g;#<ignore-line>
			$TOKEN{$tag}{$lemma}{$token}++;#<ignore-line>
		}
		$POS++;
	}

	$N=$POS+$NEG;

	foreach my $cat (keys %POS) {
		foreach my $w (keys %{$POS{$cat}}) {
			my $a = $POS{$cat}{$w};#<double>
			my $b = 0;#<double>
			if($NEG{$cat} && $NEG{$cat}{$w}){
				$b = $NEG{$cat}{$w};
			}
			my $c = $POS - $a;#<double>
			my $d = $N - $a - $b - $c;#<double>
			#print STDERR "a=$a - b=$b - c=$c - d=$d - d2=$d2 - N=$N\n";
			##chi-square segundo o artigo chines
			my $numerador = $N * ( (($a*$d) - ($b*$c)) ** 2);#<double>

			my $denominador = ($a+$c)*($b+$d)*($a+$b)*($c+$d);#<double>
			my $chiSquare = 0;#<double>
			$chiSquare = $numerador / $denominador if ($denominador >0);

			$cat =~ s/^J/A/; ##changing english tag for adjective (J) by usual tag "A"
			$Keys{$w.' '.$cat} = $chiSquare; 
			#print STDERR "#$w# -- #$cat#\n";
		}
	}

	my $i=0;#<integer>
	foreach my $k (sort {$Keys{$b} <=> $Keys{$a} or $b cmp $a} keys %Keys ) {
		$i++;
		#print STDERR "#$k#\n";
		my $chiSquare = $Keys{$k};#<string>
		my ($w, $cat) = split (qr/ /, $k);#<string>  
		if ($i<=$th) {
			$w =~ s/_/ /g;  
			if($pipe){#<ignore-line>
				print "$w\t$chiSquare\t$cat\n"#<ignore-line>
			}else{#<ignore-line>
				push (@saida, "$w\t$chiSquare\t$cat");  
			}#<ignore-line>
		}else {
			last;
		}
	}
	return \@saida;
}

sub trim {    #remove all leading and trailing spaces
	my $str = $_[0];#<string>

	$str =~ s/^\s*(.*\S)\s*$/$1/;
	return $str;
}

sub colour {    #remove all leading and trailing spaces
	my $cat = $_[0];#<string>
	my $result;#<string>

	if ($cat =~ /^A/) {
		$result = "red";
	}elsif ($cat =~ /^N/) {
		$result = "blue";
	}elsif ($cat =~ /^V/) {
		$result = "green";
	}

	return $result;
}


