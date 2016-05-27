#!/usr/bin/env perl


use  HTTP::Request::Common qw(POST);
use LWP::UserAgent;

$ua = LWP::UserAgent->new;
$ua->timeout(2000);

my $lang = shift(@ARGV); ### es, gl, pt, en
my $format = shift(@ARGV); ## -json, -xml;

my $module = "semantic_annotator";
my $size = 50; ##number of keywords

my @input =  <STDIN>;
my $input = join("\n",@input);

if (!$size) {
    $size = 50;
}
if (!$lang) {
    $lang = en;
}
$format =~ s/^\-//;
#print STDERR "$input\n";
my $req = POST "http://fegalaz.usc.es/nlpapi/$module",
              [ text => $input, lang_input =>$lang,format=>$format,size=>$size];
 
print $ua->request($req)->as_string;





