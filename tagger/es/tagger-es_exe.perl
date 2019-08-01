#!/usr/bin/env perl

#PoS tagger
#autor: Pablo Gamallo
#Grupo ProlNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Desambigua os tags do ficheiro gerado por ner.perl
package Tagger;

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

my $MODEL;#<file>
open ($MODEL, $abs_path."/model/train-es") or die "O ficheiro train-es não pode ser aberto: $!\n";
binmode $MODEL,  ':utf8';#<ignore-line>

##variabeis globais
my $w=1; #<string>#mesma janela/window que no treino
my $Border = "(Fp|<blank>)";#<string>
my @cat_open = ("NC", "VMI", "VMS", "VMG", "VMP", "VMN", "RG", "AQ");#<array><string>
#my @cat_open = ("NC", "VMI", "RG", "AQ");


my $N;#<double>
my %PriorProb=();#<hash><hash><double>
my %ProbCat=();#<hash><double>
my %featFreq=();#<hash><double>

#####################
#                   #
#    READING TRAIN  #
#                   #
#####################

my $count=0;#<integer>
while (my $line = <$MODEL>) {  #<string>#leitura treino

	my $cat;#<string>
	my $prob;#<double>
	my $feat;#<string>
	my $freq;#<double>
  
	$count++; 
	chomp $line;
	#$line = trim($line);

	($N) = ($line =~ /<number\_of\_docs>([0-9]*)</) if ($count==1);

	if ($line =~ /<cat>/) { 
		(my $tmp) = $line =~ /<cat>([^<]*)</ ;#<string>
		#print STDERR "ProbCat: ---> #$tmp# \n";
		($cat, $prob) = split (" ", $tmp);
		$ProbCat{$cat}=$prob ;
		#print STDERR "CAT: ---> #$cat# \n";
	}

	($feat, $cat, $prob, $freq) = split(qr/ /, $line) if ($line !~ /<cat>/);

	$PriorProb{$cat}{$feat} = $prob if ($cat);
	$featFreq{$feat} = $freq;
	# print STDERR "CAT: ---> #$cat# ::: FEAT: #$feat# --  $featFreq{$feat}\n";
	#printf STDERR "<%7d>\r",$cont if ($cont++ % 100 == 0);
   
}
close $MODEL;

