#!/usr/bin/env perl

#ProLNat Tokenizer (provided with Sentence Identifier)
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Script que integra 2 funçoes perl: sentences e tokens
package Splitter;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Absolute path 
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(__FILE__);#<ignore-line>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 


##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA###################
my $pron = "(me|te|mos|mas|mo|ma|tos|tas|to|ta|o|os|a|as|lo|la|las|los|se|lhe|lhes|lho|lha|lhos|lhas|nos|vos|no-lo|no-los|no-la|no-las|vo-lo|vo-los|vo-la|vo-las|se-nos|se-vos|se-lhe|se-lhes|se-lho|se-lhos|se-lha|se-lhas)";#<string>
###########################################################
my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";#<string>

sub splitter {

	my ($text) = @_ ;#<ref><list><string>
	my @saida = ();#<list><string>
	
	foreach my $token (@{$text}) {
		chomp $token;
		
		###############Verbos + procliticos######################
		##caso m-no -> m-o
		$token =~ s/m\-n([oa])\b/m\-$1/g;
		$token =~ s/m\-n([oa]s)\b/m\-$1/g; 

		##separar cliticos compostos no-lo, vo-lo, se-nos...

		$token =~ s/^(no|vo)-l([oa])(s?)/$1s $2$3/g;
		$token =~ s/^(se)-(n[oa]s|lh[eoa]s)/$1 $2/g;

		##separar procliticos de verbos
		$token =~ s/([^\-\s]+)\-$pron$/$1 $2/g;
		$token =~ s/([^\-\s]+)\-$pron$/$1 $2/g;
		#print STDERR "#$token#\n";
		##separar cliticos compostos: mo, mos, to, tos, lho, lhos..
		$token =~ s/\bmo\b/me o/g;
		$token =~ s/\bmos\b/me os/g;
		$token =~ s/\bma\b/me a/g;
		# $token =~ s/\bmas\b/me as/g; AMBIGUO
		$token =~ s/\bto\b/te o/g;
		$token =~ s/\btos\b/te os/g;
		$token =~ s/\bta\b/te a/g;
		$token =~ s/\btas\b/te as/g;
		$token =~ s/\blho\b/lhe o/g;
		$token =~ s/\blhos\b/lhe os/g;
		$token =~ s/\blha\b/lhe a/g;
		$token =~ s/\blhas\b/lhe as/g;

		#$token =~ s/\bcho\b/che o/g;
		#$token =~ s/\bchos\b/che os/g;
		#$token =~ s/\bcha\b/che a/g;
		#$token =~ s/\bchas\b/che as/g;
		##########################################################


		###############separar contraçoes nao ambiguas###########

		#ao, à, aos, às
		$token =~ s/^ao$/a o/g;
		$token =~ s/^aos$/a os/g;
		$token =~ s/^à$/a a/g;
		$token =~ s/^às$/a as/g;

		#àquele(s), àquela(s). àquilo, aonde
		$token =~ s/^àquele$/a aquel/g;
		$token =~ s/^àqueles$/a aqueles/g;
		$token =~ s/^àquela$/a aquela/g;
		$token =~ s/^àquelas$/a aquelas/g;
		$token =~ s/^àquilo$/a aquilo/g;

		$token =~ s/\baonde\b/a onde$1/g;

		#co(s), coa(s) /nao aparece no priberam nem no dico de freeling!
		#$token =~ s/\bco([\s])/com o$1/g;
		#$token =~ s/\bcoa([\s])/com a$1/g;
		#$token =~ s/\bcos([\s])/com os$1/g;
		#$token =~ s/\bcoas([\s])/com as$1/g;

		#do(s), da(s)
		$token =~ s/^do$/de o/g;
		$token =~ s/^dos$/de os/g;
		$token =~ s/^da$/de a/g;
		$token =~ s/^das$/de as/g;

		#dum(ns), duma(s)
		$token =~ s/\bdum/de um  /g;
		$token =~ s/\bduns$/de uns/g;
		$token =~ s/\bduma$/de uma/g;
		$token =~ s/\bdumas$/de umas/g;

		#dele(s), dela(s)
		$token =~ s/\bdele\b/de ele/g;
		$token =~ s/\bdeles\b/de eles/g;
		$token =~ s/\bdela\b/de ela/g;
		$token =~ s/\bdelas\b/de elas/g;

		#deste(s), desta(s), desse(s), dessa(s), daquele(s), daquela(s), disto, disso, daquilo
		#$token =~ s/([\W\s])deste([\W\s])/$1 de este$2/g; FORMA AMBIGUA
		#$token =~ s/\bdestes\b/de estes/g; FORMA AMBIGUA
		$token =~ s/\bdesta\b/de esta/g;
		$token =~ s/\bdestas\b/de estas/g;
		$token =~ s/\bdisto\b/de isto/g;
		#$token =~ s/\bdesse\b/de esse/g;  FORMA AMBIGUA
		#$token =~ s/\bdesses\b/de esses/g; FORMA AMBIGUA
		$token =~ s/\bdessa\b/de essa/g;
		$token =~ s/\bdessas\b/de essas/g;
		$token =~ s/\bdisso\b/de isso/g;
		$token =~ s/\bdaquele\b/de aquele/g;
		$token =~ s/\bdaquela\b/de aquela/g; ##em galego deveria ser ambigua (adverbio)
		$token =~ s/\bdaqueles\b/de aqueles/g;
		$token =~ s/\bdaquelas\b/de aquelas/g;
		$token =~ s/\bdaquilo\b/de aquilo/g;

		#daqui, daí, ali, acolá, donde, doutro(s), doutra(s)
		$token =~ s/\bdaqui\b/de aqui/g;
		$token =~ s/\bdaí\b/de aí/g; ##em galego deveria ser ambigua (adverbio)
		$token =~ s/\bdacolá\b/de acolá/g;
		$token =~ s/\bdonde\b/de onde/g;
		$token =~ s/\bdoutro\b/de outro/g;
		$token =~ s/\bdoutros\b/de outros/g;

		$token =~ s/\bdoutra\b/de outra/g;
		$token =~ s/\bdoutras\b/de outras/g;

		#no(s), na(s)
		$token =~ s/\bno$/em o/g;
		$token =~ s/\bnos$/em os/g;
		$token =~ s/\bna$/em a/g;
		$token =~ s/\bnas$/em as/g;

		#dum(ns), duma(s)
		$token =~ s/\bnum$/em um/g;
		$token =~ s/\bnuns$/em uns/g;
		$token =~ s/\bnuma$/em uma/g;
		$token =~ s/\bnumas$/em umas/g;

		#nele(s)
		#$token =~ s/\bnele\b/em ele/g;
		$token =~ s/\bneles\b/em eles/g;

		#neste(s), nesta(s), nesse(s), nessa(s), naquele(s), naquela(s), nisto, nisso, naquilo
		$token =~ s/\bneste\b/em este/g; 
		$token =~ s/\bnestes\b/em estes/g;
		$token =~ s/\bnesta\b/em esta/g;
		$token =~ s/\bnestas\b/em estas/g;
		$token =~ s/\bnisto\b/em isto/g;
		$token =~ s/\bnesse\b/em esse/g;  
		$token =~ s/\bnesses\b/em esses/g; 
		$token =~ s/\bnessa\b/em essa/g;
		$token =~ s/\bnessas\b/em essas/g;
		$token =~ s/\bnisso\b/em isso/g;
		$token =~ s/\bnaquele\b/em aquele/g;
		$token =~ s/\bnaquela\b/em aquela/g; 
		$token =~ s/\bnaqueles\b/em aqueles/g;
		$token =~ s/\bnaquelas\b/em aquelas/g;
		$token =~ s/\bnaquilo\b/em aquilo/g;

		#pelo(a), polo(s)  TODOS AMBIGUOS menos pelos!
		#$token =~ s/\bpelo([\s])/por o$1/g;
		#$token =~ s/\bpela([\s])/por a$1/g;
		$token =~ s/\bpelos([\s])/por os$1/g;
		#$token =~ s/\bpelas([\s])/por as$1/g;

		#$token =~ s/\bpolo([\s])/por o$1/g;
		#$token =~ s/\bpola([\s])/por a$1/g;
		#$token =~ s/\bpolos([\s])/por os$1/g;
		#$token =~ s/\bpolas([\s])/por as$1/g;


		#dentre
		$token =~ s/\bdentre\b/de entre/g;

		#aqueloutro, essoutro, estoutro
		$token =~ s/\baqueloutro\b/aquele outro/g;
		$token =~ s/\baqueloutros\b/aqueles outros/g;
		$token =~ s/\baqueloutra\b/aquela outra/g; 
		$token =~ s/\baqueloutras\b/aquelas outras/g; 
		$token =~ s/\bessoutro\b/esse outro/g; 
		$token =~ s/\bessoutros\b/esses outros/g;
		$token =~ s/\bessoutra\b/essa outra/g; 
		$token =~ s/\bessoutras\b/esse outras/g; 
		$token =~ s/\bestoutro\b/este outro/g;  
		$token =~ s/\bestoutros\b/estes outros/g;  
		$token =~ s/\bestoutra\b/esta outra/g;
		$token =~ s/\bestoutra\b/este outra/g;    

 
		##splitting tokens:
		if ($token =~ / / ) {
			my @tokens = split (" ", $token);#<array><string>
			foreach my $tok (@tokens) {
				if($pipe){#<ignore-line>
					print "$tok\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida, $tok);
				}#<ignore-line>
			}
		}else {
			if($pipe){#<ignore-line>
				print "$token\n";#<ignore-line>
			}else{#<ignore-line>
				push (@saida, $token); 
			}#<ignore-line>
		}
		#if ($i == $#text && $token eq "")  {
			#push (@saida, ""); 
		#}
	}

	return \@saida;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	splitter(\@lines);
}
#<ignore-block>
        
sub lowercase {
	my ($x) = @_ ;#<string>
	$x = lc ($x);
	$x =~  tr/ÁÉÍÓÚÇÑ/áéíóúçñ/;

	return $x;
} 

