#!/usr/bin/env perl

#ProLNat NEC (provided with Sentence Identifier, Tokenizer, Splitter, NER, Tagger)
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Script que integra 6 funçoes perl: sentences, tokens, splitter, ner_es, tagger e nec_es

package Nec;

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


##gazeetters
my $GAZLOC;#<file>
open ($GAZLOC, $abs_path."/gaz/gazLOC.dat" ) or die "O ficheiro gazLOC.dat nao pode ser aberto\n";
binmode $GAZLOC,  ':utf8';#<ignore-line>
my $GAZPER;#<file>
open ($GAZPER, $abs_path."/gaz/gazPER.dat" ) or die "O ficheiro gazPER.dat nao pode ser aberto\n";
binmode $GAZPER,  ':utf8';#<ignore-line>
my $GAZORG;#<file>
open ($GAZORG, $abs_path."/gaz/gazORG.dat" ) or die "O ficheiro gazORG.dat nao pode ser aberto\n";
binmode $GAZORG,  ':utf8';#<ignore-line>
my $GAZMISC;#<file>
open ($GAZMISC, $abs_path."/gaz/gazMISC.dat" ) or die "O ficheiro gazMISC.dat nao pode ser aberto\n";
binmode $GAZMISC,  ':utf8';#<ignore-line>

##triggerwords
my $TWLOC;#<file>
open ($TWLOC,  $abs_path."/tw/twLOC.dat") or die "O ficheiro twLOC.dat nao pode ser aberto\n";
binmode $TWLOC,  ':utf8';#<ignore-line>
my $TWPER;#<file>
open ($TWPER, $abs_path."/tw/twPER.dat" ) or die "O ficheiro twPER.dat nao pode ser aberto\n";
binmode $TWPER,  ':utf8';#<ignore-line>
my $TWORG;#<file>
open ($TWORG, $abs_path."/tw/twORG.dat" ) or die "O ficheiro twORG.dat nao pode ser aberto\n";
binmode $TWORG,  ':utf8';#<ignore-line>
my $TWMISC;#<file>
open ($TWMISC, $abs_path."/tw/twMISC.dat" ) or die "O ficheiro twMISC.dat nao pode ser aberto\n";
binmode $TWMISC,  ':utf8';#<ignore-line>


##variaveis globais 
my $Border = "(Fp|<blank>)";#<string>