sub tagger {

	my @saida=();#<list><string>
	my ($text) = @_;#<ref><list><string>

	my $pos=0;#<integer>
	my $s=0;#<integer> numero de frases
	my $tag;#<string>

	my $size = @{$text};#<integer>
	my @noamb=();#<array><$size><boolean>
	my @unk=();#<array><$size><boolean>
	my @Token=();#<array><$size><string>
	my @Tag=();#<array><$size><string>
	my @Lema=();#<array><$size><string>
	my %Tag=();#<hash><hash><string>
	my %Lema=();#<hash><hash><string>
	my @Feat=();#<list><string>
	my @Cat=();#<list><string>
 

	###############################
	#                             #
	##INPUT: FRASE A ANALISAR######
	#                             #
	###############################

	foreach my $line (@{$text}) {
#		if ($line !~ /\w/ || $line =~ /^[ ]$/) {
#			next;
#		}
 
		my @entry = split (" ", $line);#<array><string> 
  
		if ($entry[2] !~ /^$Border$/) {
			$Token[$pos] = $entry[0];
			if ($entry[0] && !$entry[1]) {
 			    $entry[1] = $entry[0];
			    $entry[2] = "Fz";
			}

			my $i=1;#<integer>
			while ($i<=$#entry) {
				 $Lema[$pos] =  $entry[$i];
				 $i++  ;
				 $tag = $entry[$i];
         
				($Tag[$pos]) = $tag =~ /([A-Z][A-Z][A-Z])/ if ($tag =~ /^V/);
				($Tag[$pos]) = $tag =~ /([A-Z][A-Z0-9]?)/ if ($tag !~ /^V/);
				$Tag{$pos}{$Tag[$pos]} = $tag;
				$Lema{$pos}{$tag} = $Lema[$pos];

				if  ($#entry == 2 && $entry[2] ne "UNK") { ##identificar formas nao ambiguas nem desconhecidas (unk)
					$noamb[$pos]=1;
				}
				if  ($#entry == 2 && $entry[2] eq "UNK") { ##identificar formas  desconhecidas (unk)
					$unk[$pos]=1;
				}

				$i++;
				#print STDERR "LEMA:: #$Token[$pos]# #$Lema{$pos}{$Tag[$pos]}# #$Tag[$pos]#\n"; 
				#print STDERR "----$Tag[$pos]# --#$ProbCat{$Tag[$pos]}#\n";
			}
    
			####REGRAS MORFOLOGICAS
			if  ($unk[$pos] && $Token[$pos] =~ /[\w]+mente$/) { ##se a forma e desconhecida acabada em -mente, RG
				my  $cat = "RG";#<string>
				$Tag{$pos}{$cat} = $cat;
				$Lema{$pos}{$Tag{$pos}{$cat}} = $Lema[$pos] ;
				$unk[$pos]=0;
			}elsif  ($unk[$pos] && $Token[$pos] !~ /[áéíóú]/ && $Token[$pos] =~ /[\w]+[aei]r$/) { ##se a forma e desconhecida acabada em -ar/er/ir, VMN
				my  $cat = "VMN";#<string>
				$Tag{$pos}{$cat} = "VMN0000";
				$Lema{$pos}{$Tag{$pos}{$cat}} = $Lema[$pos] ;
				$unk[$pos]=0;
			}elsif  ($unk[$pos] && $Token[$pos] !~ /[áéíóú]/ && $Token[$pos] =~ /[\w]+ando$/) { ##se a forma e desconhecida acabada em -ando, VMG
				my  $cat = "VMG";#<string>
				$Tag{$pos}{$cat} = "VMG0000";
				$Lema{$pos}{$Tag{$pos}{$cat}} = $Lema[$pos];
				$unk[$pos]=0;
				#print STDERR "POS:: ----#$Lema[$pos]#  #$Tag{$pos}{$cat}# #$pos# #$Tag{$pos}{$Tag{$pos}{$cat}}#\n";
			}elsif  ($unk[$pos] && $Token[$pos] !~ /[áéíóú]/ && $Token[$pos] =~ /[\w]+[ai]d[ao](s)?$/) { ##se a forma e desconhecida acabada em -ado/ido, VMP
				my  $cat = "VMP";#<string>
				$Tag{$pos}{$cat} = "VMP0000";
				$Lema{$pos}{$Tag{$pos}{$cat}} = $Lema[$pos] ;
				$unk[$pos]=0;
			}elsif  ($unk[$pos] && $Token[$pos] !~ /[áéíóú]/ && $Token[$pos] =~ /[\w]+(ie[s]+e([sn])?|iera([sn])?|a[s]+e([sn])?|ara([sn])?)$/) { ##se a forma e desconhecida acabada em -iese/iera, VMSI
				my  $cat = "VMS";#<string>
				$Tag{$pos}{$cat} = "VMSI000";
				$Lema{$pos}{$Tag{$pos}{$cat}} = $Lema[$pos] ;
				$unk[$pos]=0;
			}elsif  ($unk[$pos] && $Token[$pos] =~ /[\w]+ría([sn])?$/) { ##se a forma e desconhecida acabada em -ría, VMI
				my  $cat = "VMI";#<string>
				$Tag{$pos}{$cat} = "VMIC000";
				$Lema{$pos}{$Tag{$pos}{$cat}} = $Lema[$pos] ;
				$unk[$pos]=0;
			}elsif  ($unk[$pos] && $Token[$pos] =~ /[\w]+([áaée]is|[ae]mos)$/) { ##se a forma e desconhecida acabada em -eis/ais/amos/emos, VMI
				my  $cat = "VMI";#<string>
				$Tag{$pos}{$cat} = "VMI00P0";
				$Lema{$pos}{$Tag{$pos}{$cat}} = $Lema[$pos] ;
				$unk[$pos]=0;
				#print STDERR "POS:: ----#$Token[$pos]#  #$Tag{$pos}{$cat}# #$pos# \n";

			}
			####FIM REGRAS MORFOLOGICAS     
			$pos++;
		}else {
			$s++;
			##guardar info da ultima forma da frase (Fp ou blank)
			my @entry = split (" ", $line);#<array><string>
			#print STDERR "LAST: #$line#\n";
			my $last_entry =  "$entry[0] $entry[1] $entry[2]";#<string>
			for ($pos=0;$pos<=$#Tag;$pos++) {
				#print STDERR "TOKENS::: #$pos# -- #$Token[$pos]#\n";
				if ($noamb[$pos]) {
					###RESULTADO para nao ambiguas nem desconhecidas: 
					if($pipe){#<ignore-line>
						print "$Token[$pos] $Lema[$pos] ".$Tag{$pos}{$Tag[$pos]}."\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, "$Token[$pos] $Lema[$pos] ".$Tag{$pos}{$Tag[$pos]});
					}#<ignore-line>
				}else {
					if (!$unk[$pos]) { #se a forma e ambigua mas conhecida, utilizamos a lista de tags atribuida a forma
						foreach  my $cat (keys %{$Tag{$pos}}) {
							#print STDERR "----#$cat# \n";
							push (@Cat, $cat);
						}
					}else { #se a forma e desconhecida, utilizamos uma lista de tags de classes abertas
						foreach  my $cat (@cat_open) {
							#print STDERR "UNK----#$cat# \n";
							push (@Cat, $cat);
						}  
					}     
					#buscar a informaçao das entradas a direita (w=1)
					my $k=0;#<integer>
					my $amb;#<string>
		
					if ($pos==0) {
						for (my $j=1;$j<=$w;$j++) {#<integer>
							if ($noamb[$j]) {
								$amb = "noamb";
							}else {
								$amb = "amb";
							}
							foreach my $feat (keys %{$Tag{$j}}) {
								if (!$feat) {next;}
								$k++;
								$feat = $amb . "_" . $k . "_" . $w . "_R_" . $feat;
								my $new_token = lc $Token[$pos];#<string>
								my $featL = $feat . "_" .  $new_token;#<string>
								#  print STDERR "FEATS:: ----#$feat#  #$Tag{$j}{$feat}# #$Token[$pos]# #$Token[$j]# \n";
								push (@Feat, $feat);
								push (@Feat, $featL);
							}   
							my $feat = "noamb" . "_" . "1" . "_" . $w . "_L_" . "BEGIN";#<string>
							push (@Feat, $feat);
							$k=0;
							$amb="";
						}
					}elsif ($pos==$#Tag) {
						my $end=$#Tag-$w;#<integer>
						for (my $j=$#Tag-1;$j>=$end;$j--) {#<integer>
						if ($noamb[$j]) {
							$amb = "noamb";
						}else {
							$amb = "amb";
						}
						foreach  my $feat (keys %{$Tag{$j}}) {
							if (!$feat) {
								next;
							}
							$k++;
							$feat =  $amb . "_" . $k . "_" . $w . "_L_" . $feat;
							my $new_token = lc $Token[$pos];#<string>
							my $featL = $feat . "_" .  $new_token;#<string>
							#   print STDERR "OKKK----#$Tag{$pos}# \n";
							push (@Feat, $feat);
							push (@Feat, $featL);
						}
						my $feat = "noamb" . "_" . "1" . "_" . $w . "_R_" . "END";#<string>
						push (@Feat, $feat);  
						$k=0;
						$amb="";
						}  
					} 
					else {
						my $end=$pos+$w;#<integer>
						#print STDERR "i=#$i#::: #$Cat# -- #$#Tag#\n";
						for (my $j=$pos+1;$j<=$end;$j++) {#<integer>
							if ($noamb[$j]) {
								$amb = "noamb";
							}else {
								$amb = "amb";
							}
							foreach my $feat (keys %{$Tag{$j}}) {
								if (!$feat) {
									next;
								}
								$k++;
								$feat = $amb . "_" . $k . "_" . $w . "_R_" . $feat;
								my $new_token = lc $Token[$pos];#<string>
								my $featL = $feat . "_" .  $new_token;#<string>
								# print STDERR "OKKK----#$Token[$pos]# \n";
								#print STDERR "----#$feat# \n";
								push (@Feat, $feat);
								push (@Feat, $featL);
							}     
							$k=0; 
							$amb="";
						}  
						$end=$pos-$w; 
						for (my $j=$pos-1;$j>=$end;$j--) {#<integer>
							if ($noamb[$j]) {
								$amb = "noamb";
							}else {
								$amb = "amb";
							}
							foreach my $feat (keys %{$Tag{$j}}) {
								if (!$feat) {
									next;
								}
								$k++;
								$feat = $amb . "_" . $k . "_" . $w . "_L_" . $feat;
								my $new_token = lc $Token[$pos];#<string>
								my $featL = $feat . "_" .  $new_token;#<string>
								#print STDERR "----#$feat# \n";
								push (@Feat, $feat);
								push (@Feat, $featL);
							}  
							$k=0;    
							$amb="";
						}
					}
					$tag = classif ($pos, \@Feat, \@Cat, \@unk);
					#print STDERR "RES:::::#$Token[$pos]# #$tag#\n";
					if ($unk[$pos]) {
						$tag =~ s/^([^ ]+)/${1}00000/ if ($tag =~ /^[N]/);
						$tag =~ s/^([^ ]+)/${1}0000/ if ($tag =~ /^[AV]/);
						$Tag[$pos] = $tag;
						$Lema{$pos}{$Tag[$pos]} =  $Token[$pos]; ##colocar o mesmo token no lema para as desconhecidas
					}else {
						$Tag[$pos] = $Tag{$pos}{$tag} ;
					}
					###RESULTADO:
					if($pipe){#<ignore-line>
						print "$Token[$pos] ".$Lema{$pos}{$Tag[$pos]}." $Tag[$pos]\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, "$Token[$pos] ".$Lema{$pos}{$Tag[$pos]}." $Tag[$pos]"); 
					}#<ignore-line>

					##eliminar tags nao selecionados do token resultante para proximos processos
					foreach my $t (keys %{$Tag{$pos}}) {
						if ($t ne $tag) {
							delete $Tag{$pos}{$t}; 
						}
					}       
					@Feat=();
					@Cat=();        
				}
			}
			###RESULTADO:
			if($pipe){#<ignore-line>
				print "$last_entry\n\n";#<ignore-line>
			}else{#<ignore-line>
				push (@saida, "$last_entry");
				push (@saida, "");
			}#<ignore-line>  
    
			for ($pos=0;$pos<=$#Tag;$pos++) {
				delete $Tag{$pos}; 
				delete $Lema{$pos};
			}  
     
			@Tag=();#<$size>
			@Token=();#<$size>
			@noamb=();#<$size>
			@unk=();#<$size>
			$pos=0;      
		}
	} 
	#print STDERR "number of sentences: #$s#\n";
	return \@saida;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	tagger(\@lines);
}
#<ignore-block>

