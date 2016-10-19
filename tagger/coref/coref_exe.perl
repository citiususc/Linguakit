#!/usr/bin/perl

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));

use Getopt::Std;
our($opt_c, $opt_n);
getopts('cn');

# Invalid options > prints the help
if ($opt_c && $opt_n) {
    exit(1);
} elsif ($opt_c) {
    $opt_c = 1;
} elsif ($opt_n) {
    $opt_n = 1;
}

do $abs_path.'/crtool.pl';

#####EXECUTANDO AS FUNÇOES:
my @nec = <STDIN>;
my $cr = coref($opt_c, $opt_n, @nec);
my %Out = %$cr;

# Hash printing
#--------------
foreach my $l(sort {$a <=> $b} keys %Out) {
    if ($Out{$l} =~ /^[0-9]+ [^ ]+ [^ ]+ [A-Z]/) {
	$Out{$l} =~ s/^[0-9]+ //;
    }
    print "$Out{$l}\n";
}
print "\n";
###########

