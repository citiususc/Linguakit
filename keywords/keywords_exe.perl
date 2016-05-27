#!/usr/bin/perl

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));


do $abs_path.'/keywords.perl';
#print STDERR  "$abs_path\n";
$lang=shift(@ARGV);
$th=100;
#####EXECUTANDO AS FUNÇOES:
my @tagged = <STDIN>;
my $tagged = join("",@tagged);
#print STDERR @tagged;
my @saida = keywords($lang, $th, $tagged);
my $saida = join("\n",@saida);
print "$saida";
###########

