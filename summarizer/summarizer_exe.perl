#!/usr/bin/env perl

package Summarizer;

use strict; 
use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use open qw(:std :utf8);

# Absolute path 
use Cwd 'abs_path';#<ignore-line>
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(abs_path($0));#<ignore-line>

do $abs_path.'/Sentence.pl';

my $DIR=$abs_path;
$DIR =~ s/\/summarizer//;

# Pipe
my $pipe = !defined (caller);


sub summarizer{

	my $text = $_[0];
	my $lang = $_[1]; ### es, gl, pt, en
	my $percentage_to_summarize =  $_[2]; ##percentage of the abstract

        my @sentences = getLines($text, $lang);
	my @keys = getKeywords($text, $lang, 50);#Jugar con el numero de keywords para optimizar el cacharro
	#my @multikeys = getMultiwords($text, $lang, 50);#Jugar con el numero de keywords para optimizar el cacharro

	#Proceso de pesado keys
	for my $keyword (@keys) {
			##keyword info
			my @parts = split "\t", $keyword;
			my $term_key = lc($parts[0]);
			my $score_key = $parts[1];
                        #print STDERR "-->keyword: #$keyword#\n";
			for my $line (@sentences) {
			    $line->keywords(appearanceKeyword($line->valor(), $term_key, $score_key));
			    
			}
	}

	#for my $multiword (@multikeys) {
			##keyword info
		#	my @parts_multi = split "\t", $multiword;
		#	my $term_multikey = lc($parts_multi[0]);
		#	my $score_multikey = $parts_multi[1];
			#check si aparece en la linea
		#	for my $line (@sentences) {
				#$line->multiwords(appearanceKeyword($line->valor(), $term_multikey, $score_multikey));
		#	}
		#}



	#Debería estar en otro metodo pero en perl el paso de más de 1 array a una subrrutina es muerte por lo tanto lo dejo asi, sorry por no ser muy clean code :(
	my @resumen = ();
	my @ordenado = my @array = sort {$b->peso() <=> $a->peso()} @sentences;

	#Porcentaje de frases del total que devolveremos
	my $porcentaje = int((($#ordenado * $percentage_to_summarize)/100));
	
	for my $line (0 .. $porcentaje){
	    push(@resumen , $ordenado[$line]->valor());
	}

	#Proceso de anotado del texto y ordenado de las frases según el orden en el texto.
	my @anotado = ();
	my @sumarition_ordened = ();
	for my $sentence (@sentences) {
		my $anotacion = $sentence->valor();
		for my $mark (@resumen) {
			if($sentence->valor() eq $mark){
				#$sentence = "<tag>"+$sentence+"</tag>";
				$anotacion = "<span class=\"cilenisAPI_SUMMARIZER\">".$sentence->valor()."</span>";
				push(@sumarition_ordened , $sentence->valor());
			#	next;
			}
		}

		push(@anotado , $anotacion);
	}

	

	#@resumen = (join(" ",@anotado) , join(" ",@sumarition_ordened)); ## Esta saída contém o texto anotado!!
	@resumen = join(" ",@sumarition_ordened);

	return @resumen;
	
}


sub appearanceKeyword{
	my($sentence, $term, $score) = @_;
	if (lc($sentence) =~ m/ $term /) {
		#return 1;
		return int($score);
	}else{
		return 0;
	}
}

sub appearanceMultiword{
	my($sentence, $term, $score) = @_;
	$term =~ s/-/.*/gi;

	if (lc($sentence) =~ m/ $term /) {
		#return 1;
		return int($score)*100;
	}else{
		return 0;
	}
}

sub getKeywords{
    my($text, $lang, $num_key) = @_;

    my $SENT=$DIR."/tagger/".$lang."/sentences-".$lang."_exe.perl" ;
    my $TOK=$DIR."/tagger/".$lang."/tokens-".$lang."_exe.perl" ;
    my $SPLIT=$DIR."/tagger/".$lang."/splitter-".$lang."_exe.perl";
    my $LEMMA=$DIR."/tagger/".$lang."/lemma-".$lang."_exe.perl";
    my $TAGGER=$DIR."/tagger/".$lang."/tagger-".$lang."_exe.perl"; 
    my $KEYWORD=$DIR."/keywords/keywords_exe.perl";
    
        my @keys =`echo \"$text\"| $SENT  | $TOK | $SPLIT | $LEMMA | $TAGGER | $KEYWORD $lang`;
	#my @keys =  keywords($lang, $num_key, $text);
#        print STDERR "--->#$text#, #$lang# -- #$SENT# #@keys#\n";
	return @keys;
}

sub getMultiwords{
    my($text, $lang, $num_key) = @_;

    my $SENT=$DIR."/tagger/".$lang."/sentences-".$lang."_exe.perl" ;
    my $TOK=$DIR."/tagger/".$lang."/tokens-".$lang."_exe.perl" ;
    my $SPLIT=$DIR."/tagger/".$lang."/splitter-".$lang."_exe.perl";
    my $LEMMA=$DIR."/tagger/".$lang."/lemma-".$lang."_exe.perl";
    my $TAGGER=$DIR."/tagger/".$lang."/tagger-".$lang."_exe.perl"; 

    my $MWE=$DIR."/mwe/mwe.perl";
    my $MWE_FILT=$DIR."/mwe/filtro_galextra.perl";
    my $MWE_SIX=$DIR."/mwe/six_tokens.perl";

    
	my @keys =  `echo \"$text\"| $SENT  | $TOK | $SPLIT | $LEMMA | $TAGGER | $MWE_FILT | $MWE_SIX  | $MWE "-chi" 1`;
	#return @keys[1..$#keys]; #eliminamos la primera parte que es la que trae el texto yno lo necesitamos
	return @keys;
}


sub getLines {
    my($text, $lang) = @_;
    my $SENT=$DIR."/tagger/".$lang."/sentences-".$lang."_exe.perl" ;
    my $TOK=$DIR."/tagger/".$lang."/tokens-".$lang."_exe.perl" ;
    my $SPLIT=$DIR."/tagger/".$lang."/splitter-".$lang."_exe.perl";
    #Vamos a obtener las frases del texto. Para eso utilizaremos un analisis con freelling
    my @analitation = ();
    
    my @analitation =  `echo \"$text\" |$SENT  | $TOK | $SPLIT`;
    #print STDERR "-->anal: #@analitation#\n";
    my @lines_to_analized = ();
     #Creamos el objecto que guardará la frase
    my $sentence = Sentence::new("Sentence");
    
    
    foreach my $line (@analitation) {
        if ($line eq "\n") {
            #LINEAAA!!!
            push(@lines_to_analized, $sentence);
            $sentence = Sentence::new("Sentence");
            next;
        }

	chomp $line;
        $sentence->valor($line);
    
    }
    
    return @lines_to_analized;
    
}



if($pipe){
	my $lang = shift(@ARGV); 
	my $percentage_to_summarize = shift(@ARGV); 
	my @lines = <STDIN>;
	my $result = summarizer(join("\n" ,@lines), $lang, $percentage_to_summarize);
	print "$result\n";
}

