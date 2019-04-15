#!/usr/bin/env perl

package Triples;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
use open qw(:std :utf8);
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

# Absolute path 
use Cwd 'abs_path';#<ignore-line>
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(abs_path($0));#<ignore-line>

my $Border="SENT";#<string>

sub triples {
	my ($lines) = @_;#<ref><list><string>

	my @saida=();#<list><string>
  
	my @Pos=();#<list><integer>
	my @Token=();#<list><string>
	my @Lemma=();#<list><string>
	my @Tag=();#<list><string>
	my @Head=();#<list><string>
	my @Args=();#<list><string>
	my @Dep=();#<list><string>
	my %Const_dep=();#<hash><hash><string><smart>
	my %Const_tag=();#<hash><hash><string><smart>
	my %Const=();#<hash><hash><boolean><smart>
	my %Unit=();#<hash><hash><boolean>

	my $source="";#<string>
	my $Subj;#<string>
	my $Dobj;#<string>
	my $Dobj2;#<string>
	my $DobjCompl;#<string>
	my $Circ;#<string>
	my $Atr;#<string>

	my $l=1; #<integer>#number of words per sentence
	my $Size;#<integer>
	my $k=1; #<integer>#number of sentences

	#Perldoop
	$Pos[0] = undef;
	$Token[0] = undef;
	$Lemma[0] = undef;
	$Tag[0] = undef;
	$Head[0] = undef;
	$Args[0] = undef;
	$Dep[0] = undef;
  
	foreach my $line (@{$lines}) {
		chomp($line);
  
		if ($line eq "") {next;}

		my ($pos, $token, $lemma, $tag, $head, $args, $dep) = split("\t", $line);#<string>

		#print STDERR "LINE: #$line# -- $pos\n";
		$args =~ s/</(/;
		$args =~ s/>/)/;

		##No caso de haver NEC:
		if ($args =~ /nec:/) {
			my ($class) = ($args =~ /nec:([A-Z0-9]+)/);#<string>
			$tag = $tag . $class if ($class);
		}

	
		##construimos os vectores da oracao
		if ($tag !~  /^$Border$/) {
			if ($dep !~ /[\<\>]/) { ##saltar dependencias lexicais   
				$dep =~ s/(Creg|Iobj|DobjPrep)/Circ/; ##normalizar complementos preposicionais...
				#$dep =~ s/(Atr)/Dobj/;
				#print STDERR "Dep: #$dep#\n";
				$Pos[$l] = $pos ;
				if ($lemma =~ /@/) {
					$Token[$l] = $token;
				} else {
					$Token[$l] = $token;
				}
				$Lemma[$l] = $lemma;
				$Tag[$l] = $tag;
				$Head[$l] = $head;
				$Args[$l] = $args;
				$Dep[$l] = $dep;

				##mudamos o tag de PRP no contexto "prep+pron-rel" a PRP-REL
				if ($Tag[$l-1] =~ /PRP/ && $Tag[$l] =~ /PRO/ && ($Args[$l] =~ /type:R|W/ || $Args[$l] =~  /lemma:que|quem|quen|quien|that|which|who/) ) {
				   $Tag[$l-1] = "PRP-REL"; 
				  
				} 
				## "para o que"
				elsif ($Tag[$l-2] =~ /PRP/ && $Lemma[$l-1] =~ /^(o|el)$/ && $Tag[$l] =~ /PRO/ && ($Args[$l] =~ /type:R|W/ || $Args[$l] =~  /l
emma:que|quem|quen|quien/) ) {
				   $Tag[$l-2] = "PRP-REL"; 
				   
				} 
			        ### os antecedentes de participios imos trata-los como SUBJ:
				if ($dep =~ /AdjnR/ && $tag eq "VERB" && $Args[$l] =~ /mode:P/) {
				    $Dep[$head] = "SubjL";
				    $Const_dep{$l}{$head} = "SubjL" ;
				    ####construimos todos os hashes:
				    $Const_tag{$l}{$head} = $Tag[$head];
				    $Const{$l}{$head}=1;
				    $Unit{$l} = {} if (!defined $Unit{$l});
				    $Unit{$l}{$head}=1 ;
				    $Unit{$l}{$l}=1;
				    
				    $Head[$head] = $l;
				    $Head[$l] = 0;
				    #print STDERR "--> #$dep# - #$Dep[$head]#  - #$Lemma[$head]# head-noun:#$Head[$head]# - head-verb: #$Head[$l]#\n";
				    $head = 0;
				    
				}

				##construimos os hashes de head-dependent
				if ($head != 0 ) {
					$Const_dep{$head}{$l} = $dep;
					$Const_tag{$head}{$l} = $tag;
				}
				$Const{$head}{$l}=1;

				##construir as unidades a partir dos head
				$Unit{$head} = {} if (!defined $Unit{$head});
				$Unit{$head}{$l}=1 ;## if ($Tag[$l] !~ /^F/); ##nao tomar em conta os simbolos de punctuaçao
				$Unit{$head}{$head}=1;

				##construir a oracao fonte:
				$source .= "$Token[$l] ";
			}
			$l++;
		} elsif ($tag =~  /^$Border$/) {
			$source .= "$token" ;
			$Size = $l;
			###print "sentence\t$k\t$source\n";  ####IMPRIMIR SENTENCE NUMA VERSAO MAIS ELABORADA  
			##expansao das unidades e niveis de organizacao
			for (my $i=0;$i<=$Size;$i++) {#<integer>
				if (defined $Unit{$i}) {
					#print STDERR "Head: $i## \n";
					foreach my $const (keys %{$Unit{$i}}) {
						#print STDERR "Head: $i## -- Const: ###$const###\n";

						##TRATAR AS COORDINAÇOES!!! O CONST (coordenado) HERDA OS CONSTITUINTES DO HEAD (coordenador)
						if ($Dep[$const] =~ /Coord/ && $Tag[$const] =~ /^[V]/) { 
							$Unit{$const}{$const}=1 ;
							if ($const eq $i){next;}
							#print STDERR "--COORD1: Const1:#$Lemma[$const]# -- Head:#$Lemma[$i]#\n"; 
							foreach my $const2 (keys %{$Const{$i}}) {
							#	print STDERR "--COORD2: Const1:#$Lemma[$const]# -- Const2:#$Lemma[$const2]# -- Head:#$Lemma[$i]# Dep: $Dep[$const2]\n"; 
								if ($Dep[$const2] !~ /Coord|Punct/ ) {
								#if ($Dep[$const2] !~ /Punct/ ) {
									$Unit{$const}{$const2}=1 ;
									$Const_dep{$const}{$const2} = $Dep[$const2];
									Expand ($const2, $const, \%Unit) ;
								#	print STDERR "--COORD3: Const1:#$Lemma[$const]# -- Const2:#$Lemma[$const2]# -- Head:#$Lemma[$i]#\n"; 
								}
							}
						} 
						##FIM DA COORDINAÇAO
						else {
							$Unit{$i}{$const}=1;
							Expand ($const, $i, \%Unit) ;
						}
					}
				} else {
					$Unit{$i} = {} if (!defined $Unit{$i});
					$Unit{$i}{$i}=1;
				}
			}

			##Construir unidades (cat fun e level) a partir dos head
			foreach my $head (sort keys %Unit) {
				if ($head eq "_" || $head == 0 || $Tag[$head] !~ /VERB/) {next;}
			
				my $result;#<string>
				my $result_token;#<string>
				my $result_lemma;#<string>
				foreach my $const (sort { $a <=> $b } keys %{$Unit{$head}}) {
					if ($Const_dep{$head}{$const} =~ /Subj/)   {
						#print STDERR "Subj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --  TAG-HEAD::$Tag[$Head[$head]] \n";
						if (relative ($const, \@Tag, \@Args) && $Tag[$Head[$head]] =~ /^N/) { ##se o sujeito e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
							$Subj =  $Head[$head]; 
							#print STDERR "REL-Subj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
						} elsif (relative ($const, \@Tag, \@Args) && $Tag[$Head[$head]] =~ /^CONJ/ && $Tag[$Head[$Head[$head]]] =~ /^N/ ) { ##se o sujeito e uma relativa coordinada, entao buscamos o nome que modifica a conjunçao coordinada
							$Subj =  $Head[$Head[$head]]; 
							#print STDERR "REL-Subj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
						} else {
							$Subj = $const if ($Tag[$const] !~ /^PRO/ || $Args[$const] !~ /type:[RW]/);
							#print STDERR "REL-Subj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
						}
					}
					###subordinadas  de sujeito
					#print STDERR "const:#$Lemma[$const]-$Tag[$const]# - head:#$Lemma[$head]-$Tag[$head]#  - dep:#$Const_dep{$head}{$const}#\n";
					#if ($Tag[$Head[$head]] =~ /^NOUN/ && $Const_dep{$Head[$head]}{$head}  =~ /^AdjnR/ && $Tag[$head] =~ /^VERB/ )   {
					#if ($Tag[$Head[$const]] =~ /^NOUN/ && $Const_dep{$head}{$const}  =~ /^AdjnR/ && $Tag[$const] =~ /^VERB/ )   {
						#$Const_dep{$head}{$const} = "SubjL";
						#$Subj =  $Head[$head]; 
						#print STDERR "----------SUBJ: $Lemma[$Head[$head]] -- const:#$Lemma[$const]-$Tag[$const]# - head:#$Lemma[$head]-$Tag[$head]#  - dep:#$Const_dep{$Head[$head]}{$head}#\n";
					#}

					if ($Const_dep{$head}{$const} =~ /Dobj[LR]/)   {
						#print STDERR "Dobj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) && $Tag[$Head[$head]] =~ /^N/) { ##se o cdir e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
							$Dobj =  $Head[$head]; 
						} else {
						$Dobj = $const  if ($Tag[$const] !~ /^PRO/ || $Args[$const] !~ /type:[RW]/);
						}
					}

					if ($Const_dep{$head}{$const} =~ /Dobj2R/)   {
						#print STDERR "Dobj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) && $Tag[$Head[$head]] =~ /^N/) { ##se o cdir e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
							$Dobj2 =  $Head[$head]; 
						} else {
							$Dobj2 = $const  if ($Args[$const] !~ /type:[RW]/);
						}
					} 

					if ($Const_dep{$head}{$const} =~ /DobjCompl/)   {
						#print STDERR "Dobj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) && $Tag[$Head[$head]] =~ /^N/) { ##se o cdir e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
							$DobjCompl =  $Head[$head]; 
						} else {
							$DobjCompl = $const if ($Tag[$const] !~ /^PRO/ || $Args[$const] !~ /type:[RW]/);
						}
					} 
					if ($Const_dep{$head}{$const} =~ /Atr/)   {
						#print STDERR "Dobj: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) && $Tag[$Head[$head]] =~ /^N/) { ##se o cdir e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
							$Atr =  $Head[$head]; 
						} else {
							$Atr = $const if ($Tag[$const] !~ /^PRO/ || $Args[$const] !~ /type:[RW]/);
						}
					} 
					if ($Const_dep{$head}{$const} =~ /Circ/)   {
                                               ##fazer uma funçom relative-rel onde so se tome em conta prep+pron-rel e chama-la com os circunstanciais...
					       #print STDERR "HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# HeadHead : $Lemma[$Head[$head]] --\n";
					    	if (relative_circ ($const, \@Tag, \@Args) && $Tag[$Head[$head]] =~ /^N/) { ##se o circ e uma relativa entao buscamos o nome que modifica ao verbo (head-of verbo) #falta 'that-IN'
							$Circ .=  $Head[$head] . "|"; 
						} else {
						#print STDERR "Circ: HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# --\n";
							$Circ .= $const . "|" if ($Tag[$const] !~ /^PRO/ || $Args[$const] !~ /type:[RW]/);
						#        print STDERR "Circ: #$Circ# -- HEAD###$Lemma[$head]### ::: DEP: #$Lemma[$const]# HeadHead : $Lemma[$Head[$head]] --\n";
						}
					}

				}

				############################################################################################
				#                   construir tripletas com relaçoes verbais                               #
				############################################################################################

				my $subj;#<string>
				my $dobj;#<string>
				my $circ;#<string>
				my $pred;#<string>
				my $subj_l;#<string>
				my $dobj_l;#<string>
				my $circ_l;#<string>
				my $pred_l;#<string>
			 
				#print STDERR "++++++ Subj: HEAD###$Token[$Subj]### -- Circ: HEAD###$Token[$Circ]### --Dobj: HEAD###$Token[$Dobj]###  \n";
				##SUBJ-PRED-CIRC
				if ($Subj && $Circ && !$Dobj) {
					#print STDERR "Subj-CIRC: #$source#\n";
					my @Circ = split ('\|', $Circ);#<array><string>
					foreach my $CircN (@Circ) {
						##SUBJ 
						foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
							#print STDERR "-- Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# -- CircN=#$CircN# -- Subj=#$Subj#\n";
							if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;}
							$subj =   $subj . " " . $Token[$const]; 
							##lemas e tags:
							$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($const != $Subj) ;
							$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $Subj) ; ##marcamos o head
						}

						##PRED
						foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
							# print STDERR "-- PRED: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
							if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
								#if ($const eq $head ||  ($Dep[$const] =~ /VSpec/ && $Const{$head}{$const} ) )  {
								$pred =   $pred .  " " . $Token[$const];
								$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head); 
								$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $head) ; ##marcamos o head
							}
						}

						##CIRC
						foreach my $const  (sort { $a <=> $b } keys %{$Unit{$CircN}}) {
							# print STDERR "-- Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
							if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep)) {
							    if (relative_circ ($const, \@Tag, \@Args) && $CircN+1 eq $const && $Tag[$CircN+1] =~ /^PRP/) { ###colocar a prep do circ no predicate
								$pred = $pred . " " . $Token[$const];
								$pred_l = $pred_l . " " . $Lemma[$const]  . "_" . $Tag[$const] ;
							    }
							    last;
							} else {
							     if ($CircN eq $const && $Tag[$CircN] =~ /^PRP/) { ###colocar a prep do circ no predicate
								$pred = $pred . " " . $Token[$const];
								$pred_l = $pred_l . " " . $Lemma[$const]  . "_" . $Tag[$const] ;
							     }
							     else {
							    
								$circ =   $circ .  " " . $Token[$const] ;   
								$circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($CircN != $Head[$const]);
								$circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const]  . "-H" if  ($CircN == $Head[$const]);         
							     }
							}
						}

						$subj = trim ($subj);
						$circ = trim ($circ);
						$pred = trim ($pred);
						$subj_l = trim ($subj_l);
						$circ_l = trim ($circ_l);
						$pred_l = trim ($pred_l);

						$result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$circ";
						$result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$circ_l";

						my $saida = building_result ($k, $result_token);#<string>
						if($pipe){#<ignore-line>
							print "$saida\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida, $saida);
						}#<ignore-line>
						#print STDERR "SAIDA: #$k# -- #$result_token# -- sub:#$subj# -- circ:#$circ#\n";

						$result="";
						$subj="";
						$circ="";
						$pred="";
						$subj_l="";
						$circ_l="";
						$pred_l="";
					}
				}

				##SUBJ-PRED-CDIR2-CDIR
				if ($Subj && $Dobj && $Dobj2) {

					##SUBJ 
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
						#print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;}
						$subj =   $subj . " " . $Token[$const]; 
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Subj) ; 
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Subj) ; ##marcamos o head
					}

					##PRED
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
						#print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
						if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
							#if ($const eq $head ||  ($Dep[$const] =~ /VSpec/ && $Const{$head}{$const} ) )  {
							$pred =   $pred .  " " . $Token[$const];
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head); 
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H"  if  ($const == $head) ; ##marcamos o head
						}
					}

					##CDIR (dentro do pred!!)
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj}}) {
						#print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep) ) {last;};

						$pred =   $pred . " " . $Token[$const] ; 
						$pred_l = $pred_l . " " . $Lemma[$const] . " " . $Tag[$const];
					}

					##CDIR2
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj2}}) {
						#print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep)  || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;}

						$circ =   $circ .  " " . $Token[$const] ;   
						$circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const];       
					}
							  
					$subj = trim ($subj);
					$circ = trim ($circ);
					$pred = trim ($pred);
					$subj_l = trim ($subj_l);
					$circ_l = trim ($circ_l);
					$pred_l = trim ($pred_l);

					$result_token =  "$subj" .  "\t" . "$pred" . " "  . "to" . "\t" . "$circ";
					$result_lemma =  "$subj_l" .  "\t" . "$pred_l"  . " " . "to_PRP" . "\t" . "$circ_l";

					my $saida = building_result ($k, $result_token);#<string>
					if($pipe){#<ignore-line>
						print "$saida\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, $saida);
					}#<ignore-line>
					#print "t-extraction\t$k\t$result_token\n";
					#print "s-extraction\t$k\t$result_lemma\n";

					$result="";
					$subj="";
					$circ="";
					$pred="";
					$subj_l="";
					$circ_l="";
					$pred_l="";
				}

				##SUBJ-PRED-CDIR
				if ($Subj && $Dobj) {

					#print STDERR "Subj-DOBJ: #$source#\n";

					##SUBJ 
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
					#	print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;}
						$subj =   $subj . " " . $Token[$const]; 
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Subj) ; 
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Subj) ; ##marcamos o head
					#	print STDERR "#$subj#\n";
					}

					##PRED
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
						#print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
						#if ($const eq $head || ($Dep[$const] =~ /VSpec/ &&  ($Const{$head}{$const} || $Const{$head}{$Head[$const]}) ) )  {
						if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
							$pred =   $pred .  " " . $Token[$const];
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head) ;    
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $head) ; ##marcamos o head
						}
					}

					##CDIR
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj}}) {
						#print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;};

						##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
						$dobj =   $dobj . " " . $Token[$const]; 
						$dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Dobj) ;
						$dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Dobj) ; ##marcamos o head
					}

					$subj = trim ($subj);
					$dobj = trim ($dobj);
					$pred = trim ($pred);
					$subj_l = trim ($subj_l);
					$dobj_l = trim ($dobj_l);
					$pred_l = trim ($pred_l);

					$result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$dobj";
					$result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$dobj_l";

					my $saida = building_result ($k, $result_token);#<string>
					if($pipe){#<ignore-line>
						print "$saida\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, $saida);
					}#<ignore-line>

					$subj="";
					$dobj="";
					$pred="";
					$subj_l="";
					$dobj_l="";
					$pred_l="";
				}
			        ##SUBJ-PRED-ATR
				if ($Subj && $Atr) {

					#print STDERR "Subj-Atr: #$source#\n";

					##SUBJ 
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
					#	print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;}
						$subj =   $subj . " " . $Token[$const]; 
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Subj) ; 
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Subj) ; ##marcamos o head
					#	print STDERR "#$subj#\n";
					}

					##PRED
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
						#print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
						#if ($const eq $head || ($Dep[$const] =~ /VSpec/ &&  ($Const{$head}{$const} || $Const{$head}{$Head[$const]}) ) )  {
						if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
							$pred =   $pred .  " " . $Token[$const];
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head) ;    
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $head) ; ##marcamos o head
						}
					}

					##ATR
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Atr}}) {
					#	print STDERR "Atr: HEAD###$Token[$Atr]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;};

						$dobj =   $dobj . " " . $Token[$const]; 
						$dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Atr) ;
						$dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Atr) ; ##marcamos o head
					}

					$subj = trim ($subj);
					$dobj = trim ($dobj);
					$pred = trim ($pred);
					$subj_l = trim ($subj_l);
					$dobj_l = trim ($dobj_l);
					$pred_l = trim ($pred_l);

					$result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$dobj";
					$result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$dobj_l";

					my $saida = building_result ($k, $result_token);#<string>
					if($pipe){#<ignore-line>
						print "$saida\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, $saida);
					}#<ignore-line>

					$subj="";
					$dobj="";
					$pred="";
					$subj_l="";
					$dobj_l="";
					$pred_l="";
				}
				  
				##SUBJ-PRED-CDIRCOMPLETIVA
				if ($Subj && $DobjCompl) {

					##SUBJ 
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
					#print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
					if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep)  || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;}
						$subj =   $subj . " " . $Token[$const]; 
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $Subj) ; 
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $Subj) ; ##marcamos o head
					}
					
					##PRED
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
						#print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
						#if ($const eq $head || ($Dep[$const] =~ /VSpec/ &&  ($Const{$head}{$const} || $Const{$head}{$Head[$const]}) ) )  {
						if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
							$pred =   $pred .  " " . $Token[$const];
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head) ;    
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $head) ; ##marcamos o head
						}
					}

					##CDIR
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$DobjCompl}}) {
						#print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep) ) {last;};

						##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
						$dobj =   $dobj . " " . $Token[$const]; 
						$dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $DobjCompl) ;
						$dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $DobjCompl) ; ##marcamos o head
					}

					$subj = trim ($subj);
					$dobj = trim ($dobj);
					$pred = trim ($pred);
					$subj_l = trim ($subj_l);
					$dobj_l = trim ($dobj_l);
					$pred_l = trim ($pred_l);

					$result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$dobj";
					$result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$dobj_l";

					my $saida = building_result ($k, $result_token);#<string>
					if($pipe){#<ignore-line>
						print "$saida\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, $saida);
					}#<ignore-line>

					$subj="";
					$dobj="";
					$pred="";
					$subj_l="";
					$dobj_l="";
					$pred_l="";
				}

				##SUBJ-PRED-CDIR-CIRC
				if ($Subj && $Circ && $Dobj) {

					my @Circ = split ('\|', $Circ);#<array><string>
					foreach my $CircN (@Circ) {

						##SUBJ 
						foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
							#print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
							if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep)  || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;}
							$subj =   $subj . " " . $Token[$const]; 
							##lemas e tags:
							$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($const != $Subj);
							$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $Subj); ##marcamos o head
						}

						##PRED
						foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
							#print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
							if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
								#if ($const eq $head ||  ($Dep[$const] =~ /VSpec/ && $Const{$head}{$const} ) )  {
								$pred =   $pred .  " " . $Token[$const];
								$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head); 
								$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $head) ; ##marcamos o head
							}
						}

						##CDIR (dentro do pred!!)
						foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj}}) {
							#print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
							if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep) ) {last;};

							##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
							$pred =   $pred . " " . $Token[$const]; 
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const];
						}

						##CIRC
						foreach my $const  (sort { $a <=> $b } keys %{$Unit{$CircN}}) {
							#print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
						    if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep) || subordin($const, \@Tag, \@Head, \%Const_dep)) {
							    if (relative_circ ($const, \@Tag, \@Args) && $CircN+1 eq $const && $Tag[$CircN+1] =~ /^PRP/) { ###colocar a prep do circ no predicate
								$pred = $pred . " " . $Token[$const];
								$pred_l = $pred_l . " " . $Lemma[$const]  . "_" . $Tag[$const] ;
							    }
							    last;
						     } else {
							     if ($CircN eq $const && $Tag[$CircN] =~ /^PRP/) { ###colocar a prep do circ no predicate
								$pred = $pred . " " . $Token[$const];
								$pred_l = $pred_l . " " . $Lemma[$const]  . "_" . $Tag[$const] ;
							     }
							     else {
							    
								$circ =   $circ .  " " . $Token[$const] ;   
								$circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($CircN != $Head[$const]);
								$circ_l = $circ_l . " " . $Lemma[$const] . "_" . $Tag[$const]  . "-H" if  ($CircN == $Head[$const]);         
							     }
							}

						}

						$subj = trim ($subj);
						$circ = trim ($circ);
						$pred = trim ($pred);
						$subj_l = trim ($subj_l);
						$circ_l = trim ($circ_l);
						$pred_l = trim ($pred_l);

						$result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$circ";
						$result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$circ_l";

						my $saida = building_result ($k, $result_token);#<string>
						if($pipe){#<ignore-line>
							print "$saida\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida, $saida);
						}#<ignore-line>


						$result="";
						$subj="";
						$circ="";
						$pred="";
						$subj_l="";
						$circ_l="";
						$pred_l="";
					}
				}
			  
				##SUBJ-PRED-CDIR-CDIRCOMPL
				if ($Subj && $DobjCompl && $Dobj) {

					##SUBJ 
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Subj}}) {
						#print STDERR "Subj: HEAD###$Token[$Subj]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep)  || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;}
						$subj =   $subj . " " . $Token[$const]; 
						##lemas e tags:
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] if  ($const != $Subj) ;
						$subj_l = $subj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $Subj) ; ##marcamos o head
					}

					##PRED
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$head}}) {
						#print STDERR "Circ: HEAD###$Token[$Circ]### ::: DEP: #$Token[$const]# --\n";
						if ($const eq $head ||  ( ($Dep[$const] =~ /(VSpec|Clit)/ || $Lemma[$const] =~ /^(não|not|no|never|nunca|n\'t)$/ ) && ($Const{$head}{$const} || ($Const{$head}{$Head[$const]} && $Dep[$Head[$const]] =~ /VSpec/) ) ) )  {
							#if ($const eq $head ||  ($Dep[$const] =~ /VSpec/ && $Const{$head}{$const} ) )  {
							$pred =   $pred .  " " . $Token[$const];
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $head); 
							$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const == $head) ; ##marcamos o head
						}
					}

					##CDIR (dentro do pred!!)
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$Dobj}}) {
						#print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep)  || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;};

						##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
						$pred =   $pred . " " . $Token[$const]; 
						$pred_l = $pred_l . " " . $Lemma[$const] . "_" . $Tag[$const];
					}

					##CDIRCompl
					foreach my $const  (sort { $a <=> $b } keys %{$Unit{$DobjCompl}}) {
						#print STDERR "Cdir: HEAD###$Token[$Dobj]### ::: DEP: #$Token[$const]# --\n";
						if (relative ($const, \@Tag, \@Args) || apposition($const, \@Tag, \@Head, \@Dep)  || subordin($const, \@Tag, \@Head, \%Const_dep)) {last;};

						##pensa que estuda -> cambiar na gramatica: 'que' depende de 'pensa'!!
						$dobj =   $dobj . " " . $Token[$const]; 
						$dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const]  if  ($const != $DobjCompl) ;
						$dobj_l = $dobj_l . " " . $Lemma[$const] . "_" . $Tag[$const] . "-H" if  ($const eq $DobjCompl) ; ##marcamos o head
					}
					
					$subj = trim ($subj);
					$dobj = trim ($dobj);
					$pred = trim ($pred);
					$subj_l = trim ($subj_l);
					$dobj_l = trim ($dobj_l);
					$pred_l = trim ($pred_l);

					$result_token =  "$subj" .  "\t" . "$pred" . "\t" . "$dobj";
					$result_lemma =  "$subj_l" .  "\t" . "$pred_l" . "\t" . "$dobj_l";

					my $saida = building_result ($k, $result_token);#<string>
					if($pipe){#<ignore-line>
						print "$saida\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida, $saida);
					}#<ignore-line>

					$result="";
					$subj="";
					$dobj="";
					$pred="";
					$subj_l="";
					$dobj_l="";
					$pred_l="";
				}       
				$Circ="";
				$Subj=0;
				$Dobj=0;
				$DobjCompl=0; 
				$Dobj2=0;
				$Atr=0;
			}
			$k++;
			
			#Initialize
			@Pos=();
			@Token=();
			@Lemma=();
			@Tag=();
			@Head=();
			@Args=();
			@Dep=();

			%Const_dep=();#<smart>
			%Const_tag=();#<smart>
			%Const=();#<smart>
			%Unit=();
	 
			$source="";
			$l=1;
			$Subj=0;
			$Dobj=0;
			$Dobj2=0;
			$DobjCompl=0;
			$Atr=0;
			$Circ="";

			#Perldoop
			$Pos[0] = undef;
			$Token[0] = undef;
			$Lemma[0] = undef;
			$Tag[0] = undef;
			$Head[0] = undef;
			$Args[0] = undef;
			$Dep[0] = undef;
		}
	}
	return \@saida;
}

