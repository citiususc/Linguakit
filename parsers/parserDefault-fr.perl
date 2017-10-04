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
my $DET = "DT_[0-9]+";#<string>
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
my $SENT = "SENT_[0-9]+";#<string>
my $NOMINAL = "NOUN_[0-9]+$a2|CONJ_[0-9]+${l}coord:noun${r}";#<string>
my $NOUNCOORD = "CARD_[0-9]+$a2|DATE_[0-9]+$a2|NOUN_[0-9]+$a2|CONJ_[0-9]+${l}coord:noun${r}";#<string>
my $NOUNSINGLE = "CARD_[0-9]+$a2|DATE_[0-9]+$a2|NOUN_[0-9]+";#<string>
my $NPCOORD = "CONJ_[0-9]+${l}coord:np${r}|NOUN_[0-9]+${l}type:P${r}";#<string>
my $X = "[A-Z]+_[0-9]+";#<string>
my $NOTVERB = "[^V][^E]+_[0-9]+";#<string>
my $PUNCT = "F[a-z]+_[0-9]+";#<string>



#################################### LEXICAL CLASSES #####################################
my $Quant  = "(?:very\|more\|less\|least\|most\|quite\|as\|muy\|mucho\|bastante\|bien\|casi\|tan\|muy\|bem\|ben\|menos\|poco\|mui\|moi\|muito\|tão\|más\|mais\|máis\|pouco\|peu\|assez\|plus\|moins\|aussi\|)";#<string>
my $Partitive  = "(?:de\|of\|)";#<string>
my $PrepLocs  = "(?:a\|de\|por\|par\|by\|to\|)";#<string>
my $PrepRA  = "(?:de\|com\|con\|sobre\|sem\|sen\|entre\|of\|with\|about\|without\|between\|on\|avec\|sûr\|)";#<string>
my $PrepMA  = "(?:hasta\|até\|hacia\|desde\|em\|en\|para\|since\|until\|at\|in\|for\|to\|jusqu\'\|depuis\|pour\|dans\|)";#<string>
my $cliticopers  = "(?:lo\|la\|los\|las\|le\|les\|nos\|os\|me\|te\|se\|Lo\|La\|Las\|Le\|Les\|Nos\|Os\|Me\|Te\|Se\|lle\|lles\|lhe\|lhes\|Lles\|Lhes\|Lle\|Lhe\|che\|ches\|Che\|Ches\|o\|O\|a\|A\|him\|her\|me\|us\|you\|them\|lui\|leur\|leurs\|)";#<string>
my $PROperssuj = "(?:yo\|tú\|usted\|él\|ella\|nosotros\|vosotros\|ellos\|ellas\|ustedes\|eu\|ti\|tu\|vostede\|você\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocês\|eles\|elas\|you\|i\|we\|they\|he\|she\|je\|il\|elle\|ils\|elles\|nous\|vous\|)";#<string>
my $PROsujgz = "(?:eu\|ti\|tu\|vostede\|você\|el\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocês\|eles\|elas\|)";#<string>
my $VModalEN  = "(?:can\|cannot\|should\|must\|shall\|will\|would\|may\|might\|)";#<string>
my $Vpass  = "(?:ser\|be\|être\|)";#<string>
my $Vaux  = "(?:haber\|haver\|ter\|have\|avoir\|)";#<string>
my $NincSp  = "(?:alusión\|comentario\|referencia\|llamamiento\|mención\|observación\|declaración\|propuesta\|pregunta\|)";#<string>
my $NincExp  = "(?:afecto\|alegría\|amparo\|angustia\|ánimo\|cariño\|cobardía\|comprensión\|consuelo\|corte\|daño\|disgusto\|duda\|escándalo\|fobia\|gana\|gracias\|gusto\|inquietud\|)";#<string>
my $PTa  = "(?:aceder\|acostumar\|acudir\|adaptar\|comprometer\|chegar\|cheirar\|dar\|dedicar\|equivaler\|ir\|olhar\|negar\|pertencer\|recorrer\|referir\|regressar\|renunciar\|subir\|sustrair\|unir\|vincular\|voltar\|acostumbrar\|llegar\|oler\|mirar\|pertenecer\|recurrir\|sustraer\|volver\|)";#<string>


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
					# Single: [NOUN] [Fc]? CONJ<type:S> [NOUN] [VERB]
					# Corr: tag:PRO, type:R
					@temp = ($listTags =~ /(?:$NOUN$a2)(?:$Fc$a2)?($CONJ${l}type:S\|${r})(?:$NOUN$a2)(?:$VERB$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)?($CONJ${l}type:S\|${r})($NOUN$a2)($VERB$a2)/$1$2$3$4$5/g;
					Corr("Head","tag:PRO,type:R",\@temp);

					# PunctR: X Fz|Fe
					@temp = ($listTags =~ /($X$a2)($Fz$a2|$Fe$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X$a2)($Fz$a2|$Fe$a2)/$1/g;

					# PunctL: Fz|Fe X
					@temp = ($listTags =~ /($Fz$a2|$Fe$a2)($X$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fz$a2|$Fe$a2)($X$a2)/$2/g;

					# >: VERB<lemma:tener|ter|haber|haver|take|have> NOUN<number:S> [PRP]
					@temp = ($listTags =~ /($VERB${l}lemma:(?:tener|ter|haber|haver|take|have)\|${r})($NOUN${l}number:S\|${r})(?:$PRP$a2)/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:tener|ter|haber|haver|take|have)\|${r})($NOUN${l}number:S\|${r})($PRP$a2)/$1$3/g;
					LEX();

					# >: VERB<lemma:be|ser> ADJ [PRP]
					@temp = ($listTags =~ /($VERB${l}lemma:(?:be|ser)\|${r})($ADJ$a2)(?:$PRP$a2)/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:be|ser)\|${r})($ADJ$a2)($PRP$a2)/$1$3/g;
					LEX();

					# <: [VERB<lemma:ser|tornar|converter|be|become>] ADV<lemma:$Quant> ADJ [CONJ|PRO<lemma:que|como>]
					# NEXT
					# >: VERB<lemma:ser|tornar|converter|be|become> [ADV<lemma:$Quant>] ADJ [CONJ|PRO<lemma:que|como>]
					# NEXT
					# >: VERB<lemma:ser|tornar|converter|be|become>  [ADV<lemma:$Quant>] [ADJ] CONJ|PRO<lemma:que|como>
					@temp = ($listTags =~ /(?:$VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})($ADV${l}lemma:$Quant\|${r})($ADJ$a2)(?:$CONJ$a2|$PRO${l}lemma:(?:que|como)\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})(?:$ADV${l}lemma:$Quant\|${r})($ADJ$a2)(?:$CONJ$a2|$PRO${l}lemma:(?:que|como)\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})(?:$ADV${l}lemma:$Quant\|${r})(?:$ADJ$a2)($CONJ$a2|$PRO${l}lemma:(?:que|como)\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})($ADV${l}lemma:$Quant\|${r})($ADJ$a2)($CONJ$a2|$PRO${l}lemma:(?:que|como)\|${r})/$1/g;
					LEX();

					# AdjnL: ADV<lemma:$Quant> ADV|ADJ
					@temp = ($listTags =~ /($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/$2/g;

					# AdjnL: ADV<lemma:[Mm]ais\@de> [DET]? CARD|NOUN
					@temp = ($listTags =~ /($ADV${l}lemma:[Mm]ais\@de\|${r})(?:$DET$a2)?($CARD$a2|$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:[Mm]ais\@de\|${r})($DET$a2)?($CARD$a2|$NOUN$a2)/$2$3/g;

					# PunctL: [ADJ] Fc ADJ [NOUN]
					# NEXT
					# AdjnL: ADJ [Fc] ADJ [NOUN]
					# Recursivity: 5
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;

					# CoordL: ADJ [Fc] [ADJ] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [ADJ]
					# NEXT
					# PunctL: [ADJ] Fc [ADJ] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [ADJ]
					# Recursivity: 10
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$3$4$5/g;

					# CoordL: [Fc]? ADJ CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [ADJ]
					# NEXT
					# CoordR: [Fc]? [ADJ] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> ADJ
					# Add: coord:adj
					# Inherit: gender, number
					@temp = ($listTags =~ /(?:$Fc$a2)?($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$1$3/g;
					Inherit("HeadDep","gender,number",\@temp);
					Add("HeadDep","coord:adj",\@temp);

					# PunctL: Fc CONJ<coord:adj>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:adj\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:adj\|${r})/$2/g;

					# AdjnR:  NOUN NOUN
					# Recursivity: 1
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$1/g;
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$1/g;

					# Single: [DET] ADJ [PRP]
					# Corr: tag:NOUN
					@temp = ($listTags =~ /(?:$DET$a2)($ADJ$a2)(?:$PRP$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($ADJ$a2)($PRP$a2)/$1$2$3/g;
					Corr("Head","tag:NOUN",\@temp);

					# SpecL: DET DET|PRO<type:X> [NOUN]
					# NEXT
					# SpecL: [DET] DET|PRO<type:X> NOUN
					@temp = ($listTags =~ /($DET$a2)($DET$a2|$PRO${l}type:X\|${r})(?:$NOUN$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$DET$a2)($DET$a2|$PRO${l}type:X\|${r})($NOUN$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($DET$a2|$PRO${l}type:X\|${r})($NOUN$a2)/$3/g;

					# AdjnL: [DET] VERB<mode:P> NOUN
					# NEXT
					# SpecL: DET [VERB<mode:P>] NOUN
					@temp = ($listTags =~ /(?:$DET$a2)($VERB${l}mode:P\|${r})($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($DET$a2)(?:$VERB${l}mode:P\|${r})($NOUN$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($VERB${l}mode:P\|${r})($NOUN$a2)/$3/g;

					# SpecL: DET CARD|DATE
					@temp = ($listTags =~ /($DET$a2)($CARD$a2|$DATE$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($CARD$a2|$DATE$a2)/$2/g;

					# SpecL: DET NOUN|PRO
					# Recursivity: 1
					@temp = ($listTags =~ /($DET$a2)($NOUN$a2|$PRO$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($NOUN$a2|$PRO$a2)/$2/g;
					@temp = ($listTags =~ /($DET$a2)($NOUN$a2|$PRO$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($NOUN$a2|$PRO$a2)/$2/g;

					# SpecL: PRO<type:D> PRO<type:R>
					@temp = ($listTags =~ /($PRO${l}type:D\|${r})($PRO${l}type:R\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}type:D\|${r})($PRO${l}type:R\|${r})/$2/g;

					# ClitL: PRO<token:$cliticopers> VERB
					# Recursivity: 1
					@temp = ($listTags =~ /($PRO${l}token:$cliticopers\|${r})($VERB$a2)/g);
					$Rel =  "ClitL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}token:$cliticopers\|${r})($VERB$a2)/$2/g;
					@temp = ($listTags =~ /($PRO${l}token:$cliticopers\|${r})($VERB$a2)/g);
					$Rel =  "ClitL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}token:$cliticopers\|${r})($VERB$a2)/$2/g;

					# ClitR: VERB PRO<token:$cliticopers>
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}token:$cliticopers\|${r})/g);
					$Rel =  "ClitR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}token:$cliticopers\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}token:$cliticopers\|${r})/g);
					$Rel =  "ClitR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}token:$cliticopers\|${r})/$1/g;

					# VSpecL: VERB<type:S> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
					# Add: voice:passive
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:S\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:S\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","voice:passive",\@temp);

					# VSpecL: VERB<(type:A)|(lemma:ter|haver|haber|avoir|have)> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
					# Add: type:perfect
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","type:perfect",\@temp);

					# VSpecL: VERB [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:N|G|P>
					# Recursivity: 1
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:(?:N|G|P)\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:(?:N|G|P)\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:(?:N|G|P)\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:(?:N|G|P)\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# VSpecLocL: VERB [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? PRP<lemma:$PrepLocs>|CONJ<lemma:que&type:S> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r}|$CONJ${l}lemma:que\|${b2}type:S\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecLocL";
					DepRelHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r}|$CONJ${l}lemma:que\|${b2}type:S\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:N\|${r})/$2$3$4$5$6$7$8$9$10$11$13$14$15$16$17$18$19$20$21$22$23/g;
					Inherit("DepRelHead","mode,person,tense,number",\@temp);

					# PunctL: [ADV<pos:0>] Fc VERB
					# NEXT
					# AdjnL: ADV<pos:0> [Fc] VERB
					@temp = ($listTags =~ /(?:$ADV${l}pos:0\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV${l}pos:0\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}pos:0\|${r})($Fc$a2)($VERB$a2)/$3/g;

					# PunctL: Fc [ADV] [Fc]? VERB
					# NEXT
					# PunctL: [Fc] [ADV] Fc VERB
					# NEXT
					# AdjnL: [Fc] ADV [Fc]? VERB
					@temp = ($listTags =~ /($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$ADV$a2)($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($ADV$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($ADV$a2)($Fc$a2)?($VERB$a2)/$4/g;

					# PunctR:  VERB [Fc]? [ADV] Fc
					# NEXT
					# PunctR: VERB Fc [ADV] [Fc]
					# NEXT
					# AdjnR: VERB [Fc]? ADV [Fc]
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?(?:$ADV$a2)($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?($ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($ADV$a2)($Fc$a2)/$1/g;

					# AdjnL:  ADV  VERB
					# Recursivity: 1
					@temp = ($listTags =~ /($ADV$a2)($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($VERB$a2)/$2/g;
					@temp = ($listTags =~ /($ADV$a2)($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($VERB$a2)/$2/g;

					# AdjnR: VERB [NOUN|PRO<type:D|P|I|X>]? ADV
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/$1$2/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2)/$1$2/g;

					# TermR: PRP NOUN [Fc] [PRP] [NOUN] [CONJ<lemma:and|or|y|e|et|o|ou>] [PRP] [NOUN]
					# NEXT
					# CoordL: PRP [NOUN] [Fc] [PRP] [NOUN] CONJ<lemma:and|or|y|e|et|o|ou> [PRP] [NOUN]
					# NEXT
					# PunctL: [PRP] [NOUN] Fc [PRP] [NOUN] CONJ<lemma:and|or|y|e|et|o|ou> [PRP] [NOUN]
					# Recursivity: 3
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8/g;
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8/g;
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8/g;
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8/g;

					# CoordL: [Fc]? PRP [NOUN] CONJ<lemma:and|or|y|e|et|o|ou> [PRP] [NOUN]
					# NEXT
					# TermR: [Fc]? [PRP] [NOUN] [CONJ<lemma:and|or|y|e|et|o|ou>] PRP NOUN
					# NEXT
					# TermR: [Fc]? PRP NOUN [CONJ<lemma:and|or|y|e|et|o|ou>] [PRP] [NOUN]
					# NEXT
					# CoordR: [Fc]? [PRP] [NOUN] CONJ<lemma:and|or|y|e|et|o|ou> PRP [NOUN]
					# Add: coord:cprep
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)($NOUN$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($PRP$a2)($NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$1$4/g;
					Add("HeadDep","coord:cprep",\@temp);

					# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7$8$9/g;

					# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7/g;

					# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

					# CprepR: [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3/g;

					# CprepR: NOUNSINGLE PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CprepR: CARD<lemma:uno|one|un|um> PRP NOUNSINGLE|PRO<type:D|P|I|X>
					# Add: tag:PRO
					@temp = ($listTags =~ /($CARD${l}lemma:(?:uno|one|un|um)\|${r})($PRP$a2)($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($CARD${l}lemma:(?:uno|one|un|um)\|${r})($PRP$a2)($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					Add("HeadRelDep","tag:PRO",\@temp);

					# CoordL: NOUN [Fc] [NOUN] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN]
					# NEXT
					# PunctL: [NOUN] Fc [NOUN] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN]
					# Recursivity: 10
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5/g;

					# CoordL: [Fc]? NOUN CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN]
					# NEXT
					# CoordR: [Fc]? [NOUN] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> NOUN
					# Add: coord:noun
					@temp = ($listTags =~ /(?:$Fc$a2)?($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$1$3/g;
					Add("HeadDep","coord:noun",\@temp);

					# PunctL: Fc CONJ<coord:noun>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:noun\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:noun\|${r})/$2/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# CprepR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB<mode:P> [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [Fc|Fpt|Fct]
					# NoUniq
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($VERB${l}mode:P\|${r})($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($Fc$a2|$Fpt$a2|Fct)/$1$2$3$4$5$6$7$8$9$10$11$12$13$14/g;

					# SubjL: [NOUNCOORD] PRO<type:R|W> VERB|CONJ<coord:verb>
					# NEXT
					# AdjnR: NOUNCOORD [PRO<type:R|W>] VERB|CONJ<coord:verb>
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD)($PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD)($PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/$1$2$3/g;

					# DobjL: [NOUNCOORD] PRO<type:R|W> [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>
					# NEXT
					# AdjnR: NOUNCOORD [PRO<type:R|W>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD)($PRO${l}type:(?:R|W)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD)(?:$PRO${l}type:(?:R|W)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD)($PRO${l}type:(?:R|W)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/$1$2$3$4/g;

					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  PRP PRO<type:R|W> VERB|CONJ<coord:verb>
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [PRP] [PRO<type:R|W>] VERB|CONJ<coord:verb>
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/$1$2$3$4/g;

					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X>  VERB<mode:[GP]>|CONJ<coord:verb>
					# NoUniq
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/$1$2/g;

					# CircR: VERB<lemma:$PTa> [NOUNCOORD|PRO<type:D|P|I|X>] PRP<lemma:a> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>|ADV
					@temp = ($listTags =~ /($VERB${l}lemma:$PTa\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r}|$ADV$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$PTa\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r}|$ADV$a2)/$1$2/g;

					# CircR: VERB<mode:P> [NOUNCOORD|PRO<type:D|P|I|X>] PRP<lemma:por|by> NOUNCOORD|PRO<type:D|P|I|X>|ADV
					@temp = ($listTags =~ /($VERB${l}mode:P\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}mode:P\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/$1$2/g;

					# PunctR: VERB Fc [NOUNCOORD|PRO<type:D|P|I|X>] [PRP<lemma:$PrepMA>] [CARD|DATE]
					# NEXT
					# CircR: VERB [Fc]? [NOUNCOORD|PRO<type:D|P|I|X>] PRP<lemma:$PrepMA> CARD|DATE
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP${l}lemma:$PrepMA\|${r})(?:$CARD$a2|$DATE$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/$1$3/g;

					# CprepR: CARD PRP<lemma:de|entre|sobre|of|about|between> NOUNCOORD|PRO
					@temp = ($listTags =~ /($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNCOORD|$PRO$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNCOORD|$PRO$a2)/$1/g;

					# CprepR: PRO<type:P> PRP<lemma:de|of> NOUNCOORD|PRO
					@temp = ($listTags =~ /($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNCOORD|$PRO$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNCOORD|$PRO$a2)/$1/g;

					# CprepR: NOUNCOORD [PRP] [PRO<type:D|P|I|X>] PRP NOUNCOORD|ADV
					# NEXT
					# CprepR: NOUNCOORD PRP PRO<type:D|P|I|X> [PRP] [NOUNCOORD|ADV]
					@temp = ($listTags =~ /($NOUNCOORD)(?:$PRP$a2)(?:$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($NOUNCOORD|$ADV$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)(?:$NOUNCOORD|$ADV$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($NOUNCOORD|$ADV$a2)/$1/g;

					# PrepR: VERB [NOUNCOORD|PRO<type:D|P|I|X>] CONJ<coord:cprep>
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/g);
					$Rel =  "PrepR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/$1$2/g;

					# PrepR: NOUNCOORD|PRO<type:D|P|I|X> CONJ<coord:cprep>
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/g);
					$Rel =  "PrepR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/$1/g;

					# DobjR: VERB NOMINAL|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB$a2)($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# AdjnR: VERB ADJ|CONJ<coord:adj>
					@temp = ($listTags =~ /($VERB$a2)($ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADJ$a2|$CONJ${l}coord:adj\|${r})/$1/g;

					# CoordL: VERB [Fc] [VERB] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [VERB]
					# NEXT
					# PunctL: [VERB] Fc [VERB] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [VERB]
					# Recursivity: 5
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;

					# CoordL: [Fc]? VERB CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [VERB]
					# NEXT
					# CoordR: [Fc]? [VERB] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> VERB
					# Add: coord:verb
					# Inherit: mode, tense
					@temp = ($listTags =~ /(?:$Fc$a2)?($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$1$3/g;
					Inherit("HeadDep","mode,tense",\@temp);
					Add("HeadDep","coord:verb",\@temp);

					}
{#<function>
					# PunctL: Fc CONJ<coord:verb>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:verb\|${r})/$2/g;

					# CircR: [VERB|CONJ<coord:verb>] [PRP] VERB|CONJ<coord:verb> [PRP] [CARD|NOUNCOORD|PRO<type:D|P|I|X>] PRP CARD|NOUNCOORD|PRO<type:D|P|I|X>
					# Recursivity: 1
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)(?:$CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)(?:$CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

					# CircR: [VERB|CONJ<coord:verb>] [PRP] VERB|CONJ<coord:verb> PRP CARD|NOUNCOORD|PRO<type:D|P|I|X>
					# NEXT
					# CircR: VERB|CONJ<coord:verb> PRP VERB|CONJ<coord:verb> [PRP] [CARD|NOUNCOORD|PRO<type:D|P|I|X>]
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)(?:$CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CircR: VERB|CONJ<coord:verb>  PRP VERB<mode:[^PG]>|ADV|CARD
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB${l}mode:[^PG]\|${r}|$ADV$a2|CARD)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB${l}mode:[^PG]\|${r}|$ADV$a2|CARD)/$1/g;
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB${l}mode:[^PG]\|${r}|$ADV$a2|CARD)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB${l}mode:[^PG]\|${r}|$ADV$a2|CARD)/$1/g;

					# SpecL: [VERB|CONJ<coord:verb>]  [PRP] DET<type:A>  VERB<mode:N>|ADV|CARD
					# NEXT
					# CircR: VERB|CONJ<coord:verb>  PRP  [DET<type:A>] VERB<mode:N>|ADV|CARD
					# Recursivity: 1
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|CARD)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)(?:$DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|CARD)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|CARD)/$1/g;
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|CARD)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)(?:$DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|CARD)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|CARD)/$1/g;

					# CircR: VERB|CONJ<coord:verb> PRP NOUNCOORD|PRO<type:D|P|I|X>
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# PunctR: VERB Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?
					# NEXT
					# PunctR: VERB [Fc] [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] Fc
					# NEXT
					# TermR: [VERB] [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]?
					# NEXT
					# CircR: VERB [Fc] PRP [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?
					# Recursivity:2
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;

					# PunctL: [PRP<pos:0>] [NOUNCOORD|PRO<type:D|P|I|X>] Fc  VERB
					# NEXT
					# CircL: PRP<pos:0> NOUNCOORD|PRO<type:D|P|I|X> [Fc]?  VERB
					@temp = ($listTags =~ /(?:$PRP${l}pos:0\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP${l}pos:0\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}pos:0\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB$a2)/$4/g;

					# PunctL: Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X> ] [Fc]  VERB
					# NEXT
					# PunctL: [Fc] [PRP] [NOUNCOORD|PRO<type:D|P|I|X> ] Fc  VERB
					# NEXT
					# CircL: [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X>  [Fc]  VERB
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB$a2)/$5/g;

					# AdjnR:  VERB<mode:[^PNG]> DATE
					@temp = ($listTags =~ /($VERB${l}mode:[^PNG]\|${r})($DATE$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}mode:[^PNG]\|${r})($DATE$a2)/$1/g;

					# PunctL: Fc [DATE] VERB<mode:[^PNG]>
					# NEXT
					# AdjnL:  [Fc]? DATE VERB<mode:[^PNG]>
					@temp = ($listTags =~ /($Fc$a2)(?:$DATE$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($DATE$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($DATE$a2)($VERB${l}mode:[^PNG]\|${r})/$3/g;

					# CprepR: NOUNCOORD PRP NOUNCOORD
					@temp = ($listTags =~ /($NOUNCOORD)($PRP$a2)($NOUNCOORD)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD)($PRP$a2)($NOUNCOORD)/$1/g;

					# SpecL: [VERB] CONJ<type:S>  VERB<mode:[^PNG]>
					# NEXT
					# DobjR: VERB  [CONJ<type:S>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}type:S\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}type:S\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}type:S\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# SpecL: [VERB]  CONJ<type:S>  [NOUNCOORD|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
					# NEXT
					# SubjL:  [VERB]  [CONJ<type:S>]  NOUNCOORD|PRO<type:D|P|I|X> VERB<mode:[^PNG]>
					# NEXT
					# DobjR: VERB   [CONJ<type:S>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}type:S\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$CONJ${l}type:S\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}type:S\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}type:S\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# SpecL: [VERB] [PRP] CONJ<lemma:que> VERB<mode:[^PNG]>
					# NEXT
					# CircR: VERB PRP [CONJ<lemma:que>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$PRP$a2)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)(?:$CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca VERB [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] VERB Fc|Fpt|Fct
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($VERB$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($VERB$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($VERB$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($VERB$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# CprepR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|Fct)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|Fca)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|Fct)/$1/g;

					# AdjnL: [Fc] VERB<mode:P> [Fc] VERB
					# NEXT
					# PunctL: Fc [VERB<mode:P>] [Fc] VERB
					# NEXT
					# PunctL: [Fc] [VERB<mode:P>] Fc VERB
					@temp = ($listTags =~ /(?:$Fc$a2)($VERB${l}mode:P\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fc$a2)(?:$VERB${l}mode:P\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$VERB${l}mode:P\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($VERB${l}mode:P\|${r})($Fc$a2)($VERB$a2)/$4/g;

					# CoordL: VERB [Fc] [VERB] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [VERB]
					# NEXT
					# PunctL: [VERB] Fc [VERB] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [VERB]
					# Recursivity: 5
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5/g;

					# CoordL: [Fc]? VERB CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [VERB]
					# NEXT
					# CoordR: [Fc]? [VERB] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> VERB
					# Add: coord:verb
					# Inherit: mode, tense
					@temp = ($listTags =~ /(?:$Fc$a2)?($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($VERB$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$1$3/g;
					Inherit("HeadDep","mode,tense",\@temp);
					Add("HeadDep","coord:verb",\@temp);

					# PunctL: Fc CONJ<coord:verb>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:verb\|${r})/$2/g;

					# SubjL: NOUN<type:P> VERB<mode:[^PG]>|CONJ<coord:verb&mode:[^PG]>
					# Add: subj:yes
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^PG]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","subj:yes",\@temp);

					# SubjL: NOMINAL|PRO<type:D|P|I|X> VERB<mode:[^PG]>|CONJ<coord:verb&mode:[^PG]>
					# Add: subj:yes
					@temp = ($listTags =~ /($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^PG]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","subj:yes",\@temp);

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>] VERB<subj:yes>|CONJ<subj:yes&coord:verb>    [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>] VERB<subj:yes>|CONJ<subj:yes&coord:verb>   Fc
					# NEXT
					# DobjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W> VERB<subj:yes>|CONJ<subj:yes&coord:verb>    [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>] VERB<subj:yes>|CONJ<subj:yes&coord:verb>    [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b2}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b2}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# SubjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W> VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>] VERB|CONJ<coord:verb>  [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRP PRO<type:R|W> VERB|CONJ<coord:verb>  [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>] VERB|CONJ<coord:verb>  [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc VERB<mode:[GP]>|CONJ<coord:verb>
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? VERB<mode:[GP]>|CONJ<coord:verb>
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/$1/g;

					# AdjnR: VERB CONJ<type:S> [VERB]
					# NEXT
					# AdjnR: VERB [CONJ<type:S>] VERB
					@temp = ($listTags =~ /($VERB$a2)($CONJ${l}type:S\|${r})(?:$VERB$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}type:S\|${r})($VERB$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}type:S\|${r})($VERB$a2)/$1/g;

					# TermR: PRP NOUNCOORD|PRO<type:D|P|I|X>|VERB
					# NoUniq
					@temp = ($listTags =~ /($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB$a2)/$1$2/g;

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