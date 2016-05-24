#!/usr/bin/perl

#ProLNat Tokenizer (provided with Sentence Identifier)
#autor: Grupo ProLNat@GE, CITIUS
#Universidade de Santiago de Compostela


# Script que integra 2 funçoes perl: sentences e tokens


use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

# Absolute path 
use Cwd 'abs_path';
use File::Basename;
my $abs_path = dirname(abs_path($0));



##ficheiros de recursos
open (VERB, $abs_path."/lexicon/verbos-gl.txt") or die "O ficheiro não pode ser aberto: $!\n";
binmode VERB,  ':utf8';
my @verb = <VERB>;



##para splitter:
##########INFORMAÇAO DEPENDENTE DA LINGUA###################
my $pron1 = "me|te|che|se|lle|lles|nos|monos|vos";
my $pron2 = "mos|mas|mo|ma|chos|chas|cho|cha|llo|lla|llos|llas|cheme|chelle|chenos|chevos|chelles|nolo|nolos|nola|nolas|manola|monolos|volo|volos|vola|volas|senos|sevos|selle|selles|sello|sellos";
my $pron3 = "chema|chemas|chemo|chemos|chella|chellas|chello|chelos|chenola|chenolas|chenolo|chenolos|chevola|chevolas|chevolo|chevolos|chellela|chellelas|chellelo|chellelos";
my $acc = "o|os|a|as";
###########################################################
my $w = "[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÑÇÜa-záéíóúàèìòùâêîôûñçü]";



sub splitter {
 my (@text) = @_ ;
 
 my @saida;
 my %Verb;
 my $verb;

  ##lendo verbos
 foreach  $verb (@verb) { ##lendo o array de verbos
    chomp $verb;
    #$verb = tirar_acentos ($verb);
    $Verb{$verb}++;
 }

 ##lendo entrada (tokens)
 for (my $i=0;$i<=$#text;$i++) {
   chomp $text[$i];
   my $token = $text[$i];  

 ###############Verbos + procliticos######################

 ##separar procliticos -o/os/a/as

 ##comereino
 if ($token =~ /\b([^\W]+)ein[oa](s)?\b/) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+ei)n([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);

   if ($Verb{$raiz_lower}) {
      $token = $raiz . " " . $sufixo;
   }
 }
##comeuno
 elsif ($token =~ /\b([^\W]+)eun[oa](s)?\b/) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+eu)n([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);

   if ($Verb{$raiz_lower}) {
      $token = $raiz . " " . $sufixo;
   }
 }
##partiuno
 elsif ($token =~ /\b([^\W]+)iun[oa](s)?\b/) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+iu)n([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);

   if ($Verb{$raiz_lower}) {
      $token = $raiz . " " . $sufixo;
   }
 }

##faino
 elsif ($token =~ /\b([^\W]+)ain[oa](s)?\b/) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+ai)n([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);

   if ($Verb{$raiz_lower}) {
      $token = $raiz . " " . $sufixo;
   }
 }
##distribuíno - argüíunas
 elsif ($token =~ /\b([^\W]+)uín[oa](s)?\b/) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+[uü]í)n([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);

   if ($Verb{$raiz_lower}) {
      $token = $raiz . " " . $sufixo;
   }
 }
##comelo -> comer+o
 elsif ($token =~ /\b([^\W]+[aei])l[oa](s)?\b/) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+[aei])l([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);
  my $inf = $raiz_lower . "r";
   if ($Verb{$inf}) {
      $token = $raiz . "r " . $sufixo;
   }
 }
##cómelo -> comes+o
 elsif ($token =~ /\b([^\W]+[aeio])l[oa](s)?\b/ && HasAccent($token) ) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+[aeio])l([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);
  my $raiz_lower_semtil = tirar_acentos ($raiz_lower);
  my $raiz_semtil = tirar_acentos ($raiz);
  my $forma = $raiz_lower . "s";
  my $forma_semtil = $raiz_lower_semtil . "s";
   if ($Verb{$forma}) {
      $token = $raiz . "s " . $sufixo;
   }
   elsif ($Verb{$forma_semtil}) {
      $token = $raiz_semtil . "s " . $sufixo;
   }
 }