####INFO DEPENDENTE DA LINGUA#############
my $stopwords = "_em_|_en_|_de_|_da_|_das_|_dos_|_da_|_do_|_del_|_o_|_a_|_e_|_por_|_para_|_and_|_the_|_in_|_on_|^el_|^la_|^las_|^los_"; #<string>#CUIDADO COM ESTA VARIAVEL!!!!!!!!!!! hai que especializa-la por lingua
my $prep = "de|por|para"; #<string>
my $titulo = "aareyna|aarreyna|abade|abadesa|abadess|abadeſa|abbad|abbade|abbades|abbadesa|abbadesas|abbadessa|abbadeſa|abbadeſſa|abbadis|abbady|abbae|abbas|abbat|abbate|abbatem|abbates|abbati|abbatialem|abbatibus|abbatis|abbatisa|abbatissa|abbatissam|abbatisse|abbatissis|abbatorum|abbatum|arcebispo|arcebispos|arcediagado|arcediagados|arcediago|arcediagoo|arcediagoos|arcediano|arcedianos|arcedyano|arcedĩagon|arcepreste|arceprestes|arcepreſte|arceriagoo|archibispo|archibispos|archicpiscopus|archidiachoni|archidiacnous|archidiacocnus|archidiaconalem|archidiaconales|archidiaconati|archidiaconcus|archidiacone|archidiaconi|archidiaconis|archidiacono|archidiaconorum|archidiaconos|archidiaconum|archidiaconus|archidianconi|archidiano|archidianus|archiduquesa|archiepi|archiepiscopali|archiepiscopalis|archiepiscopi|archiepiscopis|archiepiscopo|archiepiscopos|archiepiscopum|archiepiscopus|archiepiscous|archiepiscumm|archiepisocpum|archieposcopus|archieps|archiespiscopus|archipiscopo|archipresbiter|archipresbiteratibus|archipresbiteratu|archipresbiteratus|archipresbiteri|archipresbiteris|archipresbitero|archipresbiteros|archipresbiterum|archipreste|archiprestes|archispiscopi|archispiscopo|archispiscopus|arcibipso|arcibispo|arcibispos|arcibiſpo|arcidiacono|arcidiago|arcidiagoo|arcidiagoos|arcidiagos|arcidiano|arciepiscopalis|arcigdo|arcipresbiter|arcipreste|arciprestes|arcipreſte|arcobispo|arcydiago|arsebispo|arzidiagoo|arzidiano|arzobispo|arzobispos|arçabispo|arçdiago|arçebispo|arçebispos|arçediagado|arçediagnono|arçediago|arçediagonos|arçediagoo|arçediagoos|arçediagos|arçediagóó|arçediano|arçedianos|arçedianus|arçedyano|arçeebispo|arçepreste|arçeprestes|arçeriago|arçeriagoo|arçiadiago|arçiadiagoo|arçibispal|arçibispo|arçibispos|arçibiuspo|arçibiſpo|arçidiago|arçidiagonos|arçidiagoos|arçidiagos|arçidiagóó|arçidiano|arçidianos|arçidiao|arçidyano|arçipreste|arçiprestes|arçipreſte|arçobispaas|arçobispo|arçobispos|arçobiſpo|arçobpo|arʢibiſpo|arʢidiagóó|avad|avade|avadesa|avadessa|becino|becinos|beciño|besino|besinos|besiña|besiño|besiños|besiñó|besjños|bezino|bezinos|bezios|beziño|beziños|bezjnos|bezĩo|bezĩos|beçino|beçiño|beçiños|beσinos|bicario|bicarius|bicaryo|bisbispos|bisconde|biscondes|bisinõσ|bisiño|bisiños|bisp|bispaaes|bispo|bispoo|bispos|bispu|bisspos|biziño|biziños|bizjños|biſpo|biſſpo|bysindade|bysiños|byspo|byspos|byſpo|caabiido|cabdillo|cabildo|califa|califfa|canonigo|canonigos|canonjco|canonjcos|canonjgo|canonycos|canonygo|canonygos|canoycus|canoygo|canónigo|canónigos|canónjgo|canónyco|caongo|capelaas|capelaes|capelalán|capelam|capelan|capelanes|capelanm|capelanmus|capelano|capelanos|capelans|capelanum|capelanus|capelaães|capelaãs|capelaãẽs|capelães|capellaaens|capellae|capellaes|capellam|capellan|capellanes|capellani|capellania|capellanum|capellanus|capellanía|capellaõ|capellãães|capellám|capellán|capelláns|capellãas|capellães|capellãães|capelám|capelán|capeláés|capelãas|capelãees|capelães|capelãeſ|capelãis|capelããs|capelãẽs|cappelan|cappelano|cappellam|cappellan|cappellanes|cappellani|cappellania|cappellanis|cappellanos|cappellanum|cappellanus|cappellán|cappelán|cauido|cauildo|cauildos|clerjco|clerjgo|clero|clerons|cleros|clerum|clerus|clerygo|clerygos|clérigo|cllerigo|cllérigo|clregos|clérjgo|clérygo|coego|coegos|coengo|coengoo|coengos|comde|comemdador|comemdadores|comendator|comendatore|comendeiro|comendeyro|commendador|commendadores|commendator|commendeyro|condes|condesa|condesas|condessa|condestable|condestabre|condeſ|conegos|conengos|conmendator|conmendatur|conmendeiro|consul|coygo|coygos|coyguos|coyngo|coyngos|coýgos|coýngos|cõsul|coẽgo|coẽgos|cóengo|cóengos|cónego|cóẽgo|cóẽgos|cõde|cõdes|cõsul|deam|dean|deám|deán|diachono|diachonos|diachonus|diaconi|diaconissa|diacono|diaconos|diaconus|don|dõ|domno|emperador|emperadores|emperadrid|emperadriz|emperarador|emperatriz|episciopus|episcope|episcopes|episcopi|episcopis|episcopo|episcopos|episcoppo|episcopum|episcopus|epiſcopi|epiſcopo|epíscopum|epíscopus|espiscopo|espiscopus|frei|frey|imperator|imperatore|imperatorem|imperatores|imperatori|imperatoris|imperatrice|imperatrici|inperator|inperatore|jnperador|morador|moradores|moyoraes|mperador|notario|notarjio|oBispo|obispo|obispoo|obispos|obispoσ|obisspo|obiſpo|principe|principes|prinçipe|prinçipes|rege|regidor|regidora|regidores|regidõõe|regina|reginae|reginam|regine|regineque|regna|regnam|regnamdo|regnando|regnans|regnant|regnante|regnantis|reiis|rein|reina|reinado|reinante|reinar|reinara|reinass|reinha|reinão|reis|reises|reĩna|reiσes|rex|rey|reyaas|reyaes|reyal|reyales|reydo|reyeego|reyes|reynha|reynhas|reynna|reynnas|reys|reyses|reyx|reyz|reyzes|reyña|reỹa|reyσ|reýces|reýses|reýzes|reýña|reỹas|rrainha|rrayna|rraynha|rraynhas|rregooσ|rreis|rreiss|rreiz|rreizes|rrej|rrex|rrey|rreyde|rreydo|rreyes|rreygnado|rreygno|rreyma|rreyna|rreíses|rreízes|rreýna|senhor|senor|senior|senjor|sennor|subprior|subpriore|subpriori|uezinho|uezinhos|uezino|uezinos|uezinoſ|ueziño|ueziños|uezínhos|uezjños|uezĩos|uicarie|uicarii|uicariis|uicario|uicariorum|uicariorumm|uicarios|uicarium|uicarius|uicini|uicinis|uicinitati|uicino|uicinos|uiciños|uigario|uigarios|uigarius|uigayro|uinzino|uinzinos|uizina|uizinha|uizinhas|uizinho|uizinno|uizinnos|uizino|uizinos|uizĩha|uizonio|uiçino|uiçinos|uiçiños|vecindat|vecinno|vecinnos|vecino|vecinos|veciño|veciños|vecjno|vesina|vesindade|vesindança|vesinno|vesinnos|vesino|vesinos|vesiña|vesiñança|vesiñas|vesiño|vesiños|vesiõ|vesjno|vesjnos|vesjño|vesjños|vesyno|vesynos|vesyns|vesyño|vezibõõ|vezina|vezinas|vezindad|vezindade|vezindades|vezinha|vezinham|vezinhamça|vezinhas|vezinhavõ|vezinho|vezinhos|vezinhã|vezinnno|vezinnnos|vezinno|vezinnos|vezino|vezinos|vezinoſ|vezio|veziña|veziño|veziños|vezjnnos|vezjno|vezjnos|vezjño|vezjños|vezynança|vezynho|vezynna|vezynnas|vezynno|vezyno|vezynos|vezyño|vezyños|vezỹnho|vezínoſ|vezĩas|vezĩdades|vezĩo|vezỹo|vezỹos|veçindade|veçinhos|veçinno|veçino|veçinos|veçiño|veçiños|veσiño|veσjño|veσjños|vicinam|vicine|vicini|vicinis|vicino|vicinu|vicinum|vigario|vigarios|vigariu|vigaro|vigaros|vigaroſ|vigaryo|visjnos|visjño|vizenhos|vizindade|vizindat|vizinha|vizinhamça|vizinhas|vizinho|vizinhos|vizinnanza|vizinnhos|vizinnnos|vizinno|vizinnos|vizino|vizinos|viziña|viziñas|viziño|viziños|vizjños|vizynhos|vizynos|vizĩo|viçino|viσjña|viσjño|vysiño|vysiños|vyzinhos|vyziñas|vyziño|vyzyno|vyσjno|﻿aarçebispo";#<string>
##########################################


