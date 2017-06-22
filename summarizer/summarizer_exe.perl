#!/usr/bin/env perl

package Summarizer;

use strict; 
use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;

# Pipe
my $pipe = !defined (caller);

sub summarizer{

	my $input = $_[0];
	my $lang = $_[1]; ### es, gl, pt, en
	my $size =  $_[2]; ##percentage of the abstract

	my $ua = LWP::UserAgent->new;
	$ua->timeout(2000);

	my $module = "summarizer";
	my $format = "xml";


	my $req = POST "http://fegalaz.usc.es/nlpapi/$module", [ text => $input, lang_input =>$lang,format=>$format,size=>$size];

	return $ua->request($req)->content;
}


if($pipe){
	my $lang = shift(@ARGV); 
	my $size = shift(@ARGV); 
	my @lines=<STDIN>;
	for my $line (@lines){
		my $result = summarizer($line, $lang, $size);
		print "$result\n";
	}
}

