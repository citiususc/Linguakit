#!/usr/bin/env perl

use strict;
use warnings;
use File::Basename;
$| = 1;
if (!eval{require Storable;}){
	warn "Please install Storable module: cpan Storable\n";
	exit(1);
}

my $path = dirname(__FILE__);

my @lex_stored = (
	"$path/tagger/en/lexicon/lex_stored",
	"$path/tagger/es/lexicon/lex_stored",
	"$path/tagger/pt/lexicon/lex_stored",
	"$path/tagger/gl/lexicon/lex_stored",
	"$path/tagger/gl/lexicon/split_stored",
	"$path/tagger/histgz/lexicon/lex_stored",
	"$path/tagger/histgz/lexicon/split_stored"
);

foreach my $file ( @lex_stored ) {
	if (-e $file) {
		unlink $file or die "Could not delete $file: $!";
	}
}

print ("Compiling lexicons:\n");
print ("\tEnglish   \t");
my $lex = "$path/tagger/en/store_lex.perl";
do $lex;
print ((-e $lex) ? "Done\n": "Failed\n");

print ("\tPortuguese\t");
$lex = "$path/tagger/pt/store_lex.perl";
do $lex;
print ((-e $lex) ? "Done\n": "Failed\n");

print ("\tSpanish   \t");
$lex = "$path/tagger/es/store_lex.perl";
do $lex;
print ((-e $lex) ? "Done\n": "Failed\n");

print ("\tGalician  \t");
$lex = "$path/tagger/gl/store_lex.perl";
do $lex;
print ((-e $lex) ? "Done ": "Failed ");
$lex = "$path/tagger/gl/store_split.perl";
do $lex;
print ((-e $lex) ? "Done\n": "Failed\n");

print ("\tHistoric galician-portuguese  \t");
$lex = "$path/tagger/histgz/store_lex.perl";
do $lex;
print ((-e $lex) ? "Done ": "Failed ");
$lex = "$path/tagger/histgz/store_split.perl";
do $lex;
print ((-e $lex) ? "Done\n": "Failed\n");


print ("Installation done!\n");
