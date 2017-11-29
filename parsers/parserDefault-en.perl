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
my $DET = "DET_[0-9]+";#<string>
my $PRO = "PRO_[0-9]+";#<string>
my $VERB = "VERB_[0-9]+";#<string>
my $I = "I_[0-9]+";#<string>
my $DATE = "W_[0-9]+";#<string>
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
my $Fra = "Fra_[0-9]+";#<string>
my $Frc = "Frc_[0-9]+";#<string>
my $SENT = "SENT_[0-9]+";#<string>
my $NP = "NOUN_[0-9]+$a2|PRP_[0-9]+${l}nomin:yes${r}|VERB_[0-9]+${l}nomin:yes${r}";#<string>
my $NOMINAL = "NOUN_[0-9]+$a2|PRP_[0-9]+${l}nomin:yes${r}|VERB_[0-9]+${l}nomin:yes${r}|CONJ_[0-9]+${l}coord:noun${r}";#<string>
my $NOUNCOORD = "CARD_[0-9]+$a2|DATE_[0-9]+$a2|NOUN_[0-9]+$a2|CONJ_[0-9]+${l}coord:noun${r}";#<string>
my $NOUNSINGLE = "CARD_[0-9]+$a2|DATE_[0-9]+$a2|NOUN_[0-9]+";#<string>
my $NPCOORD = "CONJ_[0-9]+${l}coord:np${r}|NOUN_[0-9]+${l}type:P${r}";#<string>
my $X = "[A-Z]+_[0-9]+";#<string>
my $NOTVERB = "[^V][^E]+_[0-9]+";#<string>
my $PUNCT = "F[a-z]+_[0-9]+";#<string>



