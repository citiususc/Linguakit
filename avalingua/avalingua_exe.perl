#!/usr/bin/env perl

package Avalingua;

use strict; 
use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use Encode;

# Pipe
my $pipe = !defined (caller);

sub avalingua{

	my $input = $_[0];
	my $lang = $_[1]; ### es, gl, pt, en
	my $format = $_[2]; ## -json, -xml;
	my $url = "https://demos.citius.usc.es/avalingua_api";
	#my $url = "https://tec.citius.usc.es/linguakit";
	#my $url = "fegalaz.usc.es/nlpapi";
	my $ua = LWP::UserAgent->new;
	$ua->timeout(2000);

	my $module = "smart_corrector";
	my $level = "grammar"; ##
	
	$format =~ s/^\-//;
	my $req = POST "$url/$module", [ text => $input, lang_input =>$lang,format=>$format,linguistic_level=>$level];

	return decode('utf-8', $ua->request($req)->content);
}


if($pipe){
	my $lang = shift(@ARGV); 
	my $format = shift(@ARGV); 
	my @lines = <STDIN>;
	my $result = linking(join("\n" ,@lines), $lang, $format);
	print "$result\n";
}

