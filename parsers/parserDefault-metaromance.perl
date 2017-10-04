#!/usr/bin/env perl
package Parser;

use strict;#<ignore-line>
binmode STDIN, ':utf8';#<ignore-line>
binmode STDOUT, ':utf8';#<ignore-line>
binmode STDERR, ':utf8';#<ignore-line>
use utf8;#<ignore-line>
  
# Pipe
my $pipe = !defined (caller);#<ignore-line>   
  
#fronteira de frase:
my $Border="SENT";#<string>

#identificar nomes de dependencias lexicais (idiomaticas)
my $DepLex = "^<\$|^>\$|lex\$";#<string>

#string com todos os atributos:
my $b2 = "[^ _<>]*";#<string>

my $a2 = "\\_<${b2}>";##<string>todos os atributos
my $l =  "\\_<${b2}";##<string>atributos parte esquerda
my $r =  "${b2}>";##<string>atributos parte direita


###########################GENERATED CODE BY COMPI#############################################

######################################## POS TAGS ########################################
my $ADJ = "ADJ_[0-9]+";#<string>
my $NOUN = "NOUN_[0-9]+";#<string>
my $PRP = "PRP_[0-9]+";#<string>
my $ADV = "ADV_[0-9]+";#<string>
my $CARD = "CARD_[0-9]+";#<string>
my $CONJ = "CONJ_[0-9]+";#<string>
my $DT = "DT_[0-9]+";#<string>
my $PRO = "PRO_[0-9]+";#<string>
my $VERB = "VERB_[0-9]+";#<string>
my $I = "I_[0-9]+";#<string>
my $DATE = "DATE_[0-9]+";#<string>
my $POS = "POS_[0-9]+";#<string>
my $PCLE = "PCLE_[0-9]+";#<string>
my $EX = "EX_[0-9]+";#<string>
my $Fc = "Fc_[0-9]+";#<string>
my $Fg = "Fg_[0-9]+";#<string>
my $Fz = "Fz_[0-9]+";#<string>
my $Fe = "Fe_[0-9]+";#<string>
my $Fd = "Fd_[0-9]+";#<string>
my $Fx = "Fx_[0-9]+";#<string>
my $Fpa = "Fpa_[0-9]+";#<string>
my $Fpt = "Fpt_[0-9]+";#<string>
my $Fca = "Fca_[0-9]+";#<string>
my $Fct = "Fct_[0-9]+";#<string>
my $SENT = "SENT_[0-9]+";#<string>
my $SYM = "SYM_[0-9]+";#<string>
my $NOUNCOORD = "CONJ_[0-9]+${l}coord:noun${r}|NOUN_[0-9]+";#<string>
my $NP = "NOUN_[0-9]+$a2|CARD_[0-9]+$a2|PRP_[0-9]+${l}nomin:yes${r}|VERB_[0-9]+${l}nomin:yes${r}";#<string>
my $NOMINAL = "NOUN_[0-9]+$a2|PRP_[0-9]+${l}nomin:yes${r}|VERB_[0-9]+${l}nomin:yes${r}";#<string>
my $NOUNS = "NOUN_[0-9]+$a2|CARD_[0-9]+$a2|DATE_[0-9]+";#<string>
my $X = "[A-Z]+_[0-9]+";#<string>
my $NOTVERB = "[^V][^E]+_[0-9]+";#<string>
my $PUNCT = "F[a-z]+_[0-9]+";#<string>



#################################### LEXICAL CLASSES #####################################
my $Quant  = "(?:very\|more\|less\|quite\|muy\|mucho\|bastante\|bien\|casi\|muy\|realmente\|considerablemente\|bem\|ben\|menos\|poco\|mui\|moi\|muito\|más\|mais\|pouco\|peu\|assez\|plus\|moins\|massa\|força\|prou\|més\|menys\|tant\|molt\|bastant\|gaire\|)";#<string>
my $CCoord  = "(?:and\|y\|e\|or\|o\|ou\|i\|ni\|nin\|nem\|né\|nor\|sau\|ori\|și\|nici\|et\|)";#<string>
my $Partitive  = "(?:de\|of\|di\|)";#<string>
my $PrepLocs  = "(?:a\|de\|por\|par\|by\|to\|)";#<string>
my $PrepRA  = "(?:de\|di\|com\|con\|sobre\|sem\|sen\|entre\|of\|with\|about\|without\|between\|for\|on\|avec\|sûr\|amb\|cu\|)";#<string>
my $PrepMA  = "(?:hasta\|até\|hacia\|desde\|em\|en\|în\|para\|since\|until\|at\|in\|for\|to\|jusqu
\|depuis\|pour\|per\|fins\|pentru\|)";#<string>
my $AdvDe  = "(?:cerca\|lejos\|acerca\|alrededor\|longe\|lonxe\|perto\|arredor\|preto\|prop\|fora\|fuera\|fóra\|)";#<string>
my $cliticopers  = "(?:lo\|la\|los\|las\|le\|les\|nos\|os\|me\|te\|se\|Lo\|La\|Las\|Le\|Les\|Nos\|Os\|Me\|Te\|Se\|lle\|lles\|lhe\|lhes\|Lles\|Lhes\|Lle\|Lhe\|che\|ches\|Che\|Ches\|o\|O\|a\|A\|em\|et\|el\|es\|en\|em\|es\|el\|els\|)";#<string>
my $cliticoInd  = "(?:le\|les\|nos\|os\|me\|te\|Le\|Les\|Nos\|Me\|Te\|lle\|lles\|lhe\|lhes\|Lles\|Lhes\|Lle\|Lhe\|che\|ches\|Che\|Ches\|em\|et\|es\|)";#<string>
my $cliticoDir  = "(?:lo\|la\|los\|las\|le\|les\|nos\|os\|me\|te\|Lo\|La\|Las\|Nos\|Os\|Me\|Te\|o\|O\|a\|A\|em\|et\|el\|es\|els\|)";#<string>
my $Month  = "(?:enero\|xaneiro\|janeiro\|febrero\|febreiro\|fevereiro\|marzo\|março\|abril\|mayo\|maio\|junio\|xuño\|junho\|julio\|xullo\|julho\|agosto\|septiembre\|setembro\|octubre\|outubro\|noviembre\|novembro\|diciembre\|decembro\|dezembro\|)";#<string>
my $Day  = "(?:semana\|mes\|mês\|día\|dia\|lunes\|luns\|segunda-feira\|martes\|terça-feira\|terza\|miércoles\|mércores\|quarta-feira\|jueves\|xoves\|quinta-feira\|viernes\|venres\|sexta-feira\|sábado\|domingo\|)";#<string>
my $PROperssuj = "(?:yo\|tú\|usted\|él\|ella\|nosotros\|vosotros\|ellos\|ellas\|ustedes\|eu\|ti\|tu\|vostede\|vocé\|el\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocés\|eles\|elas\|)";#<string>
my $PROsujgz = "(?:eu\|ti\|tu\|vostede\|vocé\|el\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocés\|eles\|elas\|)";#<string>
my $VModalEN  = "(?:can\|cannot\|should\|must\|shall\|will\|would\|may\|might\|)";#<string>
my $VModal   = "(?:poder\|deber\|dever\|)";#<string>
my $VPerif  = "(?:ir\|deber\|venir\|empezar\|comenzar\|acabar\|finalizar\|terminar\|dejar\|pasar\|estar\|vir\|comezar\|passar\|dever\|deixar\|hacer\|fazer\|facer\|)";#<string>
my $NincSp  = "(?:alusión\|comentario\|referencia\|llamamiento\|mención\|observación\|declaración\|propuesta\|pregunta\|)";#<string>
my $NincExp  = "(?:afecto\|alegría\|amparo\|angustia\|ánimo\|cariño\|cobardía\|comprensión\|consuelo\|corte\|daño\|disgusto\|duda\|escándalo\|fobia\|gana\|gracias\|gusto\|inquietud\|)";#<string>
my $VSrefleja  = "(?:acabar\|agotar\|apuntar\|esgotar\|apontar\|espalhar\|desencadear\|filtrar\|importar\|informar\|produzir\|quebrar\|desencadenar\|producir\|)";#<string>
my $VSind  = "(?:agradar\|apasionar\|apetecer\|\|asombrar\|\|cundir\|desagradar\|encantar\|extrañar\|faltar\|gustar\|interesar\|sorprender\|apaixonar\|assombrar\|estranhar\|interessar\|)";#<string>
my $VS  = "(?:abundar\|afirmar\|aflorar\|afluir\|agradar\|anidar\|apaixonar\|aparecer\|apasionar\|arder\|bastar\|bater\|bramar\|bramir\|brilhar\|brillar\|brotar\|caber\|cesar\|cessar\|chatear\|circular\|coalhar\|começar\|comenzar\|comparecer\|concluir\|concordar\|concurrir\|constar\|contrastar\|convenir\|cruzar\|cuajar\|dançar\|danzar\|decorrer\|desfilar\|despuntar\|doer\|doler\|empezar\|encher\|escusar\|estallar\|estourar\|existir\|faltar\|fascinar\|fastidiar\|figurar\|finalizar\|fracasar\|fracassar\|gastar\|gostar\|gus\|habitar\|hinchar\|holgar\|imperar\|interceder\|interesar\|interessar\|intervenir\|intervir\|latir\|mediar\|ocorrer\|ocurrir\|parecer\|particularizar\|perdurar\|predominar\|puntualizar\|ranger\|rebentar\|rechinar\|reinar\|replicar\|reventar\|rugir\|sentencia\|sentenciar\|soar\|sobrar\|sobrevenir\|sobrevir\|sobreviver\|sobrevivir\|sonar\|suceder\|surgir\|tar\|temblar\|terciar\|transcorrer\|transcurrir\|tremer\|urgir\|)";#<string>


####################################END CODE BY COMPI################################################


my $i=0;#<integer>
my $listTags="";#<string>
my $seq="";#<string>
my $info;#<string>

my @Token=();#<list><string>
my @Tag=();#<list><string>
my @Lemma=();#<list><string>
my @Attributes=();#<list><string>
my @ATTR=();#<list><map><string>
my %ATTR_lemma=();#<map><string>
my %TagStr=();#<map><integer>
my %IDF=();#<map><string>
my %Ordenar=();#<map><integer>

