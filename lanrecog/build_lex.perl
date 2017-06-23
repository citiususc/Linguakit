#!/usr/bin/env perl

use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
use File::Basename;

my $abs_path = dirname(__FILE__);
my $lex = "$abs_path/lexicons/lexicons";#Lexicon file joined

if (!-e $lex) {
	opendir(my $DIR, "$abs_path/lexicons");#Lexicon directory
	open(my $LEX, ">", $lex);

	for my $file (grep(/\.lx$/, readdir($DIR))){#Filter all files in lexicon directory that finish with .lx

		open(my $FILE, "$abs_path/lexicons/$file");
		my $lang = basename($file,".lx");
		for my $token (<$FILE>){
			chomp $token;
			print $LEX "$token\t$lang\n";
		}
		close $FILE;
	}

	close $LEX;
	closedir $DIR;
}