##Cargando gazeetters e triggerwords e mais variaveis globais
my %TwLoc=();#<hash><boolean>
my %TwOrg=();#<hash><boolean>
my %TwMisc=();#<hash><boolean>
my %TwPer=();#<hash><boolean>
my %GazLoc=();#<hash><boolean>
my %GazOrg=();#<hash><boolean>
my %GazMisc=();#<hash><boolean>
my %GazPer=();#<hash><boolean>
my %GazPer_part=();#<hash><string>

while (my $NP = <$GAZLOC>) {#<string>
	chomp $NP;
	$GazLoc{$NP}=1;
}
close $GAZLOC;


while (my $NP = <$GAZPER>) {#<string>
	my %found=();#<hash><boolean>
    
	chomp $NP;
	$GazPer{$NP}=1;
    
	if ($NP =~ /_/ && $NP !~ /$stopwords/) {
		my @temp = split ("_", $NP);#<array><string>
		for (my $i=0;$i<=$#temp;$i++) {#<integer>
			my $part = $temp[$i];#<string>
			if (!$found{$part} ) {
				#print  "$part\n";
				$GazPer_part{$part} = $NP;
				$found{$part}=1;
			}
		}
	}    
}
close $GAZPER;

while (my $NP = <$GAZORG>) {#<string>
	chomp $NP;
	$GazOrg{$NP}=1;
}
close $GAZORG;

while (my $NP = <$GAZMISC>) {#<string>
	chomp $NP;
	$GazMisc{$NP}=1;
}
close $GAZMISC;


##Combina variantes das TW

# my @lista_expandida;
# while (my $NP = <$TWLOC>) {
# chomp $NP;
# @lista_expandida = expand($NP);
# for $NP (@lista_expandida) {
# 	$TwLoc{$NP}=1;
# 		}
# }


while (my $NP = <$TWLOC>) {
	chomp $NP;
 	$TwLoc{$NP}=1
}
close $TWLOC;

while (my $NP = <$TWPER>) {#<string>
	chomp $NP;
	$TwPer{$NP}=1;
}
close $TWPER;

while (my $NP = <$TWORG>) {#<string>
	chomp $NP;
	$TwOrg{$NP}=1;
}
close $TWORG;

while (my $NP = <$TWMISC>) {#<string>
	chomp $NP;
	$TwMisc{$NP}=1;
}
close $TWMISC;