#################################### LEXICAL CLASSES #####################################
my $Quant  = "(?:very\|more\|less\|least\|most\|quite\|as\|muy\|mucho\|bastante\|bien\|casi\|tan\|muy\|bem\|ben\|menos\|poco\|mui\|moi\|muito\|tão\|más\|mais\|máis\|pouco\|peu\|assez\|plus\|moins\|aussi\|)";#<string>
my $temporal  = "(?:day\|week\|month\|year\|)";#<string>
my $Partitive  = "(?:de\|of\|)";#<string>
my $PrepLocs  = "(?:a\|de\|por\|par\|by\|to\|)";#<string>
my $PrepRA  = "(?:de\|com\|con\|sobre\|sem\|sen\|entre\|of\|with\|about\|without\|between\|on\|avec\|sûr\|)";#<string>
my $PrepMA  = "(?:hasta\|até\|hacia\|desde\|em\|en\|para\|since\|until\|at\|in\|for\|to\|jusqu
\|depuis\|pour\|dans\|)";#<string>
my $cliticopers  = "(?:lo\|la\|los\|las\|le\|les\|nos\|os\|me\|te\|se\|Lo\|La\|Las\|Le\|Les\|Nos\|Os\|Me\|Te\|Se\|lle\|lles\|lhe\|lhes\|Lles\|Lhes\|Lle\|Lhe\|che\|ches\|Che\|Ches\|o\|O\|a\|A\|him\|her\|me\|us\|you\|them\|lui\|leur\|leurs\|)";#<string>
my $PROperssuj = "(?:yo\|tú\|usted\|él\|ella\|nosotros\|vosotros\|ellos\|ellas\|ustedes\|eu\|ti\|tu\|vostede\|você\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocês\|eles\|elas\|you\|i\|we\|they\|he\|she\|je\|il\|elle\|ils\|elles\|nous\|vous\|)";#<string>
my $PROsujgz = "(?:eu\|ti\|tu\|vostede\|você\|el\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocês\|eles\|elas\|)";#<string>
my $VModalEN  = "(?:can\|cannot\|should\|must\|shall\|will\|would\|may\|might\|)";#<string>
my $Vpass  = "(?:ser\|be\|être\|)";#<string>
my $Vaux  = "(?:haber\|haver\|ter\|have\|avoir\|)";#<string>
my $VTwoObj  = "(?:give\|lend\|offer\|pass\|post\|read\|sell\|send\|show\|promise\|tell\|bring\|buy\|cost\|get\|leave\|make\|owe\|pay\|play\|read\|refuse\|show\|sing\|take\|teach\|wish\|write\|)";#<string>
my $VPhAbout  = "(?:bring\|)";#<string>
my $VPhAgainst  = "(?:hold\|)";#<string>
my $VPhAlong  = "(?:help\|)";#<string>
my $VPhAround  = "(?:jerk\|knock\|)";#<string>
my $VPhAway  = "(?:give\|put\|think\|)";#<string>
my $VPhBack  = "(?:call\|get\|give\|put\|answer\|hit\|hold\|keep\|knock\|)";#<string>
my $VPhDown  = "(?:let\|take\|write\|tear\|tur\|)";#<string>
my $VPhFrom  = "(?:keep\|)";#<string>
my $VPhIn  = "(?:call\|fill\|get\|hand\|turn\|ask\|deal\|do\|hand\|keep\|)";#<string>
my $VPhOff  = "(?:call\|drop\|get\|put\|show\|shut\|sit\|take\|turn\|cross\|cut\|finish\|)";#<string>
my $VPhOn  = "(?:bring\|go\|put\|take\|turn\|try\|)";#<string>
my $VPhOut  = "(?:ask\|cross\|cut\|figure\|fill\|give\|keep\|kick\|pick\|point\|put\|spell\|take\|throw\|bail\|find\|clean\|freak\|have\|hear\|help\|)";#<string>
my $VPhOver  = "(?:do\|look\|take\|think\|)";#<string>
my $VPhUnder  = "(?:keep\|)";#<string>
my $VPhUp  = "(?:bring\|call\|cancel\|cheer\|clean\|chop\|come\|do\|give\|hang\|look\|make\|pick\|tear\|turn\|ask\|beat\|brake\|cheer\|dress\|get\|harry\|)";#<string>


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
					# Single: [X] CONJ<lemma:and|or|y|e|et|o|ou>
					# Add: coord:no
					@temp = ($listTags =~ /(?:$X$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})/$1$2/g;
					Add("Head","coord:no",\@temp);

					# Single: PRP<lemma:so|because|though|if|whether|while> [X]?
					# Corr: tag:CONJ, type:S
					@temp = ($listTags =~ /($PRP${l}lemma:(?:so|because|though|if|whether|while)\|${r})(?:$X$a2)?/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}lemma:(?:so|because|though|if|whether|while)\|${r})($X$a2)?/$1$2/g;
					Corr("Head","tag:CONJ,type:S",\@temp);

					# Single: ADV<lemma:however> [X]?
					# Corr: tag:CONJ, type:S
					@temp = ($listTags =~ /($ADV${l}lemma:however\|${r})(?:$X$a2)?/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:however\|${r})($X$a2)?/$1$2/g;
					Corr("Head","tag:CONJ,type:S",\@temp);

					# Single: PRO<lemma:i|we|he|she|they>
					# Corr: type:S
					@temp = ($listTags =~ /($PRO${l}lemma:(?:i|we|he|she|they)\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:(?:i|we|he|she|they)\|${r})/$1/g;
					Corr("Head","type:S",\@temp);

					# Single: [NOUN] [Fc]? CONJ<lemma:that|which> [NOUN|PRO<type:D|P|I|X>] [VERB]
					# Corr: tag:PRO, type:W
					@temp = ($listTags =~ /(?:$NOUN$a2)(?:$Fc$a2)?($CONJ${l}lemma:(?:that|which)\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$VERB$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)?($CONJ${l}lemma:(?:that|which)\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/$1$2$3$4$5/g;
					Corr("Head","tag:PRO,type:W",\@temp);

					# Single: [PRO<lemma:it|there>] [VERB<lemma:be>] [NOUN] PRO<lemma:that>
					# Corr: tag:CONJ, type:S
					@temp = ($listTags =~ /(?:$PRO${l}lemma:(?:it|there)\|${r})(?:$VERB${l}lemma:be\|${r})(?:$NOUN$a2)($PRO${l}lemma:that\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:(?:it|there)\|${r})($VERB${l}lemma:be\|${r})($NOUN$a2)($PRO${l}lemma:that\|${r})/$1$2$3$4/g;
					Corr("Head","tag:CONJ,type:S",\@temp);

					# Single: [DET] VERB [NOUN]
					# Corr: tag:ADJ type:Q
					@temp = ($listTags =~ /(?:$DET$a2)($VERB$a2)(?:$NOUN$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($VERB$a2)($NOUN$a2)/$1$2$3/g;
					Corr("Head","tag:ADJ,type:Q",\@temp);

					# Single: [NOUN] VERB<mode:P>
					# Corr: mode:0
					@temp = ($listTags =~ /(?:$NOUN$a2)($VERB${l}mode:P\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($VERB${l}mode:P\|${r})/$1$2/g;
					Corr("Head","mode:0",\@temp);

					# Single: PRO<type:X> [ADJ]? [NOUN]
					# Corr: tag:DET, type:P
					@temp = ($listTags =~ /($PRO${l}type:X\|${r})(?:$ADJ$a2)?(?:$NOUN$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}type:X\|${r})($ADJ$a2)?($NOUN$a2)/$1$2$3/g;
					Corr("Head","tag:DET,type:P",\@temp);

					# Single: X<token:a|an> [NOUN|ADJ|ADV]
					# Corr: tag:DET, type:I, lemma:=token
					@temp = ($listTags =~ /($X${l}token:(?:a|an)\|${r})(?:$NOUN$a2|$ADJ$a2|$ADV$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X${l}token:(?:a|an)\|${r})($NOUN$a2|$ADJ$a2|$ADV$a2)/$1$2/g;
					Corr("Head","tag:DET,type:I,lemma:=token",\@temp);

					# Single: X<token:–> [X]
					# Corr: tag:Fe
					@temp = ($listTags =~ /($X${l}token:–\|${r})(?:$X$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X${l}token:–\|${r})($X$a2)/$1$2/g;
					Corr("Head","tag:Fe",\@temp);

					# Single: [X<lemma:este>] X<lemma:january|february|march|april|may|june|july|august|september|october|november|december>
					# Corr: tag:DATE
					@temp = ($listTags =~ /(?:$X${l}lemma:este\|${r})($X${l}lemma:(?:january|february|march|april|may|june|july|august|september|october|november|december)\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:este\|${r})($X${l}lemma:(?:january|february|march|april|may|june|july|august|september|october|november|december)\|${r})/$1$2/g;
					Corr("Head","tag:DATE",\@temp);

					# PunctR: X Fz|Fe|Frc
					@temp = ($listTags =~ /($X$a2)($Fz$a2|$Fe$a2|$Frc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($X$a2)($Fz$a2|$Fe$a2|$Frc$a2)/$1/g;

					# PunctL: Fz|Fe|Fra X
					@temp = ($listTags =~ /($Fz$a2|$Fe$a2|$Fra$a2)($X$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fz$a2|$Fe$a2|$Fra$a2)($X$a2)/$2/g;

					# <: [VERB<lemma:be|become>] ADV<lemma:$Quant> ADJ [PRP<lemma:than|as>]
					# NEXT
					# >: VERB<lemma:be|become> [ADV<lemma:$Quant>] ADJ [PRP<lemma:than|as>]
					@temp = ($listTags =~ /(?:$VERB${l}lemma:(?:be|become)\|${r})($ADV${l}lemma:$Quant\|${r})($ADJ$a2)(?:$PRP${l}lemma:(?:than|as)\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:be|become)\|${r})(?:$ADV${l}lemma:$Quant\|${r})($ADJ$a2)(?:$PRP${l}lemma:(?:than|as)\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:be|become)\|${r})($ADV${l}lemma:$Quant\|${r})($ADJ$a2)($PRP${l}lemma:(?:than|as)\|${r})/$1$4/g;
					LEX();

					# >: VERB<lemma:be|become>  ADJ [PRP<lemma:than|as>]
					@temp = ($listTags =~ /($VERB${l}lemma:(?:be|become)\|${r})($ADJ$a2)(?:$PRP${l}lemma:(?:than|as)\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:be|become)\|${r})($ADJ$a2)($PRP${l}lemma:(?:than|as)\|${r})/$1$3/g;
					LEX();

					# <: PRP<lemma:in> X<lemma:order> [PRP<lemma:to>]
					# NEXT
					# <:  [PRP<lemma:in>] X<lemma:order> PRP<lemma:to>
					@temp = ($listTags =~ /($PRP${l}lemma:in\|${r})($X${l}lemma:order\|${r})(?:$PRP${l}lemma:to\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP${l}lemma:in\|${r})($X${l}lemma:order\|${r})($PRP${l}lemma:to\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}lemma:in\|${r})($X${l}lemma:order\|${r})($PRP${l}lemma:to\|${r})/$3/g;
					LEX();

					# <:  [NOUN|VERB|PRP] X<lemma:next|last|this> NOUN<lemma:$temporal>
					# Add: date:yes
					@temp = ($listTags =~ /(?:$NOUN$a2|$VERB$a2|$PRP$a2)($X${l}lemma:(?:next|last|this)\|${r})($NOUN${l}lemma:$temporal\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$VERB$a2|$PRP$a2)($X${l}lemma:(?:next|last|this)\|${r})($NOUN${l}lemma:$temporal\|${r})/$1$3/g;
					LEX();
					Add("DepHead_lex","date:yes",\@temp);

					# Single: [NOUN|VERB|PRP] NOUN<date:yes>
					# Corr: tag:DATE
					@temp = ($listTags =~ /(?:$NOUN$a2|$VERB$a2|$PRP$a2)($NOUN${l}date:yes\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2|$VERB$a2|$PRP$a2)($NOUN${l}date:yes\|${r})/$1$2/g;
					Corr("Head","tag:DATE",\@temp);

					# <: CARD CARD
					# Recursivity: 1
					@temp = ($listTags =~ /($CARD$a2)($CARD$a2)/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($CARD$a2)/$2/g;
					LEX();
					@temp = ($listTags =~ /($CARD$a2)($CARD$a2)/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($CARD$a2)/$2/g;
					LEX();

					# AdjnL: ADV<lemma:$Quant> ADV|ADJ
					@temp = ($listTags =~ /($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/$2/g;

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

					# CoordL: ADJ CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [ADJ]
					# NEXT
					# CoordR: [ADJ]  CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> ADJ
					# Add: coord:adj
					# Inherit: gender, number
					@temp = ($listTags =~ /($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($ADJ$a2)/$2/g;
					Inherit("HeadDep","gender,number",\@temp);
					Add("HeadDep","coord:adj",\@temp);

					# CoordL: ADJ [Fc] [ADJ] [Fc]? CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [ADJ]
					# NEXT
					# PunctL:  [ADJ] Fc [ADJ] [Fc]? CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [ADJ]
					# Recursivity: 10
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3$4$5$6/g;

					# PunctL: [ADJ] Fc CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [ADJ]
					# NEXT
					# CoordL: ADJ [Fc]? CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [ADJ]
					# NEXT
					# CoordR:  [ADJ] [Fc]? CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> ADJ
					# Add: coord:adj
					# Inherit: gender, number
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($ADJ$a2)/$3/g;
					Inherit("HeadDep","gender,number",\@temp);
					Add("HeadDep","coord:adj",\@temp);

					# PunctL: [ADJ] Fc CONJ<coord:adj&lemma:and|or|y|e|et|o|ou>
					# NEXT
					# CoordL: ADJ [Fc] CONJ<coord:adj&lemma:and|or|y|e|et|o|ou>
					# Inherit: gender, number
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($CONJ${l}coord:adj\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($CONJ${l}coord:adj\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($CONJ${l}coord:adj\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})/$3/g;
					Inherit("DepHead","gender,number",\@temp);

					# CoordL: ADJ  CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN] [NOUN]
					# NEXT
					# CoordR: [ADJ]  CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> NOUN [NOUN]
					# Add: coord:adj
					@temp = ($listTags =~ /($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)($NOUN$a2)/$2$4/g;
					Add("HeadDep","coord:adj",\@temp);

					# CoordL: ADJ [Fc] [ADJ] [Fc]? CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN] [NOUN]
					# NEXT
					# PunctL:  [ADJ] Fc [ADJ] [Fc]? CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN] [NOUN]
					# Recursivity: 3
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($NOUN$a2)($NOUN$a2)/$3$4$5$6$7/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($NOUN$a2)($NOUN$a2)/$3$4$5$6$7/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($NOUN$a2)($NOUN$a2)/$3$4$5$6$7/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($NOUN$a2)($NOUN$a2)/$3$4$5$6$7/g;

					# CoordL: ADJ [Fc]? CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN] [NOUN]
					# NEXT
					# PunctL: [ADJ] Fc CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN] [NOUN]
					# NEXT
					# CoordR:  [ADJ] [Fc]? CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> NOUN [NOUN]
					# Add: coord:adj
					# Inherit: gender, number
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)(?:$Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($NOUN$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)?($CONJ${l}(type:(?:C)|(lemma:and|or|y|e|et|o|ou))\|${r})($NOUN$a2)($NOUN$a2)/$3$5/g;
					Inherit("HeadDep","gender,number",\@temp);
					Add("HeadDep","coord:adj",\@temp);

					# PunctL: [ADJ] Fc CONJ<coord:adj&lemma:and|or|y|e|et|o|ou>
					# NEXT
					# CoordL: ADJ [Fc] CONJ<coord:adj&lemma:and|or|y|e|et|o|ou>
					# Inherit: gender, number
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($CONJ${l}coord:adj\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($CONJ${l}coord:adj\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($CONJ${l}coord:adj\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})/$3/g;
					Inherit("DepHead","gender,number",\@temp);

					# AdjnL: ADJ|CONJ<coord:adj>  NOUN
					# Agreement: gender, number
					# Recursivity: 1
					@temp = ($listTags =~ /($ADJ$a2|$CONJ${l}coord:adj\|${r})($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"gender,number",\@temp);
					$listTags =~ s/($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r})($NOUN${l}concord:1${r})/$2/g;
					$listTags =~ s/concord:[01]\|//g;
					@temp = ($listTags =~ /($ADJ$a2|$CONJ${l}coord:adj\|${r})($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"gender,number",\@temp);
					$listTags =~ s/($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r})($NOUN${l}concord:1${r})/$2/g;
					$listTags =~ s/concord:[01]\|//g;

					# AdjnL: [DET|PRP] VERB<mode:G|P>  NOUN
					@temp = ($listTags =~ /(?:$DET$a2|$PRP$a2)($VERB${l}mode:(?:G|P)\|${r})($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2|$PRP$a2)($VERB${l}mode:(?:G|P)\|${r})($NOUN$a2)/$1$3/g;

					# AdjnR: NOUN [ADV]? ADJ|CONJ<coord:adj>
					# Agreement: gender, number
					# Recursivity: 1
					@temp = ($listTags =~ /($NOUN$a2)(?:$ADV$a2)?($ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"gender,number",\@temp);
					$listTags =~ s/($NOUN${l}concord:1${r})($ADV$a2)?($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r})/$1$2/g;
					$listTags =~ s/concord:[01]\|//g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$ADV$a2)?($ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"gender,number",\@temp);
					$listTags =~ s/($NOUN${l}concord:1${r})($ADV$a2)?($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r})/$1$2/g;
					$listTags =~ s/concord:[01]\|//g;

					# AdjnL: NOUN NOUN
					# Recursivity: 1
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$2/g;
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$2/g;

					# AdjnL: CARD NOUN
					# Recursivity 1
					@temp = ($listTags =~ /($CARD$a2)($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($NOUN$a2)/$2/g;

					# CprepL: NOUN POS NOUN
					@temp = ($listTags =~ /($NOUN$a2)($POS$a2)($NOUN$a2)/g);
					$Rel =  "CprepL";
					DepRelHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($POS$a2)($NOUN$a2)/$3/g;

					# AdjnL: CARD NOUN
					@temp = ($listTags =~ /($CARD$a2)($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($NOUN$a2)/$2/g;

					# Single: [DET] ADJ [PRP]
					# Corr: tag:NOUN
					@temp = ($listTags =~ /(?:$DET$a2)($ADJ$a2)(?:$PRP$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($ADJ$a2)($PRP$a2)/$1$2$3/g;
					Corr("Head","tag:NOUN",\@temp);

					# AdjnL: [PRP<lemma:as>] ADV [DET]  NOUN
					@temp = ($listTags =~ /(?:$PRP${l}lemma:as\|${r})($ADV$a2)(?:$DET$a2)($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}lemma:as\|${r})($ADV$a2)($DET$a2)($NOUN$a2)/$1$3$4/g;

					# SpecL: DET DET [NOUN]
					# NEXT
					# SpecL: [DET] DET NOUN
					@temp = ($listTags =~ /($DET$a2)($DET$a2)(?:$NOUN$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$DET$a2)($DET$a2)($NOUN$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($DET$a2)($NOUN$a2)/$3/g;

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

					# SpecL: DET CARD|DATE|ADJ
					@temp = ($listTags =~ /($DET$a2)($CARD$a2|$DATE$a2|$ADJ$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($CARD$a2|$DATE$a2|$ADJ$a2)/$2/g;

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

					# >: VERB PCLE
					@temp = ($listTags =~ /($VERB$a2)($PCLE$a2)/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PCLE$a2)/$1/g;
					LEX();

					# VSpecL: VERB<type:S> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
					# Add: voice:passive
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:S\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:S\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","voice:passive",\@temp);

					# VSpecL: VERB<(type:S)|(lemma:ser|être|be)> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
					# Add: voice:passive
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:S\|${r}|$VERB${l}lemma:(?:ser|être|be)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:S\|${r}|$VERB${l}lemma:(?:ser|être|be)\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
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

					# VSpecL: VERB<lemma:do> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:do\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB$a2)/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:do\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB$a2)/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# VSpecL: VERB<lemma:$VModalEN> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:$VModalEN\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB$a2)/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VModalEN\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB$a2)/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# VSpecL: VERB<lemma:be> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:G>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:be\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:G\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:be\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:G\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# VSpecL: [VERB] [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? PRP<lemma:$PrepLocs> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB
					# NEXT
					# VSpecL: VERB [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [PRP<lemma:$PrepLocs>] [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB$a2)/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB$a2)/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB$a2)/$2$3$4$5$6$7$8$9$10$11$13$14$15$16$17$18$19$20$21$22$23/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# >: VERB<lemma:$VPhAbout> [NOUN|PRO<type:D|P|I|X>]? X<lemma:about>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhAbout\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:about\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhAbout\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:about\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhAgainst> [NOUN|PRO<type:D|P|I|X>]? X<lemma:against>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhAgainst\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:against\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhAgainst\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:against\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhAlong> [NOUN|PRO<type:D|P|I|X>]? X<lemma:along>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhAlong\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:along\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhAlong\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:along\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhAround> [NOUN|PRO<type:D|P|I|X>]? X<lemma:around>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhAround\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:around\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhAround\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:around\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhAway> [NOUN|PRO<type:D|P|I|X>]? X<lemma:away>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhAway\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:away\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhAway\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:away\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhBack> [NOUN|PRO<type:D|P|I|X>]? X<lemma:back>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhBack\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:back\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhBack\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:back\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhDown> [NOUN|PRO<type:D|P|I|X>]? X<lemma:down>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhDown\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:down\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhDown\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:down\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhFrom> [NOUN|PRO<type:D|P|I|X>]? X<lemma:from>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhFrom\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:from\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhFrom\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:from\|${r})/$1$2/g;
					LEX();

					}
{#<function>
					# >: VERB<lemma:$VPhIn> [NOUN|PRO<type:D|P|I|X>]? X<lemma:in>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhIn\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:in\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhIn\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:in\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhOff> [NOUN|PRO<type:D|P|I|X>]? X<lemma:off>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhOff\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:off\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhOff\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:off\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhOn> [NOUN|PRO<type:D|P|I|X>]? X<lemma:on>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhOn\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:on\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhOn\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:on\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhOut> [NOUN|PRO<type:D|P|I|X>]? X<lemma:out>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhOut\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:out\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhOut\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:out\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhOver> [NOUN|PRO<type:D|P|I|X>]? X<lemma:over>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhOver\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:over\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhOver\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:over\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhUnder> [NOUN|PRO<type:D|P|I|X>]? X<lemma:under>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhUnder\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:under\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhUnder\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:under\|${r})/$1$2/g;
					LEX();

					# >: VERB<lemma:$VPhUp> [NOUN|PRO<type:D|P|I|X>]? X<lemma:up>
					@temp = ($listTags =~ /($VERB${l}lemma:$VPhUp\|${r})(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:up\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VPhUp\|${r})($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($X${l}lemma:up\|${r})/$1$2/g;
					LEX();

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

					# PunctL: Fc [ADV] [Fc] VERB
					# NEXT
					# PunctL: [Fc] [ADV] Fc VERB
					# NEXT
					# AdjnL: [Fc] ADV [Fc] VERB
					@temp = ($listTags =~ /($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$ADV$a2)($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($ADV$a2)(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($ADV$a2)($Fc$a2)($VERB$a2)/$4/g;

					# PunctR:  VERB [Fc] [ADV] Fc
					# NEXT
					# PunctR: VERB Fc [ADV] [Fc]
					# NEXT
					# AdjnR: VERB [Fc] ADV [Fc]
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$ADV$a2)($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($ADV$a2)($Fc$a2)/$1/g;

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

					# >: VERB [NOUN]? PCLE
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2)?($PCLE$a2)/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2)?($PCLE$a2)/$1$2/g;
					LEX();

					# CoordL: PRP [NOUN] CONJ<lemma:and|or|y|e|et|o|ou> [PRP] [NOUN]
					# NEXT
					# TermR: [PRP] [NOUN] [CONJ<lemma:and|or|y|e|et|o|ou>] PRP NOUN
					# NEXT
					# TermR: PRP NOUN [CONJ<lemma:and|or|y|e|et|o|ou>] [PRP] [NOUN]
					# NEXT
					# CoordR: [PRP] [NOUN] CONJ<lemma:and|or|y|e|et|o|ou> PRP [NOUN]
					# Add: coord:cprep
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$3/g;
					Add("HeadDep","coord:cprep",\@temp);

					# TermR: PRP NOUN [Fc] [PRP] [NOUN] [Fc] [CONJ<lemma:and|or|y|e|et|o|ou>] [PRP] [NOUN]
					# NEXT
					# PunctL: [PRP] [NOUN] Fc [PRP] [NOUN] [Fc] CONJ<lemma:and|or|y|e|et|o|ou> [PRP] [NOUN]
					# NEXT
					# CoordL: PRP [NOUN] [Fc] [PRP] [NOUN] [Fc] CONJ<lemma:and|or|y|e|et|o|ou> [PRP] [NOUN]
					# Recursivity: 3
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8$9/g;
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8$9/g;
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8$9/g;
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8$9/g;

					# CoordL: [Fc]? PRP [NOUN] [Fc] CONJ<lemma:and|or|y|e|et|o|ou> [PRP] [NOUN]
					# NEXT
					# TermR: [Fc]? [PRP] [NOUN] [Fc] [CONJ<lemma:and|or|y|e|et|o|ou>] PRP NOUN
					# NEXT
					# TermR: [Fc]? PRP NOUN [Fc] [CONJ<lemma:and|or|y|e|et|o|ou>] [PRP] [NOUN]
					# NEXT
					# PunctL: [Fc]? [PRP] [NOUN] Fc CONJ<lemma:and|or|y|e|et|o|ou> [PRP] [NOUN]
					# NEXT
					# CoordR: [Fc]? [PRP] [NOUN] [Fc] CONJ<lemma:and|or|y|e|et|o|ou> PRP [NOUN]
					# Add: coord:cprep
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($PRP$a2)($NOUN$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($PRP$a2)($NOUN$a2)/$1$5/g;
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

					# CprepR: NOUNSINGLE PRP<lemma:$PrepRA> VERB<mode:G>
					@temp = ($listTags =~ /($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($VERB${l}mode:G\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP${l}lemma:$PrepRA\|${r})($VERB${l}mode:G\|${r})/$1/g;

					# CoordL: NOUN CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN]
					# NEXT
					# CoordR: [NOUN]  CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> NOUN
					# Add: coord:noun
					@temp = ($listTags =~ /($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$2/g;
					Add("HeadDep","coord:noun",\@temp);

					# CoordL: NOUN [Fc] [NOUN] [Fc] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN]
					# NEXT
					# PunctL:  [NOUN] Fc [NOUN] [Fc] CONJ<(type:C)|(lemma:and|or|y|e|et|o|ou)> [NOUN]
					# Add: coord:yes
					# Recursivity: 10
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($NOUN$a2)($Fc$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3$4$5$6/g;
					Add("DepHead","coord:yes",\@temp);

					# CoordL: NOUN [Fc] CONJ<coord:yes&lemma:and|or|y|e|et|o|ou> [NOUN]
					# NEXT
					# PunctL: [NOUN] Fc CONJ<coord:yes&lemma:and|or|y|e|et|o|ou> [NOUN]
					# NEXT
					# CoordR:  [NOUN] [Fc] CONJ<coord:yes&lemma:and|or|y|e|et|o|ou> NOUN
					# Add: coord:noun
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)($CONJ${l}coord:yes\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)($Fc$a2)($CONJ${l}coord:yes\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUN$a2)(?:$Fc$a2)($CONJ${l}coord:yes\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)($CONJ${l}coord:yes\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($NOUN$a2)/$3/g;
					Add("HeadDep","coord:noun",\@temp);

					# CprepR: ADJ|ADV|DATE PRP NOUNCOORD|PRO<type:D|P|I|X|>
					@temp = ($listTags =~ /($ADJ$a2|$ADV$a2|$DATE$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X|)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2|$ADV$a2|$DATE$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X|)\|${r})/$1/g;

					# CprepR: ADJ|ADV|DATE PRP VERB<mode:N>
					# NoUniq
					@temp = ($listTags =~ /($ADJ$a2|$ADV$a2|$DATE$a2)($PRP$a2)($VERB${l}mode:N\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2|$ADV$a2|$DATE$a2)($PRP$a2)($VERB${l}mode:N\|${r})/$1$2$3/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|S>] Fc|Fpa|Fca NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|S>] [Fc|Fpa|Fca] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|S> [Fc|Fpa|Fca] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|S>] Fc|Fpa|Fca [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|S>] [Fc|Fpa|Fca] [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# CprepR: NOUNCOORD|PRO<type:D|P|I|S> [Fc|Fpa|Fca] PRP NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/$1/g;

					# AdjnR: NOUNCOORD|PRO<type:D|P|I|S> [Fc|Fpa|Fca] VERB<mode:P> [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [Fc|Fpt|Fct]
					# NoUniq
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($VERB${l}mode:P\|${r})(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($VERB${l}mode:P\|${r})($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($Fc$a2|$Fpt$a2|$Fct$a2)/$1$2$3$4$5$6$7$8$9$10$11$12$13$14/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:that|which|who>] [NOUNCOORD|PRO<type:D|P|I|X>]  VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>|PRO<lemma:that|which|who>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>   Fc
					# NEXT
					# DobjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:that|which|who> [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:that|which|who>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>    [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5$6/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# SubjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:that|which|who> VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb>  [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  [Fc]? PRP PRO<type:R|W>|PRO<lemma:that|which|who> VERB|CONJ<coord:verb> [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb> [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5$6/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>|PRO<lemma:that|which|who>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>|PRO<lemma:that|which|who>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  [Fc]? PRP PRO<type:R|W>|PRO<lemma:that|which|who> [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb> [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>|PRO<lemma:that|which|who>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb> [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5$6$7/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc VERB<mode:[GP]>|CONJ<coord:verb>
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X>  [Fc]? VERB<mode:[GP]>|CONJ<coord:verb>
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/$1$2$3/g;

					# CircR: VERB<mode:P> [NOUNCOORD|PRO<type:D|P|I|X>] PRP<lemma:por|by> NOUNCOORD|PRO<type:D|P|I|X>|ADV
					@temp = ($listTags =~ /($VERB${l}mode:P\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}mode:P\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/$1$2/g;

					# CircR: VERB [NOUNCOORD|PRO<type:D|P|I|X>] PRP<lemma:$PrepMA> CARD|DATE
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/$1$2/g;

					# PunctR: VERB Fc [PRP] [DATE]
					# NEXT
					# CircR: VERB [Fc]? PRP DATE
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$DATE$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?($PRP$a2)($DATE$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($PRP$a2)($DATE$a2)/$1/g;

					# PunctL: [PRP] [DATE] Fc VERB
					# NEXT
					# CircL: PRP DATE [Fc]? VERB
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$DATE$a2)($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)($DATE$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($DATE$a2)($Fc$a2)?($VERB$a2)/$4/g;

					# PunctR: VERB Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]
					# NEXT
					# PunctR: VERB [Fc] [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] Fc
					# NEXT
					# CircR: VERB [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/$1/g;

					# CprepR: CARD PRP<lemma:de|entre|sobre|of|about|between> NOUNCOORD|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CprepR: PRO<type:P> PRP<lemma:de|of> NOUNCOORD|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CprepR: NOUNCOORD [PRP] [PRO<type:D|P|I|X>] PRP NOUNCOORD|ADV
					# NEXT
					# CprepR: NOUNCOORD PRP PRO<type:D|P|I|X> [PRP] [NOUNCOORD]|ADV
					@temp = ($listTags =~ /($NOUNCOORD)(?:$PRP$a2)(?:$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($NOUNCOORD|$ADV$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)([NOUNCOORD]|ADV)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)([NOUNCOORD]|ADV)/$1/g;

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

					# SubjL: [VERB] [X<lemma:what>] NOUNCOORD|PRO<type:D|P|I|S> VERB
					# NEXT
					# DobjL: [VERB] X<lemma:what> [NOUNCOORD|PRO<type:D|P|I|S>] VERB
					# Add: compl:yes
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$X${l}lemma:what\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB$a2)/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($X${l}lemma:what\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB$a2)/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($X${l}lemma:what\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB$a2)/$1$4/g;
					Add("DepHead","compl:yes",\@temp);

					# AdjnL:  [VERB] [X<lemma:where|when>] NOUNCOORD|PRO<type:D|P|I|S> VERB
					# NEXT
					# DobjL: [VERB] X<lemma:where|when> [NOUNCOORD|PRO<type:D|P|I|S>] VERB
					# Add: compl:yes
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$X${l}lemma:(?:where|when)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($X${l}lemma:(?:where|when)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB$a2)/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($X${l}lemma:(?:where|when)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB$a2)/$1$4/g;
					Add("DepHead","compl:yes",\@temp);

					# CircR: [VERB] [NOUN]  VERB<compl:yes&mode:[^PNG]> PRP NOUNCOORD|PRO<type:D|P|I|X>
					# NEXT
					# SubjL: [VERB] NOUN VERB<compl:yes&mode:[^PNG]>  [PRP] NOUNCOORD|PRO<type:D|P|I|X>]
					# NEXT
					# DobjComplR: VERB [NOUN]? VERB<compl:yes&mode:[^PNG]>  [PRP] NOUNCOORD|PRO<type:D|P|I|X>]
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$NOUN$a2)($VERB${l}compl:yes\|${b2}mode:[^PNG]\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($NOUN$a2)($VERB${l}compl:yes\|${b2}mode:[^PNG]\|${r})(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}])/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2)?($VERB${l}compl:yes\|${b2}mode:[^PNG]\|${r})(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}])/g);
					$Rel =  "DobjComplR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2)?($VERB${l}compl:yes\|${b2}mode:[^PNG]\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}])/$1/g;

					# CircR: [VERB<lemma:say|think>]  [NOUN]  VERB<mode:[^PNG]> PRP NOUNCOORD|PRO<type:D|P|I|X>
					# NEXT
					# SubjL: [VERB<lemma:say|think>] NOUN VERB<mode:[^PNG]> [PRP] [NOUNCOORD|PRO<type:D|P|I|X>]
					# NEXT
					# DobjComplR: VERB<lemma:say|think> [NOUN]? VERB<mode:[^PNG]>  [PRP] [NOUNCOORD|PRO<type:D|P|I|X>]
					@temp = ($listTags =~ /(?:$VERB${l}lemma:(?:say|think)\|${r})(?:$NOUN$a2)($VERB${l}mode:[^PNG]\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}lemma:(?:say|think)\|${r})($NOUN$a2)($VERB${l}mode:[^PNG]\|${r})(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:say|think)\|${r})(?:$NOUN$a2)?($VERB${l}mode:[^PNG]\|${r})(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "DobjComplR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:say|think)\|${r})($NOUN$a2)?($VERB${l}mode:[^PNG]\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# Dobj2R: VERB NOUNCOORD|PRO<type:P|X> [NOUNCOORD|PRO<type:D|I|X>]
					# NEXT
					# DobjR: VERB [NOUNCOORD|PRO<type:P|X>] NOUNCOORD|PRO<type:D|I|X>
					@temp = ($listTags =~ /($VERB$a2)($NOUNCOORD|$PRO${l}type:(?:P|X)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|I|X)\|${r})/g);
					$Rel =  "Dobj2R";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUNCOORD|$PRO${l}type:(?:P|X)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|I|X)\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUNCOORD|$PRO${l}type:(?:P|X)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|I|X)\|${r})/$1/g;

					# CircR: [VERB<lemma:be>] [ADJ|CONJ<coord:adj>] [PRP] VERB [NOUNCOORD|PRO<type:D|P|I|X>]? PRP NOUNCOORD|PRO<type:D|P|I|X>
					# NEXT
					# DobjR: [VERB<lemma:be>] [ADJ|CONJ<coord:adj>] [PRP] VERB NOUNCOORD|PRO<type:D|P|I|X> [PRP]? [NOUNCOORD|PRO<type:D|P|I|X>]?
					# NEXT
					# CprepR: [VERB<lemma:be>] ADJ|CONJ<coord:adj> PRP VERB [NOUNCOORD|PRO<type:D|P|I|X>]? [PRP]? [NOUNCOORD|PRO<type:D|P|I|X>]?
					@temp = ($listTags =~ /(?:$VERB${l}lemma:be\|${r})(?:$ADJ$a2|$CONJ${l}coord:adj\|${r})(?:$PRP$a2)($VERB$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}lemma:be\|${r})(?:$ADJ$a2|$CONJ${l}coord:adj\|${r})(?:$PRP$a2)($VERB$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)?(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}lemma:be\|${r})($ADJ$a2|$CONJ${l}coord:adj\|${r})($PRP$a2)($VERB$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$PRP$a2)?(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:be\|${r})($ADJ$a2|$CONJ${l}coord:adj\|${r})($PRP$a2)($VERB$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP$a2)?($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?/$1$2/g;

					# AtrR: VERB<lemma:be> NOUNCOORD|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB${l}lemma:be\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "AtrR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:be\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# AtrR: VERB ADJ|CONJ<coord:adj>
					@temp = ($listTags =~ /($VERB$a2)($ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "AtrR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADJ$a2|$CONJ${l}coord:adj\|${r})/$1/g;

					# DobjR: VERB CARD|NOUN|CONJ<coord:noun>|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB$a2)($CARD$a2|$NOUN$a2|$CONJ${l}coord:noun\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CARD$a2|$NOUN$a2|$CONJ${l}coord:noun\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CoordL: VERB CONJ<coord:no&lemma:and|or|y|e|et|o|ou> [VERB]
					# NEXT
					# CoordR: [VERB]  CONJ<coord:no&lemma:and|or|y|e|et|o|ou> VERB
					# Add: coord:verb
					# Inherit: mode, tense
					@temp = ($listTags =~ /($VERB$a2)($CONJ${l}coord:no\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}coord:no\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}coord:no\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$2/g;
					Inherit("HeadDep","mode,tense",\@temp);
					Add("HeadDep","coord:verb",\@temp);

					# CoordL: VERB [Fc] [VERB] [Fc] CONJ<lemma:and|or|y|e|et|o|ou> [VERB]
					# NEXT
					# PunctL:  [VERB] Fc [VERB] [Fc] CONJ<lemma:and|or|y|e|et|o|ou> [VERB]
					# Add: coord:verb
					# Recursivity: 5
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);

					# PunctL: [VERB] Fc CONJ<coord:verb&lemma:and|or|y|e|et|o|ou> [VERB]
					# NEXT
					# CoordL: VERB [Fc] CONJ<coord:verb&lemma:and|or|y|e|et|o|ou> [VERB]
					# NEXT
					# CoordR:  [VERB] [Fc] CONJ<coord:verb&lemma:and|or|y|e|et|o|ou> VERB
					# Add: coord:verb
					# Inherit: mode, tense
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)($CONJ${l}coord:verb\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($CONJ${l}coord:verb\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}coord:verb\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($CONJ${l}coord:verb\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3/g;
					Inherit("HeadDep","mode,tense",\@temp);
					Add("HeadDep","coord:verb",\@temp);

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

					}
{#<function>
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

					# CircR: VERB|CONJ<coord:verb> PRP VERB|ADV|CARD
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$ADV$a2|$CARD$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$ADV$a2|$CARD$a2)/$1/g;
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$ADV$a2|$CARD$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$ADV$a2|$CARD$a2)/$1/g;

					# CircR: VERB|CONJ<coord:verb> PRP NOUNCOORD|PRO<type:D|P|I|X>
					# Recursivity: 2
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CircR: VERB|CONJ<coord:verb> [X]? [X]? PRP<lemma:to> VERB|CONJ<coord:verb>
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$X$a2)?(?:$X$a2)?($PRP${l}lemma:to\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($X$a2)?($X$a2)?($PRP${l}lemma:to\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})/$1$2$3/g;

					# PunctR: VERB Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?
					# NEXT
					# PunctR: VERB [Fc] [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] Fc
					# NEXT
					# TermR: [VERB] [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]?
					# NEXT
					# CircR: VERB [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]?
					# Recursivity:1
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
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
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
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

					# PunctL: Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]  VERB
					# NEXT
					# PunctL: [Fc] [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] Fc  VERB
					# NEXT
					# CircL: [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]  VERB
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB$a2)/$5/g;

					# AdjnR:  VERB DATE
					@temp = ($listTags =~ /($VERB$a2)($DATE$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($DATE$a2)/$1/g;

					# PunctL: Fc [DATE] VERB
					# NEXT
					# AdjnL:  [Fc]? DATE VERB>
					@temp = ($listTags =~ /($Fc$a2)(?:$DATE$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($DATE$a2)($VERB$a2\|${r})/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($DATE$a2)($VERB$a2\|${r})/$3/g;

					# CprepR: NOUNCOORD PRP NOUNCOORD
					@temp = ($listTags =~ /($NOUNCOORD)($PRP$a2)($NOUNCOORD)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD)($PRP$a2)($NOUNCOORD)/$1/g;

					# SpecL: [VERB] CONJ<lemma:that|whether>  VERB<mode:[^PNG]>
					# NEXT
					# DobjComplR: VERB [CONJ<lemma:that|whether>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}lemma:(?:that|whether)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}lemma:(?:that|whether)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjComplR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}lemma:(?:that|whether)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# SpecL: [VERB]  CONJ<lemma:that|whether>  [NOUNCOORD|PRO<type:D|P|I|S>] VERB<mode:[^PNG]>
					# NEXT
					# SubjL:  [VERB]  [CONJ<lemma:that|whether>]  NOUNCOORD|PRO<type:D|P|I|S> VERB<mode:[^PNG]>
					# NEXT
					# DobjComplR: VERB   [CONJ<lemma:that|whether>] [NOUNCOORD|PRO<type:D|P|I|S>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}lemma:(?:that|whether)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$CONJ${l}lemma:(?:that|whether)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}lemma:(?:that|whether)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjComplR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}lemma:(?:that|whether)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# DobjComplR: VERB [NOUN]? VERB<compl:yes&mode:[^PNG]>
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2)?($VERB${l}compl:yes\|${b2}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjComplR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2)?($VERB${l}compl:yes\|${b2}mode:[^PNG]\|${r})/$1$2/g;

					# DobjComplR: VERB<lemma:say|think> [NOUN]? VERB<mode:[^PNG]>
					@temp = ($listTags =~ /($VERB${l}lemma:(?:say|think)\|${r})(?:$NOUN$a2)?($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjComplR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:say|think)\|${r})($NOUN$a2)?($VERB${l}mode:[^PNG]\|${r})/$1$2/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|S>] Fc|Fpa VERB [Fc|Fpt]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|S>] [Fc|Fpa] VERB Fc|Fpt
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|S> [Fc|Fpa] VERB [Fc|Fpt]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($Fc$a2|$Fpa$a2)($VERB$a2)(?:$Fc$a2|$Fpt$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})(?:$Fc$a2|$Fpa$a2)($VERB$a2)($Fc$a2|$Fpt$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})(?:$Fc$a2|$Fpa$a2)($VERB$a2)(?:$Fc$a2|$Fpt$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|S)\|${r})($Fc$a2|$Fpa$a2)($VERB$a2)($Fc$a2|$Fpt$a2)/$1/g;

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

					# CoordL: VERB CONJ<coord:no&lemma:and|or|y|e|et|o|ou> [VERB]
					# NEXT
					# CoordR: [VERB]  CONJ<coord:no&lemma:and|or|y|e|et|o|ou> VERB
					# Add: coord:verb
					# Inherit: mode, tense
					@temp = ($listTags =~ /($VERB$a2)($CONJ${l}coord:no\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}coord:no\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}coord:no\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$2/g;
					Inherit("HeadDep","mode,tense",\@temp);
					Add("HeadDep","coord:verb",\@temp);

					# CoordL: VERB [Fc] [VERB] [Fc] CONJ<lemma:and|or|y|e|et|o|ou> [VERB]
					# NEXT
					# PunctL:  [VERB] Fc [VERB] [Fc] CONJ<lemma:and|or|y|e|et|o|ou> [VERB]
					# Add: coord:verb
					# Recursivity: 5
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($VERB$a2)($Fc$a2)($CONJ${l}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3$4$5$6/g;
					Add("DepHead","coord:verb",\@temp);

					# PunctL: [VERB] Fc CONJ<coord:verb&lemma:and|or|y|e|et|o|ou> [VERB]
					# NEXT
					# CoordL: VERB [Fc] CONJ<coord:verb&lemma:and|or|y|e|et|o|ou> [VERB]
					# NEXT
					# CoordR:  [VERB] [Fc] CONJ<coord:verb&lemma:and|or|y|e|et|o|ou> VERB
					# Add: coord:verb
					# Inherit: mode, tense
					@temp = ($listTags =~ /(?:$VERB$a2)($Fc$a2)($CONJ${l}coord:verb\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($CONJ${l}coord:verb\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})(?:$VERB$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$Fc$a2)($CONJ${l}coord:verb\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($CONJ${l}coord:verb\|${b2}lemma:(?:and|or|y|e|et|o|ou)\|${r})($VERB$a2)/$3/g;
					Inherit("HeadDep","mode,tense",\@temp);
					Add("HeadDep","coord:verb",\@temp);

					# SubjL: [NOUNCOORD] NOMINAL|PRO<type:D|P|I|S>  VERB<mode:[^G]>|CONJ<coord:verb&mode:[^G]>
					# Add: adsubj:yes
					# NEXT
					# AdjnR: NOUNCOORD [NOMINAL|PRO<type:D|P|I|S>]  VERB<mode:[^G]>|CONJ<coord:verb&mode:[^G]>
					@temp = ($listTags =~ /(?:$NOUNCOORD)($NOMINAL|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^G]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^G]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					Add("DepHead","adsubj:yes",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD)(?:$NOMINAL|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^G]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^G]\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD)($NOMINAL|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^G]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^G]\|${r})/$1/g;

					# SubjL: NOUN<type:D|P|I|S> VERB<mode:[^G]>|CONJ<coord:verb&mode:[^G]>
					# Add: adsubj:yes
					@temp = ($listTags =~ /($NOUN${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^G]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^G]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^G]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^G]\|${r})/$2/g;
					Add("DepHead","adsubj:yes",\@temp);

					# SubjL: NOMINAL|PRO<type:D|P|I|S>  VERB<mode:[^G]>|CONJ<coord:verb&mode:[^G]>
					# Add: adsubj:yes
					@temp = ($listTags =~ /($NOMINAL|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^G]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^G]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOMINAL|$PRO${l}type:(?:D|P|I|S)\|${r})($VERB${l}mode:[^G]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^G]\|${r})/$2/g;
					Add("DepHead","adsubj:yes",\@temp);

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>    [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>   Fc
					# NEXT
					# DobjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:that|which|who> VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>    [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>    [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# SubjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:that|which|who> VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb>  [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  [Fc]? PRP PRO<type:R|W>|PRO<lemma:that|which|who> VERB|CONJ<coord:verb> [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>|PRO<lemma:that|which|who>] VERB|CONJ<coord:verb> [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:that|which|who)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1/g;

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

					# AdjnL: CONJ<type:S> VERB
					@temp = ($listTags =~ /($CONJ${l}type:S\|${r})($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($CONJ${l}type:S\|${r})($VERB$a2)/$2/g;

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
                                        my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					my $feat2 = $feat;
					$feat2 =~ s/\|/\\|/g;
					$listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					my @feat = split ('\|', $feat); 
					push (@feat,$info);
					@feat = sort (@feat); 
					$feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;    

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
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
					    my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					    #$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;

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
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
					    my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
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
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;

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
				$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
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
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					 
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
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
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
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
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
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
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
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
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
				        $listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
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
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
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
	##dates
	elsif ($x =~  /^DATE/) {
		$TagStr{"number"} = 0;
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
