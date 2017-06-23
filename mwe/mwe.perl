#!/usr/bin/perl

#GERA UMA LISTA DE TRIGRAMAS "EXPR VALUE PADRAO" 
#lê um ficheiro com N-gramas etiquetados e filtrados 
#2 parametros: 
  ## medida (fr, chi, scp, log, mi) 
  ## frequencia minima da expressao 

#use lib "./galeXtra-3.0";
#use categorias ;
package Mwe;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 
my $sep = " ";#<string>

sub mwe{

	my @saida=();#<list><string>
	my ($lines, #<ref><list><string>
	  $measure, #<string>
	  $fr) = @_;#<float>

	my %Dico=();#<hash><double>
	my %Wfreq=();#<hash><integer>
	my %VPCLE=();#<hash><integer>
	my %NA=();#<hash><integer>
	my %AN=();#<hash><integer>
	my %NN=();#<hash><integer>
	my %NPN=();#<hash><integer>
	

	my $CountLines=0;#<integer>
	my $N=0;#<integer>
	for my $line (@{$lines}){
		my %IsPrep=();#<hash><boolean>
		my %IsName=();#<hash><boolean>
		my %IsMod=();#<hash><boolean>
		my %IsPcle=();#<hash><boolean>
		my %IsVerb=();#<hash><boolean>
		
		my $p1 = "";#<string>
		my $p2 = "";#<string>
		my $p3 = "";#<string>
		my $p4 = "";#<string>
		my $p5 = "";#<string>
		my $p6 = "";#<string>
		my $tag1 = "";#<string>
		my $tag2 = "";#<string>
		my $tag3 = "";#<string>
		my $tag4 = "";#<string>
		my $tag5 = "";#<string>
		my $tag6 = "";#<string>

		chomp($line);
		($p1, $p2, $p3, $p4, $p5, $p6) = split(" ", $line);

		#print STDERR "#$line# ------- #$p1# -- #$p2# -- #$p3#\n";

		if ($p1 =~ /\_/) {
		($p1, $tag1) = split ('\_', $p1);
			if ( Prep($tag1) ) {
				$IsPrep{$p1}=1;
				#print STDERR "$p1, $tag1\n";
			}
			if  (Adj($tag1)) {
				$IsMod{$p1}=1;
				#print STDERR "adj: $p1, $tag1\n";
			}
			if  (Nome($tag1)) {
				$IsName{$p1}=1;
				#print STDERR "name: $p1, $tag1\n";
			}
			if  (Pcle($tag1)) {
				$IsPcle{$p1}=1;
				#print STDERR "pcle: $p1, $tag1\n";
			}
			if  (Verbo($tag1)) {
				$IsVerb{$p1}=1;
				#print STDERR "verb: $p1, $tag1\n";
			}
		}
		if ($p2 =~ /\_/) {
			($p2, $tag2) = split ('\_', $p2);
			if ( Prep($tag2) ) {
				$IsPrep{$p2}=1;
				#print STDERR "$p2, $tag2\n";
			}
			if  (Nome($tag2)) {
				$IsName{$p2}=1;
				#print STDERR "name: $p2, $tag2\n";
			}
			if  (Adj($tag2)) {
				$IsMod{$p2}=1;
				#print STDERR "adj: $p2, $tag2\n";
			}
			if  (Pcle($tag2)) {
				$IsPcle{$p2}=1;
				#print STDERR "pcle: $p2, $tag2\n";
			}
			if  (Verbo($tag2)) {
				$IsVerb{$p2}=1;
				#print STDERR "verb: $p2, $tag2\n";
			}
		}
		if ($p3 =~ /\_/) {
			($p3, $tag3) = split ('\_', $p3);
			if ( Prep($tag3) ) {
				$IsPrep{$p3}=1;
				#print STDERR "$p3, $tag3\n";
			}
			if  (Nome($tag3)) {
				$IsName{$p3}=1;
				#print STDERR "name: $p3, $tag3\n";
			}
			if  (Adj($tag3)) {
				$IsMod{$p3}=1;
				#print STDERR "adj: $p3, $tag3\n";
			}
		}
		if ($p4 =~ /\_/) {
			($p4, $tag4) = split ('\_', $p4);
			if ( Prep($tag4) ) {
				$IsPrep{$p4}=1;
				#print STDERR "$p4, $tag4\n";
			}
			if  (Nome($tag4)) {
				$IsName{$p4}=1;
				#print STDERR "name: $p4, $tag4\n";
			}
			if  (Adj($tag4)) {
				$IsMod{$p4}=1;
				#print STDERR "adj: $p4, $tag4\n";
			}
		}
		if ($p5 =~ /\_/) {
			($p5, $tag5) = split ('\_', $p5);
			if ( Prep($tag5) ) {
				$IsPrep{$p5}=1;
				#print STDERR "$p5, $tag5\n";
			}
			if  (Nome($tag5)) {
				$IsName{$p5}=1;
				#print STDERR "name: $p5, $tag5\n";
			}
			if  (Adj($tag5)) {
				$IsMod{$p5}=1;
				#print STDERR "adj: $p5, $tag5\n";
			}
		}
		if ($p6 =~ /\_/) {
			($p6, $tag6) = split ('\_', $p6);
			if ( Prep($tag6) ) {
				$IsPrep{$p6}=1;
				#print STDERR "$p6, $tag6\n";
			}
			if  (Nome($tag6)) {
				$IsName{$p6}=1;
				#print STDERR "name: $p6, $tag6\n";
			}
			if  (Adj($tag6)) {
				$IsMod{$p6}=1;
				#print STDERR "adj: $p6, $tag6\n";
			}
		}
		###### Corpus Size:
		$N++;

		####### counting single words:
		$Wfreq{$p1}++;

		###PADRAO VERB-PCLE
		if ( ((defined $IsVerb{$p1}) && defined $IsPcle{$p2}) ){
			$VPCLE{$p1.$sep.$p2}++;
		}

		###PADRAO NOUN-ADJ
		if ( ((defined $IsName{$p1}) && defined $IsMod{$p2}) ){
			$NA{$p1.$sep.$p2}++;
		}

		###PADRAO ADJ-NOUN
		if ( ((defined $IsName{$p2}) && defined $IsMod{$p1}) ){
			$AN{$p1.$sep.$p2}++;
		}

		###PADRAO NOUN-NOUN
		if ( ((defined $IsName{$p1}) && defined $IsName{$p2}) ){
			$NN{$p1.$sep.$p2}++;
		}

		###PADRAO NOUN-PREP-NOUN
		if ( ((defined $IsName{$p1}) && defined $IsPrep{$p2}) && (defined $IsName{$p3}) ){
			$NPN{$p1.$sep.$p2.$sep.$p3}++;
		}

	}

	#print STDERR "fim leitura das ocurrencias em 6gramas\n";
	if ($measure =~ /(^-scp$|^-log$|^-chi$|^-mi$|^-cooc$)/ ) {
		##bigramas
		measure(\%Dico, $measure, $fr, $N, "V-PCLE", \%VPCLE, \%Wfreq);
		measure(\%Dico, $measure, $fr, $N, "N-A", \%NA, \%Wfreq);
		measure(\%Dico, $measure, $fr, $N, "A-N", \%AN, \%Wfreq);
		measure(\%Dico, $measure, $fr, $N, "N-N", \%NN, \%Wfreq);
		##trigramas
		measure(\%Dico, $measure, $fr, $N, "N-P-N", \%NPN, \%Wfreq);
		##imprimir resultados com valores ordenados:
		foreach my $expr (sort {$Dico{$b} <=> $Dico{$a} or $a cmp $b} keys %Dico ) {
				my ($mw, $cat) =  split ("_", $expr);#<string>
				$mw =~ s/@/ /g;
				if($pipe){#<ignore-line>
					print ("$mw\t$Dico{$expr}\t$cat\n");#<ignore-line>
				}else{#<ignore-line>
					push(@saida, "$mw\t$Dico{$expr}\t$cat");
				}#<ignore-line>
		}
	}
	return \@saida;
}