sub nec{

	my @saida=();#<list><string>
	my ($text) = @_;#<ref><list><string>

	my $Window=3;#<integer>#para as triggerwords
	my $last_tag="";#<string>
	my $new_tag="";#<string>
	my $i=0;#<integer>
	my $token;#<string>
	my $lema;#<string>
	my $tag;#<string>

	my $size = @{$text};#<integer>
	my @Token=();#<array><$size><string>
	my @Lema=();#<array><$size><string>
	my @Tag=();#<array><$size><string>
	my @Others=();#<array><$size><string># a remover
	my @composto;#<array><string>
	my $left;#<integer>
	my $Left_1;#<integer>
	my $Left_2;#<integer>
	my $right;#<integer>
	my $others;#<string>#a remover  
    
	foreach my $line (@{$text}){
		chomp $line;
		if ($line eq "") {
			if($pipe){#<ignore-line>
				print "\n";#<ignore-line>
			}else{#<ignore-line>
				push (@saida, "");
			}#<ignore-line>
			next;
		}

		my @array = split (" ", $line);#<array><string>
		$token = $array[0];
		$lema = $array[1];
		$tag = $array[2];

		for (my $k=3;$k<=$#array;$k++) {#<integer>#esta parte tera que ser removida se hai desambiguaçao previa
			$others .= $array[$k] .  " ";  
		}
		if ($tag !~ /^$Border$/) {
			$Token[$i] = $token;
			$Lema[$i] = $lema;
			$Tag[$i] = $tag;
			$Others[$i] = $others;
			$i++;
			$others="";
		}else {	
			for ($i=0;$i<=$#Lema;$i++) {
				my $found=0;#<boolean>     
				#print STDERR "okk:: #$i# ----------- #$Tag[$i]#\n";

				###Caso 'don+NP': todos person
				if ($Lema[$i] =~ /^($titulo)$/ && $Tag[$i+1] =~ /^NP/) {
					$new_tag =  "NP00SP0";
					$Token[$i] =  $Token[$i] . "_" .  $Token[$i+1];
					$Lema[$i] =  $Lema[$i] . "_" .  $Lema[$i+1];
					#print STDERR "---->>$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
					if($pipe){#<ignore-line>
						print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, "$Token[$i] $Lema[$i] $new_tag");
					}#<ignore-line>
					$found=1;
					$i+=1;
					next;
					

				}

				###Caso titulo + prep. em ou de + NP: todos LOC

				if ($Lema[$i-2] =~ /^($titulo)$/ && $Lema[$i-1] =~ /^(en|em|n.|en.|en.s|enn.|enn.s|n.s|d.|d.s|in)$/  && $Tag[$i] =~ /^NP/) {
					$new_tag =  "NP00G00";
					#$Token[$i] =  $Token[$i] . "_" .  $Token[$i+1] . "_" .  $Token[$i+2] ;
					#$Lema[$i] =  $Lema[$i] . "_" .  $Lema[$i+1] . "_" .  $Lema[$i+2] ;
					#print STDERR "---->>$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
					if($pipe){#<ignore-line>
						print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, "$Token[$i] $Lema[$i] $new_tag");
					}#<ignore-line>
					$found=1;
					#$i+=2;
					next;
				}

				###Caso titulo + prep. em ou de + artigo + NP: todos LOC

				if ($Lema[$i-3] =~ /^($titulo)$/ && $Lema[$i-2] =~ /^(en|em|n.|en.|en.s|enn.|enn.s|n.s|d.|d.s|in)$/ && $Lema[$i-1] =~ /^(o|a|os|as|ho|hos)$/   && $Tag[$i] =~ /^NP/) {
					$new_tag =  "NP00G00";
                                        #$Token[$i] =  $Token[$i] . "_" .  $Token[$i+1] . "_" .  $Token[$i+2] . "_" .  $Token[$i+3];
					#$Lema[$i] =  $Lema[$i] . "_" .  $Lema[$i+1] . "_" .  $Lema[$i+2] . "_" .  $Lema[$i+3] ;
					
					if($pipe){#<ignore-line>
						print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, "$Token[$i] $Lema[$i] $new_tag");
					}#<ignore-line>
					$found=1;
					#$i+=3;
					next;
				}


					
				if ($Tag[$i] =~ /^NP/ && !$found) {
					#print STDERR "okk:: #$i# #$Lema[$i]#\n";
					#if (defined $meses{$Lema[$i]}) {
					#	$new_tag =  "NP00V00";
					#	print "$Token[$i] $Lema[$i] $new_tag\n";
					#	$found=1;
					#}
					
				       
					###Caso NP + de (Art) + NP: todos LOC
		        
					if ($Lema[$i-1] =~  /(os|as|a|o|\')/  && $Lema[$i-2] =~  /^(d|de)$/ && $Tag[$i-3] =~ /^NP/) {
					$new_tag =  "NP00G00";
					
					if($pipe){#<ignore-line>
						print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, "$Token[$i] $Lema[$i] $new_tag");
					}#<ignore-line>
					$found=1;
					$i+=1;
					next;
					}

                                        
					
					###Caso NP + de + NP: todos LOC

					if ($Lema[$i-1] =~  /de/ && $Tag[$i-2] =~ /^NP/) {
					$new_tag =  "NP00G00";
					
					if($pipe){#<ignore-line>
						print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, "$Token[$i] $Lema[$i] $new_tag");
					}#<ignore-line>
					$found=1;
					$i+=1;
					next;
					}
					
                                       

					## buscar NPs nao ambiguos nos gazetteers
 
					if (!Ambiguous ($Lema[$i]) &&  Gaz ($Lema[$i]) ) {
						$new_tag = Gaz ($Lema[$i]);
                                                #print STDERR "NO AMBIG ---- $Token[$i] $Lema[$i] $new_tag \n";
						if($pipe){#<ignore-line>
							print "$Token[$i] $Lema[$i] $new_tag\n";
						}else{#<ignore-line>
							push (@saida, "$Token[$i] $Lema[$i] $new_tag");
						}#<ignore-line>
						$found=1;
					}
					##buscar NPs que coincidem com os triggers:
					elsif (Tw ($Lema[$i]) ) {
						$new_tag = Tw ($Lema[$i]);
						if($pipe){#<ignore-line>
							print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida, "$Token[$i] $Lema[$i] $new_tag");
						}#<ignore-line>
						$found=1;
						#print STDERR "okkk\n";
					}
					##buscar NPs missing ou ambiguos
					elsif (Missing ($Lema[$i]) || Ambiguous ($Lema[$i]) )  {
						# print STDERR "okk:: #$i# #$Lema[$i]#\n";
						@composto = split ("_", $Lema[$i]);             

						##se o NP é PER, é composto e esta Missing ou é ambiguo, e a primeira parte é uma parte dum trigger PER ("Presidente Zapatero" ... - presidente)
						if ( ( (Ambiguous ($Lema[$i]) && defined $GazPer{$Lema[$i]}) || Missing ($Lema[$i]) ) && defined $TwPer{$composto[0]} ) {
							$new_tag =  "NP00SP0";
							$found=1;
							if($pipe){#<ignore-line>
								print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
							}else{#<ignore-line>
								push (@saida, "$Token[$i] $Lema[$i] $new_tag");
							}#<ignore-line>
						}   
						elsif ( ( (Ambiguous ($Lema[$i]) && defined $GazOrg{$Lema[$i]})  || Missing ($Lema[$i]) ) && defined $TwOrg{$composto[0]} ) {
							$new_tag =  "NP00O00";
							$found=1;
							if($pipe){#<ignore-line>
								print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
							}else{#<ignore-line>
								push (@saida, "$Token[$i] $Lema[$i] $new_tag");
							}#<ignore-line>
						}   
						elsif ( ( (Ambiguous ($Lema[$i]) && defined $GazLoc{$Lema[$i]})  || Missing ($Lema[$i]) ) && defined $TwLoc{$composto[0]} ) {
							#print "OKKKKKKKK $Lema[$i]  $composto[0]\n";
							$new_tag =  "NP00G00";
							$found=1;
							if($pipe){#<ignore-line>
								print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
							}else{#<ignore-line>
								push (@saida, "$Token[$i] $Lema[$i] $new_tag");
							}#<ignore-line>
						}  
						elsif ( ( (Ambiguous ($Lema[$i]) && defined $GazMisc{$Lema[$i]})  || Missing ($Lema[$i]) ) && defined $TwMisc{$composto[0]} ) {
							#print "OKKKKKKKK $Lema[$i]  $composto[0]\n";
							$new_tag =  "NP00V00";
							$found=1;
							if($pipe){#<ignore-line>
								print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
							}else{#<ignore-line>     
								push (@saida, "$Token[$i] $Lema[$i] $new_tag");
							}#<ignore-line>     
						}  

						### Se o NP é ambíguo PER, mas vai precedido de preposição em, então é LOC
						elsif (Ambiguous ($Lema[$i]) && defined $GazPer{$Lema[$i]} && $Lema[$i-1] =~ /^(en|em|n.|en.|en.s|enn..|enn.s|n.s|d.|d.s)$/) {
							#print STDERR "LOC - OKK\n";
							$new_tag =  "NP00G00";
							if($pipe){#<ignore-line>
								print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
							}else{#<ignore-line>
								push (@saida, "$Token[$i] $Lema[$i] $new_tag");
							}#<ignore-line>
							$found=1;
						}             	     

						###Se o NP vai precedido por título mais prep. de ou em, então é LOC
						elsif  ( (Ambiguous ($Lema[$i]) || Missing ($Lema[$i]) )   && $Lema[$i-1]  =~ /^(en|em|n.|en.|en.s|enn..|enn.s|n.s|d.|d.s)$/ &&  $Lema[$i-2]  =~  /^($titulo)$/ ) {
							$new_tag =  "NP00G00";
							if($pipe){#<ignore-line>
								print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
							}else{#<ignore-line>
								push (@saida, "$Token[$i] $Lema[$i] $new_tag");
							}#<ignore-line>
							$found=1;
						}

						###Se o NP vai precedido por título mais prep. de ou em, e artigo então é LOC
						elsif ((Ambiguous ($Lema[$i]) || Missing ($Lema[$i]) ) && $Lema[$i-3] =~ /^($titulo)$/ && $Lema[$i-2] =~ /^(en|em|n.|en.|en.s|enn..|enn.s|n.s|d.|d.s|in)$/ && $Lema[$i-1] =~ /^(o|a|os|as|ho|hos)$/   && $Tag[$i] =~ /^NP/) {
							$new_tag =  "NP00G00";
					
							if($pipe){#<ignore-line>
							print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
							}else{#<ignore-line>
							push (@saida, "$Token[$i] $Lema[$i] $new_tag");
							}#<ignore-line>
							$found=1;
					
						}



						##se o NP é PER, é composto e esta Missing, e a primeira parte é uma parte dum gazeteeiro composto (Pablo Gamallo - Pablo Picasso)
						elsif  ( ( (Ambiguous ($Lema[$i]) && defined $GazPer{$Lema[$i]}) || Missing ($Lema[$i]) ) && defined $GazPer_part{$composto[0]}) {
							$new_tag =  "NP00SP0";
							if($pipe){#<ignore-line>
								print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
							}else{#<ignore-line>
								push (@saida, "$Token[$i] $Lema[$i] $new_tag");
							}#<ignore-line>
							$found=1;
						} 



						###buscar NPs entre aspas que passam a ser MISC
						elsif  ( (Ambiguous ($Lema[$i]) || Missing ($Lema[$i]) )   && $Lema[$i-1]  =~  /^[\"\“\«]/ &&  $Lema[$i+1]  =~  /[\"\»\”]/ ) {
							$new_tag =  "NP00V00";
							if($pipe){#<ignore-line>
								print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
							}else{#<ignore-line>
								push (@saida, "$Token[$i] $Lema[$i] $new_tag");
							}#<ignore-line>
							$found=1;
						}

			

						##buscar os contextos (triggers) de  NPs (compostos ou nao) que estao missing ou que sao ambiguos 
						else {
							my $j;#<integer>
							##buscar nos triggerwords (on the left)
							if ($i > 0) {
								$left = $i - $Window;
								##para impedir presidente de a  Seat##
								$Left_1 = $i-1;
								$Left_2 = $i-2;
								##############
								for ($j=$left;$j<=$i;$j++) {
									#print STDERR "LEFT:: #$j# #$left# -- $Lema[$i]--$Lema[$j]\n";
									if (Trigger ($j, $Left_1, $Left_2, \@Lema) && !$found) {
										$found=1;
										$new_tag = Trigger ($j, $Left_1, $Left_2, \@Lema);
										if($pipe){#<ignore-line>
											print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
										}else{#<ignore-line>
											push (@saida,"$Token[$i] $Lema[$i] $new_tag");
										}#<ignore-line>
										#print STDERR "TRIGGER-LEFT ---- $Token[$i] $Lema[$i] $new_tag \n";
									}
								}
							}
							##buscar nos triggerwords (on the right)
							if (!$found) {
								##aqui nao interessa o valor de Left_1 e Left_2 porque nao buscamos preps. Na nova versao fazer dous Trigger: trigger-right e trigger-left
								$Left_1=$i; 
								$Left_2=$i;
								$right = $i + $Window;
								for ($j=$i;$j<=$right;$j++) {
									#print STDERR "RIGHT:: #$j# #$left#\n";
									if ($j <= $#Lema) {
										if (Trigger ($j, $Left_1, $Left_2, \@Lema) && !$found ) {       
											$found=1;
											$new_tag = Trigger ($j, $Left_1, $Left_2, \@Lema);
											if($pipe){#<ignore-line>
												print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
											}else{#<ignore-line>
												push (@saida,"$Token[$i] $Lema[$i] $new_tag");
											}#<ignore-line>
											#print STDERR "TRIGGER-RIGHT ---- $Token[$i] $Lema[$i] $new_tag \n";
										}
									}
								}
							}
						}
					}##missing ou ambiguous
					##se o NP é ambiguo (mas nao missing), e nao tem triggers nos contextos nem partes nos triggers nem nos gazetteers, entao desambiguamos
					if (!$found && (Ambiguous ($Lema[$i]) ) ) {      
						$new_tag = Disambiguation ($Lema[$i]);
                                                #print STDERR "DISAMB  ---- $Token[$i] $Lema[$i] $new_tag \n";
						if($pipe){#<ignore-line>
							print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida,"$Token[$i] $Lema[$i] $new_tag");
						}#<ignore-line>
						$found=1;
					}
					##finalmente, se esta totalmente missing mas NP vem precedido por presposição de lugar:

					elsif (!$found && $Lema[$i-1] =~ /^(en|em|n.|en.|en.s|enn.|enn.s|n.s|in)$/) {
						#print "$Token[$i] $Lema[$i] NP00G00\n";
						$new_tag = "NP00G00";
						if($pipe){#<ignore-line>
							print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida,"$Token[$i] $Lema[$i] $new_tag");
						}#<ignore-line>
						#print STDERR "DISAMB AD HOC ---- $Token[$i] $Lema[$i] $new_tag \n";
						$found=1;             
					}

					##finalmente, se esta totalmente missing mas NP


					elsif (!$found) {
						#print "$Token[$i] $Lema[$i] NP00V00\n";
						$new_tag = DisambiguationAdHoc ($Token[$i]);
						if($pipe){#<ignore-line>
							print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida,"$Token[$i] $Lema[$i] $new_tag");
						}#<ignore-line>
						#print STDERR "DISAMB AD HOC ---- $Token[$i] $Lema[$i] $new_tag \n";
						$found=1;             
					}
					$last_tag = $new_tag if ($found);
				}#end NPs
				##finalmente, se esta totalmente missing (nao vale para nada: ja foi tomado em conta...)
				##else {
					##print "OKKKKKKKK$Token[$i] $Lema[$i] NP00V00\n";
				#}
				else { 
					if ($Others[$i]) {##a remover
						if($pipe){#<ignore-line>
							print "$Token[$i] $Lema[$i] $Tag[$i] $Others[$i]\n"; #<ignore-line>
						}else{#<ignore-line>
							push (@saida,"$Token[$i] $Lema[$i] $Tag[$i] $Others[$i]");
						}#<ignore-line>
					}else {
						if($pipe){#<ignore-line>
							print "$Token[$i] $Lema[$i] $Tag[$i]\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida,"$Token[$i] $Lema[$i] $Tag[$i]");
						}#<ignore-line>
					}
				}
			}
			if($pipe){#<ignore-line>
				print "$line\n";#<ignore-line>
			}else{#<ignore-line>
				push (@saida, "$line" );
			}#<ignore-line>
			@Token=();#<$size>
			@Lema=();#<$size>
			@Tag=();#<$size>
			@Others=();#<$size># a remover
			$new_tag="";
			$i=0;
		}
	}
	return \@saida;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	nec(\@lines);
}
#<ignore-block>

