#!/usr/bin/env perl


use  HTTP::Request::Common qw(POST);
use LWP::UserAgent;

$ua = LWP::UserAgent->new;
$ua->timeout(2000);

my $lang = shift(@ARGV); ### es, gl, pt, en
my $variety = shift(@ARGV); ##percentage of the abstract
my $module = "conjugator";
my $format = "json";

my $input =  <STDIN>;
chomp $input;
#my $input = join("\n",@input);

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


#print STDERR "#$variety#\n";
#print STDERR "#$input#\n";
#http://0.0.0.0:3000/
#fegalaz.usc.es/nlpapi
my $req = POST "http://fegalaz.usc.es/nlpapi/$module",
              [ text => $input, lang_input =>$lang,format=>$format,variety=>$variety];
 
print $ua->request($req)->as_string;





