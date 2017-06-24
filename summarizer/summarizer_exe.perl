#!/usr/bin/env perl

package Summarizer;

use strict; 
use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use Encode;

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

	my $req = POST "http://fegalaz.usc.es/nlpapi/$module", [ text => $input, lang_input =>$lang,format=>$format,output_size=>$size];

	return decode('utf-8', $ua->request($req)->content);
}


if($pipe){
	my $lang = shift(@ARGV); 
	my $size = shift(@ARGV); 
	my @lines = <STDIN>;
	my $result = summarizer(join("\n" ,@lines), $lang, $size);
	print "$result\n";
}