##FUNÇOES DEPENDENTES DE nec_es
sub Missing {
	my ($x) = @_ ;#<string>
	if (!defined $GazLoc{$x} && !defined $GazPer{$x} && !defined $GazOrg{$x} && !defined $GazMisc{$x}) {
		return 1;
	}else {
		return 0;
	}
}


sub Ambiguous {
    my ($x) = @_ ;#<string>
    if  ( 
	  (defined $GazLoc{$x} && defined $GazPer{$x}) || 
	  (defined $GazLoc{$x} && defined $GazOrg{$x}) ||
	  (defined $GazPer{$x} && defined $GazOrg{$x}) ||
	  (defined $GazLoc{$x} && defined $GazMisc{$x}) ||
	  (defined $GazPer{$x} && defined $GazMisc{$x}) ||
	  (defined $GazOrg{$x} && defined $GazMisc{$x})
	) { 
		return 1;
	}else {
		return 0;
	}
}

sub Disambiguation {
	my ($x) = @_ ;#<string>
	my $result;#<string>

    if (defined $GazLoc{$x} && defined $GazPer{$x}) {
		$result = "NP00SP0";
	}elsif  (defined $GazLoc{$x} && defined $GazOrg{$x}) {
		$result = "NP00G00";
	}elsif  (defined $GazPer{$x} && defined $GazOrg{$x}) {
		$result = "NP00SP0";
	}elsif  (defined $GazPer{$x} && defined $GazMisc{$x}) {
		$result = "NP00SP0";
	}elsif  (defined $GazOrg{$x} && defined $GazMisc{$x}) {
		$result = "NP00O00";
	}elsif  (defined $GazLoc{$x} && defined $GazMisc{$x}) {
		$result = "NP00G00";
	}else {
		$result = "NP00SP0";
	}
	return $result;
}


