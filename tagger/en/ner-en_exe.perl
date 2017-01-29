#!/usr/bin/env perl

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
##carregando palavras ambiguas
while (my $t = <AMB>) {
    $t = Trim ($t);
    $Ambig{$t}++;
}


my $separador = "\n\n" ;
$/ = $separador;

#sub lemma_es {
    
    my $N=10;
#    my $saida;
#    my @saida;
#    my @saida2; # Variante de saida1 com espaços entre orações
    
    ######################info dependente da língua!!!####################################################################################
    my $Prep = "(de|del|of)" ;  ##preposiçoes que fazem parte dum NP composto
    my $Art = "(el|la|los|las|the)" ; ##artigos que fazem parte dum NP composto
    my $currency = "(euro|euros|peseta|pesetas|€|dollar|dollars|pound|pounds)";
    my $measure = "(kg|kilogram|gram|g|centimeter|cm|hour|second|minute|ton|tn|meter|km|kilometer|%)";
    my $quant = "(hundred|hundreds|thousand|thousands|million|millions|bilion|billions||trillion|trillions)";  
    my $cifra = "(two|three|four|five|six|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|eighteen|nineteen|twenty|hundred|thousand)";  ##hai que criar as cifras básicas...
    my $meses =  "(january|february|march|april|may|june|july|august|september|october|november|december)";
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
    
