#!/usr/bin/perl -w

##Entrada: saida do etiquetador de DepPattern
##Saida: formato Freeling


#lista declarada de tags:

$P = "PRO";
$N = "NOUN";
$V = "VERB";
$C = "CONJ";
$I = "I";
$CARD = "CARD";
$ADJ = "ADJ";
$ADV = "ADV";
$PRP = "PRP";
$D = "DT";

$SENT = "SENT";


while (<>) {
    chop($_);
    
    if ($_ eq "") {
	next
    }
    
    else {
	#troca do simbolo de composicao tipico de DepPatter polo de freeling
	s/\@/\_/g ;
	
	($token, $info) = split("\t", $_);
	# print STDERR  "$token ---- $info\n";
	(@tmp) = split ('\|', $info);
	foreach $feat (@tmp) {
	    ($attr, $value) = split (":", $feat);
	    $Exp{$attr} = $value;
	    #print STDERR  "$attr ******* $value ------- $feat\n";
	}
	$lemma =   $Exp{"lemma"} ;
	$tag =   $Exp{"tag"} ;
	
	
	# print STDERR "$lemma -- $tag \n";
	#se temos um lema que começa com maiuscula, passa a minuscula
	
	if (IsUpper($lemma) )  {
	    $lemma = UpperToLower ($lemma); 
	}
	
	
	
	##correcçoes ad hoc de problemas de etiquetaçao:
	
	# if ( ($lemma =~ /^pol[oa](s?)$/) && ($tag =~ /^SP/) ) {
	#       $lemma = "por"
	# }
	
	
	
	
	##tag conversion:
	
	##pronouns:
	if ($tag =~ /^$P/) {
	    
	    $TAG = "P" .  $Exp{"type"}  . $Exp{"person"} . $Exp{"gender"}  . $Exp{"number"} . 
		$Exp{"case"} .  $Exp{"possessor"} . $Exp{"politeness"} 
	}
	##conjunctions
	elsif ($tag =~ /^$C/) {
	    
	    $TAG = "C" .  $Exp{"type"}  
	}
	##interjections
	elsif ($tag =~ /^$I/) {
	    
	    $TAG = "I"  
	}
	##numbers
	elsif ($tag =~ /^$CARD/) {
	    
	    $TAG = "Z" 
	}  
	##adjectives:
	elsif ($tag =~ /^$ADJ/) {
	    
	    $TAG = "A" .  $Exp{"type"}  . $Exp{"degree"} . $Exp{"gender"}  . $Exp{"number"} . 
		$Exp{"function"}
	} 
	##adverbs:
	elsif ($tag =~ /^$ADV/) {
	    
	    $TAG = "R" .  $Exp{"type"} 
	}
	##preps (add, simple:S, genre:0, number:0
	elsif ($tag =~ /^$PRP/) {
	    
	    $TAG = "S" .  $Exp{"type"} . "S" . "0" . "0" 
		
	}
	##nouns (add 0 values for semantic and degree:
	elsif ($tag =~ /^$N/) {
	    
	    $TAG = "N" .  $Exp{"type"}  . $Exp{"gender"}  . $Exp{"number"} . $Exp{"person"} . "0" . "0" # ultimo . "0" meu
	}
	
	##pronouns:
	elsif ($tag =~ /^$D/) {
	    
	    $TAG = "D" .  $Exp{"type"}  . $Exp{"person"} . $Exp{"gender"}  . $Exp{"number"} . 
		$Exp{"possessor"} ;
	}
	
	##verbs:
	elsif ($tag =~ /^$V/) {
	    
	    $TAG = "V" .  $Exp{"type"}  . $Exp{"mode"}  . $Exp{"tense"} . $Exp{"person"} . $Exp{"number"} . 
		$Exp{"gender"} 
	}  
	
	
	##puntuation marks
	elsif ($tag =~ /^$SENT/ && $lemma eq ".") {
	    
	    $TAG = "Fp"
	}  
        elsif ($tag =~ /^$SENT/ && $lemma eq "?") {
	    
	    $TAG = "Fit"
	}   
        elsif ($tag =~ /^$SENT/ && $lemma eq "!") {
	    
	    $TAG = "Fat"
	}  
 
       
	elsif ($token =~ ":") {
	    $lemma = ":";
	    $TAG = "Fd";
	}
	else {
	    
	    $TAG = $tag;
	}  
	
	
	
	##(pre-processing) removing quotation marks:
	##(fazer mais cousas deste tipo num pre-processo...)
#   if   ( ($tag =~ /^Fra/) || ( $tag =~ /^Frc/) || 
	#         ($tag eq "Fe") ) {
	#  }
	
	
	
	print "$token $lemma $TAG\n";
	
    }
    
}


##as conjunçoes seguem a ser CS (subord) e CC (coordenada)


sub UpperToLower {
    local ($l) = @_;
    $l =~tr/A-Z/a-z/;
    $l =~tr/ÑÇ/ñç/;
    $l =~tr/\301\311\315\323\332\307\303\325\302\312\324\300\310/\341\351\355\363\372\347\343\365\342\352\364
\340\350/;
    return $l;
}

sub IsUpper {
    local ($l) = @_ ;
    
    if ($l =~ /^[A-ZÑÇ\301\311\315\323\332\307\303\325\302\312\324\300\310]/) {
        return 1;
    }
    else {
	return 0
    }
}