sub Trigger {
	my ($x,$L1,$L2)=@_;#<integer>
	my $X = $_[3];#<ref><array><string>
	my $result;#<string>
    #print STDERR "okk:: #$x# #$x[$x]#  -- #$X->[$L1] -- #$X->[$L2]##\n";
	if (!$X->[$x]) {
		$result = 0;
	}else {
		if ($TwLoc{$X->[$x]}  || $X->[$L2] =~ /^(en|em|n.|en.|en.s|enn.|enn.s|n.s|d.|d.s|in)$/) {
		$result = "NP00G00";
		}elsif ($TwLoc{$X->[$x]}  || $X->[$L1] =~ /^(en|em|n.|en.|en.s|enn.|enn.s|n.s|d.|d.s|in)$/) {
			$result = "NP00G00";  # Adicionado 2/2/2018 para reconhecer tb o caso paços de Rianjo
		}elsif ($TwPer{$X->[$x]} && ##) { 
			$X->[$L1] !~ /^($prep)$/ && $X->[$L2] !~ /^($prep)$/ ) {
			#print STDERR "okk:: #$x# #$x[$x]# #$x[$L1]# \n";
			$result = "NP00SP0";
		}elsif ($TwOrg{$X->[$x]} ) {
			$result = "NP00O00";
		}elsif ($TwMisc{$X->[$x]} ) {
			$result = "NP00V00";
		}else {
			$result = 0;
		}
	}
	return $result;
}


