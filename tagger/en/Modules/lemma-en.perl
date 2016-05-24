#!/usr/bin/perl

# ProLNat NER 
# autor: Grupo ProLNat@GE, CiTIUS
# Universidade de Santiago de Compostela

use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
use Storable qw(store retrieve freeze thaw dclone);

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));


##ficheiros de recursos
my $lex = $abs_path."/lexicon/lex_stored" ;

my $arrayref = retrieve($lex); 
my $Entry = $arrayref->[0];
my $Lex = $arrayref->[1];
my $StopWords =  $arrayref->[2];
my $Noamb =  $arrayref->[3];

##lexico de formas ambiguas
open (AMB, $abs_path."/lexicon/ambig.txt") or die "O ficheiro de palavras ambiguas não pode ser aberto: $!\n";
binmode AMB,  ':utf8';

##variaveis globais
##para sentences e tokens:
my $UpperCase = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜ]" ;
my $LowerCase = "[a-záéíóúàèìòùâêîôûñçü]" ;
my $Punct =  qr/[\,\;\«\»\“\”\'\"\&\$\#\=\(\)\<\>\!\¡\?\¿\\\[\]\{\}\|\^\*\€\·\¬\…\-\+]/;
my $Punct_urls = qr/[\:\/\~]/ ;
my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";


my %Ambig;
##cargando palavras ambiguas
while (my $t = <AMB>) {
    $t = Trim ($t);
    $Ambig{$t}++;
}

sub lemma_en {
    my (@text) = @_ ;
    
    my $N=10;
    my $saida;
    my @saida;
    my @saida2; # Variante de saida1 com espaços entre orações
    
    ######################info dependente da língua!!!####################################################################################
       my $cifra = "(two|three|four|five|six|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|eighteen|nineteen|twenty|hundred|thousand)";  ##hai que criar as cifras básicas...
       ######################info dependente da língua!!!####################################################################################
    
    my $SEP = "_";
    # my @tokens;
    my %Tag;
    my $Candidate;
    my $Nocandidate;
    #my $ContarCandidatos=0;
    my $linhaFinal;
    my $token;
    my $adiantar;  
    
    my $text = join("",@text)  ;  
    (my @tokens) = split ('\n', $text);
    
    for (my $i=0; $i<=$#tokens; $i++) {
	
	chomp $tokens[$i];
	##marcar fim de frase
	$Tag{$tokens[$i]} = "";
	my $lowercase = lowercase ($tokens[$i] ); 
	if  ($tokens[$i] =~ /^[ ]*$/) {
	    $tokens[$i] = "#SENT#";
	}
        my $k = $i - 1 ;
        my $j = $i + 1;
	
	
	####CADEA COM TODAS PALAVRAS EM MAIUSCULA
        if ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$j] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$j])}) {
	    $Tag{$tokens[$i]} = "UNK"; ##identificamos cadeas de tokens so em maiusculas e estao no dicionario
	}
	elsif ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$k] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$k])} &&
	       ($tokens[$j] =~ /^(\#SENT\#|\<blank\>|\"|\»|\”|\.|\-|\s|\?|\!|\:)$/ || $i == $#tokens ) ) { ##ultimo token de uma cadea com so maiusculas
	    $Tag{$tokens[$i]} = "UNK";             
	}
	
	####CADEAS ENTRE ASPAS com palavras que começam por maiuscula 
	elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
	       $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /[\"\»\”\']/) {
	    $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] ;  
	    $i = $i + 1; 
	    $tokens[$i] = $Candidate;
	}
	elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
	       $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /[\"\»\”\']/) {
	    $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP . $tokens[$i+2] ;   
	    $i = $i + 2;
	    $tokens[$i] = $Candidate;	    
	}
	elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
	       $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ &&
	       $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /[\"\»\”\']/) {
	    $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3];   
	    $i = $i + 3;   
	    $tokens[$i] = $Candidate;           
	}
	elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
	       $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ &&
	       $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /^$UpperCase/ && $tokens[$i+5] =~ /[\"\»\”\']/) {
	    $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3] . $SEP . $tokens[$i+4];   
	    $i = $i + 4;   
	    $tokens[$i] = $Candidate;           
	}
	elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
	       $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ &&
	       $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /^$UpperCase/ && $tokens[$i+5] && $tokens[$i+6] =~ /[\"\»\”\']/) {
	    $Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3] . $SEP . $tokens[$i+4] . $SEP . $tokens[$i+5];   
	    $i = $i + 5;   
	    $tokens[$i] = $Candidate;
	}
	
        ###Palavras que começam por maiúscula e nao estao no dicionario com maiusculas
        elsif ( $tokens[$i] =~ /^$UpperCase/ && $Noamb->{$tokens[$i]} ) { ##começa por maiúscula e e um nome proprio nao ambiguo no dicionario
	    $Tag{$tokens[$i]} = "NNP";
	}
	elsif ( ($tokens[$i] =~ /^$UpperCase/) && !$StopWords->{$lowercase} && 
		$tokens[$k] !~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/ &&
		$tokens[$k] !~ /^\.\.\.$/  && $i>0 ) { ##começa por maiúscula e nao vai a principio de frase
	    $Tag{$tokens[$i]} = "NNP";
	}
	elsif ( ($tokens[$i] =~ /^$UpperCase/ && !$StopWords->{$lowercase} &&
		 $tokens[$k] =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/) || ($i==0) ) { ##começa por maiúscula e vai a principio de frase 
           #print STDERR "OKKKK- #$tokens[$i]#\n";
	    if (!$Lex->{$lowercase} || $Ambig{$lowercase}) {
		$Tag{$tokens[$i]} = "NNP"; 
                
	    }
	}
	## if   ( $tokens[$i] =~ /^$UpperCase$LowerCase+/ && ($StopWords->{$lowercase} && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡)$/) || ($i==0)) ) {   }
        ## se em principio de frase a palavra maiuscula e uma stopword, nao fazemos nada
	
        if ( ($tokens[$i] =~ /^$UpperCase$LowerCase+/ && $Lex->{$lowercase} &&
	      !$Ambig{$lowercase}) && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/ || $i==0) ) {
              #print STDERR "OKKKK- #$tokens[$i]#\n";  
        } ##se em principio de frase a palavra maiuscula e está no lexico sem ser ambigua, nao fazemos nada

        elsif ( $tokens[$i] eq "I") {  
         #print STDERR "OKKKK- #$tokens[$i]#\n";
          $Tag{$tokens[$i]} = "UNK" ; 
        } ##se aparece I, nao fazemos nada: fica ambigua
	
	
	##NP se é composto
	if ($tokens[$i] =~ /[^\s]_[^\s]/ ) { 
	    $Tag{$tokens[$i]} = "NNP" ;	    
	}
	##se não lhe foi assigado o tag NP, entao UNK (provisional)
	elsif (! $Tag{$tokens[$i]}) {
	    $Tag{$tokens[$i]} = "UNK" ; 
	}
	
	##se é UNK (é dizer nao é NP), entao vamos buscar no lexico
	if ($Tag{$tokens[$i]} eq "UNK") {
	    $token = lowercase ($tokens[$i]);
	    if ($Lex->{$token}) {
		$Tag{$tokens[$i]} = $Entry->{$token};                
	    }
	}
	elsif ($Tag{$tokens[$i]} eq "NNP") {
	    $token = lowercase ($tokens[$i]); 
	}
	
	$adiantar=0;
	##os numeros, medidas e datas #USAR O FICHEIRO QUANTITIES.DAT##################
	
	##CIFRAS OU NUMEROS
	if ($tokens[$i] =~ /[0-9]+/ || $tokens[$i] =~ /^$cifra$/) {
	    $token = $tokens[$i];
	    $Tag{$tokens[$i]} = "Z"; 
	}
	
        
	#agora etiquetamos os simbolos de puntuaçao
	if ($tokens[$i] eq "\.") {
	    $token = "\.";
	    $Tag{$tokens[$i]} = "Fp"; 
	}
	
	elsif ($tokens[$i] eq "#SENT#" && $tokens[$i-1] ne "\." && $tokens[$i-1] ne "<blank>" ){
	    $tokens[$i] = "<blank>";
	    $token = "<blank>";
	    $Tag{$tokens[$i]} = "Fp"; 
	}
	
	elsif ($tokens[$i] =~ /^$Punct$/ || $tokens[$i] =~ /^$Punct_urls$/ || 
	       $tokens[$i] =~ /^(\.\.\.|\`\`|\'\'|\<\<|\>\>|\-\-)$/ ) {
            $Tag{$tokens[$i]} = punct ($tokens[$i]);
            $token = $tokens[$i]; 
	}
	
	##as linhas em branco eliminam-se 
	if ($tokens[$i] eq  "#SENT#") {
	    next;
	}
        
        ##parte final
        $Tag{$tokens[$i]} = $token . " " . $Tag{$tokens[$i]} if ( $Tag{$tokens[$i]} =~ /^(UNK|F|NNP|Z)/  || $Tag{$tokens[$i]} eq "W" );
	$saida  = "$tokens[$i] $Tag{$tokens[$i]}";
	push (@saida, $saida);
	
	##caso especial: final de texto sem puntuaçao
        if ($i == $#tokens && $tokens[$i] ne "\.") {
	    $saida = "<blank> <blank> Fp";
	    push (@saida, $saida);
        }
	
        $Tag{$tokens[$i]} = "";
        $i += $adiantar if ($adiantar); ##adiantar o contador se foram encontradas expressoes compostas        
    }    

    # Parche meu (Marcos) para adicionar espaços entre orações
    foreach my $s(@saida) {
	if ($s =~ /Fp$/) {
	    $s .= "\n";
	}
	push (@saida2, $s);
    }
    return @saida2;
}

###OUTRAS FUNÇOES

sub punct {
    my ($p) = @_ ;
    my $result;
    
    if ($p eq "\.") {
	$result = "Fp"; 
    }
    elsif ($p eq "\,") {
	$result = "Fc"; 
    }
    elsif ($p eq "\:") {
	$result = "Fd"; 
    }
    elsif ($p eq "\;") {
	$result = "Fx"; 
    }
    elsif ($p =~ /^(\-|\-\-)$/) {
	$result = "Fg"; 
    } 
    elsif ($p =~ /^(\'|\"|\`\`|\'\')$/) {
	$result = "Fe"; 
    }
    elsif ($p eq "\.\.\.") {
	$result = "Fs"; 
    }
    elsif ($p =~ /^(\<\<|«|\“)/) {
	$result = "Fra"; 
    }
    elsif ($p =~ /^(\>\>|»|\”)/) {
	$result = "Frc"; 
    }
    elsif ($p eq "\%") {
	$result = "Ft"; 
    }
    elsif ($p =~ /^(\/|\\)$/) {
	$result = "Fh"; 
    }
    elsif ($p eq "\(") {
	$result = "Fpa"; 
    }
    elsif ($p eq "\)") {
	$result = "Fpt"; 
    }
    elsif ($p eq "\¿") {
	$result = "Fia"; 
    } 
    elsif ($p eq "\?") {
	$result = "Fit"; 
    }
    elsif ($p eq "\¡") {
	$result = "Faa"; 
    }
    elsif ($p eq "\!") {
	$result = "Fat"; 
    }
    elsif ($p eq "\[") {
	$result = "Fca"; 
    } 
    elsif ($p eq "\]") {
	$result = "Fct"; 
    }
    elsif ($p eq "\{") {
	$result = "Fla"; 
    } 
    elsif ($p eq "\}") {
	$result = "Flt"; 
    }
    elsif ($p eq "\…") {
	$result = "Fz"; 
    }
    elsif ($p =~ /^[\+\*\#\&]$/) {
         $result = "Fz"; 
  }

    return $result;
}

sub lowercase {
    my ($x) = @_ ;
    $x = lc ($x);
    $x =~  tr/ÁÉÍÓÚÇÑ/áéíóúçñ/;
    
    return $x;    
}

sub Trim {
    my ($x) = @_ ;
    
    $x =~ s/^[\s]*//;  
    $x =~ s/[\s]$//;  
    
    return $x
}
