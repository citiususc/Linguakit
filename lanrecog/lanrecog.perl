#!/usr/bin/env perl

#IDENTIFICA SE UM TEXTO E ESPANHOL OU GALEGO 

#le um ficheiro a identificar (pipe) que foi previamente tokenizado
#le um ficheiro com todos os lexicons disponiveis. O formato é "token ling"

package LanRecog;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

# Absolute path 
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(__FILE__);#<ignore-line>


my %Lex = ();#<hash><hash><string>
my %Rank = ();#<hash><hash><integer>
my %Suffix = ();#<hash><hash><integer>
my $ling_def="en";#<string>
my $Separador = "[\.\,\;\:\«\»\"\&\%\+\=\$\#\(\)\<\>\!\¡\?\¿\\[\\]]";#<string>

do "$abs_path/build_lex.perl";
my $L;#<file>
open ($L, "$abs_path/lexicons/lexicons") or die "O ficheiro não pode ser aberto: $!\n";
binmode $L,  ':utf8';#<ignore-line>

my $i = 1;#<integer>
while (my $line = <$L>) {#<string>
	chomp $line;
	my ($term, $ling) = split ("\t", $line);#<string>

	if (!defined $Lex{$ling}) {
		$i=1;
		$Rank{$ling} = {};
		$Lex{$ling} = {};
	}
	$Rank{$ling}{$term} = $i;
	$Lex{$ling}{$term} = $term;
	$i++;
	#print STDERR "#$term# #$ling#\n";
}
close $L;

my $S;#<file>
open ($S, "$abs_path/morpho/suffix.txt") or die "O ficheiro não pode ser aberto: $!\n";
binmode $S,  ':utf8';#<ignore-line>

while (my $line = <$S>) {#<string>
	chomp $line;
	my ($suffix, $ling) = split ("\t", $line);#<string>

	if (!defined $Suffix{$ling}) {
		$Suffix{$ling} = {};
		if (!defined $Suffix{$ling}{$suffix}) {
			$Suffix{$ling}{$suffix} = 1;
			next;
		}
	}
	$Suffix{$ling}{$suffix}++;
	#print STDERR "#$suffix# #$ling#\n";
}
close $S;

sub norm {  
	my ($str) = $_[0]; #<string>
	$str =~ s/^jaja[j]*.*/jaja/ ;

	return $str
}

sub langrecog{

	my ($text) = @_;#<ref><list><string>
	my $Peso;#<hash><double>
	if (@_ > 1){
		$Peso = $_[1];
	}else{
		$Peso = {};
	}

	foreach my $line (@{$text}) {
		chomp $line;
		my $token = $line; #<string>
		$token = norm($token);
		##change uppercase to lowercase:
		$token = lc ($token);
		if ($token !~ /$Separador/) {
			foreach my $ling (keys %Lex) {
				#if ($Lex{$ling}{$token} =~ /^$token$/i) {
				if (defined $Lex{$ling} and defined $Lex{$ling}{$token}) {
					$Peso->{$ling} += $i - $Rank{$ling}{$token} ;
					# print STDERR "lex: #$ling# :: #$token# #$Peso->{$ling}# #$i# # $Rank{$ling}{$token} # \n";
				} else {
					foreach my $s (keys %{$Suffix{$ling}}) {
						#print STDERR "lex: #$ling# :: #$token# #$Peso->{$ling}# #$s# \n";
						if ($token =~ /$s$/) {
							$Peso->{$ling} += $i - ($i/2) ;
							#print STDERR "lex: #$ling# :: #$token# #$Peso->{$ling}# #$i# \n";
						}
					}
				}
			}
		}
	}

	if(keys %{$Peso} == 0){
		return $ling_def;
	}

	foreach my $ling (sort {$Peso->{$b} <=> $Peso->{$a}} keys %{$Peso} ) {
		return $ling;
	}

	#print STDERR "esp = $esp || gal = $gal\n";
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	print langrecog(\@lines);
}
#<ignore-block>


