sub parse{
	my $lines = $_[0];#<ref><list><string>
	my @saida=();#<list><string>

	## -a por defeito
	my $flag = "-a"; #<string>

	##flag -a=analisador -c=corrector
	if(@_>1 && $_[1]){
		$flag = $_[1];
	}

	my $j=0;#<integer>
	foreach my $line (@{$lines}) {
		chop($line);

		(my $token, $info) = split(" ", $line);#<string>

		###Convertimos caracteres significativos na sintaxe de DepPattern em tags especiais
		if ($token =~ /:/) {
			ConvertChar ('\:', "Fd");
		}
		if ($token =~ /\|/) {
			ConvertChar ('\|', "Fz");
		}
		if ($token =~ /\>/) {
			ConvertChar ('\>', "Fz1");
		}
		if ($token =~ /\</) {
			ConvertChar ('\<', "Fz2");
		}

		my %Exp=();#<map><string>

		##organizamos a informacao de cada token:
		if ($info ne "") {
			my @info = split ('\|', $info);#<array><string>
			for ($i=0;$i<=$#info;$i++) {
				if ($info[$i] ne "") {
					my($attrib, $value) = split (':', $info[$i]);#<string>
					$Exp{$attrib} = $value ;
				}
			}
		}

		##construimos os vectores da oracao
		if ($Exp{"tag"} ne $Border) {
			$Token[$j] = $token ;
			if ($info ne "") {
				$Lemma[$j] = $Exp{"lemma"};
				$Tag[$j] = $Exp{"tag"} ;
				$Attributes[$j] = "";
				foreach my $at (sort keys %Exp) {
					if ($at ne "tag"){
						$Attributes[$j] .= "$at:$Exp{$at}|"; 
						$ATTR[$j] = {} if (!defined $ATTR[$j]);
						$ATTR[$j]{$at} = $Exp{$at} ;
					}
				}
			}
			$j++;
			#print STDERR "$j\r";
		} elsif ($Exp{"tag"} eq $Border) {
			$Token[$j] = $token;
			$Lemma[$j] = $Exp{"lemma"};
			$Tag[$j] = $Exp{"tag"} ;
			$Attributes[$j] = "";
			foreach my $at (sort keys %Exp) {
				if ($at ne "tag"){
					$Attributes[$j] .= "$at:$Exp{$at}|";
					$ATTR[$j] = {} if (!defined $ATTR[$j]);
					$ATTR[$j]{$at} = $Exp{$at};
				}
			}

			##construimos os strings com a lista de tags-atributos e os token-tags da oraçao
			for ($i=0;$i<=$#Token;$i++) {
				ReConvertChar ('\:', "Fd", $i);
				ReConvertChar ('\|', "Fz", $i);
				ReConvertChar ('\>', "Fz1", $i);
				ReConvertChar ('\<', "Fz2", $i);

				$listTags .= "$Tag[$i]_${i}_<$Attributes[$i]>";
				$seq .= "$Token[$i]_$Tag[$i]_${i}_<$Attributes[$i]>" . " ";

			}##fim do for

			my $STOP=0;#<boolean>
			#$iteration=0;
			while (!$STOP) {
				my $ListInit = $listTags;#<string>
				#$iteration++;
				#print STDERR "$iteration\n";

				my @temp;#<array><string>
				my $Rel;#<string>
###########################BEGIN GRAMMAR#############################################
				{#<function>
					# Single: VERB
					# Add: nomin:no
					@temp = ($listTags =~ /($VERB$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)/$1/g;
					Add("Head","nomin:no",\@temp);

					# Single: CONJ<lemma:pero|porque|mas|mais>
					# Add: type:S
					@temp = ($listTags =~ /($CONJ${l}lemma:(?:pero|porque|mas|mais)\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($CONJ${l}lemma:(?:pero|porque|mas|mais)\|${r})/$1/g;
					Add("Head","type:S",\@temp);

					# fixedR: X<token:sen|sin> X<token:embargo>
					# Add: tag:CONJ, type:S
					@temp = ($listTags =~ /($X${l}token:(?:sen|sin)\|${r})($X${l}token:embargo\|${r})/g);
					$Rel =  "fixedR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X${l}token:(?:sen|sin)\|${r})($X${l}token:embargo\|${r})/$1/g;
					Add("HeadDep","tag:CONJ,type:S",\@temp);

					# fixedR: X<token:assim|asÃ­> X<token:como>
					@temp = ($listTags =~ /($X${l}token:(?:assim|asÃ­)\|${r})($X${l}token:como\|${r})/g);
					$Rel =  "fixedR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X${l}token:(?:assim|asÃ­)\|${r})($X${l}token:como\|${r})/$1/g;

					# fixedR: ADV<lemma:$AdvDe> PRP<lemma:de>
					@temp = ($listTags =~ /($ADV${l}lemma:$AdvDe\|${r})($PRP${l}lemma:de\|${r})/g);
					$Rel =  "fixedR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:$AdvDe\|${r})($PRP${l}lemma:de\|${r})/$1/g;

					# punctR:  [Fz|Fe] X Fz|Fe
					# NEXT
					# punctL: Fz|Fe X [Fz|Fe]
					@temp = ($listTags =~ /(?:$Fz$a2|$Fe$a2)($X$a2)($Fz$a2|$Fe$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fz$a2|$Fe$a2)($X$a2)(?:$Fz$a2|$Fe$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fz$a2|$Fe$a2)($X$a2)($Fz$a2|$Fe$a2)/$2/g;

					# cc: [ADV] [Fc] [ADV] [Fc] [ADV] CONJ<lemma:$CCoord> ADV
					# NEXT
					# conj: ADV [Fc] [ADV] [Fc] [ADV]  [CONJ<lemma:$CCoord>] ADV
					# NEXT
					# punctL: [ADV] [Fc] [ADV] Fc ADV  [CONJ<lemma:$CCoord>] [ADV]
					# NEXT
					# conj: ADV [Fc] [ADV] [Fc] ADV  [CONJ<lemma:$CCoord>] [ADV]
					# NEXT
					# punctL: [ADV] Fc ADV [Fc] [ADV]  [CONJ<lemma:$CCoord>] [ADV]
					# NEXT
					# conj: ADV [Fc] ADV [Fc] [ADV]  [CONJ<lemma:$CCoord>] [ADV]
					@temp = ($listTags =~ /(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($Fc$a2)($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$Fc$a2)($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/$1/g;

					# cc: [ADV] [Fc] [ADV] CONJ<lemma:$CCoord> ADV
					# NEXT
					# conj: ADV [Fc] [ADV]  [CONJ<lemma:$CCoord>] ADV
					# NEXT
					# punctL: [ADV] Fc ADV  [CONJ<lemma:$CCoord>] [ADV]
					# NEXT
					# conj: ADV [Fc] ADV  [CONJ<lemma:$CCoord>] [ADV]
					@temp = ($listTags =~ /(?:$ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/$1/g;

					# cc: [ADV] CONJ<lemma:$CCoord> ADV
					# NEXT
					# conj: ADV [CONJ<lemma:$CCoord>] ADV
					@temp = ($listTags =~ /(?:$ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($CONJ${l}lemma:$CCoord\|${r})($ADV$a2)/$1/g;

					# cc: [ADJ] [Fc] [ADJ] [Fc] [ADJ] CONJ<lemma:$CCoord> ADJ
					# NEXT
					# conj: ADJ [Fc] [ADJ] [Fc] [ADJ]  [CONJ<lemma:$CCoord>] ADJ
					# NEXT
					# punctL: [ADJ] [Fc] [ADJ] Fc ADJ  [CONJ<lemma:$CCoord>] [ADJ]
					# NEXT
					# conj: ADJ [Fc] [ADJ] [Fc] ADJ  [CONJ<lemma:$CCoord>] [ADJ]
					# NEXT
					# punctL: [ADJ] Fc ADJ [Fc] [ADJ]  [CONJ<lemma:$CCoord>] [ADJ]
					# NEXT
					# conj: ADJ [Fc] ADJ [Fc] [ADJ]  [CONJ<lemma:$CCoord>] [ADJ]
					@temp = ($listTags =~ /(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/$1/g;

					# cc: [ADJ] [Fc] [ADJ] CONJ<lemma:$CCoord> ADJ
					# NEXT
					# conj: ADJ [Fc] [ADJ]  [CONJ<lemma:$CCoord>] ADJ
					# NEXT
					# punctL: [ADJ] Fc ADJ  [CONJ<lemma:$CCoord>] [ADJ]
					# NEXT
					# conj: ADJ [Fc] ADJ  [CONJ<lemma:$CCoord>] [ADJ]
					@temp = ($listTags =~ /(?:$ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/$1/g;

					# cc: [ADJ] CONJ<lemma:$CCoord> ADJ
					# NEXT
					# conj: ADJ [CONJ<lemma:$CCoord>] ADJ
					@temp = ($listTags =~ /(?:$ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($CONJ${l}lemma:$CCoord\|${r})($ADJ$a2)/$1/g;

					# advmodL: ADV<lemma:$Quant> ADV|ADJ
					@temp = ($listTags =~ /($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/$2/g;

					# flatR:  NOUN<type:P> NOUN<type:P>
					# Recursivity: 2
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "flatR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "flatR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "flatR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;

					# amodL: ADJ [ADV]? NOUN<type:C>
					# Agreement: gender, number
					# Recursivity: 1
					@temp = ($listTags =~ /($ADJ$a2)(?:$ADV$a2)?($NOUN${l}type:C\|${r})/g);
					$Rel =  "amodL";
					DepHead($Rel,"gender,number",\@temp);
					$listTags =~ s/($ADJ${l}concord:1${r})($ADV$a2)?($NOUN${l}concord:1${b2}type:C\|${r})/$2$3/g;
					$listTags =~ s/concord:[01]\|//g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$ADV$a2)?($NOUN${l}type:C\|${r})/g);
					$Rel =  "amodL";
					DepHead($Rel,"gender,number",\@temp);
					$listTags =~ s/($ADJ${l}concord:1${r})($ADV$a2)?($NOUN${l}concord:1${b2}type:C\|${r})/$2$3/g;
					$listTags =~ s/concord:[01]\|//g;

					# amodR: NOUN<type:C> [ADV]? ADJ
					# Agreement: gender, number
					# Recursivity: 1
					@temp = ($listTags =~ /($NOUN${l}type:C\|${r})(?:$ADV$a2)?($ADJ$a2)/g);
					$Rel =  "amodR";
					HeadDep($Rel,"gender,number",\@temp);
					$listTags =~ s/($NOUN${l}concord:1${b2}type:C\|${r})($ADV$a2)?($ADJ${l}concord:1${r})/$1$2/g;
					$listTags =~ s/concord:[01]\|//g;
					@temp = ($listTags =~ /($NOUN${l}type:C\|${r})(?:$ADV$a2)?($ADJ$a2)/g);
					$Rel =  "amodR";
					HeadDep($Rel,"gender,number",\@temp);
					$listTags =~ s/($NOUN${l}concord:1${b2}type:C\|${r})($ADV$a2)?($ADJ${l}concord:1${r})/$1$2/g;
					$listTags =~ s/concord:[01]\|//g;

					# amodL: ADV<lemma:no|nÃ£o|non> NOUN
					@temp = ($listTags =~ /($ADV${l}lemma:(?:no|nÃ£o|non)\|${r})($NOUN$a2)/g);
					$Rel =  "amodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:(?:no|nÃ£o|non)\|${r})($NOUN$a2)/$2/g;

					# nmod2R:  NOUN<type:P> NOUN<type:P>
					# Recursivity: 2
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($NOUN${l}type:P\|${r})/$1/g;

					# nmod2R:  NOUN NOUN
					# Recursivity: 1
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$1/g;
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "nmod2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$1/g;

					# nmodR: CARD PRP<lemma:de> NOUN<lemma:$Month>
					# Add: date:yes
					# NoUniq
					@temp = ($listTags =~ /($CARD$a2)($PRP${l}lemma:de\|${r})($NOUN${l}lemma:$Month\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($PRP${l}lemma:de\|${r})($NOUN${l}lemma:$Month\|${r})/$1$2$3/g;
					Add("HeadRelDep","date:yes",\@temp);

					# amodL: ADJ NOUN
					@temp = ($listTags =~ /($ADJ$a2)($NOUN$a2)/g);
					$Rel =  "amodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($NOUN$a2)/$2/g;

					# amodR: NOUN ADJ
					@temp = ($listTags =~ /($NOUN$a2)($ADJ$a2)/g);
					$Rel =  "amodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($ADJ$a2)/$1/g;

					# det: DT [DT|PRO<type:X>|PRO<token:lo>] NOUN
					# NEXT
					# det: [DT] DT|PRO<type:X>|PRO<token:lo> NOUN
					@temp = ($listTags =~ /($DT$a2)(?:$DT$a2|$PRO${l}type:X\|${r}|$PRO${l}token:lo\|${r})($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$DT$a2)($DT$a2|$PRO${l}type:X\|${r}|$PRO${l}token:lo\|${r})($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($DT$a2|$PRO${l}type:X\|${r}|$PRO${l}token:lo\|${r})($NOUN$a2)/$3/g;

					# det: DT [CARD] NOUN
					# NEXT
					# nummodL: [DT] CARD NOUN
					@temp = ($listTags =~ /($DT$a2)(?:$CARD$a2)($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$DT$a2)($CARD$a2)($NOUN$a2)/g);
					$Rel =  "nummodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($CARD$a2)($NOUN$a2)/$3/g;

					# det: DT<type:I> [DT<type:A>] PRO<type:R>
					# NEXT
					# det: [DT<type:I>] DT<type:A> PRO<type:R>
					@temp = ($listTags =~ /($DT${l}type:I\|${r})(?:$DT${l}type:A\|${r})($PRO${l}type:R\|${r})/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$DT${l}type:I\|${r})($DT${l}type:A\|${r})($PRO${l}type:R\|${r})/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT${l}type:I\|${r})($DT${l}type:A\|${r})($PRO${l}type:R\|${r})/$3/g;

					# amodL: [DT] VERB<mode:P> NOUN
					# NEXT
					# det: DT [VERB<mode:P>] NOUN
					@temp = ($listTags =~ /(?:$DT$a2)($VERB${l}mode:P\|${r})($NOUN$a2)/g);
					$Rel =  "amodL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($DT$a2)(?:$VERB${l}mode:P\|${r})($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($VERB${l}mode:P\|${r})($NOUN$a2)/$3/g;

					# nummodL: CARD NOUN
					@temp = ($listTags =~ /($CARD$a2)($NOUN$a2)/g);
					$Rel =  "nummodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($NOUN$a2)/$2/g;

					# det: DT NOUN
					@temp = ($listTags =~ /($DT$a2)($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($NOUN$a2)/$2/g;

					# det: DT PRO<type:D|P|I|X>|ADJ|CARD
					@temp = ($listTags =~ /($DT$a2)($PRO${l}type:(?:D|P|I|X)\|${r}|$ADJ$a2|CARD)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($PRO${l}type:(?:D|P|I|X)\|${r}|$ADJ$a2|CARD)/$2/g;

					# det: DT|PRO<type:D> PRO<type:[RW]>
					# Add: sust:yes
					# Inherit: number, person
					@temp = ($listTags =~ /($DT$a2|$PRO${l}type:D\|${r})($PRO${l}type:[RW]\|${r})/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2|$PRO${l}type:D\|${r})($PRO${l}type:[RW]\|${r})/$2/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","sust:yes",\@temp);

					# det: DT<type:[AD]>|PRO<type:D> PRP<lemma:de> [NOUNS|PRO<type:D|P|I|X>]
					# Add: nomin:yes
					# Inherit: number, person
					@temp = ($listTags =~ /($DT${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRP${l}lemma:de\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$2$3/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

					# det: DT [ADV<lemma:$AdvDe>] [PRP<lemma:de>] NOUN
					@temp = ($listTags =~ /($DT$a2)(?:$ADV${l}lemma:$AdvDe\|${r})(?:$PRP${l}lemma:de\|${r})($NOUN$a2)/g);
					$Rel =  "det";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DT$a2)($ADV${l}lemma:$AdvDe\|${r})($PRP${l}lemma:de\|${r})($NOUN$a2)/$2$3$4/g;

					# explL: PRO<token:se> VERB
					# Add: se:yes
					@temp = ($listTags =~ /($PRO${l}token:se\|${r})($VERB$a2)/g);
					$Rel =  "explL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}token:se\|${r})($VERB$a2)/$2/g;
					Add("DepHead","se:yes",\@temp);

					# explR: VERB PRO<token:se>
					# Add: se:yes
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}token:se\|${r})/g);
					$Rel =  "explR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}token:se\|${r})/$1/g;
					Add("HeadDep","se:yes",\@temp);

					# explL: PRO<lemma:$cliticoInd>  [PRO<lemma:$cliticoDir>]? VERB [ADV]? [NOUNS|PRO<type:D|P|I|X>]? [PRP<lemma:a>] [NOUN]
					# NEXT
					# iobjR: [PRO<lemma:$cliticoInd>]  [PRO<lemma:$cliticoDir>]? VERB [ADV]? [NOUNS|PRO<type:D|P|I|X>]? PRP<lemma:a> NOUN
					@temp = ($listTags =~ /($PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)(?:$ADV$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$PRP${l}lemma:a\|${r})(?:$NOUN$a2)/g);
					$Rel =  "explL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)(?:$ADV$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUN$a2)/g);
					$Rel =  "iobjR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:$cliticoInd\|${r})($PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)($ADV$a2)?($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUN$a2)/$2$3$4$5/g;

					# explR: VERB PRO<lemma:$cliticoInd>  [PRO<lemma:$cliticoDir>]? [ADV]? [NOUNS|PRO<type:D|P|I|X>]? [PRP<lemma:a>] [NOUN]
					# NEXT
					# iobjR: VERB [PRO<lemma:$cliticoInd>]  [PRO<lemma:$cliticoDir>]? [ADV]? [NOUNS|PRO<type:D|P|I|X>]? PRP<lemma:a> NOUN
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?(?:$ADV$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$PRP${l}lemma:a\|${r})(?:$NOUN$a2)/g);
					$Rel =  "explR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?(?:$ADV$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUN$a2)/g);
					$Rel =  "iobjR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}lemma:$cliticoInd\|${r})($PRO${l}lemma:$cliticoDir\|${r})?($ADV$a2)?($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUN$a2)/$1$3$4$5/g;

					# iobj2L: PRO<lemma:$cliticoInd> [PRO<lemma:$cliticoDir>]? VERB
					# Add: ind:yes
					@temp = ($listTags =~ /($PRO${l}lemma:$cliticoInd\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)/g);
					$Rel =  "iobj2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:$cliticoInd\|${r})($PRO${l}lemma:$cliticoDir\|${r})?($VERB$a2)/$2$3/g;
					Add("DepHead","ind:yes",\@temp);

					# iobj2L: PRO<lemma:se> [PRO<lemma:$cliticoDir>] VERB
					@temp = ($listTags =~ /($PRO${l}lemma:se\|${r})(?:$PRO${l}lemma:$cliticoDir\|${r})($VERB$a2)/g);
					$Rel =  "iobj2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:se\|${r})($PRO${l}lemma:$cliticoDir\|${r})($VERB$a2)/$2$3/g;

					# objL: PRO<lemma:$cliticoDir> VERB
					@temp = ($listTags =~ /($PRO${l}lemma:$cliticoDir\|${r})($VERB$a2)/g);
					$Rel =  "objL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:$cliticoDir\|${r})($VERB$a2)/$2/g;

					# iobj2R: VERB PRO<lemma:$cliticoInd>
					# Add: ind:yes
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}lemma:$cliticoInd\|${r})/g);
					$Rel =  "iobj2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}lemma:$cliticoInd\|${r})/$1/g;
					Add("HeadDep","ind:yes",\@temp);

					# objR: VERB PRO<lemma:$cliticoDir>
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}lemma:$cliticoDir\|${r})/g);
					$Rel =  "objR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}lemma:$cliticoDir\|${r})/$1/g;

					# auxL: VERB<type:S> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
					# Add: voice:passive
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:S\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:S\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","voice:passive",\@temp);

					# auxL: VERB<(type:A)|(lemma:ter|haver|haber|avoir|have)> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
					# Add: type:perfect
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","type:perfect",\@temp);

					# auxL: VERB<lemma:estar> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:G>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:estar\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:G\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:estar\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:G\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# auxL: VERB<lemma:$VModal> [ADV]? VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:$VModal\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VModal\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# markL: [VERB<lemma:tener|ter|haber>] [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? CONJ<lemma:que&type:S>|PRP<lemma:de> [ADV]? VERB<mode:N>
					# NEXT
					# auxL: VERB<lemma:tener|haber> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [CONJ<lemma:que&type:S>|PRP<lemma:de>] [ADV]? VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /(?:$VERB${l}lemma:(?:tener|ter|haber)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($CONJ${l}lemma:que\|${b2}type:S\|${r}|$PRP${l}lemma:de\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:tener|haber)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$CONJ${l}lemma:que\|${b2}type:S\|${r}|$PRP${l}lemma:de\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "auxL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:tener|haber)\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($CONJ${l}lemma:que\|${b2}type:S\|${r}|$PRP${l}lemma:de\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$3$4$5$6$7$8$9$10$11$13$14/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# markL: [VERB]? [ADV]? [PRP<lemma:$PrepLocs>]? [ADV]? [VERB<mode:N>] [ADV|PRO<type:P>]? PRP<lemma:$PrepLocs>  VERB<mode:N>
					# NEXT
					# xcomp2R: [VERB]? [ADV]? [PRP<lemma:$PrepLocs>]? [ADV]? VERB<mode:N>  [ADV|PRO<type:P>]? [PRP<lemma:$PrepLocs>]  VERB<mode:N>
					# NEXT
					# markL: [VERB] [ADV]? PRP<lemma:$PrepLocs> [ADV]? VERB<mode:N>  [ADV|PRO<type:P>]? [PRP<lemma:$PrepLocs>]  [VERB<mode:N>]
					# NEXT
					# xcomp2R: VERB [ADV]? [PRP<lemma:$PrepLocs>] [ADV]? VERB<mode:N>  [ADV|PRO<type:P>]? [PRP<lemma:$PrepLocs>]  [VERB<mode:N>]
					# NoUniq
					@temp = ($listTags =~ /(?:$VERB$a2)?(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})?(?:$ADV$a2)?(?:$VERB${l}mode:N\|${r})(?:$ADV$a2|$PRO${l}type:P\|${r})?($PRP${l}lemma:$PrepLocs\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)?(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})?(?:$ADV$a2)?($VERB${l}mode:N\|${r})(?:$ADV$a2|$PRO${l}type:P\|${r})?(?:$PRP${l}lemma:$PrepLocs\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "xcomp2R";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})(?:$ADV$a2|$PRO${l}type:P\|${r})?(?:$PRP${l}lemma:$PrepLocs\|${r})(?:$VERB${l}mode:N\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})(?:$ADV$a2|$PRO${l}type:P\|${r})?(?:$PRP${l}lemma:$PrepLocs\|${r})(?:$VERB${l}mode:N\|${r})/g);
					$Rel =  "xcomp2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})($ADV$a2|$PRO${l}type:P\|${r})?($PRP${l}lemma:$PrepLocs\|${r})($VERB${l}mode:N\|${r})/$1$2$3$4$5$6$7$8/g;

					# caseL: [VERB] ADV<lemma:$AdvDe> NOUNS
					# NEXT
					# advmodR: VERB [ADV<lemma:$AdvDe>] NOUNS
					@temp = ($listTags =~ /(?:$VERB$a2)($ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/g);
					$Rel =  "advmodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/$1/g;

					# punctL: [ADV<pos:0>] Fc VERB
					# NEXT
					# advmodL: ADV<pos:0> [Fc] VERB
					@temp = ($listTags =~ /(?:$ADV${l}pos:0\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV${l}pos:0\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}pos:0\|${r})($Fc$a2)($VERB$a2)/$3/g;

					# punctR:  VERB [Fc]? [ADV] Fc
					# NEXT
					# punctR: VERB Fc [ADV] [Fc]
					# NEXT
					# advmodR: VERB [Fc]? ADV [Fc]
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?(?:$ADV$a2)($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?($ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "advmodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($ADV$a2)($Fc$a2)/$1/g;

					# punctL: Fc [ADV] [Fc]? VERB
					# NEXT
					# punctL: [Fc] [ADV] Fc VERB
					# NEXT
					# advmodL: [Fc] ADV [Fc]? VERB
					@temp = ($listTags =~ /($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$ADV$a2)($Fc$a2)($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($ADV$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($ADV$a2)($Fc$a2)?($VERB$a2)/$4/g;

					# advmodR: VERB [NOUN|PRO<type:D|P|I|X>]? ADV
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/g);
					$Rel =  "advmodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/$1$2/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/g);
					$Rel =  "advmodR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/$1$2/g;

					# advmodL:  ADV  VERB
					# Recursivity: 1
					@temp = ($listTags =~ /($ADV$a2)($VERB$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($VERB$a2)/$2/g;
					@temp = ($listTags =~ /($ADV$a2)($VERB$a2)/g);
					$Rel =  "advmodL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($VERB$a2)/$2/g;

					# cc: [PRP] [NOUNS] [Fc] [PRP] [NOUNS] CONJ<lemma:$CCoord> [PRP] NOUNS
					# NEXT
					# caseL: [PRP] [NOUNS] [Fc] [PRP] [NOUNS] [CONJ<lemma:$CCoord>] PRP NOUNS
					# NEXT
					# conj: [PRP] NOUNS [Fc] [PRP] [NOUNS] [CONJ<lemma:$CCoord>] [PRP] NOUNS
					# NEXT
					# caseL: [PRP] [NOUNS] [Fc] PRP NOUNS [CONJ<lemma:$CCoord>] [PRP] [NOUNS]
					# NEXT
					# punctR: [PRP] NOUNS Fc [PRP] [NOUNS] [CONJ<lemma:$CCoord>] [PRP] [NOUNS]
					# NEXT
					# conj: [PRP] NOUNS [Fc] [PRP] NOUNS [CONJ<lemma:$CCoord>] [PRP] [NOUNS]
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2)($CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)($NOUNS$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($PRP$a2)($NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)($NOUNS$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)($NOUNS$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)(?:$Fc$a2)($PRP$a2)($NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)(?:$NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)($NOUNS$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)(?:$NOUNS$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)($NOUNS$a2)(?:$Fc$a2)(?:$PRP$a2)($NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)(?:$NOUNS$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUNS$a2)($Fc$a2)($PRP$a2)($NOUNS$a2)($CONJ${l}lemma:$CCoord\|${r})($PRP$a2)($NOUNS$a2)/$1$2/g;

					# cc: [PRP] [NOUNS] CONJ<lemma:$CCoord> [PRP] NOUNS
					# NEXT
					# caseL: [PRP] [NOUNS] [CONJ<lemma:$CCoord>] PRP NOUNS
					# NEXT
					# conj: [PRP] NOUNS [CONJ<lemma:$CCoord>] [PRP] NOUNS
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)($CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)($NOUNS$a2)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})($PRP$a2)($NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)($NOUNS$a2)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$PRP$a2)($NOUNS$a2)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUNS$a2)($CONJ${l}lemma:$CCoord\|${r})($PRP$a2)($NOUNS$a2)/$1$2/g;

					# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7$8$9/g;

					# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7/g;

					# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

					# nmodR: [NOUNS] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3/g;

					# nmodR: NOUN<type:C> PRP<lemma:$PrepRA> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					}
{#<function>
					# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7$8$9/g;

					# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] [NOUNS] [PRP] NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7/g;

					# nmodR: [NOUNS] [PRP] [NOUNS] [PRP] NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)(?:$NOUNS$a2)(?:$PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

					# nmodR: [NOUNS] [PRP] NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNS$a2)(?:$PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3/g;

					# nmodR: NOUNS PRP<lemma:de> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP${l}lemma:de\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# caseL: [NOUNS] ADV<lemma:$AdvDe> NOUNS
					# NEXT
					# nmodR: NOUNS [ADV<lemma:$AdvDe>] NOUNS
					@temp = ($listTags =~ /(?:$NOUNS$a2)($ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2)(?:$ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($ADV${l}lemma:$AdvDe\|${r})($NOUNS$a2)/$1/g;

					# nmodR: X<lemma:uno>|PRO<type:[DI]> PRP NOUNS|PRO<type:D|P|I|X>
					# Add: tag:PRO, nomin:yes
					@temp = ($listTags =~ /($X${l}lemma:uno\|${r}|$PRO${l}type:[DI]\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:uno\|${r}|$PRO${l}type:[DI]\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					Add("HeadRelDep","tag:PRO,nomin:yes",\@temp);

					# caseL: PRP<nomin:yes> NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($PRP${l}nomin:yes\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}nomin:yes\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$2/g;

					# nmodR: NOUN<pos:1&type:C> PRP NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($NOUN${l}pos:1\|${b2}type:C\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}pos:1\|${b2}type:C\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# nmodR: [Fc] NOUN<type:C> PRP NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$Fc$a2)($NOUN${l}type:C\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($NOUN${l}type:C\|${r})($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2/g;

					# cc: [NP] [Fc] [NP] [Fc] [NP] CONJ<lemma:$CCoord> NP
					# NEXT
					# conj: NP [Fc] [NP] [Fc] [NP]  [CONJ<lemma:$CCoord>] NP
					# NEXT
					# punctL: [NP] [Fc] [NP] Fc NP  [CONJ<lemma:$CCoord>] [NP]
					# NEXT
					# conj: NP [Fc] [NP] [Fc] NP  [CONJ<lemma:$CCoord>] [NP]
					# NEXT
					# punctL: [NP] Fc NP [Fc] [NP]  [CONJ<lemma:$CCoord>] [NP]
					# NEXT
					# conj: NP [Fc] NP [Fc] [NP]  [CONJ<lemma:$CCoord>] [NP]
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)($Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($Fc$a2)($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

					# cc: [NP] [Fc] [NP] CONJ<lemma:$CCoord> NP
					# NEXT
					# conj: NP [Fc] [NP]  [CONJ<lemma:$CCoord>] NP
					# NEXT
					# punctL: [NP] Fc NP  [CONJ<lemma:$CCoord>] [NP]
					# NEXT
					# conj: NP [Fc] NP  [CONJ<lemma:$CCoord>] [NP]
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

					# cc: [NP] CONJ<lemma:$CCoord> NP
					# NEXT
					# conj: NP [CONJ<lemma:$CCoord>] NP
					@temp = ($listTags =~ /(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

					# punctL: [NOUNS|PRO<type:D|P|I|X>] Fc|Fpa|Fca NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# punctR: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] NOUNS|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# apposR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

					# punctL: [NOUNS|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# punctR: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNS|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# caseL: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] PRP NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# apposR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

					# punctL: [NOUNS|PRO<type:D|P|I|X>] Fd NOUNS|PRO<type:D|P|I|X>|CARD
					# NEXT
					# apposR: NOUNS|PRO<type:D|P|I|X> [Fd] NOUNS|PRO<type:D|P|I|X>|CARD
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/$1/g;

					# aclR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB<mode:P> [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [Fc|Fpt|Fct]
					# NoUniq
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($Fc$a2|$Fpt$a2|Fct)/$1$2$3$4$5$6$7$8$9$10$11$12$13$14/g;

					# nmodR: CARD PRP<lemma:de|entre|sobre|of|about|between> NOUNS|PRO
					@temp = ($listTags =~ /($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNS$a2|$PRO$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNS$a2|$PRO$a2)/$1/g;

					# nmodR: PRO<type:P> PRP<lemma:de|of> NOUNS|PRO
					@temp = ($listTags =~ /($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNS$a2|$PRO$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNS$a2|$PRO$a2)/$1/g;

					# nmodR: NOUNS [PRP] [PRO<type:D|P|I|X>] PRP NOUNS|ADV
					# NEXT
					# nmodR: NOUNS PRP PRO<type:D|P|I|X> [PRP] [NOUNS|ADV]
					@temp = ($listTags =~ /($NOUNS$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($NOUNS$a2|$ADV$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)(?:$NOUNS$a2|$ADV$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($NOUNS$a2|$ADV$a2)/$1/g;

					# nsubjL: [NOUN] PRO<type:R|W> VERB
					# NEXT
					# aclR: NOUN [PRO<type:R|W>] VERB
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUN$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)/$1$2$3/g;

					# objL: [NOUN] PRO<type:R|W> [NOUNS|PRO<type:D|P|I|X>] VERB
					# NEXT
					# aclR: NOUN [PRO<type:R|W>] [NOUNS|PRO<type:D|P|I|X>] VERB
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUN$a2)($PRO${l}type:(?:R|W)\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "objL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$PRO${l}type:(?:R|W)\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($PRO${l}type:(?:R|W)\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/$1$2$3$4/g;

					# obl2L: [NOUNS|PRO<type:D|P|I|X>]  [PRP] PRO<type:R|W> VERB
					# NEXT
					# caseL: [NOUNS|PRO<type:D|P|I|X>]  PRP PRO<type:R|W> [VERB]
					# NEXT
					# aclR: NOUNS|PRO<type:D|P|I|X> [PRP] [PRO<type:R|W>] VERB
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($PRO${l}type:(?:R|W)\|${r})(?:$VERB$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)/$1$2$3$4/g;

					# aclR: NOUN|PRO<type:D|P|I|X>  VERB<mode:[GP]>
					# NoUniq
					@temp = ($listTags =~ /($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[GP]\|${r})/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[GP]\|${r})/$1$2/g;

					# nsubjL: PRO<sust:yes>  VERB
					# Add: nomin:yes
					# Inherit: number, person
					@temp = ($listTags =~ /($PRO${l}sust:yes\|${r})($VERB$a2)/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}sust:yes\|${r})($VERB$a2)/$2/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

					# nsubjL: [PRO<sust:yes>] NOUNCOORD|PRO<type:D|P|I|X> VERB
					# NEXT
					# objL: PRO<sust:yes> [NOUNCOORD|PRO<type:D|P|I|X>] VERB
					# Add: nomin:yes
					# Inherit: number, person
					@temp = ($listTags =~ /(?:$PRO${l}sust:yes\|${r})($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRO${l}sust:yes\|${r})(?:$NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "objL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}sust:yes\|${r})($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/$3/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

					# oblR: VERB<mode:P> [NOUNS|PRO<type:D|P|I|X>] PRP<lemma:por|by> NOUNCOORD|PRO<type:D|P|I|X>|ADV
					@temp = ($listTags =~ /($VERB${l}mode:P\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}mode:P\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/$1$2/g;

					# punctR: VERB Fc  [PRP]? [NOUNS|PRO<type:D|P|I|X>] [PRP<lemma:$PrepMA>] [CARD|DATE]
					# NEXT
					# oblR: VERB [Fc]?  [PRP]? [NOUNS|PRO<type:D|P|I|X>] PRP<lemma:$PrepMA> CARD|DATE
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP${l}lemma:$PrepMA\|${r})(?:$CARD$a2|$DATE$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?(?:$PRP$a2)?(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($PRP$a2)?($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/$1$3$4/g;

					# nsubjR: VERB<lemma:$VS> NOUNS|PRO<type:D|P|I|X>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}lemma:$VS\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nsubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VS\|${r})($NOUNS${l}concord:1${r}|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# nsubjR: VERB<se:yes&lemma:$VSrefleja> NOUNS|PRO<type:D|P|I|X>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}lemma:$VSrefleja\|${b2}se:yes\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nsubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VSrefleja\|${b2}se:yes\|${r})($NOUNS${l}concord:1${r}|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# nsubjR: VERB<ind:yes&lemma:$VSind> NOUNS|PRO<type:D|P|I|X>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}ind:yes\|${b2}lemma:$VSind\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "nsubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}ind:yes\|${b2}lemma:$VSind\|${r})($NOUNS${l}concord:1${r}|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# nsubjR: NOUN<number:S> [VERB<number:P&lemma:ser|estar>] NOUN<number:P>
					# NEXT
					# cop2R: NOUN<number:S> VERB<number:P&lemma:ser|estar> [NOUN<number:P>]
					# Inherit: person, number, tense, mode
					@temp = ($listTags =~ /($NOUN${l}number:S\|${r})(?:$VERB${l}lemma:(?:ser|estar)\|${b2}number:P\|${r})($NOUN${l}number:P\|${r})/g);
					$Rel =  "nsubjR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN${l}number:S\|${r})($VERB${l}lemma:(?:ser|estar)\|${b2}number:P\|${r})(?:$NOUN${l}number:P\|${r})/g);
					$Rel =  "cop2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}number:S\|${r})($VERB${l}lemma:(?:ser|estar)\|${b2}number:P\|${r})($NOUN${l}number:P\|${r})/$1/g;
					Inherit("HeadDep","person,number,tense,mode",\@temp);

					# cop2L: VERB<lemma:ser> VERB<nomin:yes>
					# Add: cop:yes
					# Inherit: person, number, tense, mode
					@temp = ($listTags =~ /($VERB${l}lemma:ser\|${r})($VERB${l}nomin:yes\|${r})/g);
					$Rel =  "cop2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:ser\|${r})($VERB${l}nomin:yes\|${r})/$2/g;
					Inherit("DepHead","person,number,tense,mode",\@temp);
					Add("DepHead","cop:yes",\@temp);

					# cop2L: VERB<lemma:ser|estar> NOUNS|ADJ|ADV|VERB<mode:P>|PRO<type:D|P|I|X>
					# Add: cop:yes
					# Inherit: person, number, tense, mode
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ser|estar)\|${r})($NOUNS$a2|$ADJ$a2|ADV|$VERB${l}mode:P\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "cop2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:ser|estar)\|${r})($NOUNS$a2|$ADJ$a2|ADV|$VERB${l}mode:P\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/$2/g;
					Inherit("DepHead","person,number,tense,mode",\@temp);
					Add("DepHead","cop:yes",\@temp);

					# copL: VERB<lemma:ser|estar> PRP NOUNS|ADJ|ADV|VERB<mode:P>|PRO<type:D|P|I|X>
					# Add: cop:yes
					# Inherit: person, number, tense, mode
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ser|estar)\|${r})($PRP$a2)($NOUNS$a2|$ADJ$a2|ADV|$VERB${l}mode:P\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "copL";
					DepRelHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:ser|estar)\|${r})($PRP$a2)($NOUNS$a2|$ADJ$a2|ADV|$VERB${l}mode:P\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/$3/g;
					Inherit("DepRelHead","person,number,tense,mode",\@temp);
					Add("DepRelHead","cop:yes",\@temp);

					# obl2R:  VERB CARD<date:yes>|NOUN<lemma:$Day>
					@temp = ($listTags =~ /($VERB$a2)($CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})/g);
					$Rel =  "obl2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})/$1/g;

					# punctL: Fc [CARD<date:yes>|NOUN<lemma:$Day>] VERB
					# NEXT
					# obl2L:  [Fc]? CARD<date:yes>|NOUN<lemma:$Day> VERB
					@temp = ($listTags =~ /($Fc$a2)(?:$CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})($VERB$a2)/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($CARD${l}date:yes\|${r}|$NOUN${l}lemma:$Day\|${r})($VERB$a2)/$3/g;

					# objR: VERB  NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "objR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# cc: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] [Fc] [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
					# NEXT
					# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>] [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] VERB<nomin:no>
					# NEXT
					# punctL: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] Fc VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					# NEXT
					# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>] [Fc] VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					# NEXT
					# punctL: [VERB<nomin:no>] Fc VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					# NEXT
					# conj: VERB<nomin:no> [Fc] VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

					# cc: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
					# NEXT
					# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] VERB<nomin:no>
					# NEXT
					# punctL: [VERB<nomin:no>] Fc VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					# NEXT
					# conj: VERB<nomin:no> [Fc] VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

					# cc: [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
					# NEXT
					# conj: VERB<nomin:no> [CONJ<lemma:$CCoord>] VERB<nomin:no>
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

					# oblR: VERB PRP NOUNS|PRO<type:D|P|I|X>
					# Recursivity: 3
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# punctR: VERB Fc [PRP] [NOUNS|PRO<type:D|P|I|X>] [Fc]?
					# NEXT
					# punctR: VERB [Fc] [PRP] [NOUNS|PRO<type:D|P|I|X>] Fc
					# NEXT
					# oblR: VERB [Fc] PRP NOUNS|PRO<type:D|P|I|X> [Fc]?
					# Recursivity:1
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "oblR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;

					# punctL: [PRP<pos:1>] [NOUNS|PRO<type:D|P|I|X>] Fc  VERB<mode:[^PNG]>
					# NEXT
					# caseL: PRP<pos:1> NOUNS|PRO<type:D|P|I|X> [Fc]?  [VERB<mode:[^PNG]>]
					# NEXT
					# obl2L: [PRP<pos:1>] NOUNS|PRO<type:D|P|I|X> [Fc]?  VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$PRP${l}pos:1\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP${l}pos:1\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP${l}pos:1\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}pos:1\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/$4/g;

					# punctL: [Fc] [PRP] [NOUNS|PRO<type:D|P|I|X>] Fc  VERB<mode:[^PNG]>
					# NEXT
					# punctL: Fc [PRP] [NOUNS|PRO<type:D|P|I|X>] [Fc]?  VERB<mode:[^PNG]>
					# NEXT
					# caseL: [Fc] PRP NOUNS|PRO<type:D|P|I|X> [Fc]?  [VERB<mode:[^PNG]>]
					# NEXT
					# obl2L: [Fc] [PRP] NOUNS|PRO<type:D|P|I|X> [Fc]?  VERB<mode:[^PNG]>
					# Recursivity:1
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/$5/g;
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/$5/g;

					# caseL: [CONJ] PRP NOUNS|PRO<type:D|P|I|X> [Fc]?  [VERB<mode:[^PNG]>]
					# NEXT
					# obl2L: [CONJ] [PRP] NOUNS|PRO<type:D|P|I|X> [Fc]?  VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$CONJ$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$CONJ$a2)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($CONJ$a2)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r})/$1$4$5/g;

					# caseL: [NOUN] PRP<lemma:de> [CONJ<lemma:que>] VERB
					# NEXT
					# markL: [NOUN] [PRP<lemma:de>] CONJ<lemma:que> VERB
					# NEXT
					# obl2L: NOUN [PRP<lemma:de>] [CONJ<lemma:que>] VERB
					@temp = ($listTags =~ /(?:$NOUN$a2)($PRP${l}lemma:de\|${r})(?:$CONJ${l}lemma:que\|${r})($VERB$a2)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)(?:$PRP${l}lemma:de\|${r})($CONJ${l}lemma:que\|${r})($VERB$a2)/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$PRP${l}lemma:de\|${r})(?:$CONJ${l}lemma:que\|${r})($VERB$a2)/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($PRP${l}lemma:de\|${r})($CONJ${l}lemma:que\|${r})($VERB$a2)/$4/g;

					# objR: VERB  NOUNS|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "objR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# xcomp2R: VERB  VERB<mode:[PNG]>|ADJ
					@temp = ($listTags =~ /($VERB$a2)($VERB${l}mode:[PNG]\|${r}|$ADJ$a2)/g);
					$Rel =  "xcomp2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($VERB${l}mode:[PNG]\|${r}|$ADJ$a2)/$1/g;

					# xcompR: VERB PRP VERB
					# Recursivity:1
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($VERB$a2)/g);
					$Rel =  "xcompR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($VERB$a2)/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)($VERB$a2)/g);
					$Rel =  "xcompR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($VERB$a2)/$1/g;

					# markL: [VERB] [PRP] CONJ<lemma:que> VERB<mode:[^PNG]>
					# NEXT
					# xcompR: VERB PRP [CONJ<lemma:que>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$PRP$a2)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)(?:$CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "xcompR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# nmodR: NOUNS PRP NOUNS
					@temp = ($listTags =~ /($NOUNS$a2)($PRP$a2)($NOUNS$a2)/g);
					$Rel =  "nmodR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2)($PRP$a2)($NOUNS$a2)/$1/g;

					# markL: [VERB] CONJ<lemma:que|si|that> VERB<mode:[^PNG]>
					# NEXT
					# ccompR: VERB  [CONJ<lemma:que|si|that>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}lemma:(?:que|si|that)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}lemma:(?:que|si|that)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "ccompR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}lemma:(?:que|si|that)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# markL: [VERB]  CONJ<lemma:que|si|that>  [NOUNS|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
					# NEXT
					# nsubjL:  [VERB]  [CONJ<lemma:que|si|that>]  NOUNS|PRO<type:D|P|I|X> VERB<mode:[^PNG]>
					# NEXT
					# ccompR: VERB [CONJ<lemma:que|si|that>] [NOUNS|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}lemma:(?:que|si|that)\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$CONJ${l}lemma:(?:que|si|that)\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}lemma:(?:que|si|that)\|${r})(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "ccompR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}lemma:(?:que|si|that)\|${r})($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# ccompR: VERB VERB<nomin:yes>
					@temp = ($listTags =~ /($VERB$a2)($VERB${l}nomin:yes\|${r})/g);
					$Rel =  "ccompR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($VERB${l}nomin:yes\|${r})/$1/g;

					# punctL: [NOUNS|PRO<type:D|P|I|X>] Fc|Fpa|Fca NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# punctR: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] NOUNS|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# apposR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

					# punctL: [NOUNS|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# punctR: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNS|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# caseL: [NOUNS|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] PRP NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# apposR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNS|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

					# punctL: [NOUNS|PRO<type:D|P|I|X>] Fd NOUNS|PRO<type:D|P|I|X>|CARD
					# NEXT
					# apposR: NOUNS|PRO<type:D|P|I|X> [Fd] NOUNS|PRO<type:D|P|I|X>|CARD
					@temp = ($listTags =~ /(?:$NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/g);
					$Rel =  "apposR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fd$a2)($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)/$1/g;

					# punctR: NOUNS|PRO<type:D|P|I|X> Fc|Fpa|Fca [VERB<mode:P>]  [Fc|Fpt|Fct]
					# NEXT
					# punctR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] [VERB<mode:P>]  Fc|Fpt|Fct
					# NEXT
					# aclR: NOUNS|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB<mode:P>  [Fc|Fpt|Fct]
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)(?:$VERB${l}mode:P\|${r})(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)(?:$VERB${l}mode:P\|${r})($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})($Fc$a2|$Fpt$a2|Fct)/$1/g;

					# advclL: [Fc] VERB<mode:P> [Fc] VERB
					# NEXT
					# punctL: Fc [VERB<mode:P>] [Fc] VERB
					# NEXT
					# punctL: [Fc] [VERB<mode:P>] Fc VERB
					@temp = ($listTags =~ /(?:$Fc$a2)($VERB${l}mode:P\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "advclL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fc$a2)(?:$VERB${l}mode:P\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$VERB${l}mode:P\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($VERB${l}mode:P\|${r})($Fc$a2)($VERB$a2)/$4/g;

					}
{#<function>
					# cc: [NP] [Fc] [NP] [Fc] [NP] CONJ<lemma:$CCoord> NP
					# NEXT
					# conj: NP [Fc] [NP] [Fc] [NP]  [CONJ<lemma:$CCoord>] NP
					# NEXT
					# punctL: [NP] [Fc] [NP] Fc NP  [CONJ<lemma:$CCoord>] [NP]
					# NEXT
					# conj: NP [Fc] [NP] [Fc] NP  [CONJ<lemma:$CCoord>] [NP]
					# NEXT
					# punctL: [NP] Fc NP [Fc] [NP]  [CONJ<lemma:$CCoord>] [NP]
					# NEXT
					# conj: NP [Fc] NP [Fc] [NP]  [CONJ<lemma:$CCoord>] [NP]
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)($Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($Fc$a2)($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

					# cc: [NP] [Fc] [NP] CONJ<lemma:$CCoord> NP
					# NEXT
					# conj: NP [Fc] [NP]  [CONJ<lemma:$CCoord>] NP
					# NEXT
					# punctL: [NP] Fc NP  [CONJ<lemma:$CCoord>] [NP]
					# NEXT
					# conj: NP [Fc] NP  [CONJ<lemma:$CCoord>] [NP]
					@temp = ($listTags =~ /(?:$NP)(?:$Fc$a2)(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)($NP)(?:$CONJ${l}lemma:$CCoord\|${r})(?:$NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

					# cc: [NP] CONJ<lemma:$CCoord> NP
					# NEXT
					# conj: NP [CONJ<lemma:$CCoord>] NP
					@temp = ($listTags =~ /(?:$NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NP)(?:$CONJ${l}lemma:$CCoord\|${r})($NP)/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NP)($CONJ${l}lemma:$CCoord\|${r})($NP)/$1/g;

					# cc: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] [Fc] [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
					# NEXT
					# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>] [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] VERB<nomin:no>
					# NEXT
					# punctL: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] Fc VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					# NEXT
					# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>] [Fc] VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					# NEXT
					# punctL: [VERB<nomin:no>] Fc VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					# NEXT
					# conj: VERB<nomin:no> [Fc] VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

					# cc: [VERB<nomin:no>] [Fc] [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
					# NEXT
					# conj: VERB<nomin:no> [Fc] [VERB<nomin:no>]  [CONJ<lemma:$CCoord>] VERB<nomin:no>
					# NEXT
					# punctL: [VERB<nomin:no>] Fc VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					# NEXT
					# conj: VERB<nomin:no> [Fc] VERB<nomin:no>  [CONJ<lemma:$CCoord>] [VERB<nomin:no>]
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

					# cc: [VERB<nomin:no>] CONJ<lemma:$CCoord> VERB<nomin:no>
					# NEXT
					# conj: VERB<nomin:no> [CONJ<lemma:$CCoord>] VERB<nomin:no>
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "cc";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "conj";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($CONJ${l}lemma:$CCoord\|${r})($VERB${l}nomin:no\|${r})/$1/g;

					# markL: [VERB] [ADV]? PRP<lemma:$PrepLocs> [ADV]? VERB<mode:N>
					# NEXT
					# xcompR: VERB [ADV]? [PRP<lemma:$PrepLocs>]? [ADV]? VERB<mode:N>
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})?(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "xcompR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})?($ADV$a2)?($VERB${l}mode:N\|${r})/$1$2$4/g;

					# nsubjL: NOUNS X<cop:yes>
					# Agr: number, person
					# Add: subj:yes
					@temp = ($listTags =~ /($NOUNS$a2)($X${l}cop:yes\|${r})/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"number,person",\@temp);
					$listTags =~ s/($NOUNS${l}concord:1${r})($X${l}concord:1${b2}cop:yes\|${r})/$2/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("DepHead","subj:yes",\@temp);

					# nsubjL: NOUN<type:P> VERB<mode:[^PG]>
					# Add: subj:yes
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r})/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","subj:yes",\@temp);

					# nsubjL: NOUNS|PRO<type:D|P|I|X> VERB<mode:[^PG]>
					# Add: subj:yes
					@temp = ($listTags =~ /($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r})/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUNS$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","subj:yes",\@temp);

					# csubjL: VERB<nomin:yes> VERB<mode:[^PG]>
					# Add: subj:yes
					@temp = ($listTags =~ /($VERB${l}nomin:yes\|${r})($VERB${l}mode:[^PG]\|${r})/g);
					$Rel =  "csubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:yes\|${r})($VERB${l}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","subj:yes",\@temp);

					# csubjR: VERB<lemma:$VS> VERB<nomin:yes>
					# Agr: number, person
					# Add: subj:yes
					@temp = ($listTags =~ /($VERB${l}lemma:$VS\|${r})($VERB${l}nomin:yes\|${r})/g);
					$Rel =  "csubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VS\|${r})($VERB${l}concord:1${b2}nomin:yes\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("HeadDep","subj:yes",\@temp);

					# csubjR: VERB<se:yes&lemma:$VSrefleja>  VERB<nomin:yes>
					# Agr: number, person
					# Add: subj:yes
					@temp = ($listTags =~ /($VERB${l}lemma:$VSrefleja\|${b2}se:yes\|${r})($VERB${l}nomin:yes\|${r})/g);
					$Rel =  "csubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VSrefleja\|${b2}se:yes\|${r})($VERB${l}concord:1${b2}nomin:yes\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("HeadDep","subj:yes",\@temp);

					# csubjR: VERB<ind:yes&lemma:$VSind> VERB<nomin:yes>
					# Agr: number, person
					# Add: subj:yes
					@temp = ($listTags =~ /($VERB${l}ind:yes\|${b2}lemma:$VSind\|${r})($VERB${l}nomin:yes\|${r})/g);
					$Rel =  "csubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}ind:yes\|${b2}lemma:$VSind\|${r})($VERB${l}concord:1${b2}nomin:yes\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("HeadDep","subj:yes",\@temp);

					# punctL: [NOUN|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>] VERB<subj:yes>   [Fc]?
					# NEXT
					# punctR: [NOUN|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>] VERB<subj:yes>  Fc
					# NEXT
					# objL: [NOUN|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W> VERB<subj:yes>   [Fc]?
					# NEXT
					# aclR: NOUN|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>] VERB<subj:yes>    [Fc]?
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})(?:$Fc$a2)?/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})(?:$Fc$a2)?/g);
					$Rel =  "objL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})(?:$Fc$a2)?/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r})($Fc$a2)?/$1/g;

					# punctL: [NOUN|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>] VERB   [Fc]?
					# NEXT
					# punctR: [NOUN|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>] VERB Fc
					# NEXT
					# nsubjL: [NOUN|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W> VERB  [Fc]?
					# NEXT
					# aclR: NOUN|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>] VERB [Fc]?
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "nsubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB$a2)($Fc$a2)?/$1/g;

					# punctL: [NOUN|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>] VERB   [Fc]?
					# NEXT
					# punctR: [NOUN|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>] VERB Fc
					# NEXT
					# obl2L: [NOUN|PRO<type:D|P|I|X>] [Fc]? [PRP] PRO<type:R|W> VERB  [Fc]?
					# NEXT
					# caseL: [NOUN|PRO<type:D|P|I|X>] [Fc]? PRP PRO<type:R|W> [VERB]  [Fc]?
					# NEXT
					# aclR: NOUN|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>] VERB [Fc]?
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)($Fc$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "obl2L";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r})(?:$VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2)(?:$Fc$a2)?/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2)($Fc$a2)?/$1/g;

					# punctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc VERB<mode:[GP]>
					# NEXT
					# aclR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? VERB<mode:[GP]>
					@temp = ($listTags =~ /(?:$NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[GP]\|${r})/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[GP]\|${r})/g);
					$Rel =  "aclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[GP]\|${r})/$1/g;

					# markR: VERB [Fc]? CONJ<type:S> [VERB]
					# NEXT
					# punctR: VERB Fc [CONJ<type:S>] [VERB]
					# NEXT
					# advclR: VERB [Fc]? [CONJ<type:S>] VERB
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?($CONJ${l}type:S\|${r})(?:$VERB$a2)/g);
					$Rel =  "markR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$CONJ${l}type:S\|${r})(?:$VERB$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?(?:$CONJ${l}type:S\|${r})($VERB$a2)/g);
					$Rel =  "advclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($CONJ${l}type:S\|${r})($VERB$a2)/$1/g;

					# markL:  CONJ<type:S> VERB [Fc]? [VERB]
					# NEXT
					# punctR:  [CONJ<type:S>] VERB Fc [VERB]
					# NEXT
					# advclR: [CONJ<type:S>] VERB [Fc]? VERB
					@temp = ($listTags =~ /($CONJ${l}type:S\|${r})($VERB$a2)(?:$Fc$a2)?(?:$VERB$a2)/g);
					$Rel =  "markL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$CONJ${l}type:S\|${r})($VERB$a2)($Fc$a2)(?:$VERB$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$CONJ${l}type:S\|${r})($VERB$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "advclR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($CONJ${l}type:S\|${r})($VERB$a2)($Fc$a2)?($VERB$a2)/$2/g;

					# punctR: X Fz|Fe
					@temp = ($listTags =~ /($X$a2)($Fz$a2|$Fe$a2)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X$a2)($Fz$a2|$Fe$a2)/$1/g;

					# punctL: Fz|Fe X
					@temp = ($listTags =~ /($Fz$a2|$Fe$a2)($X$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fz$a2|$Fe$a2)($X$a2)/$2/g;

					# caseL: PRP NOUNS|VERB|ADJ|ADV
					@temp = ($listTags =~ /($PRP$a2)($NOUNS$a2|$VERB$a2|ADJ|ADV)/g);
					$Rel =  "caseL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUNS$a2|$VERB$a2|ADJ|ADV)/$2/g;

					# punctR: X PUNCT|SENT|SYM
					# Recursivity: 1
					@temp = ($listTags =~ /($X$a2)($PUNCT$a2|$SENT$a2|SYM)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X$a2)($PUNCT$a2|$SENT$a2|SYM)/$1/g;
					@temp = ($listTags =~ /($X$a2)($PUNCT$a2|$SENT$a2|SYM)/g);
					$Rel =  "punctR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X$a2)($PUNCT$a2|$SENT$a2|SYM)/$1/g;

					# punctL: PUNCT|SENT|SYM X
					# Recursivity: 1
					@temp = ($listTags =~ /($PUNCT$a2|$SENT$a2|SYM)($X$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PUNCT$a2|$SENT$a2|SYM)($X$a2)/$2/g;
					@temp = ($listTags =~ /($PUNCT$a2|$SENT$a2|SYM)($X$a2)/g);
					$Rel =  "punctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PUNCT$a2|$SENT$a2|SYM)($X$a2)/$2/g;

				}
############################## END GRAMMAR  ###############################

				if ($ListInit eq $listTags) {
					$STOP = 1;
				}
			}
			#print STDERR "Iterations: $iteration\n";

#########SAIDA CORRECTOR TAGGER
			if ($flag eq "-c") {    
				for($i=0;$i<=$#Token;$i++) {
					my $saida = "$Token[$i]\t";#<string>
					my %OrdTags=();#<map><string>
					$OrdTags{"tag"} = $Tag[$i]; 
					foreach my $feat (keys %{$ATTR[$i]}) {
						$OrdTags{$feat} = $ATTR[$i]{$feat};
					}
					foreach my $feat (sort keys %OrdTags) {
						$saida .= "$feat:$OrdTags{$feat}|";
					}
					if($pipe){#<ignore-line>
						print "$saida\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,$saida);
					}#<ignore-line>
				}
				##Colocar a zero os vectores de cada oraçao
				@Token=();
				@Tag=();
				@Lemma=();
				@Attributes=();
				@ATTR=();   
			}
#########SAIDA STANDARD DO ANALISADOR 
			elsif ($flag eq "-a") {
				##Escrever a oraçao que vai ser analisada:
				if($pipe){#<ignore-line>
					print "SENT::$seq\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"SENT::$seq");
				}#<ignore-line>
				#print STDERR "LIST:: $listTags\n";
				####imprimir Hash de dependencias ordenado:
				foreach my $triplet (sort {$Ordenar{$a} <=> $Ordenar{$b} } keys %Ordenar ) {
					$triplet =~ s/^\(//;
					$triplet =~ s/\)$//;
					my ($re, $he, $de) =  split (";", $triplet);#<string>
					if ($re !~ /($DepLex)/) {
						($he , my $ta1, my $pos1) = split ("_", $he);#<string>
						$he = $Lemma[$pos1];
						($de ,my $ta2, my $pos2) = split ("_", $de);#<string>
						$de = $Lemma[$pos2];
						$triplet = "$re;$he\_$ta1\_$pos1;$de\_$ta2\_$pos2" ;
					}
					if($pipe){#<ignore-line>
						print "($triplet)\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"($triplet)");
					}#<ignore-line>
				}
				##final de analise de frase:
				if($pipe){#<ignore-line>
					print "---\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"---");
				}#<ignore-line>
			}
###SAIDA ANALISADOR COM ESTRUTURA ATRIBUTO-VALOR (full analysis)
			elsif ($flag eq "-fa") {
				##Escrever a oraçao que vai ser analisada:
				if($pipe){#<ignore-line>
					print "SENT::$seq\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"SENT::$seq");
				}#<ignore-line>
				#print STDERR "LIST:: $listTags\n";
				####imprimir Hash de dependencias ordenado:
				my $re="";#<string>
				foreach my $triplet (sort {$Ordenar{$a} <=>
					$Ordenar{$b} }
					keys %Ordenar ) {
					$triplet =~ s/^\(//;
					$triplet =~ s/\)$//;
					($re, my $he,my $de) =  split (";", $triplet);#<string>

					if ($re !~ /($DepLex)/) { ##se rel nao e lexical
						my ($he1, $ta1, $pos1) = split ("_", $he);#<string>
						$he1 = $Lemma[$pos1];
						my ($de2 ,$ta2, $pos2) = split ("_", $de);#<string>
						$de2 = $Lemma[$pos2];
						$triplet = "$re;$he1\_$ta1\_$pos1;$de2\_$ta2\_$pos2";
					}
					if($pipe){#<ignore-line>
						print "($triplet)\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"($triplet)");
					}#<ignore-line>

					($he, my $ta, my $pos) = split ("_", $he);#<string>
					my $saida = "HEAD::$he\_$ta\_$pos<";#<string>
					$ATTR[$pos]{"lemma"} = $Lemma[$pos];
					$ATTR[$pos]{"token"} = $Token[$pos];
					foreach my $feat (sort keys %{$ATTR[$pos]}) {
						$saida .= "$feat:$ATTR[$pos]{$feat}|";
					}
					if($pipe){#<ignore-line>
						print "$saida>\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"$saida>");
					}#<ignore-line>

					($de, $ta, $pos) = split ("_", $de);#<string>
					$saida = "DEP::$de\_$ta\_$pos<";
					$ATTR[$pos]{"lemma"} = $Lemma[$pos];
					$ATTR[$pos]{"token"} = $Token[$pos];
					foreach my $feat (sort keys %{$ATTR[$pos]}) {
						$saida .= "$feat:$ATTR[$pos]{$feat}|" ;
					}
					if($pipe){#<ignore-line>
						print "$saida>\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"$saida>");
					}#<ignore-line>

					if ($re =~ /\//) {
						my ($depName, $reUnit) = split ('\/', $re);#<string>
						(my $reLex, $ta, $pos) = split ("_", $reUnit);#<string>
						$saida =  "REL::$reLex\_$ta\_$pos<";
						$ATTR[$pos]{"lemma"} = $Lemma[$pos];
						$ATTR[$pos]{"token"} = $Token[$pos];
						foreach my $feat (sort keys %{$ATTR[$pos]}) {
							$saida .= "$feat:$ATTR[$pos]{$feat}|" ;
						}
						if($pipe){#<ignore-line>
							print "$saida>\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida,"$saida>");
						}#<ignore-line>
					}
				}
				##final de analise de frase:
				if($pipe){#<ignore-line>
					print "---\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"---");
				}#<ignore-line>
			}
    
			##Colocar numa lista vazia os strings com os tags (listTags) e a oraçao (seq)
			##Borrar hash ordenado de triplets

			$i=0;
			$j=0;
			$listTags="";
			$seq="";
			%Ordenar=();
			@Token=();
			@Tag=();
			@Lemma=();
			@Attributes=();
			@ATTR=();  
	   
		} ##fim do elsif

	}

	#print "\n";
	return \@saida;
}


sub HeadDep {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);


		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			my $Rel =  $y ;#<string>
			$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && 
				($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) && ##a modificar: so no caso de que atr = number or genre (N = invariable or neutral)
				($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {

				$found=1;
				}
			}

			# print STDERR "Found: $found\n";
			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				my $Rel =  $y ;#<string>
				$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
			}
		}
	}
}


sub DepHead {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	# print STDERR "-$y-, -$z-, -@x-\n";

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			my $Rel =  $y;#<string>
			$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {
				$found=1;
				}
			}

			#  print STDERR "Found: $found\n";
			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
				$found=0;
			} else  {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
				$found=0;
				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				my $Rel =  $y;#<string>
				$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
			}
		}
	}
}


sub DepRelHead {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
					($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
					($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;


				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub HeadRelDep {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Rel = $y . "_" . $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);


		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) && 
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found)  {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}";
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub RelDepHead {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;


				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub RelHeadDep {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
				($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
				($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
				$found = 1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub DepHeadRel {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		$m++;
		my $Rel = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
					($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
					($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found = 1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub HeadDepRel {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}";
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}";

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
					($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
					($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;
			}
		}
	}
}


sub HeadDep_lex {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}" ;
			my $Rel =  $y;#<string>
			#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
			#print STDERR "head::$Head -- dep:::$Dep\n";

			if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} . "\@$Lemma[$n2]" ;
				# $ATTR_token{$n1} = $ATTR[$n1]{"token"} .  "\@$Token[$n2]";
				$IDF{$n1}++;
			} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} .  "\@$ATTR_lemma{$n2}" ;
				#$ATTR_token{$n1} = $ATTR[$n1]{"token"} .   "\@$ATTR_token{$n2}";
				$IDF{$n1}++;
			} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} .=   "\@$Lemma[$n2]";
				#$ATTR_token{$n1} .=   "\@$Token[$n2]";
			} else {
				$ATTR_lemma{$n1} .=    "\@$ATTR_lemma{$n2}" ;
				#$ATTR_token{$n1} .=    "\@$ATTR_token{$n2}";
			}
			#print STDERR "$n1::: $ATTR_lemma{$n1} -- $ATTR_token{$n1} \n";
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {
					$found = 1;
				}
			}

			# print STDERR "Found: $found\n";
			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
				$found=0;

				#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}";
				my $Rel =  $y;#<string>
				#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}";

				$Ordenar{"($Rel;$Head;$Dep)"} = $n2;

				if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
					$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} . "\@$Lemma[$n2]" ;
					# $ATTR_token{$n1} = $ATTR[$n1]{"token"} .  "\@$Token[$n2]";
					$IDF{$n1}++;
				} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
					$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} .  "\@$ATTR_lemma{$n2}" ;
					#$ATTR_token{$n1} = $ATTR[$n1]{"token"} .   "\@$ATTR_token{$n2}";
					$IDF{$n1}++;
				} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
					$ATTR_lemma{$n1} .=   "\@$Lemma[$n2]" ;
					#$ATTR_token{$n1} .=   "\@$Token[$n2]";
				} else {
					$ATTR_lemma{$n1} .=    "\@$ATTR_lemma{$n2}";
					#$ATTR_token{$n1} .=    "\@$ATTR_token{$n2}";
				}
			}
		}
		$Lemma[$n1] = $ATTR_lemma{$n1};
		# $Token[$n1] = $ATTR_token{$n1};
	}
}


