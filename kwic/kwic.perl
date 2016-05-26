#!/usr/bin/perl -w

# program: kwic.perl
# This is a very simple "key words in context" concordancer written in perl. 
# It is a version of a tool available in: 
# Language Discovery and Exploration Tools for English Teachers, Translators, and Writers
# by Jon Fernquest:
#  http://www.geocities.com/SoHo/Square/3472/program.html#scripts


binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));

my $word = shift(@ARGV);

while (my $texto = <STDIN>) {
  my $window = 10;
  my @saida;
  my $saida;
  my %words;
  my @collocates;
  my @contexts3;

  my @texto = split ('\n', $texto);
  $lines = join("",@texto);
  $lines =~ s/\n/ /g;
  $lines =~ s/\r/ /g;

#transform multi-word keys
  $word =~ s/ $//;
  
  if ($word =~ / /) {
   $tmp = $word;
   
   $tmp =~ s/[\$\^]//g;
   
   @user_words = ($lines =~ /($tmp)/g);
   foreach $user_word (@user_words) {
      $modif_word = $user_word;
      $modif_word  =~ s/ /_/g;
      $lines =~ s/$user_word/$modif_word/g;
   }
   $word =~ s/ /_/g;
  
 }

 @words = ($lines =~ /(\S+)\s+/gi) ;


 if (!defined $window) {$window = 10}

 my $max = 0;
 for ($i = 0; $i < @words; $i++) {
   ## just the entire keyword
   #if ($words[$i] =~ /^$word[\W]*$/) {
    if ($words[$i] =~ /$word/) {
      @collocates = ();
      for ($j = -$window; $j <= -1; $j++) {

         push(@collocates,collocate(\@words,$i,$j));
      }

      push(@collocates,collocate(\@words,$i,0));

      for ($j = 1; $j <= $window; $j++) {

         push(@collocates,collocate(\@words,$i, $j));
      }

      $left   = join(" ", splice(@collocates,0,$window));
      $middle = splice(@collocates,0,1);
      $right  = join(" ", splice(@collocates,0,$window));
      @tmp = ($left,$middle,$right);
      push(@contexts3,[ @tmp ]);
      $max = (length($left) > $max) ? length($left) : $max;
   }

 }







# create a string filled with blanks equal to the max left context
 my $dummy = "";
 for ($i=1; $i < $max; $i++) { 
   $dummy .= " ";
 } 

# |<-----$remainder------->|<---------------$lenleft----------->|
# |<---------------------------$max---------------------------->|

 foreach $context (@contexts3) {
   $lenleft = length($context->[0]);
   $remainder = $max - $lenleft;
   $spacer = $dummy;
   substr($spacer,$remainder,$lenleft) = substr($context->[0],0,$lenleft);
   $context->[1] =~ s/_/ /g;
   print "$spacer   $context->[1]   $context->[2]\n";
 
 }
}


sub collocate {
   my($words,$i,$delta) = @_;
   
   my($target);

   # check bounds
   $target = $i + $delta;
    
   if (($target < 0) || ($target > @words - 1)) {
      #print "out of bounds\n";
     # print STDERR "W: #$target# #@words#\n";
      return "";
   } 
   
   #print "in bounds: $words->[$target]\n";
   return $words->[$target];
}



