#!/usr/bin/env perl

# program: kwic.perl
# This is a very simple "key words in context" concordancer written in perl. 
# It is a version of a tool available in: 
# Language Discovery and Exploration Tools for English Teachers, Translators, and Writers
# by Jon Fernquest:
#  http://www.geocities.com/SoHo/Square/3472/program.html#scripts

package Kwic;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

#<ignore-block>
if($pipe){
	my $word = shift(@ARGV);
	my @lines=<STDIN>;
	kwic(\@lines, $word);
}
#<ignore-block>

sub kwic{

	my $lines = $_[0];#<ref><list><string>
	my $w = $_[1];#<string>
	my @saida = ();#<list><string>

	my $window = 10;#<integer>
	my @collocates;#<list><string>
	my @contexts3=();#<list><array><string>

	$w =~ s/ $//;#transform multi-word keys
	for my $line (@{$lines}){
		chomp $line;
		my $word = $w;#<string>

		if ($word =~ / /) {
			my $tmp = $word;#<string>

			$tmp =~ s/[\$\^]//g;

			my @user_words = ($line =~ /($tmp)/g);#<array><string>
			foreach my $user_word (@user_words) {
				my $modif_word = $user_word;#<string>
				$modif_word  =~ s/ /_/g;
				$line =~ s/$user_word/$modif_word/g;
			}
			$word =~ s/ /_/g;
		}

		my @words = ($line =~ /(\S+)\s+/gi);#<array><string>

		my $max = 0;#<integer>
		for (my $i = 0; $i < @words; $i++) {#<integer>
			## just the entire keyword
			#if ($words[$i] =~ /^$word[\W]*$/) {
			if ($words[$i] =~ /$word/) {
				@collocates = ();
				for (my $j = -$window; $j <= -1; $j++) {#<integer>
					push(@collocates,collocate(\@words,$i,$j));
				}
				push(@collocates,collocate(\@words,$i,0));
				for (my $j = 1; $j <= $window; $j++) {#<integer>
					push(@collocates,collocate(\@words,$i, $j));
				}
				my $left   = join(" ", splice(@collocates,0,$window));#<string>
				my $middle = splice(@collocates,0,1);#<string>
				my $right  = join(" ", splice(@collocates,0,$window));#<string>
				my @tmp = ($left,$middle,$right);#<array><string>
				push(@contexts3,\@tmp);
				$max = (length($left) > $max) ? length($left) : $max;
			}
		}

		# create a string filled with blanks equal to the max left context
		my $dummy = "";#<string>
		for (my $i=1; $i < $max; $i++) {#<integer>
			$dummy .= " ";
		} 

		# |<-----$remainder------->|<---------------$lenleft----------->|
		# |<---------------------------$max---------------------------->|

		foreach my $context (@contexts3) {
			my $lenleft = length($context->[0]);#<integer>
			my $remainder = $max - $lenleft;#<integer>
			my $spacer = $dummy;#<string>
			substr($spacer,$remainder,$lenleft) = substr($context->[0],0,$lenleft);
			$context->[1] =~ s/_/ /g;

			if($pipe){#<ignore-line>
				print "$spacer   $context->[1]   $context->[2]\n";#<ignore-line>
			}else{#<ignore-line>
				push(@saida,"$spacer   $context->[1]   $context->[2]");
			}#<ignore-line>
		}
	}
	return \@saida;
}

sub collocate {
	my($words,#<ref><array><string>
	  $i,$delta) = @_;#<integer>

	my $target;#<integer>

	# check bounds
	$target = $i + $delta;#<integer>

	if (($target < 0) || ($target > @{$words} - 1)) {
		#print "out of bounds\n";
		# print STDERR "W: #$target# #@words#\n";
		return "";
	} 

	#print "in bounds: $words->[$target]\n";
	return $words->[$target];
}