sub DepHead_lex {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>

		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}" ;
			my $Rel =  $y;#<string>
			#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}" ;
			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

			#print STDERR "OKKKK: #$Dep - $n2#\n";
			if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n2]{"lemma"} . "\@$Lemma[$n1]" ;
				#$ATTR_token{$n1} = $ATTR[$n2]{"token"} .  "\@$Token[$n1]";
				$IDF{$n1}++;
			} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} =   "$ATTR_lemma{$n2}\@"  . $ATTR[$n1]{"lemma"}  ;
				#$ATTR_token{$n1} =   "$ATTR_token{$n2}\@" .  $ATTR[$n1]{"token"};
				$IDF{$n1}++;
		} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
			$ATTR_lemma{$n1} .=   "$Lemma[$n2]\@";
			#$ATTR_token{$n1} .=   "$Token[$n2]\@";
		} else {
			$ATTR_lemma{$n1} .=    "$ATTR_lemma{$n1}\@" ;
			#$ATTR_token{$n1} .=    "$ATTR_token{$n1}\@" ;
		}
	} else {
		foreach my $atr (@z) {
			if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
			 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "")  ) {
				$found=1;
			}
		}
		# print STDERR "Found: $found\n";
		if ($found) {
			$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
			$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
			$found=0;
		} else {
			$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
			$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
			$found=0;
			#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}";
			my $Rel =  $y;#<string>
			#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}";
			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

			if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n2]{"lemma"} . "\@$Lemma[$n1]" ;
				#$ATTR_token{$n1} = $ATTR[$n2]{"token"} .  "\@$Token[$n1]";
				$IDF{$n1}++;
			} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} =   "$ATTR_lemma{$n2}\@"  . $ATTR[$n1]{"lemma"}  ;
				#$ATTR_token{$n1} =   "$ATTR_token{$n2}\@" .  $ATTR[$n1]{"token"};
				$IDF{$n1}++;
			} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} .=   "$Lemma[$n2]\@";
				#$ATTR_token{$n1} .=   "$Token[$n2]\@";
			} else {
				$ATTR_lemma{$n1} .=    "$ATTR_lemma{$n1}\@";
				#$ATTR_token{$n1} .=    "$ATTR_token{$n1}\@";
			}
		}
	}
	$Lemma[$n1] = $ATTR_lemma{$n1} ;
	#$Token[$n1] = $ATTR_token{$n1} ;
	}
}