sub Gaz {
	my ($x) = @_ ;#<string>
	my $result;#<string>

	#print STDERR "okk:: #$j# #$x#\n";
	if ($GazLoc{$x} ) {
		$result = "NP00G00";
	}elsif ($GazPer{$x} ) {
		$result = "NP00SP0";
	}elsif ($GazOrg{$x} ) {
		$result = "NP00O00";
	}elsif ($GazMisc{$x} ) {
		$result = "NP00V00";
	}else {
		$result = 0;
	}
	return $result;
}

sub Tw {
	my ($x) = @_ ;#<string>
	my $result;#<string>

	#print STDERR "okk:: #$j# #$x#\n";
	if (defined $TwLoc{$x} ) {
		$result = "NP00G00";
	}elsif (defined $TwPer{$x} ) {
		$result = "NP00SP0";
	}elsif (defined $TwOrg{$x} ) {
		$result = "NP00O00";
	}elsif (defined $TwMisc{$x} ) {
		$result = "NP00V00";
	}else {
		$result = 0;
	}
	return $result;   
}

sub DisambiguationAdHoc {
	my ($x) = @_ ;#<string>
	my $result;#<string>
    
	#if (AllUpper ($x) || $x !~ /_/)  {
	if (AllUpper ($x) ) {
		$result = "NP00O00";
	}else {  
		$result = "NP00V00";
		#$result = $last_tag;
	}
	#print STDERR "Ultimo recurso: #$x# -- $result\n";
	return $result;
}


