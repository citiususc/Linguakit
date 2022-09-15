#!/usr/bin/env perl


use HTTP::Request ();
use LWP::UserAgent;
use Data::Dumper;
use Encode;
use utf8;
use open ':std', ':encoding(utf8)';
use strict;
use warnings;
use JSON;

my $ua = LWP::UserAgent->new;
$ua->timeout(2000);

my $ling = 'pt';
my $module = 'tagger';
my $format = "nec";
my $port = '';

if(exists($ARGV[0]))
{
    $ling = $ARGV[0];
}

if($ling eq "pt") {
    $port = 3000;
} elsif($ling eq "gl") {
    $port = 3001;
} elsif($ling eq "es") {
    $port = 3002;
} elsif($ling eq "en") {
    $port = 3003;
} else {
    die "ERROR: Unsupported language '$ling'.\n";
}

my @input =  <STDIN>;
my $input = join("\n",@input);
$input =~ s/[\`\']//g;

my $headers = ['Content-Type' => 'application/json; charset=UTF-8'];
my $url = "http://127.0.0.1:$port/v2.0/$module";
my $data = {text => $input};
#my $data = {text => $input, output => $format};
my $encoded_data = encode_json($data);
my $request = HTTP::Request->new('POST', $url, $headers, $encoded_data);

my $response = $ua->request($request);
if($response->is_success)
{
    my $json_data = decode_json($response->{'_content'});
    for my $item (@{$json_data})
    {
        print "$item\n";
    }
}
else
{
    die "Connection failed: ", $response->content, "\n";
}