sub Head {
	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>

	return 1;
}


sub LEX {

	foreach my $idf (keys %IDF) {
		#print STDERR "idf = $idf";

		##parche para \2... \pi...:
		# $ATTR[$idf]{"lemma"}  =~ s/[\\]/\\\\/g ;
		# $ATTR[$idf]{"token"}  =~ s/[\\]/\\\\/g ;

		$listTags =~ s/($Tag[$idf]_${idf}${l})lemma:$ATTR[$idf]{'lemma'}/${1}lemma:$ATTR_lemma{$idf}/;
		# $listTags =~ s/($Tag[$idf]_${idf}${l})token:$ATTR[$idf]{"token"}/${1}token:$ATTR_token{$idf}/;

		delete $IDF{$idf};
		delete $ATTR_lemma{$idf};
		#delete $ATTR_token{$idf};
	}
}


##Operaçoes Corr, Inherit, Add, 
sub Corr {

	(my $z, my $y,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $atr="";#<string>
	my $value="";#<string>
	my $info="";#<string>
	my $attribute="";#<string>
	my $entry="";#<string>

	my @y = split (",", $y);#<array><string>


	if ($z eq "Head") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##token:=lemma / lemma:=token
				if ($value =~ /^=/) {
					$value =~ s/^=//;
					$ATTR[$n1]{$atr} = $ATTR[$n1]{$value} ;
					if ($value eq "token") {
						$Lemma[$n1] = $ATTR[$n1]{$value} ;
					} elsif ($value eq "lemma") {
						$Token[$n1] = $ATTR[$n1]{$value} ;
					}
				} 
				##change the PoS tag:
				elsif ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$entry = "${value}_${n1}_<";
					if (activarTags($value,$n1)) {
						foreach my $attribute (sort keys %{$ATTR[$n1]}) {
							#print STDERR "--atribs: $attribute\n";      
							if (defined $TagStr{$attribute}) {
								$entry .= "$attribute:$ATTR[$n1]{$attribute}|" ;
								#print STDERR "atribute defined : $attribute --$entry\n";
							} else {
								#$entry .= "$attribute:$TagStr{$attribute}|" ;
								delete $ATTR[$n1]{$attribute} ;
								#print STDERR "++entry : $entry\n";
							} 
						}

						foreach my $attribute (sort keys %TagStr) {
							#print STDERR "++atribs: $attribute\n";      
							if (!defined $ATTR[$n1]{$attribute}) {
								$entry .= "$attribute:$ATTR[$n1]{$attribute}|" ;
								$ATTR[$n1]{$attribute} = $TagStr{$attribute};
								#print STDERR "++atribute defined : $attribute --$entry\n";
							}
						}
					}
					$entry .= ">";
					#print STDERR  "--$entry\n" ;
					$listTags =~ s/$Tag[$n1]_$n1$a2/$entry/;
					$Tag[$n1] = $value;
					desactivarTags($value);
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};  
					}
				}
			}
		}
	}
}