sub classif {
	my $pos = $_[0];#<integer>
	my $F = $_[1];#<ref><list><string>
	my $C = $_[2];#<ref><list><string>
	my $unk = $_[3];#<ref><array><boolean>
	my $result;#<string>
 

	#########################################
	#                                       #
	#       Classification                  #
	#                                       #
	#########################################
  
	my %found=();#<hash><boolean>
	my $smooth = 1/$N;#<double>
	#my $cat_restr;
	#my $n;
	my $feat;#<string>
	my %PostProb;#<hash><double>

	##Para cada cat, construir os cat_restr em funçao do numero de features ambiguos
	#foreach $cat (@{$C}) {
		#foreach $feat (@{$F}) {
			#($n)  = $feat =~ /^[a-z]+\_([0-9]+)/;
			#$cat_restr = $cat . "_" . $n; 
			#push (@CAT_RESTR, $cat_restr);
		#}
	#}

	#my $Normalizer=0;
	#my %count;#<hash><integer>
	foreach my $cat (@{$C}) {
		if (!$cat) {
			next;
		}
		#$count{$cat}++;
		$PostProb{$cat}  = $ProbCat{$cat};
		#print STDERR "----#$cat_restr# #$ProbCat{$cat}#\n";
		$found{$cat}=0;
		foreach my $feat_restr (@{$F}) {
			($feat) = $feat_restr =~ /^[a-z]+\_[0-9]+\_[0-9]\_([RL]\_[^ ]+)/;
			#print STDERR "FEAT: #$cat# - #$feat#\n"; 
			if (!$featFreq{$feat}) { 
			  #print STDERR "NOFREQ----#$cat# - #$feat#\n" ;
			   next;
			}    
			$PriorProb{$cat}{$feat}  = $smooth if ($PriorProb{$cat}{$feat}  ==0 ) ; 
			if (rules_neg ($cat, $feat)) {
			  $PriorProb{$cat}{$feat}  = 0;  
			  #print STDERR "RULES NEG:: ----#$cat# - #$feat# PriorProb=#$PriorProb{$cat}{$feat}# \n";
			}
			elsif (!$unk->[$pos] && rules_pos ($cat, $feat)) {
			  $PriorProb{$cat}{$feat}  = 100; ##CUIDADO COM ESTE VALOR MAS COM 1 NOM FURRULA BEM!! 
			  #print STDERR "RULES POS:: ----#$cat# - #$feat# PriorProb=#$PriorProb{$cat}{$feat}# \n";
			}
			$found{$cat}=1; 
			$PostProb{$cat} = $PostProb{$cat} * $PriorProb{$cat}{$feat};
#			print STDERR "----#$cat# - #$feat# PriorProb#$PriorProb{$cat}{$feat}# PostProb#$PostProb{$cat}#  -- featFreq:#$featFreq{$feat}# N=#$N#  \n";
		}
		$PostProb{$cat} =  $PostProb{$cat} * $ProbCat{$cat} ;
		$PostProb{$cat} = 0 if (!$found{$cat});    
		#$Normalizer +=   $PostProb{$cat} 
		#print STDERR "----#$cat# $PostProb{$cat} \n";
	}
	my $First=0;#<integer>
	foreach my $c (sort {$PostProb{$b} <=> 	$PostProb{$a} }	keys %PostProb ) {
		if (!$First) {
			my $score = $PostProb{$c};#<double>
			#print STDERR "$c\t$score\n";
			$result = "$c";
			$First=1;
		}
	}
	#print STDERR "RES:::: #$result#\n";
	return $result;
}


sub rules_neg {    #regras lexico-sintacticas negativas
	my ($cat, $feat) = @_ ;#<string>
	my $result;#<string>

	##impedir o 'que' conjunção após nome comum
	if ($cat =~ /^CS/ && $feat eq "L_NC_que") {
		$result = 1;
	}
	#impedir artigo final de frase ou seguido de preposiçao ou de conjunção
	elsif ($cat =~ /^D/ && ($feat eq "R_END" || $feat eq "R_SP" || $feat eq "R_CC") ) {
		$result = 1;
	}
	
	return $result;

}


sub rules_pos {    #regras lexico-sintacticas positivas
	my ($cat, $feat) = @_ ;#<string>
	my $result;#<string>

	##se hai um adverbio negativo diante dum verbo
	if ($cat =~ /^RN/   && $feat =~ /R_V/  ) {
		$result = 1;
	}
	elsif ($cat =~ /^VMM/   && $feat =~ /R_PP/  ) {
		$result = 1;
	}
	
	return $result;
}


sub trim {    #remove all leading and trailing spaces
	my $str = $_[0];#<string>

	$str =~ s/^\s*(.*\S)\s*$/$1/;
	return $str;
}

