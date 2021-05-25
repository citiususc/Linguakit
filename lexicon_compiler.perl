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
my $lexicon = {
    "gl" => \&compile_gl,
    "pt" => \&compile_pt,
    "es" => \&compile_es,
    "en" => \&compile_en,
    "histgz" => \&compile_histgz,
};
my @langs = keys(%{$lexicon});
if($#ARGV >= 0)
{
    @langs = @ARGV;
}


print ("Compiling lexicons:\n");

foreach my $lang (@langs)
{
    if(!exists($lexicon->{$lang}))
    {
        print "\tSkipping $lang: language does not exist or is unsupported.\n";
        next;
    }
    $lexicon->{$lang}->();
}
print ("Installation done!\n");


#---------------------------------------functions-----------------------------------#
sub compile_en
{
    my $lex = "$path/tagger/en/store_lex.perl";
    my $lex_stored = "$path/tagger/en/lexicon/lex_stored";
    unlink $lex_stored or die "Could not delete $lex_stored: $!";

    print ("\tEnglish   \t");
    do $lex;
    print ((-e $lex) ? "Done\n": "Failed\n");
}

sub compile_pt
{
    my $lex = "$path/tagger/pt/store_lex.perl";
    my $lex_stored = "$path/tagger/pt/lexicon/lex_stored";
    unlink $lex_stored or die "Could not delete $lex_stored: $!";

    print ("\tPortuguese\t");
    do $lex;
    print ((-e $lex) ? "Done\n": "Failed\n");
}

sub compile_es
{
    my $lex = "$path/tagger/es/store_lex.perl";
    my $lex_stored = "$path/tagger/es/lexicon/lex_stored";
    unlink $lex_stored or die "Could not delete $lex_stored: $!";

    print ("\tSpanish   \t");
    do $lex;
    print ((-e $lex) ? "Done\n": "Failed\n");
}

sub compile_gl
{
    my $lex = "$path/tagger/gl/store_lex.perl";
    my $lex_stored = "$path/tagger/gl/lexicon/lex_stored";
    my $split_stored = "$path/tagger/gl/lexicon/split_stored";
    unlink $lex_stored or die "Could not delete $lex_stored: $!";
    unlink $split_stored or die "Could not delete $split_stored: $!";

    print ("\tGalician  \t");
    do $lex;
    print ((-e $lex) ? "Done ": "Failed ");

    $lex = "$path/tagger/gl/store_split.perl";
    do $lex;
    print ((-e $lex) ? "Done\n": "Failed\n");
}

sub compile_histgz
{
    my $lex = "$path/tagger/histgz/store_lex.perl";
    my $lex_stored = "$path/tagger/histgz/lexicon/lex_stored";
    my $split_stored = "$path/tagger/histgz/lexicon/split_stored";
    unlink $lex_stored or die "Could not delete $lex_stored: $!";
    unlink $split_stored or die "Could not delete $split_stored: $!";

    print ("\tHistoric galician-portuguese  \t");
    do $lex;
    print ((-e $lex) ? "Done ": "Failed ");

    $lex = "$path/tagger/histgz/store_split.perl";
    do $lex;
    print ((-e $lex) ? "Done\n": "Failed\n");
}