sub Inherit {

	(my $z, my $y,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>

	my @y = split (",", $y);#<array><string>

	if ($z eq "DepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "HeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "DepRelHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m +=2;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "HeadRelDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m +=2;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "RelDepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "RelHeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "DepHeadRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};               
			}
		}
	} elsif ($z eq "HeadDepRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
			}
		}
	} elsif ($z eq "DepHead_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/);
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
					$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
			}
		}
	} elsif ($z eq "HeadDep_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
			}
		}
	}
}


sub Add {

	(my $z, my $y,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $atr="";#<string>
	my $value="";#<string>
	my $info="";#<string>

	my @y = split (",", $y);#<array><string>

 
	if ($z eq "Head") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;
				if ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "DepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/);
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $info (@y) {
				($atr, $value) = split (":", $info);
				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]/$value/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
					#print STDERR "$atr - $value : #$l# - #$r#";
					} else {
						$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
						$ATTR[$n1]{$atr} = $value;
						if ($atr eq "lemma") {
							$Lemma[$n1] = $ATTR[$n1]{"lemma"};
				}
				if ($atr eq "token") {
					$Token[$n1] = $ATTR[$n1]{"token"};
				}
				#print STDERR "$atr - $value ::: #$l# - #$r#";
				}
			}
		}
	} elsif ($z eq "HeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]/$value/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value; 
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "DepRelHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m+=2;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]/$value/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "HeadRelDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m +=2;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
				$ATTR[$n1]{$atr} = $value;
				$listTags =~ s/$Tag[$n1]/$value/;
				$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "RelDepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]/$value/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "RelHeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]/$value/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "DepHeadRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]/$value/;
					$Tag[$n1] = $value;
				} elsif ($listTags  =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "HeadDepRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]/$value/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
				if ($atr eq "lemma") {
					$Lemma[$n1] = $ATTR[$n1]{"lemma"};
				}
				if ($atr eq "token") {
					$Token[$n1] = $ATTR[$n1]{"token"};
				}
				$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "DepHead_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]/$value/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} 

	if ($z eq "HeadDep_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]/$value/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}${info}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					#print STDERR "$atr - $value ::: #$l# - #$r#";
				}
			}
		}
	} 
}


