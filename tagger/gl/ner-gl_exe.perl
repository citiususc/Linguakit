#!/usr/bin/env perl

#ProLNat NER 
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela

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
$abs_path = dirname(__FILE__);#<ignore-line>
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
open ($AMB, $abs_path."/lexicon/ambig.txt") or die "O ficheiro de palavras ambiguas não pode ser aberto: $!\n";
binmode $AMB,  ':utf8';#<ignore-line>


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
my $Prep = "(de|da|do)";#<string>  ##preposiçoes que fazem parte dum NP composto
my $Art = "(o|a|os|as)";#<string> ##artigos que fazem parte dum NP composto
my $Det = "(o|a|os|as|um|uma|uns|umas|algum|alguns|alguma|algumas|todo|todos|toda|todas|varios|varias|moito|moitos|moita|moitas)" ; #<string>#determinantes par ver o contexto das ambiguas: desse, pelo...
my $PrepCompl = "(de|con|para|sen)";#<string>  ##preposiçoes
my $currency = "(euro|euros|dólar|dólares|peseta|pesetas|yen|yenes|escudo|escudos|franco|francos|real|reais|€)";#<string>
my $measure = "(kg|kilogramo|quilogramo|gramo|g|centímetro|cm|hora|segundo|minuto|tonelada|tn|metro|m|km|kilómetro|quilómetro|%)";#<string>
my $quant = "(cento|centos|miles|millón|millóns|billón|billóns|trillón|trillóns)";#<string>
my $cifra = "(dous|tres|catro|cinco|seis|sete|oito|nove|dez|cem|mil)";#<string>  ##hai que criar as cifras básicas: once, doce... veintidós, treinta y uno...
my $meses =  "([Xx]aneiro|[Ff]ebreiro|[Mm]arzo|[Aa]bril|[Mm]aio|[Jj]uño|[Jj]ullo|[Aa]gosto|[Ss]etembro|[Oo]utubro|[Nn]ovembro|[Dd]ezembro)";#<string>
######################info dependente da língua!!!####################################################################################

