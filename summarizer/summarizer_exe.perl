#!/usr/bin/env perl


use  HTTP::Request::Common qw(POST);
use LWP::UserAgent;

$ua = LWP::UserAgent->new;
$ua->timeout(2000);

my $lang = shift(@ARGV); ### es, gl, pt, en
my $size = shift(@ARGV); ##percentage of the abstract
my $module = "summarizer";
my $format = "xml";

my @input =  <STDIN>;
my $input = join("\n",@input);

if (!$size) {
    $size = 10;
}
if (!$lang) {
    $lang = en;
}
#print STDERR "#$input#\n";
#http://0.0.0.0:3000/
#fegalaz.usc.es/nlpapi
my $req = POST "http://fegalaz.usc.es/nlpapi/$module",
              [ text => $input, lang_input =>$lang,format=>$format,output_size=>$size];
 
print $ua->request($req)->as_string;





