#!/usr/bin/env perl

#ProLNat NER 
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela

package Ner;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
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
my $UpperCase = qr/\p{Uppercase}/;#<string>
my $LowerCase = qr/\p{Lowercase}/;#<string>
my $Punct =  qr/[\,\;\«\»\“\”\'\"\&\$\#\=\(\)\<\>\!\¡\?\¿\\\[\]\{\}\|\^\*\€\·\¬\…\-\+]/;#<string>
my $Punct_urls = qr/[\:\/\~]/;#<string>
my $w = qr/\p{Letter}/;#<string>

##########CARGANDO RECURSOS COMUNS
##cargando o lexico freeling e mais variaveis globais
my %Ambig=();#<hash><boolean>
##carregando palavras ambiguas
while (my $t = <$AMB>) {#<string>
	$t = Trim ($t);
	$Ambig{$t}=1;
}



######################info dependente da língua!!!####################################################################################
my $Prep = "(de|da|do|von)";#<string>  ##preposiçoes que fazem parte dum NP composto
my $Art = "(o|a|os|as)";#<string> ##artigos que fazem parte dum NP composto
my $Det = "(o|a|os|as|um|uma|uns|umas|algum|alguns|alguma|algumas|todo|todos|toda|todas|vários|várias)";#<string> ##determinantes par ver o contexto das ambiguas: desse, pelo...
my $currency = "(euro|euros|dólar|dólares|peseta|pesetas|yen|yenes|escudo|escudos|franco|francos|real|reais|€|$|ރ|aed|afegane|afn|agora|all|amd|ang|aoa|apsar|ar|ariari|ars|att|aud|avo|awg|azn|b/.|baht|baisa|balboa|bam|ban|bbd|bdt|bgn|bhd|bif|birr|bmd|bnd|bob|boliviano|bolívar|br|brl|bs|bs.|bsd|btn|butu|bwp|byr|bzd|c$|cad|cdf|cedi|cent|centavo|centésimo|chetrum|chf|chon|clp|cny|colón|cop|copeque|coroa|crc|cuc|cup|cve|czk|cêntimo|córdoba|dalasi|db|deni|din|dinar|dirame|djf|dkk|dobrae|dongue|dop|dram|dzd|dólar|egp|ern|esc|escudo|etb|eur|euro|eyrir|fen|fils|fjd|fkp|florim|fr|franco|ft|gbp|gel|ghs|gip|gmd|gnf|grosz|grívnia|gtq|guarani|gurde|gyd|halala|haléř|hkd|hnl|hrk|htg|huf|hào|idr|iene|ils|imp|inr|iqd|iraimbilanja|irr|isk|iuane|jeon|jep|jmd|jod|jpy|k|kes|kgs|khoums|khr|kina|kipe|km|kmf|kn|kobo|kopiyka|kpw|kr|krw|ks|kuna|kuruş|kwacha|kwanza|kwd|kyat|kyd|kz|kzt|kč|laari|lak|lari|lbp|le|lei|lek|lempira|leone|leu|lev|libra|lilangeni|lipa|lira|lkr|loti|lrd|lsl|luma|lyd|mad|manat|marco|mdl|metical|mga|milésimo|mk|mkd|mmk|mnt|mop|mro|mt|mur|mvr|mwk|mxn|myr|mzn|möngö|nad|naira|nakfa|nehum|nfk|ngn|ngultrum|ngwee|nio|nok|npr|nu|nzd|omr|oyra|p|pab|paisa|pataca|paʻanga|pen|peseta|pesewa|peso|pgk|php|piastra|pkr|pln|pnb|ptas|pul|pula|pya|pyg|q|qar|qindarkë|quetzal|qəpik|r$|rand|real|rial|riel|ringuite|rm|ron|rp|rsd|rub|rublo|rupia|rwf|sar|satang|sbd|scr|sdg|sek|sen|sgd|sh|shp|siclo|sll|sol|som|somoni|sos|srd|ssp|std|stotinka|syp|szl|t|t$|taka|tala|tambala|tengue|tennesi|tetri|thb|thebe|tjs|tmt|tnd|toea|top|try|ttd|tugrik|twd|tyiyn|tzs|tïın|uah|uguia|ugx|um|usd|uyu|uzs|vatu|ves|vnd|vt|vuv|won|wst|xaf|xcd|xelim|xof|yer|zar|zk|zlóti|zmk|zł|£|¥|öre|øre|ƒ|condorim|maz|braça|vara|toesa|passo|palmo|polegada|linha|braça|moio|fanga|alqueire|maquia|selamim|meio-selamim|quarto|tonel|toneis|cântaro|pipa|almude|pote|canada)";#<string>
my $measure = "(kg|kilogramo|quilogramo|gramo|g|centímetro|cm|hora|segundo|minuto|tonelada|tn|metro|m|km|kilómetro|quilómetro|µm|dia|ano|%|a/m|a/m²|ac|acre|ag|al|am|ampère|am²|ano|ano-luz|are|arroba|arrátel|atm|atmosfera|attograma|attolitro|attômetro|b|bar|barn|barril|becquerel|bel|bimestre|biênio|bq|byte|c|cal|caloria|candela|cavalo-vapor|cd|cd·m²|celsius|centigrama|centilitro|centipoise|centímetro|cg|cl|cm|cm/s|cmhg|cm²|cm³|corrente|coulomb|cv|d|dag|dal|dalton|dam|dam²|dam³|dau|decagrama|decalitro|decigrama|decilitro|decâmetro|decímetro|delisle|dg|dia|diel|dina|dine|dl|dm|dm²|dm³|dracma|dunam|dyn|eb|eg|ehz|eib|em²|escrópulo|esterradiano|ev|ev/c²|exabyte|exagrama|exahercio|exalitro|exametro|exbibyte|f|fahrenheit|farad|femtograma|femtolitro|femtômetro|fentômetro|fg|fl|fm|fm²|frigurina|ft|ft/s|ft²|furlong|g|g/ml|galão|gauss|gb|gf|gg|ghz|gib|gibibyte|gigabyte|gigagrama|gigahercio|gigalitro|gigametro|gigapascal|gill|gl|gm|gm²|gpa|gradiano|grado|grama|grau|gray|grão|gy|h|habitante|hectare|hectograma|hectolitro|hectômetro|henry|hertz|hg|hl|hm|hm²|hm³|homestead|hora|hz|in²|ipc|j|jarda|joule|k|kat|katal|kb|kcal|kelvin|kg/l|kg/m³|kgf|kib|kibibyte|kilobyte|kilonewton|kj|kl|km|km/h|km/s|km²|km³|kn|kpa|kw|kwh|l|lb|lb/bu|lb/ft³|lb/gal|lb/in³|lb/yd³|lbf|libra|libra-força|litro|lm|lux|lx|légua|lúmen|m|mca|m/s|mag|mb|mebibyte|megabyte|megagrama|megahert|megalitro|megametro|megapascal|megawatt|meio-quartilho|mercúrio|metro|mg|mhz|mib|micrograma|microlitro|micrômetro|mil|milha|miligrama|mililitro|milénio|milênio|milímetro|min|minim|minuto|miriagrama|ml|mm|mm/s|mmhg|mm²|mm³|mol|mol/m³|mpa|mph|mps|mwt|m²|m³|métrico|mês|n|n/m³|nanograma|nanolitro|nanômetro|neper|newton|newton/metro|ng|nl|nm|nm²|np|nó|ohm|oitava|onça|oz|oz/in³|p|pa|parsec|pascal|pascal-segundo|pb|pe|pebibyte|petabyte|petagrama|petahercio|petalitro|petametro|pg|phz|pib|picograma|picolitro|picômetro|pinto|pl|pm|pm²|poise|polegada|ponto|pé|q|quadrimestre|quadriênio|quartilho|quarto|quilate|quilocaloria|quilograma|quilojoule|quilolitro|quilopascal|quilowatt|quilômetro|quinquênio|quintal|quintais|quintalejo|quinzena|rad|rad/s|rad/s²|radiano|rankine|rod|rood|rotação|rpm|réaumur|rø|rømer|s|saeculum|segundo|semana|semestre|siemens|sievert|slug|slug/ft³|sr|stoke|sv|século|t|tb|tebibyte|terabyte|teragrama|terahercio|teralitro|terametro|termia|tesla|tex|tg|thz|tib|tl|tm|tm²|tonelada|trimestre|triênio|ua|unidade-astronômica|v|va|vintém-de-ouro|volt|volt-ampère|voltampere|w|w/m²watt|watt|wb|weber|yb|yottabyteipm|yd|yd²|yg|yib|yl|ym|ym²|yobibyte|yoctograma|yoctolitro|yoctômetro|yottagrama|yottalitro|yottametro|zb|zebibyte|zeptograma|zeptolitro|zeptômetro|zettabyte|zettagrama|zettalitro|zettametro|zg|zib|zl|zm|zm²|°|°c|°d|°f|°n|°ra|°ré|µg|µl|µm|µm²|ω)";#<string>
my $quant = "(cento|centos|miles|milhão|milhões|bilhão|bilhões|trilhão|trilhões)"; #<string>
my $cifra = "(dois|duas|três|quatro|cinco|seis|sete|oito|nove|dez|onze|doze|treze|catorze|quinze|dezesseis|dezessete|dezoito|dezenove|vinte|trinta|quarenta|cinquenta|sessenta|setenta|oitenta|noventa|cem|mil)";#<string>  ##hai que criar as cifras básicas: once, doce... veintidós, treinta y uno...
my $meses =  "(Janeiro|Fevereiro|Março|Abril|Maio|Junho|Julho|Agosto|Setembro|Outubro|Novembro|Dezembro)";#<string>
my $semana = "(segunda-feira|terça-feira|quarta-feira|quinta-feira|sexta-feira|sábado|domingo)";#<string>
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
		my $k = $i - 1;#<string>
		my $j = $i + 1;#<string>
		
		####CADEA COM TODAS PALAVRAS EM MAIUSCULA
		if ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$j] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$j])} ) {
			$Tag{$tokens[$i]} = "UNK"; ##identificamos cadeas de tokens so em maiusculas e estao no dicionario
		}elsif   ($tokens[$i] =~ /^$UpperCase+$/ && $tokens[$k] =~ /^$UpperCase+$/ && $Lex->{$lowercase} && $Lex->{lowercase($tokens[$k])} &&
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
		}elsif ( $tokens[$i] =~ /^$UpperCase/ && $Ambig{$lowercase} ) { ##começa por maiúscula e e um nome proprio ambiguo no dicionario
			$Tag{$tokens[$i]} = "NP00000";
		}elsif (($tokens[$i] =~ /^$UpperCase/) &&  !$StopWords->{$lowercase} && 
			$tokens[$k] !~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡|\?|\!|\:|\`\`)$/ && $tokens[$k] !~ /^\.\.\.$/  && $i>0 ) { ##começa por maiúscula e nao vai a principio de frase
			$Tag{$tokens[$i]} = "NP00000"; 
			#print "TOKEN::: ##$tokens[$i]## K=#$tokens[$k]#\n" ;
			#print  STDERR "1TOKEN::: ##$i## --  ##$tokens[$i]## - - #$Tag{$tokens[$i]}# --  prev:#$tokens[$k]# --  post:#$tokens[$j]#\n" if ($tokens[$i] eq "De");
		}elsif (($tokens[$i] =~ /^$UpperCase/ &&  !$StopWords->{$lowercase} && 
			$tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡|\?|\!|\:|\`\`)$/) || ($i==0) ) { ##começa por maiúscula e vai a principio de frase 
			#$token = lowercase ($tokens[$i]);
			# print STDERR "2TOKEN::: lowercase: #$lowercase# -- token: #$tokens[$i]# --  token_prev: #$tokens[$k]# --  post:#$tokens[$j]#--- #$Tag{$tokens[$i]}#\n" if ($tokens[$i] eq "De");       
			if (!$Lex->{$lowercase} || $Ambig{$lowercase}) {
				#print STDERR "--AMBIG::: #$lowercase#\n";
				$Tag{$tokens[$i]} = "NP00000"; 
				#print STDERR "OKKKK::: lowercase: #$lowercase# -- token: #$tokens[$i]# --  token_prev: #$tokens[$k]#  --  post:#$tokens[$j]#\n" ;       
			}
			# print STDERR "##$tokens[$i]## -  #$tokens[$k]#\n" if ($tokens[$i] eq "De");
		}

		##if ( $tokens[$i] =~ /^$UpperCase$LowerCase+/ && ($StopWords->{$lowercase} && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\¿|\¡)$/) || ($i==0)) ) {   }##se em principio de frase a palavra maiuscula e uma stopword, nao fazemos nada

		if( ($tokens[$i] =~ /^$UpperCase$LowerCase*/ && $Lex->{$lowercase} &&  !$Ambig{$lowercase}) && ($tokens[$k]  =~ /^(\#SENT\#|\<blank\>|\"|\“|\«|\.|\-|\s|\?|\!|\:|\`\`)$/ || $i==0) ) {         
			#print  STDERR "1TOKEN::: ##$lowercase## // #!$Ambig{$lowercase}# - - #$Tag{$tokens[$i]}# --  #$tokens[$k]#\n" ;      
		}##se em principio de frase a palavra maiuscula e está no lexico sem ser ambigua, nao fazemos nada
		##caso que seja maiuscula
		###construimos candidatos para os NOMES PROPRIOS COMPOSTOS#############################################################
		elsif  ($tokens[$i] =~ /^$UpperCase$LowerCase*/) {
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
				}elsif ( ($tokens[$j] !~ /^$UpperCase$LowerCase*/ ||  $Candidate =~ /($Punct)|($Punct_urls)/ ) &&
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
		if ($tokens[$i] =~ /[^\s]_[^\s]/ and !$Lex->{lowercase($tokens[$i])}) {
			$Tag{$tokens[$i]} = "NP00000" ;
		}
		##se não lhe foi assigado o tag NP, entao UNK (provisional)
		elsif   (! $Tag{$tokens[$i]}) {
			$Tag{$tokens[$i]} = "UNK"; 
		}
                ##Numeros romanos 
                elsif ($tokens[$i] =~ /^$UpperCase/ && $Entry->{$tokens[$i]} =~ / Z$/) {
                    $Tag{$tokens[$i]} = $Entry->{$tokens[$i]};
                    #print STDERR "OKK $tokens[$i] - #$Tag{$tokens[$i]}#\n";
                }
		##se é UNK (é dizer nao é NP), entao vamos buscar no lexico
		if ($Tag{$tokens[$i]} eq "UNK") {
			$token = lowercase ($tokens[$i]);
			if ($Lex->{$token}) {
				$Tag{$tokens[$i]} = $Entry->{$token};
			} elsif ($tokens[$i] =~ /\-/) { ##se o token é composto, dever ser um sustantivo
				$Tag{$tokens[$i]} = "$tokens[$i] NC00000";
			}
		}elsif ($Tag{$tokens[$i]} eq "NP00000") {
			$token = lowercase ($tokens[$i]); 
		}
		$adiantar=0;
		##os numeros, medidas e datas #USAR O FICHEIRO QUANTITIES.DAT##################
		#print STDERR "token1->#$tokens[$i]# tag1->#$Tag{$tokens[$i]}#\n";
		##CIFRAS OU NUMEROS
		if ($tokens[$i] =~ /^[0-9]+$/ || $tokens[$i] =~ /^$cifra$/) {
			$token = $tokens[$i];
			$Tag{$tokens[$i]} = "Z"; 
		       #	print STDERR "OKKK-$Tag{$tokens[$i]} -$tokens[$i+1] - $tokens[$i+2] - $tokens[$i+3]\n"  if($tokens[$i+3] =~ /^$currency$/i);
		}         
              #  print STDERR "--$tokens[$i] $tokens[$i+1] - $tokens[$i+2] - $tokens[$i+3]\n" if ($tokens[$i] =~ /^$semana$/ && $Tag{$tokens[$i+1]} =~ /^Z/  && $tokens[$i+2] =~ /^de$/i && $tokens[$i+3] =~ /^$meses$/i  && $tokens[$i+4] =~ /^de$/i && $tokens[$i+5] =~ /[0-9]+/ );
 #             print STDERR "--$tokens[$i] $tokens[$i+1]/$Tag{$tokens[$i+1]} - $tokens[$i+2] - $tokens[$i+3]\n" if ($tokens[$i] =~ /^$semana$/ );

		##MEAUSURES
		if ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^$measure(s|\.)?$/i && $tokens[$i+2] =~ /^(quadrado|cúbico)(s)?$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2];
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "Zu"; 
			$adiantar=2 ;
		}  
		elsif ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^$measure(s|\.)?$/i && $tokens[$i+2] =~ /^por$/ && $tokens[$i+3] =~ /^$measure(s|\.)?$/i && $tokens[$i+4] =~ /^(quadrado|cúbico)(s)?$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] . "_" . $tokens[$i+4];
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "Zu"; 
			$adiantar=4 ;
		}  
		elsif  ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^$measure(s|\.)?$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: kg=kilogramo,...
			$Tag{$tokens[$i]} = "Zu";
			#print STDERR "measure-->#$tokens[$i]#\n";
			$adiantar=1 ;
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$quant$/i &&  $tokens[$i+2] =~ /^$measure(s|\.)?$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2]  ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "Zu"; 
			$adiantar=2;	        
		}
		##CURRENCY
		elsif ($Tag{$tokens[$i]} =~ /^Z/ && $tokens[$i+1] =~ /^$currency(s|\.)?$/i) {
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
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$quant$/i && $tokens[$i+2] =~ /^de$/i && $tokens[$i+3] =~ /^$currency(s|\.)?$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
			$Tag{$tokens[$i]} = "Zm"; 
			$adiantar=3;	        
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^$quant$/i && $tokens[$i+2] =~ /^$currency(s|\.)?$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2]  ;
			$token = lc ($tokens[$i]); ##haveria que lematizar/normalizar o token: euros=euro...
			$Tag{$tokens[$i]} = "Zm"; 
			$adiantar=2;	        
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^de$/i && $tokens[$i+2] =~ /^$currency(s|\.)?$/i) {
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
			$adiantar=1 ;
		}   
		
	        ##DATES
		elsif ($tokens[$i] =~ /^$semana$/i && $tokens[$i+1] =~ /\,/ && $tokens[$i+2] =~ /^[0-9]/  && $tokens[$i+3] =~ /^de$/i && $tokens[$i+4] =~ /^$meses$/i  && $tokens[$i+5] =~ /^de$/i && $tokens[$i+6] =~ /[0-9]+/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] . "_" . $tokens[$i+4] . "_" . $tokens[$i+5] . "_" . $tokens[$i+6]  ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=6;   
		}elsif ($tokens[$i] =~ /^$semana$/i && $tokens[$i+1] =~ /^[0-9]/  && $tokens[$i+2] =~ /^de$/i && $tokens[$i+3] =~ /^$meses$/i  && $tokens[$i+4] =~ /^de$/i && $tokens[$i+5] =~ /[0-9]+/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] . "_" . $tokens[$i+4] . "_" . $tokens[$i+5]  ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=5;	        
		}
			elsif ($tokens[$i] =~ /^$semana$/i && $tokens[$i+1] =~ /\,/ && $tokens[$i+2] =~ /^[0-9]/  && $tokens[$i+3] =~ /^de$/i && $tokens[$i+4] =~ /^$meses$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] . "_" . $tokens[$i+4]  ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=4;   
		}elsif ($tokens[$i] =~ /^$semana$/i && $tokens[$i+1] =~ /^[0-9]/  && $tokens[$i+2] =~ /^de$/i && $tokens[$i+3] =~ /^$meses$/i ) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3]   ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=3;	        
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^de$/i && $tokens[$i+2] =~ /^$meses$/i  && $tokens[$i+3] =~ /^de$/i && $tokens[$i+4] =~ /[0-9]+/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3] . "_" . $tokens[$i+4]  ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=4;	        
		}elsif ($tokens[$i] =~ /^$meses$/i  && $tokens[$i+1] =~ /^de$/i && $tokens[$i+2] =~ /^[0-9]+$/) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] ;
			$token = lc ($tokens[$i]);
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=2;   
		}elsif ($Tag{$tokens[$i]} =~ /^Z/  && $tokens[$i+1] =~ /^de$/i && $tokens[$i+2] =~ /^$meses$/i) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]  . "_" . $tokens[$i+2] ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=2;   
		}elsif ($tokens[$i-1] =~ /^(em)$/i && $tokens[$i] =~ /^[12]?[0-9][0-9][0-9]$/  ) {
			#$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3]   ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=0;	        
		}elsif ($tokens[$i] =~ /^(ano|século)$/i && ($tokens[$i+1] =~ /^[0-9IXCVIM][^a-z]/ || $tokens[$i+1] =~ /^[0-9IXCVIM]$/) ) {
			$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1]    ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=1;	        
		}elsif ($tokens[$i] =~ /^$semana$/i ) {
			#$tokens[$i] = $tokens[$i] . "_" . $tokens[$i+1] . "_" . $tokens[$i+2] . "_" . $tokens[$i+3]   ;
			$token = lc ($tokens[$i]); 
			$Tag{$tokens[$i]} = "W"; 
			$adiantar=0;	        
		}
		#################################FIM DATAS E NUMEROS
		##etiquetamos UNK_UC (Abril, Maio...)
		elsif ($Tag{$tokens[$i]} eq "UNK_UC") { 
			$Tag{$tokens[$i]} =  $Entry->{$tokens[$i]};
		}#agora etiquetamos os simbolos de puntuaçao
		elsif ($tokens[$i] eq "\.") {
			$token = "\.";
			$Tag{$tokens[$i]} = "Fp"; 
		}elsif ($tokens[$i] eq "#SENT#" && $tokens[$i-1] ne "\." && $tokens[$i-1] ne "<blank>" ){
			#print STDERR "--- #$tokens[$i]# #$tokens[$i-1]#\n";
			$tokens[$i] = "<blank>";
			$token = "<blank>";
			$Tag{$tokens[$i]} = "Fp"; 
		}elsif ($tokens[$i] =~ /^$Punct$/ || $tokens[$i] =~ /^$Punct_urls$/ || 
			$tokens[$i] =~ /^(\.\.\.|\`\`|\'\'|\<\<|\>\>|\-\-)$/ ) {
			$Tag{$tokens[$i]} = punct ($tokens[$i]);
			$token = $tokens[$i]; 
			#print STDERR "token: #$token# -- #$tokens[$i]# -- #$Tag{$tokens[$i]}# \n";
		}
		##as linhas em branco eliminam-se 
		if ($tokens[$i] eq  "#SENT#") {
			next;
		}
		#print STDERR "token2->#$tokens[$i]# tag2->#$Tag{$tokens[$i]}#\n"; 
		#################CASOS AMBIGUOS (desse(s), deste(s) pelo, pela(s)...)
	#	if (0) { ##multiline comments
		if ($tokens[$i] =~ /^desse$/i && $tokens[$i+1] !~ /^$Det$/i) {
			if($pipe){#<ignore-line>
				print "de de SPS00\n";#<ignore-line>
				print  "esse esse DD0MS0 esse PD0MS000\n";#<ignore-line> 
			}else{#<ignore-line>
				push(@saida,"de de SPS00");
				push(@saida,"esse esse DD0MS0 esse PD0MS000");
			}#<ignore-line>
		}elsif ($tokens[$i] =~ /^desses$/i && $tokens[$i+1] !~ /^$Det$/i) {
			if($pipe){#<ignore-line>
				print "de de SPS00\n";#<ignore-line>
				print "esse esse DD0MP0 esse PD0MP000\n";#<ignore-line> 
			}else{#<ignore-line>
				push(@saida,"de de SPS00");
				push(@saida,"esse esse DD0MP0 esse PD0MP000");
			}#<ignore-line>
		}elsif ($tokens[$i] =~ /^deste$/i && $tokens[$i+1] !~ /^$Det$/i) {
			if($pipe){#<ignore-line>
				print "de de SPS00\n";#<ignore-line>  
				print "este este DD0MS0 este PD0MS000\n";#<ignore-line>  
			}else{#<ignore-line>
				push(@saida,"de de SPS00");
				push(@saida,"este este DD0MS0 este PD0MS000");
			}#<ignore-line>
		}elsif ($tokens[$i] =~ /^destes$/i && $tokens[$i+1] !~ /^$Det$/i) {
			if($pipe){#<ignore-line>
				print "de de SPS00\n";#<ignore-line>  
				print "esse este DD0MP0 esse PD0MP000\n";#<ignore-line>  
			}else{#<ignore-line>
				push(@saida,"de de SPS00");
				push(@saida,"esse este DD0MP0 esse PD0MP000");
			}#<ignore-line>
		}elsif ($tokens[$i] =~ /^pelo$/i && $tokens[$i+1] !~ /^$Det$/i) {
			if($pipe){#<ignore-line>
				print "por por SPS00\n";#<ignore-line>  
				print "o o DA0MS0\n";#<ignore-line>  
			}else{#<ignore-line>
				push(@saida,"por por SPS00");
				push(@saida,"o o DA0MS0");
			}#<ignore-line>
		}elsif ($tokens[$i] =~ /^pela$/i && $tokens[$i+1] !~ /^$Det$/i) {
			if($pipe){#<ignore-line>
				#print STDERR "#$tokens[$i]# #$Tag{$tokens[$i]}# #$tokens[$i+1]# #$Det# \n";
				print "por por SPS00\n";#<ignore-line>  
				print "a o DA0FS0\n";#<ignore-line>  
			}else{#<ignore-line>
				push(@saida,"por por SPS00");
				push(@saida,"a o DA0FS0");
			}#<ignore-line>
		}elsif ($tokens[$i] =~ /^pelas$/i && $tokens[$i+1] !~ /^$Det$/i) {
			if($pipe){#<ignore-line>
				print "por por SPS00\n";#<ignore-line>  
				print "as o DA0FP0\n";#<ignore-line>
			}else{#<ignore-line>
				push(@saida,"por por SPS00");
				push(@saida,"as o DA0FP0");
			}#<ignore-line>
	#	} ##end comment
		}else {
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

       