#<ignore-block>
if($pipe){
	my $measure = shift(@ARGV);#<string>
	my $fr = shift(@ARGV);#<string>
	
	my @lines=<STDIN>;
	mwe(\@lines, $measure, $fr);
}
#<ignore-block>

sub measure{
	my $Dico = $_[0];#<ref><hash><double>
	my $measure = $_[1];#<string>
	my $fr = $_[2];#<float>
	my $N = $_[3];#<integer>
	my $name = $_[4];#<string>
	my $hash = $_[5];#<ref><hash><integer>
	my $Wfreq = $_[6];#<ref><hash><integer>

	if( $measure eq "-chi"){
		foreach my $key (sort keys %{$hash}) {
			my @keys = split ($sep, $key);#<array><string>
			if ($hash->{$key} >= $fr) {
				my $exp = join ('@', @keys) . "_" . $name;#<string>
				$Dico->{$exp} =  chi ($hash->{$key}, $Wfreq->{$keys[0]}, $Wfreq->{$keys[$#keys]}, $N);
			}
		}
	}elsif ($measure eq "-log"){
		foreach my $key (sort keys %{$hash}) {
			my @keys = split ($sep, $key);#<array><string>
			if ($hash->{$key} >= $fr) {
				my $exp = join ('@', @keys) . "_" . $name;#<string>
				$Dico->{$exp} =  &log ($hash->{$key}, $Wfreq->{$keys[0]}, $Wfreq->{$keys[$#keys]}, $N);
			}
		}
	}elsif ($measure eq "-mi"){
		foreach my $key (sort keys %{$hash}) {
			my @keys = split ($sep, $key);#<array><string>
			if ($hash->{$key} >= $fr) {
				my $exp = join ('@', @keys) . "_" . $name;#<string>
				$Dico->{$exp} =  mi ($hash->{$key}, $Wfreq->{$keys[0]}, $Wfreq->{$keys[$#keys]}, $N);
			}
		}
	}elsif ($measure eq "-cooc"){
		foreach my $key (sort keys %{$hash}) {
			my @keys = split ($sep, $key);#<array><string>
			if ($hash->{$key} >= $fr) {
				my $exp = join ('@', @keys) . "_" . $name;#<string>
				$Dico->{$exp} =  cooc ($hash->{$key}, $Wfreq->{$keys[0]}, $Wfreq->{$keys[$#keys]}, $N);
			}
		}
	}elsif ($measure eq "-scp"){
		foreach my $key (sort keys %{$hash}) {
			my @keys = split ($sep, $key);#<array><string>
			if ($hash->{$key} >= $fr) {
				my $exp = join ('@', @keys) . "_" . $name;#<string>
				$Dico->{$exp} =  scp ($hash->{$key}, $Wfreq->{$keys[0]}, $Wfreq->{$keys[$#keys]}, $N);
			}
		}
	}

}

sub log {

	my $joint = $_[0];#<integer>
	my $w1 = $_[1];#<integer>
	my $w2 = $_[2];#<integer>
	my $N = $_[3];#<integer>

	my $a = $joint;#<integer>
	my $b = $w1 - $a;#<integer>
	my $c = $w2 - $a;#<integer>
	my $d = $N - $a - $b -$c;#<integer>

	my $result;#<double>
	if ($a > 0  && $b>0 && $c>0 && $d>0) {  
		my $baux = ($b==0)?0:($b*log($b));#<double>
		my $caux = ($c==0)?0:($c*log($c));#<double>

		$result = $a*log($a) +
		  $baux              +
		  $caux              +
		  $d*log($d)         +
		  $N*log($N)         -
		  ($a+$c)*log($a+$c) -
		  ($a+$b)*log($a+$b) -
		  ($b+$d)*log($b+$d) -
		  ($c+$d)*log($c+$d);

    }
    return $result;
} 

sub chi {

	my $joint = $_[0];#<integer>
	my $w1 = $_[1];#<integer>
	my $w2 = $_[2];#<integer>
	my $N = $_[3];#<integer>

	my $a = $joint;#<integer>
	my $b = $w1 - $a;#<integer>
	my $c = $w2 - $a;#<integer>
	my $d = $N - $a - $b -$c;#<integer>

	my $chi_a = (( ($a+$b)*($a+$c)/$N - $a )**2)/$a;#<double>
	my $chi_b = ($b==0)?0:(( ($a+$b)*($b+$d)/$N - $b )**2)/$b;#<double>
	my $chi_c = ($c==0)?0:(( ($c+$d)*($a+$c)/$N - $c )**2)/$c;#<double>
	my $chi_d = (( ($c+$d)*($b+$d)/$N - $d )**2)/$d;#<double>

	my $result =   $chi_a + $chi_b + $chi_c + $chi_d;#<double>

	return $result;
} 

sub mi {

	my $joint = $_[0];#<integer>
	my $w1 = $_[1];#<integer>
	my $w2 = $_[2];#<integer>
	my $N = $_[3];#<integer>

	my $a = $joint;#<integer>
	my $result =  log($N * ( $a / ($w1 * $w2) ) )/log(2);#<double>

	return $result;
} 


sub scp {

	my $joint = $_[0];#<integer>
	my $w1 = $_[1];#<integer>
	my $w2 = $_[2];#<integer>
	my $N = $_[3];#<integer>

	my $a = $joint;#<integer>
	my $result = ( ($a * $a) / ($w1 * $w2) );#<double>

	return $result;
} 

   
sub cooc {

	my $joint = $_[0];#<integer>
	my $w1 = $_[1];#<integer>
	my $w2 = $_[2];#<integer>
	my $N = $_[3];#<integer>
    
       
	return $joint;
} 

   
##Linguistic functions:

sub Prep {
	my ($x) = @_;#<string>
	my $result=0;#<boolean>
	if ( ($x =~ /PRP/) || ($x =~ /PREP/) || 
	  ($x eq "PDEL") || ($x eq "IN") || ($x eq "TO") ||
	  ($x =~ /^SP/) ) {
		$result = 1;
	}
	return $result;
}


sub Nome {
	my ($x) = @_;#<string>
	my $result=0;#<integer>
	if ($x =~ /^N/)  {
		$result = 1;
	}
	return $result;
}

sub Verbo {
	my ($x) = @_;#<string>
	my $result=0;#<integer>
	if ($x =~ /^V/ || $x =~ /^MD/)  {
		$result = 1;
	}
	return $result;
}

sub VPP {
	my ($x) = @_;#<string>
	my $result=0;#<integer>
	if ( ($x =~ /^VMP/) || ($x =~ /^VBP/))  {
		$result = 1;
	}
	return $result;
}


sub Adj {
	my ($x) = @_;#<string>
	my $result=0;#<integer>
	if ( ($x =~ /ADJ/) || ($x eq "JJ") || ($x =~ /AQ/)) {
		$result = 1;
	}
	return $result;
}
 

sub Num {
	my ($x) = @_;#<string>
	my $result=0;#<integer>
	if ($x =~ /CARD/)  {
		$result = 1;
	}
	return $result;
}

sub Mod {
	my ($x) = @_;#<string>
	my $result=0;#<integer>
	if ( ($x =~ /ADJ/) || ($x eq "JJ") || 
	  ($x =~ /ADV/) || ($x =~ /^RB/) ||
	  ($x =~ /AQ/) ){
		$result = 1;
	}
	return $result;
}


sub Adv {
	my ($x) = @_;#<string>
	my $result=0;#<integer>
	if ( ($x =~ /ADV/) || ($x =~ /^RB/) ) {
		$result = 1; 
	}
	return $result;
}

sub Pcle {
	my ($x) = @_;#<string>
	my $result=0;#<integer>
	if ($x =~ /^RP/)  {
		$result = 1; 
	}
	return $result;
}