sub AllUpper {
	my ($l) = @_;#<string>
	my $countletters=0;#<integer>
	my $result;#<string>

	my @string = split ("", $l);#<array><string>
	foreach my $letter (@string) {
		if ($letter =~ /[A-ZÁÉÍÓÚÑÇ]/) {
			$countletters++;
		}
	}
	if ( $countletters >= $#string ) {
		$result = 1;
	}
	else {
		$result = 0;
	}
	#print STDERR "OKKKK $l -- #$countletters# #$#string#-- \n";
	return $result;
}



########################################################################
#                                                                      #
#      Combina caracteres da lista de triggers                         #
#                                                                      #
########################################################################




##  Função para expandir uma lista com novas palavras formadas a partir de caracteres equivalentes

sub expand {    

my @lista_original = @_;  	# Lista original

my @lista_completa; 		# Lista original mais variantes


my @lista_variantes1 = itera(@lista_original);

push(@lista_completa,@lista_variantes1);

my @lista_variantes2 = itera(@lista_variantes1);

push(@lista_completa,@lista_variantes2);

push(@lista_completa,@_);

return @lista_completa;	


}


# Função que itera sobre uma lista (ou termo) para gerar as variantes

sub itera {


my @lista_variantes;   	# Declara a lista de novas variantes

my @character_nn;       # Declara a lista de nasais palatais

my @character_s;	# Declara equivalentes para s

my @character_ll;    	# Declara equivalentes para a lateral palatal

my @character_a;

my @character_an;

my @character_e;

my @character_en;

my @character_i;

my @character_in;

my @character_o;

my @character_on;

my @character_un;

my @character_u;

my @character_r;

my @full_list = @_;  	# Termos da lista original

my @character_pass;  	# Lista de caracteres para enviar a subrutina


@character_nn = ("nn","gn","nh","in", "jn", "yn", "ñ");

@character_pass = @character_nn;

my @mute_found_nn = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a nn e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_nn);	


@character_ll = ("ll","lh","il", "jl", "yl");

@character_pass = @character_ll;

my @mute_found_ll = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_ll);	


@character_s = ("s","ss","ʢ", "ç", "z", "ſ");

@character_pass = @character_s;

my @mute_found_s = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_s);	


@character_a = ("a","aa", "á");

@character_pass = @character_a;

my @mute_found_a = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_a);	


@character_an = ("ã","an", "am");

@character_pass = @character_an;

my @mute_found_an= combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_an);	


@character_e = ("e","ee", "é");

@character_pass = @character_e;

my @mute_found_e = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_e);	


@character_en = ("ẽ","en", "em");

@character_pass = @character_en;

my @mute_found_en = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_en);	



@character_i = ("i","y","j","ii","í","ĩ");

@character_pass = @character_i;

my @mute_found_i = combine_characters(\@character_pass, \@full_list);   # pesquisa a lista para palavras com caracteres equivalentes a i e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_i);	


@character_in = ("ĩ","in", "im");

@character_pass = @character_in;

my @mute_found_in = combine_characters(\@character_pass, \@full_list);   # pesquisa a lista para palavras com caracteres equivalentes a i e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_in);	


@character_o = ("o","oo", "ó");

@character_pass = @character_o;

my @mute_found_o = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_o);	


@character_on = ("õ","on", "om");

@character_pass = @character_on;

my @mute_found_on = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_on);	


@character_u = ("u","v", "uu", "vv", "ú");

@character_pass = @character_u;

my @mute_found_u = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_u);	


@character_un = ("ũ","un", "um");

@character_pass = @character_un;

my @mute_found_un = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_un);	


@character_r = ("r","rr");

@character_pass = @character_r;

my @mute_found_r = combine_characters(\@character_pass, \@full_list);  # pesquisa a lista para palavras com caracteres equivalentes a ll e adiciona as mutações para a lista de novas variantes

push (@lista_variantes, @mute_found_r);	


return @lista_variantes;
	

}





#  Função que combina os caracteres equivalentes 

sub combine_characters {

my ($character_pass, $full_list) = @_;

my @muted_list;  								# declara uma lista temporal para guardar as palavras mutadas

	foreach my $character (@$character_pass) {    				#  Para cada um dos caracteres considerados equivalentes

	
		my @find_char = grep(/$character/,@$full_list);       		# pesquisa a lista completa e recupera as palavras em que aparece o carácter (ou dígrafo)
							
			for my $word_found (@find_char)    			# Para cada uma das palavras recuperadas que contêm o carácter
			
			{
				
				foreach my $equivalent_char (@$character_pass) {    # itera outra vez sobre cada um dos caracteres equivalentes

				my $muted_word = $word_found;        		    # dá um novo novo para a variável de modo que seja reescrita em cada iteração                

				$muted_word =~ s/$character/$equivalent_char/g;     # troca o caracter equivalente tantas vezes quanto apareça nesta palavra
			
				push (@muted_list, $muted_word);	            # adiciona a nova palavra para a lista de palavras mutadas

				#print "replace $character with $equivalent_char gives $muted_word in $word_found \n";
							
				}

			}

	}


return @muted_list;    # devolve a lista de palavras mutadas

}