##comíao, comeríao
 elsif ($token =~ /\b([^\W]+)ía[oa](s)?\b/) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+ía)([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);
   if ($Verb{$raiz_lower}) {
      $token = $raiz . " " . $sufixo;
   }
 }
##dáo, cómeo, vélo?? (se houver alguma ambiguedade, haveria que evita-la)
 elsif ($token =~ /\b([^\W]+[aeiouáéíóú])[oa](s)?\b/  && HasAccent($token) ) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+[aeiouáéíóú])([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);
  my $raiz_lower_semtil = tirar_acentos ($raiz_lower);
  my $raiz_semtil = tirar_acentos ($raiz);
   if ($Verb{$raiz_lower_semtil}) {
      $token = $raiz_semtil . " " . $sufixo;
   }
 }
##coméstelo 
 elsif ($token =~ /\b([^\W]+(che|te))l[oa](s)?\b/  && HasAccent($token) ) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+(te|che))([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);
  my $raiz_lower_semtil = tirar_acentos ($raiz_lower);
  my $raiz_semtil = tirar_acentos ($raiz);
  my $forma = $raiz_lower_semtil . "s";
   if ($Verb{$forma}) {
      $token = $raiz_semtil . "s " . $sufixo;
   }
 }


 ##teno (buscar mais casos especificos)
 elsif ($token =~ /\bten[oa](s)?\b/) {
  my ($raiz, $sufixo) = $token =~ /\b(ten)([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);
   if ($Verb{$raiz_lower}) {
      $token = $raiz . " " . $sufixo;
   }
 }
 #dilo (dis+o)
 elsif ($token =~ /\b(di)l[oa](s)?\b/) {
  my ($raiz, $sufixo) = $token =~ /\b(di)l([oa](s)?)\b/;
  my $raiz_lower = lowercase ($raiz);
   if ($Verb{$raiz_lower}) {
      $token = $raiz . "s " . $sufixo;
   }
 }
#####################################################
 ##separar procliticos de verbos (exceto -o/os/a/as)
 elsif ($token =~ /\b([^\W]+)($pron1|$pron2|$pron3)\b/) {
  my ($raiz, $sufixo) = $token =~ /\b([^\W]+)($pron1|$pron2|$pron3)\b/;
  my $raiz_lower = lowercase ($raiz);
  my $raiz_lower_semtil = tirar_acentos ($raiz_lower);
  my $raiz_semtil = tirar_acentos ($raiz);

   if ($Verb{$raiz_lower} || $Verb{$raiz_lower_semtil}) {

     ##mudança de raiz: comémonolas -> comemos nos as
       if ($sufixo =~ /^monol[ao](s)?$/) {
	   $raiz_semtil =~ s/s$/mos/;
       }


     if ($sufixo =~ /^$pron3$/) {
      ##separar cliticos compostos: mo, mos, to, tos, lho, lhos..
      $sufixo =~ s/\bchema\b/che me a/g;
      $sufixo =~ s/\bchemos\b/che me os/g;
      $sufixo =~ s/\bchemo\b/che me o/g;
      $sufixo =~ s/\bchemas\b/che me as/g; #AMBIGUO?
      $sufixo =~ s/\bchello\b/che lle o/g;
      $sufixo =~ s/\bchellos\b/che lle os/g;
      $sufixo =~ s/\bchella\b/che lle a/g;
      $sufixo =~ s/\bche llas\b/che lle as/g;
      $sufixo =~ s/\bchenola\b/che nos a/g;
      $sufixo =~ s/\bchenolas\b/che nos as/g;
      $sufixo =~ s/\bchenolo\b/che nos o/g;
      $sufixo =~ s/\bchenolos\b/che nos os/g;
      $sufixo =~ s/\bchevola\b/che vos a/g;
      $sufixo =~ s/\bchevolas\b/che vos as/g;
      $sufixo =~ s/\bchevolo\b/che vos o/g;
      $sufixo =~ s/\bchevolos\b/che vos os/g;
      $sufixo =~ s/\bchellela\b/che lles a/g;
      $sufixo =~ s/\bchellelass\b/che lles as/g;
      $sufixo =~ s/\bchellelo\b/che lles o/g;
      $sufixo =~ s/\bchellelos\b/che lles os/g;
     }
     elsif ($sufixo =~ /^$pron2$/) {
      ##separar cliticos compostos: mo, mos, to, tos, lho, lhos..
      $sufixo =~ s/\bmo\b/me o/g;
      $sufixo =~ s/\bmos\b/me os/g;
      $sufixo =~ s/\bma\b/me a/g;
      $sufixo =~ s/\bmas\b/me as/g; #AMBIGUO?
      $sufixo =~ s/\bllo\b/lhe o/g;
      $sufixo =~ s/\bllos\b/lhe os/g;
      $sufixo =~ s/\blla\b/lhe a/g;
      $sufixo =~ s/\bllas\b/lhe as/g;
      $sufixo =~ s/\bcho\b/che o/g;
      $sufixo =~ s/\bchos\b/che os/g;
      $sufixo =~ s/\bcha\b/che a/g;
      $sufixo =~ s/\bchas\b/che as/g;
      $sufixo =~ s/\bchelle\b/che lle/g;
      $sufixo =~ s/\bchelles\b/che lles/g;
      $sufixo =~ s/\bchenos\b/che nos/g;
      $sufixo =~ s/\bchevos\b/che vos/g;
      $sufixo =~ s/\bnola\b/nos a/g;
      $sufixo =~ s/\bnolas\b/nos as/g;
      $sufixo =~ s/\bmonola\b/nos a/g;
      $sufixo =~ s/\bmonolas\b/nos as/g;
      $sufixo =~ s/\bmonolo\b/nos o/g;
      $sufixo =~ s/\bmonolos\b/nos os/g;
      $sufixo =~ s/\bnolo\b/nos o/g;
      $sufixo =~ s/\bnolos\b/nos os/g;
      $sufixo =~ s/\bvola\b/vos a/g;
      $sufixo =~ s/\bvolas\b/nos as/g;
      $sufixo =~ s/\bvolo\b/vos o/g;
      $sufixo =~ s/\bvolos\b/nos os/g;
      $sufixo =~ s/\bllela\b/lles a/g;
      $sufixo =~ s/\bllelas\b/lles as/g;
      $sufixo =~ s/\bllelo\b/lles o/g;
      $sufixo =~ s/\bllelos\b/lles os/g;
      $sufixo =~ s/\bseme\b/se me/g;
      $sufixo =~ s/\bselle\b/se lle/g;
      $sufixo =~ s/\bselles\b/se lles/g;
      $sufixo =~ s/\bsenos\b/se nos/g;
      $sufixo =~ s/\bsevos\b/se vos/g
     }

   if ($Verb{$raiz_lower}) {
       ##separar pron2
       $token = $raiz . " " . $sufixo;
   }
   elsif  ($Verb{$raiz_lower_semtil}) {
       ##separar pron2
       $token = $raiz_semtil . " " . $sufixo;
   }
  }
 }

##########################################################


###############separar contraçoes nao ambiguas###########

  #ao, à, aos, às
  $token =~ s/^ao$/a o/g;
  $token =~ s/^aos$/a os/g;
  $token =~ s/^á$/a a/g;
  $token =~ s/^ás$/a as/g;

  #áquele(s), áquela(s). áquilo, aonde
  $token =~ s/^áquele$/a aquel/g;
  $token =~ s/^áqueles$/a aqueles/g;
  $token =~ s/^áquela$/a aquela/g;
  $token =~ s/^áquelas$/a aquelas/g;
  $token =~ s/^áquilo$/a aquilo/g;
  
  $token =~ s/\baonde\b/a onde$1/g;

  #co(s), coa(s) /nao aparece no priberam nem no dico de freeling!
 # $token =~ s/\bco([\s])/com o$1/g;
 # $token =~ s/\bcoa([\s])/com a$1/g;
 # $token =~ s/\bcos([\s])/com os$1/g;
 # $token =~ s/\bcoas([\s])/com as$1/g;

  #do(s), da(s)
   $token =~ s/^do$/de o/g;
  $token =~ s/^dos$/de os/g;
  $token =~ s/^da$/de a/g;
  $token =~ s/^das$/de as/g;

  #dun(ns), duna(s)
  $token =~ s/\bdun/de un  /g;
  $token =~ s/\bduns$/de uns/g;
  $token =~ s/\bduna$/de una/g;
  $token =~ s/\bdunas$/de unas/g;

  #dele(s), dela(s)
  $token =~ s/\bdele\b/de ele/g;
  $token =~ s/\bdeles\b/de eles/g;
  $token =~ s/\bdela\b/de ela/g;
  $token =~ s/\bdelas\b/de elas/g;

  #deste(s), desta(s), desse(s), dessa(s), daquele(s), daquela(s), disto, disso, daquilo
  #$token =~ s/([\W\s])deste([\W\s])/$1 de este$2/g; FORMA AMBIGUA
 # $token =~ s/\bdestes\b/de estes/g; FORMA AMBIGUA
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
  $token =~ s/\bno$/en o/g;
  $token =~ s/\bnos$/en os/g;
  $token =~ s/\bna$/en a/g;
  $token =~ s/\bnas$/en as/g;
  
   #dun(ns), duna(s)
  $token =~ s/\bnun$/en un/g;
  $token =~ s/\bnuns$/en uns/g;
  $token =~ s/\bnuna$/en una/g;
  $token =~ s/\bnunas$/en unas/g;
   
  #nele(s)
 # $token =~ s/\bnele\b/en ele/g;
  $token =~ s/\bneles\b/en eles/g;

  #neste(s), nesta(s), nesse(s), nessa(s), naquele(s), naquela(s), nisto, nisso, naquilo
  $token =~ s/\bneste\b/en este/g; 
  $token =~ s/\bnestes\b/en estes/g;
  $token =~ s/\bnesta\b/en esta/g;
  $token =~ s/\bnestas\b/en estas/g;
  $token =~ s/\bnisto\b/en isto/g;
  $token =~ s/\bnesse\b/en esse/g;  
  $token =~ s/\bnesses\b/en esses/g; 
  $token =~ s/\bnessa\b/en essa/g;
  $token =~ s/\bnessas\b/en essas/g;
  $token =~ s/\bnisso\b/en isso/g;
  $token =~ s/\bnaquele\b/en aquele/g;
  $token =~ s/\bnaquela\b/en aquela/g; 
  $token =~ s/\bnaqueles\b/en aqueles/g;
  $token =~ s/\bnaquelas\b/en aquelas/g;
  $token =~ s/\bnaquilo\b/en aquilo/g;

  #pelo(a), polo(s)  TODOS AMBIGUOS menos pelos!
 # $token =~ s/\bpelo([\s])/por o$1/g;
 # $token =~ s/\bpela([\s])/por a$1/g;
  $token =~ s/\bpolos([\s])/por os$1/g;
 # $token =~ s/\bpelas([\s])/por as$1/g;

 # $token =~ s/\bpolo([\s])/por o$1/g;
 # $token =~ s/\bpola([\s])/por a$1/g;
 # $token =~ s/\bpolos([\s])/por os$1/g;
 # $token =~ s/\bpolas([\s])/por as$1/g;


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
       (my @tokens) = split (" ", $token) ;
       foreach my $tok (@tokens) {
           push (@saida, $tok);
       }
   }


   else {
      push (@saida, $token); 
   }
#   if ($i == $#text && $token eq "")  {
#      push (@saida, ""); 
#   }
 }


  return @saida;
} 
        
sub lowercase {
  my ($x) = @_ ;
  $x = lc ($x);
  $x =~  tr/ÁÉÍÓÚÇÑ/áéíóúçñ/;

  return $x;

} 

sub tirar_acentos {
    my ($x) = @_ ;
    $x =~ s/([a-z]*)[á]([a-z]*)/$1a$2/;
    $x =~ s/([a-z]*)[é]([a-z]*)/$1e$2/;
    $x =~ s/([a-z]*)[í]([a-z]*)/$1i$2/;
    $x =~ s/([a-z]*)[ó]([a-z]*)/$1o$2/;
    $x =~ s/([a-z]*)[úü]([a-z]*)/$1u$2/;
   
    return $x;
}

sub HasAccent {
  my ($x) = @_ ;
  if ($x =~ /áéíóúÁÉÍÓÚ/) {
    return 1;
  }
 else  {
    return 0
 }

} 