#<ignore-block>
	if($pipe){
		my @lines = <STDIN>;
		triples(\@lines);
	}
#<ignore-block>


##########Funcoes###############

sub building_result {
	my ($idf, $res_tok) = @_ ;#<string>

	my $saida  =   "SENTID_$idf\t$res_tok";#<string>

	return $saida;
}

sub Expand {

	my ($c, $h) = @_ ;#<string>
	my $Unit = $_[2];#<ref><hash><hash><boolean>

	if (defined $Unit->{$c} ) {
		#print STDERR "FUNC: ---$c---$h-- ### CONST: ---$c ---- $sub_c\n";
		foreach my $sub_c (keys %{$Unit->{$c}}) {
			if ($sub_c != $c && !defined $Unit->{$h}{$sub_c} ) {
				#print STDERR "FUNC: ---$c---$h-- ### CONST: ---$c ---- $sub_c\n";
				$Unit->{$h}{$sub_c} = 1;
				Expand ($sub_c, $h, $Unit) ;
			}
		}
	}
}


sub trim {
	my ($x) = @_ ;#<string>

	$x =~ s/^[\s]*//;
	$x =~ s/[\s]*$//;
	$x =~ s/[\s]*\,$//;
	$x =~ s/[\s]*\,\_Fc$//;
	$x =~ s/[\s]*\"\_Fe$//;
	$x =~ s/^\"\_Fe//; 
	$x =~ s/^\"//; 

	return $x;
}


