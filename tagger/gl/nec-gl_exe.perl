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
my $titulo = "señor|señora|señorita|señorito|don|doña|dona";#<string>
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

while (my $NP = <$TWLOC>) {#<string>
	chomp $NP;
	$TwLoc{$NP}=1;
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
					if($pipe){#<ignore-line>
						print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, "$Token[$i] $Lema[$i] $new_tag");
					}#<ignore-line>
					$found=1;
					$i+=1;
					next;
				}
				if ($Tag[$i] =~ /^NP/ && !$found) {
					#print STDERR "okk:: #$i# #$Lema[$i]#\n";
					#if (defined $meses{$Lema[$i]}) {
					#	$new_tag =  "NP00V00";
					#	print "$Token[$i] $Lema[$i] $new_tag\n";
					#	$found=1;
					#}
					## buscar NPs nao ambiguos nos gazetteers 
					if (!Ambiguous ($Lema[$i]) &&  Gaz ($Lema[$i]) ) {
						$new_tag = Gaz ($Lema[$i]);
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
						elsif (Ambiguous ($Lema[$i]) && defined $GazPer{$Lema[$i]} && $Lema[$i-1] =~ /^(en|em|in)$/) {
							#print STDERR "LOC - OKK\n";
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
						elsif  ( (Ambiguous ($Lema[$i]) || Missing ($Lema[$i]) )   && $Lema[$i-1]  =~  /^[\"\“\«\']/ &&  $Lema[$i+1]  =~  /[\"\»\”\']/ ) {
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
						if($pipe){#<ignore-line>
							print "$Token[$i] $Lema[$i] $new_tag\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida,"$Token[$i] $Lema[$i] $new_tag");
						}#<ignore-line>
						$found=1;
					}
					##finalmente, se esta totalmente missing:
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
		if ($TwLoc{$X->[$x]}  || $X->[$L2] =~ /^(en|em|in)$/) {
		$result = "NP00G00";
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