sub negL {

	my ($x) = @_ ;#<string>
	my $expr="";#<string>
	my $ref="";#<string>
	my $CAT="";#<string>

	($CAT, $ref) = split ("_", $x);  
	$expr = "(?<!${CAT})\\_$ref";


	return $expr;
}


sub negR {

	my ($x) = @_ ;#<string>
	my $expr="";#<string>
	my $ref="";#<string>
	my $CAT="";#<string>

	($CAT, $ref) = split ("_", $x); 
	$expr = "?!${CAT}\\_$ref";

	return $expr;
}



sub activarTags {

	my ($x, #<string>
	$pos) = @_ ; #<integer>

	##shared attributes:
	# $TagStr{"tag"} = 0;
	$TagStr{"lemma"} = 0;
	$TagStr{"token"} = 0;

	if ($x =~ /^PRO/) {
		$TagStr{"type"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"case"} = 0;
		$TagStr{"possessor"} = 0;
		$TagStr{"politeness"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##conjunctions:
	elsif ($x =~ /^C/) {
		$TagStr{"type"} =  0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##interjections:
	elsif ($x =~ /^I/) {
		$TagStr{"type"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##numbers
	elsif ($x =~  /^CARD/) {
		$TagStr{"number"} = "P";
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	elsif ($x =~ /^ADJ/) {
		$TagStr{"type"} = 0;
		$TagStr{"degree"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"function"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	elsif ($x =~ /^ADV/) {
		$TagStr{"type"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	elsif ($x =~ /^PRP/) {
		$TagStr{"type"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
   elsif ($x =~ /^NOUN/) {    
		$TagStr{"type"} = 0 ;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
   }
   elsif ($x =~ /^DT/) {
		$TagStr{"type"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"possessor"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
   }
  ##mudar tags nos verbos:
   elsif ($x =~ /^VERB/) {
		$TagStr{"type"} = 0;
		$TagStr{"mode"} = 0;
		$TagStr{"tense"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;  
   }
   else {
		return 0;
   }
}


sub desactivarTags {

	my ($x) = @_ ; #<string>

	delete $TagStr{"type"} ;
	delete $TagStr{"person"};
	delete $TagStr{"gender"} ;
	delete $TagStr{"number"} ;
	delete $TagStr{"case"} ;
	delete $TagStr{"possessor"} ;
	delete $TagStr{"politeness"} ;
	delete $TagStr{"mode"} ;
	delete $TagStr{"tense"} ;
	delete $TagStr{"function"} ;
	delete $TagStr{"degree"} ;
	delete $TagStr{"pos"} ;     

	delete $TagStr{"lemma"} ;
	delete $TagStr{"token"} ;
	# delete $TagStr{"tag"} ;
	return 1;
}


sub ConvertChar {

	my ($x, $y) = @_ ;#<string>

	$info =~ s/lemma:$x/lemma:\*$y\*/g; 
	$info =~ s/token:$x/token:\*$y\*/g;

}

sub ReConvertChar {

	my ($x, $y, $z) = @_ ;#<string>

	$Attributes[$z] =~ s/lemma:\*$y\*/lemma:$x/g;
	$Attributes[$z] =~ s/token:\*$y\*/token:$x/g;
	$ATTR[$z]{"lemma"} =~ s/\*$y\*/$x/g;
	$ATTR[$z]{"token"} =~ s/\*$y\*/$x/g;
	$Token[$z] =~ s/\*$y\*/$x/g;
	$Lemma[$z] =~ s/\*$y\*/$x/g;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	parse(\@lines, shift(@ARGV));
}
#<ignore-block>