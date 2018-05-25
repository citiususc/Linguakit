#!/usr/bin/env perl

package Conjugator;

use strict; 
use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use Encode;

# Pipe
my $pipe = !defined (caller);

sub conjugator{
	my $input = $_[0];
	my $lang = $_[1]; 
	my $variety = $_[2]; 
	my $module = "conjugator";
	my $format = "json";
	my $url = "https://tec.citius.usc.es/linguakit";
	#my $url = "fegalaz.usc.es/nlpapi";
	my $ua = LWP::UserAgent->new;
	$ua->timeout(2000);

	chomp $input;
	if (!$lang) {
		$lang = "pt";
	}

	if ($variety eq "-pe") {
		$variety = "pt_pt";
	}
	elsif ($variety eq "-pb") {
		$variety = "pt_br";
	}
	elsif ($variety eq "-pen") {
		$variety = "pt_pt_sao";
	}
	elsif ($variety eq "-pbn") {
		$variety = "pt_br_sao";
	}

	if (!$variety && $lang eq "pt") {
		$variety = "pt_pt";
	}

	my $req = POST "$url/$module", [ text => $input, lang_input =>$lang,format=>$format,variety=>$variety];

	return decode('utf-8', $ua->request($req)->content);
}

if($pipe){
	my $line = <STDIN>;
	my $lang = shift(@ARGV); ### es, gl, pt, en
	my $variety = shift(@ARGV); ##percentage of the abstract
	my $result = conjugator($line, $lang, $variety);
	print "$result\n";
}