sub relative {
	my ($x) = @_ ;#<string>
	my $Tag = $_[1];#<ref><list><string>
	my $Args = $_[2];#<ref><list><string>

	if ( ($Tag->[$x] =~ /^PRO/ && ($Args->[$x] =~ /type:[RW]/ || $Args->[$x] =~ /lemma:(que|quem|quen|quien|which|that|who)/)) || ($Tag->[$x] =~ /^PRP-REL/) ) {
	    # print STDERR "OOOOKKKK- RELATIVE --> $Tag->[$x]\n";
		#foreach my $y (keys %{$Const_tag{$x}}) {
			#print STDERR "REL:: #$Tag[$x]#  -- #$Tag[$y]#\n";
			#if ($Tag[$y] =~ /^DT/) {
				#return 0;
			#}
		#}
		return 1;
	} else {
		return 0;
	}
}
sub relative_circ {
	my ($x) = @_ ;#<string>
	my $Tag = $_[1];#<ref><list><string>
	my $Args = $_[2];#<ref><list><string>

	if ($Tag->[$x] =~ /^PRP-REL/ ) {
	    #print STDERR "OOOOKKKK- RELATIVE-CIRC --> $Tag->[$x]\n";
	
		return 1;
	} else {
		return 0;
	}
}

sub subordin {
	my ($x) = @_ ;#<string> 
	my $Tag = $_[1];#<ref><list><string>
	my $Head = $_[2];#<ref><list><string>
	my $Const_dep = $_[3];;#<ref><hash><hash><string>

	if ($Tag->[$x] =~ /^VERB/ &&  $Tag->[$Head->[$x]] =~ /^NOUN/ && $Const_dep->{$Head->[$x]}{$x} =~ /^Adjn/) {
		return 1;
	} else {
		return 0;
	}
}


sub apposition {
    my ($x) = @_ ;#<string>
	my $Tag = $_[1];#<ref><list><string> 
	my $Head = $_[2];#<ref><list><string>
	my $Dep = $_[3];#<ref><list><string>

	if ($Tag->[$x] =~ /^(Fc|Fpa|Fca)/  && $Dep->[$Head->[$x]] =~ /AdjnR/ && $Tag->[$Head->[$x]] =~ /^(NOUN|ADJ)/ ) { ##se aparece uma virgula e a cabeça e um nome/adj como modificador (Adjn), entao é uma aposiçao nominal
		return 1;
	} elsif ($Tag->[$x] =~ /^(Fc|Fpa|Fca)/) { ##se aparece uma vírgula no constituinte, paramos! 
		return 1;
	} else {
		return 0;
	}
}


