#!/usr/bin/env perl

# ProLNat NER 
# autor: Grupo ProLNat@GE, CiTIUS
# Universidade de Santiago de Compostela

package Ner;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>


# Pipe
my $pipe = !defined (caller);#<ignore-line> 

# Absolute path 
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(__FILE__);#<ignore-line>>
unshift(@INC, $abs_path);#<ignore-line>
do "store_lex.perl";

##ficheiros de recursos
my $Entry;#<ref><hash><string>
my $Lex;#<ref><hash><integer>
my $StopWords;#<ref><hash><string>
my $Noamb;#<ref><hash><boolean>
($Entry,$Lex,$StopWords,$Noamb) = Store::read();

##lexico de formas ambiguas
my $AMB;#<file>
open ($AMB, $abs_path."/lexicon/ambig.txt") or die "O ficheiro de palavras ambiguas não pode ser aberto\n";
binmode AMB,  ':utf8';#<ignore-line>

##variaveis globais
##para sentences e tokens:
my $UpperCase = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜ]";#<string>
my $LowerCase = "[a-záéíóúàèìòùâêîôûñçü]";#<string>
my $Punct =  qr/[\,\;\«\»\“\”\'\"\&\$\#\=\(\)\<\>\!\¡\?\¿\\\[\]\{\}\|\^\*\€\·\¬\…\-\+]/;#<string>
my $Punct_urls = qr/[\:\/\~]/;#<string>
my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";#<string>

##########CARGANDO RECURSOS COMUNS
##cargando o lexico freeling e mais variaveis globais
my %Ambig=();#<hash><boolean>
##carregando palavras ambiguas
while (my $t = <$AMB>) {#<string>
	$t = Trim ($t);
	$Ambig{$t}=1;
}
close $AMB;


######################info dependente da língua!!!####################################################################################
my $Prep = "(de|del|of)";#<string>  ##preposiçoes que fazem parte dum NP composto
my $Art = "(el|la|los|las|the)";#<string> ##artigos que fazem parte dum NP composto
my $currency = "(euro|euros|peseta|pesetas|€|dollar|dollars|pound|pounds)";#<string>
my $measure = "(kg|kilogram|gram|g|centimeter|cm|hour|second|minute|ton|tn|meter|km|kilometer|%)";#<string>
my $quant = "(hundred|hundreds|thousand|thousands|million|millions|bilion|billions||trillion|trillions)";#<string>
my $cifra = "(two|three|four|five|six|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|eighteen|nineteen|twenty|hundred|thousand)";#<string>  ##hai que criar as cifras básicas...
my $meses =  "(january|february|march|april|may|june|july|august|september|october|november|december)";#<string>
######################info dependente da língua!!!####################################################################################

sub ner {
    
	my $N=10;#<integer>
	my @saida=();#<list><string> 
	my $SEP = "_";#<string>
	my %Tag=();#<hash><string>
	my $Candidate;#<string>
	my $Nocandidate;#<string>
	#my $ContarCandidatos=0;
	#my $linhaFinal;
	my $token;#<string>
	my $adiantar;#<integer>
    
	my ($lines) = @_;#<ref><list><string>
	my @tokens=@{$lines};#<list><string>

	for (my $i=0; $i<=$#tokens; $i++) {#<integer>

		##marcar fim de frase
		$Tag{$tokens[$i]} = "";
		my $lowercase = lowercase ($tokens[$i]);#<string>
		if ($tokens[$i] =~ /^[ ]*$/) {
			$tokens[$i] = "#SENT#";
		}
		my $k = $i - 1;#<integer>
		my $j = $i + 1;#<integer>

		####CADEA COM TODAS PALAVRAS EM MAIUSCULA
		if ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$j] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$j])}) {
			$Tag{$tokens[$i]} = "UNK"; ##identificamos cadeas de tokens so em maiusculas e estao no dicionario
		}elsif ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$k] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$k])} &&
		  ($tokens[$j] =~ /^(\#SENT\#|\<blank\>|\"|\»|\”|\.|\-|\s|\?|\!|\:)$/ || $i == $#tokens ) ) { ##ultimo token de uma cadea com so maiusculas
			$Tag{$tokens[$i]} = "UNK";             
		}
		####CADEAS ENTRE ASPAS com palavras que começam por maiuscula 
		elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
		  $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /[\"\»\”\']/) {
			$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1];  
			$i = $i + 1; 
			$tokens[$i] = $Candidate;
		}elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
		  $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /[\"\»\”\']/) {
			$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP . $tokens[$i+2];   
			$i = $i + 2;
			$tokens[$i] = $Candidate;	    
		}elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
		  $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ &&
		  $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /[\"\»\”\']/) {
			$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3];   
			$i = $i + 3;   
			$tokens[$i] = $Candidate;           
		}elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
		  $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ &&
		  $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /^$UpperCase/ && $tokens[$i+5] =~ /[\"\»\”\']/) {
			$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3] . $SEP . $tokens[$i+4];   
			$i = $i + 4;   
			$tokens[$i] = $Candidate;           
		}elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ &&
		$tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ &&
		$tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /^$UpperCase/ && $tokens[$i+5] && $tokens[$i+6] =~ /[\"\»\”\']/) {
		$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3] . $SEP . $tokens[$i+4] . $SEP . $tokens[$i+5];   
		$i = $i + 5;   
		$tokens[$i] = $Candidate;
		}
		###Palavras que começam por maiúscula e nao estao no dicionario com maiusculas
		elsif ( $tokens[$i] =~ /^$UpperCase/ && $Noamb->{$tokens[$i]} ) { ##começa por maiúscula e e um nome proprio nao ambiguo no dicionario
			$Tag{$tokens[$i]} = "NNP";
		}elsif ( ($tokens[$i] =~ /^$UpperCase/) && !$StopWords->{$lowercase} && 
		  $tokens[$k] !~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/ &&
		  $tokens[$k] !~ /^\.\.\.$/  && $i>0 ) { ##começa por maiúscula e nao vai a principio de frase
			$Tag{$tokens[$i]} = "NNP";
		}elsif ( ($tokens[$i] =~ /^$UpperCase/) && $Ambig{$lowercase} && 
		  $tokens[$k] !~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/ &&
		  $tokens[$k] !~ /^\.\.\.$/  && $i>0 ) { ##começa por maiúscula ambigua, e nao vai a principio de frase
						   $Tag{$tokens[$i]} = "NNP";
		}elsif ( ($tokens[$i] =~ /^$UpperCase/ && !$StopWords->{$lowercase} &&
		  $tokens[$k] =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/) || ($i==0) ) { ##começa por maiúscula e vai a principio de frase 
			#print STDERR "OKKKK- #$tokens[$i]#\n";
			if (!$Lex->{$lowercase} || $Ambig{$lowercase}) {
			$Tag{$tokens[$i]} = "NNP"; 
			}
		}
		
		##if ( $tokens[$i] =~ /^$UpperCase$LowerCase+/ && ($StopWords->{$lowercase} && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡)$/) || ($i==0)) ) {   }
		##se em principio de frase a palavra maiuscula e uma stopword, nao fazemos nada
		if (($tokens[$i] =~ /^$UpperCase$LowerCase+/ && $Lex->{$lowercase} &&
		  !$Ambig{$lowercase}) && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/ || $i==0) ) {
			#print STDERR "OKKKK- #$tokens[$i]#\n";  
		} 
		##se em principio de frase a palavra maiuscula e está no lexico sem ser ambigua, nao fazemos nada
		elsif ( $tokens[$i] eq "I") {  
			#print STDERR "OKKKK- #$tokens[$i]#\n";
			$Tag{$tokens[$i]} = "UNK" ; 
		}##se aparece I, nao fazemos nada: fica ambigua

		##caso que seja maiuscula
		###construimos candidatos para os NOMES PROPRIOS COMPOSTOS#############################################################
		elsif ($tokens[$i] =~ /^$UpperCase$LowerCase+/) {
			$Candidate = $tokens[$i]  ;
			#$Candidate = $tokens[$i];
			#$Nocandidate = $tokens[$i] ;
			my $count = 1;#<integer>
			my $found = 0;#<boolean>
			#while ( (!$found) && ($count < $N) )    {
			while (!$found) {
				my $j = $i + $count;#<integer>
				#chomp $tokens[$j];
				if ($tokens[$j] eq "" ||
				  ($tokens[$j] =~ /^($Art)$/i && $tokens[$j-1] !~ /^($Prep)$/i) ) {
					#se chegamos ao final de uma frase sem ponto ou se temos um artigo sem uma preposiçao precedente, paramos (Pablo el muchacho)
					$found=1;
				}elsif ( ($tokens[$j] !~ /^$UpperCase$LowerCase+/ ||  $Candidate =~ /($Punct)|($Punct_urls)/ ) &&
				  #($tokens[$j] !~ /^($Prep)$/ && $tokens[$j+1] !~ /^($Art)$/ && $tokens[$j+1] !~ /^$UpperCase$LowerCase+/ )  )  { 
				  ($tokens[$j] !~ /^($Prep)$/i && $tokens[$j] !~ /^($Art)$/i )  )  { 
					$found = 1;
				}else {
					$Candidate .= $SEP . $tokens[$j] ;
					#$Nocandidate .=  " " . $tokens[$j] ; 
					$count++;
				}
			}
			if ( ($count > 1) && ($count <= $N) &&
			  ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/) && 
			  $Candidate !~ /$SEP($Prep)$/ && $Candidate !~ /$SEP($Prep)$SEP($Art)$/) {
				$i = $i + $count - 1;
				$tokens[$i] =  $Candidate ; 
			}elsif ( ($count > 1) && ($count <= $N) &&
			  ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/)
			  &&  $Candidate =~ /$SEP($Prep)$/i ) {
				$i = $i + $count - 2;
				$Candidate =~ s/$SEP($Prep)$//;  
				$tokens[$i] =  $Candidate;
			}elsif ( ($count > 1) && ($count <= $N) &&
			  ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/) &&
			  $Candidate =~ /$SEP($Prep)$SEP($Art)$/i ) {
				$i = $i + $count - 3;
				$Candidate =~ s/$SEP($Prep)$SEP($Art)$//i;  
				$tokens[$i] =  $Candidate ;
				#print STDERR "OKK:  #$Candidate#\n";
			} elsif ( ($count > 1) && ($count <= $N) &&
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
		}elsif ($Tag{$tokens[$i]} eq "NNP") {
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
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$quant$/i &&  $tokens[$i+2] =~ /^$measure(s|\.)?$/i) {
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
		}elsif ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^\$$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1];
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
			$Tag{$tokens[$i]} = "Zm"; 
			$adiantar=1;	        
			#print STDERR "OK2: #$tokens[$i]# #$tokens[$i+1]#\n";
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$quant$/i && $tokens[$i+2] =~ /^de$/i && $tokens[$i+3] =~ /^$currency$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
			$Tag{$tokens[$i]} = "Zm"; 
			$adiantar=3;	    
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$quant$/i && $tokens[$i+2] =~ /^$currency$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2]  ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
			$Tag{$tokens[$i]} = "Zm"; 
			$adiantar=2;	    
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^de$/i && $tokens[$i+2] =~ /^$currency$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
			$Tag{$tokens[$i]} = "Zm"; 
			$adiantar=2;	    
		}##QUANTITIES
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
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^of$/i && $tokens[$i+2] =~ /^$meses$/i   && $tokens[$i+3] =~ /[0-9][0-9][0-9][0-9]+/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=3;	        
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$meses$/i   && $tokens[$i+2] =~ /^[0-9][0-9][0-9][0-9]+$/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2]  ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=2;	        
		}elsif ($tokens[$i] =~ /^$meses$/i  && $tokens[$i+1] =~ /^of$/i && $tokens[$i+2] =~ /^[0-9][0-9][0-9][0-9]+$/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] ;
			$token = lc ($tokens[$i]);
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=2;   
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^of$/i && $tokens[$i+2] =~ /^$meses$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=2;   
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$meses$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=1;   
		}elsif ($tokens[$i] =~ /^$meses$/i  && $tokens[$i+1] =~ /^the$/i && $Tag{$tokens[$i+2]} =~ /^Z/  && $tokens[$i+3] =~ /^\,$/i  && $tokens[$i+4] =~ /^[0-9][0-9][0-9][0-9]+$/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] . "_" . $tokens[$i+4] ;
			$token = lc ($tokens[$i]);
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=4;   
		}elsif ($tokens[$i] =~ /^$meses$/i  && $tokens[$i+1] =~ /^the$/i && $Tag{$tokens[$i+2]} =~ /^Z/  && $tokens[$i+3] =~ /^[0-9][0-9][0-9][0-9]+$/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] ;
			$token = lc ($tokens[$i]);
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=3;   
		}elsif ($tokens[$i] =~ /^$meses$/i   && $Tag{$tokens[$i+1]} =~ /^Z/  && $tokens[$i+2] =~ /^[0-9][0-9][0-9][0-9]+$/) {
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
		}elsif ($tokens[$i] eq "#SENT#" && $tokens[$i-1] ne "\." && $tokens[$i-1] ne "<blank>" ){
			$tokens[$i] = "<blank>";
			$token = "<blank>";
			$Tag{$tokens[$i]} = "Fp"; 
		}elsif ($tokens[$i] =~ /^$Punct$/ || $tokens[$i] =~ /^$Punct_urls$/ || 
		  $tokens[$i] =~ /^(\.\.\.|\`\`|\'\'|\<\<|\>\>|\-\-)$/ ) {
			$Tag{$tokens[$i]} = punct ($tokens[$i]);
			$token = $tokens[$i]; 
		}

		##as linhas em branco eliminam-se 
		if ($tokens[$i] eq  "#SENT#") {
			next;
		}
	
		##parte final
		my $tag = $Tag{$tokens[$i]};#<string>
		$tag = $token . " " . $tag if ( $tag =~ /^(UNK|F|NNP|Z)/  || $tag eq "W" );
		
		if($pipe){#<ignore-line>
			print "$tokens[$i] $tag\n";#<ignore-line>
		}else{#<ignore-line>
			push (@saida, "$tokens[$i] $tag");
		}#<ignore-line>
		if($Tag{$tokens[$i]} eq "Fp"){
			if($pipe){#<ignore-line>
				print "\n";#<ignore-line>
			}else{#<ignore-line>
				push (@saida, "");
			}#<ignore-line>
		}

		$Tag{$tokens[$i]} = "";
		$i += $adiantar if ($adiantar); ##adiantar o contador se foram encontradas expressoes compostas    
	}
	return \@saida;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;

	for (my $i=0; $i<=$#lines; $i++) {
		chomp $lines[$i];
	}

	ner(\@lines);
}
#<ignore-block>

###OUTRAS FUNÇOES

sub punct {
	my ($p) = @_ ;#<string>
	my $result;#<string>

	if ($p eq "\.") {
		$result = "Fp"; 
	}elsif ($p eq "\,") {
		$result = "Fc"; 
	}elsif ($p eq "\:") {
		$result = "Fd"; 
	}elsif ($p eq "\;") {
		$result = "Fx"; 
	}elsif ($p =~ /^(\-|\-\-)$/) {
		$result = "Fg"; 
	}elsif ($p =~ /^(\'|\"|\`\`|\'\')$/) {
		$result = "Fe"; 
	}elsif ($p eq "\.\.\.") {
		$result = "Fs"; 
	}elsif ($p =~ /^(\<\<|«|\“)/) {
		$result = "Fra"; 
	}elsif ($p =~ /^(\>\>|»|\”)/) {
		$result = "Frc"; 
	}elsif ($p eq "\%") {
		$result = "Ft"; 
	}elsif ($p =~ /^(\/|\\)$/) {
		$result = "Fh"; 
	}elsif ($p eq "\(") {
		$result = "Fpa"; 
	}elsif ($p eq "\)") {
		$result = "Fpt"; 
	}elsif ($p eq "\¿") {
		$result = "Fia"; 
	}elsif ($p eq "\?") {
		$result = "Fit"; 
	}elsif ($p eq "\¡") {
		$result = "Faa"; 
	}elsif ($p eq "\!") {
		$result = "Fat"; 
	}elsif ($p eq "\[") {
		$result = "Fca"; 
	}elsif ($p eq "\]") {
		$result = "Fct"; 
	}elsif ($p eq "\{") {
		$result = "Fla"; 
	}elsif ($p eq "\}") {
		$result = "Flt"; 
	}elsif ($p eq "\…") {
		$result = "Fz"; 
	}elsif ($p =~ /^[\+\*\#\&]$/) {
		$result = "Fz"; 
	}
	return $result;
}

sub lowercase {
	my ($x) = @_ ;#<string>
	$x = lc ($x);
	$x =~  tr/ÁÉÍÓÚÇÑ/áéíóúçñ/;

	return $x;    
}

sub Trim {
	my ($x) = @_ ;#<string>

	$x =~ s/^[\s]*//;  
	$x =~ s/[\s]$//;  

	return $x;
}