sub ner {
    
	my $N=10;#<integer>
	my @saida=();#<list><string> 
	my $SEP = "_";#<string>
	my %Tag=();#<hash><string>
	my %Tag_ant=();#<hash><string>
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
		my $k = $i - 1;#<string>
		my $j = $i + 1;#<string>
   
		####CADEA COM TODAS PALAVRAS EM MAIUSCULA
		if ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$j] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$j])} ) {
		$Tag{$tokens[$i]} = "UNK"; ##identificamos cadeas de tokens so em maiusculas e estao no dicionario
		}elsif ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$k] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$k])} &&
		($tokens[$j] =~ /^(\#SENT\#|\<blank\>|\"|\»|\”|\.|\-|\s|\?|\!)$/ || $i == $#tokens ) ) { ##ultimo token de uma cadea com so maiusculas
		$Tag{$tokens[$i]} = "UNK";             
		}
		####CADEAS ENTRE ASPAS com palavras que começam por maiuscula 
		elsif ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /[\"\»\”\']/) {
			#print STDERR  "#$tokens[$i]# --- #$tokens[$k]#\n";
			$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] ;  
			$i = $i + 1; 
			$tokens[$i] = $Candidate;                
		}elsif   ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /[\"\»\”\']/) {
			#print STDERR  "#$tokens[$i]# --- #$tokens[$k]#\n";
			$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP . $tokens[$i+2] ;   
			$i = $i + 2;
			$tokens[$i] = $Candidate;            
		}elsif   ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /[\"\»\”\']/) {
			$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3];   
			$i = $i + 3;   
			$tokens[$i] = $Candidate;           
		}elsif   ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /^$UpperCase/ && $tokens[$i+5] =~ /[\"\»\”\']/) {
			$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3] . $SEP . $tokens[$i+4];   
			$i = $i + 4;   
			$tokens[$i] = $Candidate;           
		}elsif   ($tokens[$k]  =~ /^(\"|\“|\«|\')/ && $tokens[$i] =~ /^$UpperCase/ && $tokens[$i+1] =~ /^$UpperCase/ && $tokens[$i+2] =~ /^$UpperCase/ && $tokens[$i+3] =~ /^$UpperCase/ && $tokens[$i+4] =~ /^$UpperCase/  && $tokens[$i+5] && $tokens[$i+6] =~ /[\"\»\”\']/) {
			$Candidate =  $tokens[$i] . $SEP . $tokens[$i+1] . $SEP .  $tokens[$i+2] . $SEP . $tokens[$i+3] . $SEP . $tokens[$i+4] . $SEP . $tokens[$i+5];   
			$i = $i + 5;   
			$tokens[$i] = $Candidate;           
		}
		###Palavras que começam por maiúscula e nao estao no dicionario com maiusculas
		elsif ( $tokens[$i] =~ /^$UpperCase/ && $Noamb->{$tokens[$i]} ) { ##começa por maiúscula e e um nome proprio nao ambiguo no dicionario
			$Tag{$tokens[$i]} = "NP00000";
		}elsif   ( ($tokens[$i] =~ /^$UpperCase/) &&  !$StopWords->{$lowercase} && 
			$tokens[$k] !~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡|\?|\!|\:|\`\`)$/ && $tokens[$k] !~ /^\.\.\.$/  && $i>0 ) { ##começa por maiúscula e nao vai a principio de frase
			$Tag{$tokens[$i]} = "NP00000"; 
			#print "TOKEN::: ##$tokens[$i]## K=#$tokens[$k]#\n" ;
			#print  STDERR "1TOKEN::: ##$i## --  ##$tokens[$i]## - - #$Tag{$tokens[$i]}# --  prev:#$tokens[$k]# --  post:#$tokens[$j]#\n" if ($tokens[$i] eq "De");
		}elsif   ( ($tokens[$i] =~ /^$UpperCase/ &&  !$StopWords->{$lowercase} && 
			$tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡|\?|\!|\:|\`\`)$/) || ($i==0) ) { ##começa por maiúscula e vai a principio de frase 
			#$token = lowercase ($tokens[$i]);
			#print STDERR "2TOKEN::: lowercase: #$lowercase# -- token: #$tokens[$i]# --  token_prev: #$tokens[$k]# --  post:#$tokens[$j]#--- #$Tag{$tokens[$i]}#\n" if ($tokens[$i] eq "De");       
			if (!$Lex->{$lowercase} || $Ambig{$lowercase}) {
				#print STDERR "--AMBIG::: #$lowercase#\n";
				$Tag{$tokens[$i]} = "NP00000"; 
				#print STDERR "OKKKK::: lowercase: #$lowercase# -- token: #$tokens[$i]# --  token_prev: #$tokens[$k]#  --  post:#$tokens[$j]#\n" ;       
			}
			#print STDERR "##$tokens[$i]## -  #$tokens[$k]#\n" if ($tokens[$i] eq "De");
		}
					 
		##if( $tokens[$i] =~ /^$UpperCase$LowerCase+/ && ($StopWords->{$lowercase} && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡)$/) || ($i==0)) ) {   }##se em principio de frase a palavra maiuscula e uma stopword, nao fazemos nada

		if ( ($tokens[$i] =~ /^$UpperCase$LowerCase+/ && $Lex->{$lowercase} &&  !$Ambig{$lowercase}) && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/ || $i==0) ) {         
			#print  STDERR "1TOKEN::: ##$lowercase## // #!$Ambig{$lowercase}# - - #$Tag{$tokens[$i]}# --  #$tokens[$k]#\n" ;        
		}##se em principio de frase a palavra maiuscula e está no lexico sem ser ambigua, nao fazemos nada

		##caso que seja maiuscula
		###construimos candidatos para os NOMES PROPRIOS COMPOSTOS#############################################################
		elsif ($tokens[$i] =~ /^$UpperCase$LowerCase+/) {
			#print "##$tokens[$i]## - #$Tag{$tokens[$i]}# --  #$tokens[$k]# ---- #$StopWords->{$lowercase}#\n"; 
			$Candidate = $tokens[$i]  ;
			#$Candidate = $tokens[$i];
			#$Nocandidate = $tokens[$i] ;
			#print  STDERR "4TOKEN::: ##$tokens[$i]## - - #$Tag{$tokens[$i]}# --  #$tokens[$k]#\n" ;         
			my $count = 1;#<integer>
			my $found = 0;#<boolean>
			#print  STDERR "Begin: ##$i## - ##$count##- $tokens[$i]\n";
			#while ( (!$found) && ($count < $N) )    {
			while (!$found) {
				my $j = $i + $count;#<integer>
				#chomp $tokens[$j];
				#print  STDERR "****Begin: ##$i## - ##$j##- #$tokens[$i]# --- #$tokens[$j]#\n";
				if ($tokens[$j] eq "" || ($tokens[$j] =~ /^($Art)$/i && $tokens[$j-1] !~ /^($Prep)$/i) ) { #se chegamos ao final de uma frase sem ponto ou se temos um artigo sem uma preposiçao precedente, paramos (Pablo el muchacho)
					$found=1;
				}elsif ( ($tokens[$j] !~ /^$UpperCase$LowerCase+/ ||  $Candidate =~ /($Punct)|($Punct_urls)/ ) &&
					#($tokens[$j] !~ /^($Prep)$/ && $tokens[$j+1] !~ /^($Art)$/ && $tokens[$j+1] !~ /^$UpperCase$LowerCase+/ )  )  { 
					($tokens[$j] !~ /^($Prep)$/i && $tokens[$j] !~ /^($Art)$/i )  )  { 
					#print  STDERR "4TOKEN::: ##$i## - ##$j## - ##$count##----> ##$tokens[$i]## - - #$tokens[$j]# --  #$tokens[$k]#\n" ;
					$found = 1;
				 }else {
					$Candidate .= $SEP . $tokens[$j] ;
					#$Nocandidate .=  " " . $tokens[$j] ; 
					$count++;
					#print STDERR "okk: #$Candidate#\n";                 
				}
			}
			#print STDERR "---------#$count# -- #$Candidate# - #$SEP#  - #$N#\n";

			if ( ($count > 1) && ($count <= $N) && ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/) &&  $Candidate !~ /$SEP($Prep)$/ && $Candidate !~ /$SEP($Prep)$SEP($Art)$/  ) {
				#print STDERR "----------#$Candidate#\n";
				$i = $i + $count - 1;
				$tokens[$i] =  $Candidate ; 
			}elsif ( ($count > 1) && ($count <= $N) && ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/) &&  $Candidate =~ /$SEP($Prep)$/i ) {
				$i = $i + $count - 2;
				$Candidate =~ s/$SEP($Prep)$//;  
				$tokens[$i] =  $Candidate ;
				#print STDERR "OK----------#$Candidate#\n";
			}elsif ( ($count > 1) && ($count <= $N) && ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/) &&  $Candidate =~ /$SEP($Prep)$SEP($Art)$/i ) {
				$i = $i + $count - 3;
				$Candidate =~ s/$SEP($Prep)$SEP($Art)$//i;  
				$tokens[$i] =  $Candidate ;
				#print STDERR "----------#$Candidate#\n"; 
			}elsif ( ($count > 1) && ($count <= $N) && ($Candidate !~ /$Punct$SEP/ || $Candidate !~ /$Punct_urls$SEP/) &&  $Candidate =~ /SEP($Art)$/i ) {
				$i = $i + $count - 2;
				$Candidate =~ s/$SEP($Art)$//i;  
				$tokens[$i] =  $Candidate ;
				#print STDERR "----------#$Candidate#\n"; 
			}
		}
		###FIM CONSTRUÇAO DOS NP COMPOSTOS##############################


		##NP se é composto
		if ($tokens[$i] =~ /[^\s]_[^\s]/ ) { 
			$Tag{$tokens[$i]} = "NP00000" ;
		}
		##se não lhe foi assigado o tag NP, entao UNK (provisional)
		elsif   (! $Tag{$tokens[$i]}) {
			$Tag{$tokens[$i]} = "UNK" ; 
		}

		##se é UNK (é dizer nao é NP), entao vamos buscar no lexico
		if ($Tag{$tokens[$i]} eq "UNK") {
			$token = lowercase ($tokens[$i]);
			if ($Lex->{$token}) {
				$Tag{$tokens[$i]} = $Entry->{$token};               
			}elsif ($tokens[$i] =~ /\-/) { ##se o token é composto, dever ser um sustantivo
				$Tag{$tokens[$i]} = "$tokens[$i] NC00000";
			}
		}elsif ($Tag{$tokens[$i]} eq "NP00000") {
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
		}
		##QUANTITIES
		elsif ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^$quant$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
			$Tag{$tokens[$i]} = "Z"; 
			$adiantar=1;
		}

		##DATES
		if ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^de$/i && $tokens[$i+2] =~ /^$meses$/i  && $tokens[$i+3] =~ /^de$/i && $tokens[$i+4] =~ /[0-9]+/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] . "_" . $tokens[$i+4]  ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
			$Tag{$tokens[$i]} = "W"; 
		$adiantar=4;	        
		}
		elsif ($tokens[$i] =~ /^$meses$/i  && $tokens[$i+1] =~ /^de$/i && $tokens[$i+2] =~ /^[0-9]+$/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] ;
			$token = lc ($tokens[$i]);
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=2;   
		}
		elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^de$/i && $tokens[$i+2] =~ /^$meses$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=2;   
		}
		#################################FIM DATAS E NUMEROS
		elsif ($Tag{$tokens[$i]} eq "UNK_UC") { 
			$Tag{$tokens[$i]} =  $Entry->{$tokens[$i]};
		}
		#agora etiquetamos os simbolos de puntuaçao
		elsif ($tokens[$i] eq "\.") {
			$token = "\.";
			$Tag{$tokens[$i]} = "Fp"; 
		}elsif ($tokens[$i] eq "#SENT#" && $tokens[$i-1] ne "\." && $tokens[$i-1] ne "<blank>" ){
			# print STDERR "--- #$tokens[$i]# #$tokens[$i-1]#\n";
			$tokens[$i] = "<blank>";
			$token = "<blank>";
			$Tag{$tokens[$i]} = "Fp"; 
		} elsif ($tokens[$i] =~ /^$Punct$/ || $tokens[$i] =~ /^$Punct_urls$/ || 
			$tokens[$i] =~ /^(\.\.\.|\`\`|\'\'|\<\<|\>\>|\-\-)$/ ) {
			$Tag{$tokens[$i]} = punct ($tokens[$i]);
			$token = $tokens[$i]; 
		#print STDERR "token: #$token# -- #$tokens[$i]# -- #$Tag{$tokens[$i]}# \n";
		}
		##as linhas em branco eliminam-se 
		if ($tokens[$i] eq  "#SENT#") {
			next;
		}

		#################CASOS AMBIGUOS (dese(s), destes pelo, pola(s)...)
   
		if ($tokens[$i] =~ /^dese$/i && $tokens[$i+1] !~ /^$Det$/i) {
			if($pipe){#<ignore-line>
				print "de de SPS00\n";#<ignore-line>
				print "ese ese DD0MS0 ese PD0MS000\n";#<ignore-line>
			}else{#<ignore-line>
				push(@saida,"de de SPS00");
				push(@saida,"ese ese DD0MS0 ese PD0MS000");
			}#<ignore-line>
		}elsif ($tokens[$i] =~ /^deses$/i && $tokens[$i+1] !~ /^$Det$/i) {
			if($pipe){#<ignore-line>
				print "de de SPS00\n";#<ignore-line>
				print "ese ese DD0MP0 ese PD0MP000\n";#<ignore-line>  
			}else{#<ignore-line>
				push(@saida,"de de SPS00");
				push(@saida,"ese ese DD0MP0 ese PD0MP000");
			}#<ignore-line>
		}
		#elsif ($tokens[$i] =~ /^deste$/i && $tokens[$i+1] !~ /^$Det$/i) { ##forma nom normativa
			#$saida  = "de de SPS00";  
			#push (@saida, $saida);
			#$saida  = "este este DD0MS0 este PD0MS000";  
			#push (@saida, $saida);
		#}
		elsif ($tokens[$i] =~ /^destes$/i && $tokens[$i+1] !~ /^$Det|$PrepCompl$/i) {
			if($pipe){#<ignore-line>
				print "de de SPS00\n";#<ignore-line> 
				print "ese este DD0MP0 ese PD0MP000\n";#<ignore-line>
			}else{#<ignore-line>
				push(@saida,"de de SPS00");
				push(@saida,"ese este DD0MP0 ese PD0MP000");
			}#<ignore-line>
		}elsif ($tokens[$i] =~ /^polo$/i && $tokens[$k] !~ /^$Det/i &&  $tokens[$j] !~ /$PrepCompl/i ) {
			if($pipe){#<ignore-line>
				#print STDERR "i:#$tokens[$i]# - j:#$tokens[$j]# - k:#$tokens[$k]# -- tag1 #$Tag{$tokens[$i]}# tag+1 #$Tag{$tokens[$j]}# tag-1 #$Tag_ant{$tokens[$k]}# \n";
				print "por por SPS00\n";#<ignore-line>  
				print "o o DA0MS0\n";#<ignore-line>  
			}else{#<ignore-line>
				push(@saida,"por por SPS00");
				push(@saida,"o o DA0MS0");
			}#<ignore-line>
		}elsif ($tokens[$i] =~ /^polos$/i && $tokens[$k] !~ /^$Det/i &&  $tokens[$j] !~ /$PrepCompl/i ) {
			if($pipe){#<ignore-line>
				print "por por SPS00\n";  
				print "o os DA0MS0\n"; 
			}else{#<ignore-line>
				push(@saida,"por por SPS00");
				push(@saida,"o os DA0MS0");
			}#<ignore-line>
		}
		#elsif ($tokens[$i] =~ /^pola$/i && $tokens[$k] !~ /^$Det/i &&  $tokens[$j] !~ /$PrepCompl/i) {
			#print STDERR "#$tokens[$i]# #$Tag{$tokens[$i]}# #$tokens[$i+1]# #$Det# \n";
			#$saida  = "por por SPS00";  
			#push (@saida, $saida);
			#$saida  = "a o DA0FS0";  
			#push (@saida, $saida);
		#}
		#elsif ($tokens[$i] =~ /^polas$/i && $tokens[$k] !~ /^$Det/i &&  $tokens[$j] !~ /$PrepCompl/i) {
			#$saida  = "por por SPS00";  
			#push (@saida, $saida);
			#$saida  = "as o DA0FP0";  
			#push (@saida, $saida);
		#}  
		else {
			##parte final..
			$Tag{$tokens[$i]} = $token . " " . $Tag{$tokens[$i]} if ( $Tag{$tokens[$i]} =~ /^(UNK|F|NP|Z|W)/  );
			if($pipe){#<ignore-line>
				print "$tokens[$i] $Tag{$tokens[$i]}\n";#<ignore-line>
			}else{#<ignore-line>
				push(@saida,"$tokens[$i] ".$Tag{$tokens[$i]});
			}#<ignore-line>
		}
		if($tokens[$i] eq "\." or $tokens[$i] eq "<blank>"){
			if($pipe){#<ignore-line>
				print "\n";#<ignore-line>
			}else{#<ignore-line>
				push (@saida, "");
			}#<ignore-line>
		}

		$Tag_ant{$tokens[$i]} = $Tag{$tokens[$i]}  if ($Tag{$tokens[$i]});

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
