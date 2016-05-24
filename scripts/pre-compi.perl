#!/usr/bin/perl -X

##IT TAKES THE GRAMMAR AS INPUT AND PROCESS SOME CHANGES BEFORE COMPILING

$file = shift(@ARGV);
open (FILE, $file) or die "The file cannot be open: $!\n";

$N=10 ; #number of times [ ]+ and [ ]* are applied

$separador = "%";
$/ = $separador ;

while ($rule = <FILE>) {

 
 if ($rule !~ /(\]\+)|(\]\*)/) {
    print $rule;
 }
 else {
 
     @lines = split ('\n', $rule) ;
     for ($l=0;$l<=$#lines;$l++) {
      $line = $lines[$l];
      if ($line !~ /(\]\+)|(\]\*)/) {
        print "$line\n";
      }
      else {
        ($dep, $pattern) = ($line =~ /([^:]+):([\w\W ]+)/) ;
        @pattern = split (" ", $pattern);

        print  "$dep: ";
        for ($i=0;$i<=$#pattern;$i++) {
            if ($pattern[$i] ne "") {      
              $tag = $pattern[$i];
              if ($tag  =~ /(\]\+)$|(\]\*)$/)  {
                 
                 PrintNtimes($tag,$N);
              }
              else {
                 print  "$tag ";
              }
              
             
	   }
	}
        print "\n"; 
       
      }
     
   
  }

 }
} 

  



sub PrintNtimes {

    local ($x,$n) = @_ ;
    local $k=0;
    local $y="";
    for ($k=1;$k<=$n;$k++) {
      if ($x  =~ /(\]\+)$/ && $k==1)  { 
           $y=$x;
           $y =~ s/(\+$)//;
           print "$y ";
	}
        else   { 
           $x =~ s/(\+$)|(\*$)/?/;
           print "$x ";
	}
      
    }

    return 1 ;
}