#    my $text = join("",@text)  ;  
while (my $text = <STDIN>) {
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
        elsif ( ($tokens[$i] =~ /^$UpperCase/) && $Ambig{$lowercase} && 
			  $tokens[$k] !~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/ &&
			  $tokens[$k] !~ /^\.\.\.$/  && $i>0 ) { ##começa por maiúscula ambigua, e nao vai a principio de frase
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
	
	##caso que seja maiuscula
	###construimos candidatos para os NOMES PROPRIOS COMPOSTOS#############################################################
	elsif ($tokens[$i] =~ /^$UpperCase$LowerCase+/) {
	    $Candidate = $tokens[$i]  ;
	    # $Candidate = $tokens[$i];
            # $Nocandidate = $tokens[$i] ;
	    my $count = 1;
	    my $found = 0;
            # while ( (!$found) && ($count < $N) )    {
	    while (!$found) {
                my $j = $i + $count;
                #chomp $tokens[$j];
                if ($tokens[$j] eq "" ||
		    ($tokens[$j] =~ /^($Art)$/i && $tokens[$j-1] !~ /^($Prep)$/i) ) {
                    # se chegamos ao final de uma frase sem ponto ou se temos um artigo sem uma preposiçao precedente, paramos (Pablo el muchacho)
		    $found=1
                }
                elsif ( ($tokens[$j] !~ /^$UpperCase$LowerCase+/ ||  $Candidate =~ /($Punct)|($Punct_urls)/ ) &&
			#($tokens[$j] !~ /^($Prep)$/ && $tokens[$j+1] !~ /^($Art)$/ && $tokens[$j+1] !~ /^$UpperCase$LowerCase+/ )  )  { 
			($tokens[$j] !~ /^($Prep)$/i && $tokens[$j] !~ /^($Art)$/i )  )  { 
		    $found = 1 ;
		}		
		else {
		    $Candidate .= $SEP . $tokens[$j] ;
		    # $Nocandidate .=  " " . $tokens[$j] ; 
		    $count++;
		}
	    }
	    
            if ( ($count > 1) && ($count <= $N) &&
		 ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/) && 
		 $Candidate !~ /$SEP($Prep)$/ && $Candidate !~ /$SEP($Prep)$SEP($Art)$/) {
		$i = $i + $count - 1;
		$tokens[$i] =  $Candidate ; 
            }
	    
            elsif ( ($count > 1) && ($count <= $N) &&
		    ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/)
		    &&  $Candidate =~ /$SEP($Prep)$/i ) {
		$i = $i + $count - 2;
		$Candidate =~ s/$SEP($Prep)$//;  
		$tokens[$i] =  $Candidate ;
	    }
            elsif ( ($count > 1) && ($count <= $N) &&
		    ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/) &&
		    $Candidate =~ /$SEP($Prep)$SEP($Art)$/i ) {
		$i = $i + $count - 3;
		$Candidate =~ s/$SEP($Prep)$SEP($Art)$//i;  
		$tokens[$i] =  $Candidate ;
                #print STDERR "OKK:  #$Candidate#\n";
	    }
            elsif ( ($count > 1) && ($count <= $N) &&
		    ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/) &&
		    $Candidate =~ /SEP($Art)$/i ) {
		$i = $i + $count - 2;
		$Candidate =~ s/$SEP($Art)$//i;  
		$tokens[$i] =  $Candidate ;
	    }            
	}
	###FIM CONSTRUÇAO DOS NP COMPOSTOS##############################
	
	
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
	
	##MEAUSURES
	if  ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^$measure(s|\.)?$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] ;
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
	    $Tag{$tokens[$i]} = "Zu"; 
	    $adiantar=1 ;
	}
	elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$quant$/i &&  $tokens[$i+2] =~ /^$measure(s|\.)?$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2]  ;
	    $token = lc ($tokens[$i]); 
	    $Tag{$tokens[$i]} = "Zu"; 
	    $adiantar=2;	        
	}
	
	##CURRENCY
	elsif ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^$currency$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1];
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
	    $Tag{$tokens[$i]} = "Zm"; 
	    $adiantar=1;	        
	   # print STDERR "OK1: #$tokens[$i]# #$tokens[$i+1]#\n";
	}
	elsif ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^\$$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1];
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
	    $Tag{$tokens[$i]} = "Zm"; 
	    $adiantar=1;	        
	    #print STDERR "OK2: #$tokens[$i]# #$tokens[$i+1]#\n";
	}
	elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$quant$/i && $tokens[$i+2] =~ /^de$/i && $tokens[$i+3] =~ /^$currency$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] ;
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
	    $Tag{$tokens[$i]} = "Zm"; 
	    $adiantar=3;	    
	}
	elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$quant$/i && $tokens[$i+2] =~ /^$currency$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2]  ;
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
	    $Tag{$tokens[$i]} = "Zm"; 
	    $adiantar=2;	    
	}
	elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^de$/i && $tokens[$i+2] =~ /^$currency$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] ;
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
	    $Tag{$tokens[$i]} = "Zm"; 
	    $adiantar=2;	    
	}
	##QUANTITIES
	elsif ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^$quant$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] ;
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
	    $Tag{$tokens[$i]} = "Z"; 
	    $adiantar=1;
	}        
	
	##DATES
	elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^of$/i && $tokens[$i+2] =~ /^$meses$/i  && $tokens[$i+3] =~ /^\,$/i && $tokens[$i+4] =~ /[0-9][0-9][0-9][0-9]+/) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] . "_" . $tokens[$i+4]  ;
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
	    $Tag{$tokens[$i]} = "W"; 
	    $adiantar=4;	        
	}
        elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^of$/i && $tokens[$i+2] =~ /^$meses$/i   && $tokens[$i+3] =~ /[0-9][0-9][0-9][0-9]+/) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] ;
	    $token = lc ($tokens[$i]); 
	    $Tag{$tokens[$i]} = "W"; 
	    $adiantar=3;	        
	}
        elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$meses$/i   && $tokens[$i+2] =~ /^[0-9][0-9][0-9][0-9]+$/) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2]  ;
	    $token = lc ($tokens[$i]); 
	    $Tag{$tokens[$i]} = "W"; 
	    $adiantar=2;	        
	}
	elsif ($tokens[$i] =~ /^$meses$/i  && $tokens[$i+1] =~ /^of$/i && $tokens[$i+2] =~ /^[0-9][0-9][0-9][0-9]+$/) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] ;
	    $token = lc ($tokens[$i]);
	    $Tag{$tokens[$i]} = "W"; 
	    $adiantar=2;   
	}
	elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^of$/i && $tokens[$i+2] =~ /^$meses$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] ;
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
	    $Tag{$tokens[$i]} = "W"; 
	    $adiantar=2;   
	}
       	elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$meses$/i) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  ;
	    $token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
	    $Tag{$tokens[$i]} = "W"; 
	    $adiantar=1;   
	}
       	elsif ($tokens[$i] =~ /^$meses$/i  && $tokens[$i+1] =~ /^the$/i && $Tag{$tokens[$i+2]} =~ /^Z/  && $tokens[$i+3] =~ /^\,$/i  && $tokens[$i+4] =~ /^[0-9][0-9][0-9][0-9]+$/) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] . "_" . $tokens[$i+4] ;
	    $token = lc ($tokens[$i]);
	    $Tag{$tokens[$i]} = "W"; 
	    $adiantar=4;   
	}
        elsif ($tokens[$i] =~ /^$meses$/i  && $tokens[$i+1] =~ /^the$/i && $Tag{$tokens[$i+2]} =~ /^Z/  && $tokens[$i+3] =~ /^[0-9][0-9][0-9][0-9]+$/) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] ;
	    $token = lc ($tokens[$i]);
	    $Tag{$tokens[$i]} = "W"; 
	    $adiantar=3;   
	}
        elsif ($tokens[$i] =~ /^$meses$/i   && $Tag{$tokens[$i+1]} =~ /^Z/  && $tokens[$i+2] =~ /^[0-9][0-9][0-9][0-9]+$/) {
	    $tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2]  ;
	    $token = lc ($tokens[$i]);
	    $Tag{$tokens[$i]} = "W"; 
	    $adiantar=2;   
	}
	
	#################################FIM DATAS E NUMEROS
        
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
	print "$tokens[$i] $Tag{$tokens[$i]}\n";
	#push (@saida, $saida);
	
	##caso especial: final de texto sem puntuaçao
        if ($i == $#tokens && $tokens[$i] ne "\.") {
	    print "<blank> <blank> Fp\n";
	    #push (@saida, $saida);
        }
	
        $Tag{$tokens[$i]} = "";
        $i += $adiantar if ($adiantar); ##adiantar o contador se foram encontradas expressoes compostas        
    }    
    print "\n";


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
