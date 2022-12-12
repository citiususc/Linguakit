#!/usr/bin/env perl

#############################################################
# ProLNat Linguakit API
#
# author: Grupo ProLNat@GE, CITIUS
# Isaac González
# Pablo Gamallo
# Susana Sotelo
#
# Universidade de Santiago de Compostela
#
#############################################################

package linguakit_api;

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(utf8)';
use Data::Dump qw(dump);
use Cwd 'getcwd';
use Dancer2;
use JSON ();
use IO::Handle;
use POSIX qw(strftime);

sub run()
{
    #Linguakit dependencies
    my $lang = shift;
    push(@INC, dirname(__FILE__)."/lib");
    my $deps = 1;
    if (!eval{require Getopt::ArgParse;})
    {
        warn "Please install Getopt::ArgParse module: cpan Getopt::ArgParse\n";
        $deps = 0;
    }
    if (!eval{require Storable;})
    {
        warn "Please install Storable module: cpan Storable\n";
        $deps = 0;
    }
    if (!eval{require LWP::UserAgent;})
    {
        warn "WARNING LWP::UserAgent module not installed, use 'cpan LWP::UserAgent' to solve\n";
    }
    if (!eval{require HTTP::Request::Common;})
    {
        warn "WARNING HTTP::Request::Common module not installed, use 'cpan HTTP::Request::Common' to solve\n";
    }
    exit 1 if !$deps;

    STDOUT->autoflush(1);


    ############################
    # Config
    ############################

    my $Linguakit = config->{linguakit_path} || "..";

    # Command-line options
    my $appname = config->{appname};
    my $shortDescription = "Linguakit RESTful API";
    my $errorPrint = "$appname: ";
    my $parser = Getopt::ArgParse -> new_parser(
        prog => $appname,
        help => $shortDescription,
        error_prefix  => $errorPrint
    );

    $parser->add_arg(
        '--lang',
        '-l',
        type => 'Scalar',
        required => 0, 
        choices_i => ["en", "es", "pt", "gl", "histgz"],
        help => 'Language resources for LANG will be loaded'
    );
    $parser->add_arg(
        '--port',
        '-p',
        type => 'Scalar'
    );
    my $args = $parser->parse_args();

    my $PROGS = "scripts";
    my $DIRPARSER = "parsers";
    my $LING = $lang || $args->lang || "pt";

    set port => $args->port || config->{port}{$LING};
    set serializer => 'JSON';

    # Loading modules
    do "$Linguakit/$DIRPARSER/parserDefault-$LING.perl";
    do "$Linguakit/$PROGS/AdapterFreeling-${LING}.perl";
    do "$Linguakit/$PROGS/saidaCoNLL-fa.perl";
    do "$Linguakit/tagger/$LING/sentences-${LING}_exe.perl";
    do "$Linguakit/tagger/$LING/tokens-${LING}_exe.perl";
    do "$Linguakit/tagger/$LING/splitter-${LING}_exe.perl";
    do "$Linguakit/tagger/$LING/ner-${LING}_exe.perl";
    do "$Linguakit/tagger/$LING/tagger-${LING}_exe.perl" ;
    do "$Linguakit/tagger/$LING/nec-${LING}_exe.perl";
    do "$Linguakit/tagger/$LING/lemma-${LING}_exe.perl";

    do "$Linguakit/tagger/coref/coref_exe.perl";
    do "$Linguakit/sentiment/nbayes.perl";
    do "$Linguakit/keywords/keywords_exe.perl";
    do "$Linguakit/triples/triples_exe.perl";
    do "$Linguakit/summarizer/summarizer_exe.perl";

    do "$Linguakit/mwe/mwe.perl";
    do "$Linguakit/mwe/filtro_galextra.perl";
    do "$Linguakit/mwe/six_tokens.perl";

    do "$Linguakit/summarizer/Sentence.pl";

    do "$Linguakit/lanrecog/lanrecog.perl";
    do "$Linguakit/lanrecog/build_lex.perl";

    do "$Linguakit/kwic/kwic.perl";

    ############## API ################

    get '/ping' => sub
    { 
        return { status => "ok" }
    };

    post '/v2.0/:module' => sub
    {
        header 'Content-Type' => 'application/json';
        header 'Access-Control-Allow-Origin' => '*';
        
        my $MOD = route_parameters->get('module');
        my $TEXT = body_parameters->get('text') || "";
        my $OUTPUT = body_parameters->get('output') || "";

        plog("$appname - POST request: $TEXT\n");
        
        if($MOD eq "dep")
        {
            if($OUTPUT eq "conll")
            {
                return CONLL::conll(Parser::parse(AdapterFreeling::adapter(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])))))), '-fa'));
            }
            elsif($OUTPUT eq "fa")
            {
                return Parser::parse(AdapterFreeling::adapter(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])))))),  '-fa');
            }
            elsif($OUTPUT eq "c")
            {
                return Parser::parse(AdapterFreeling::adapter(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])))))), '-c');
            }
            else
            {
                return Parser::parse(AdapterFreeling::adapter(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])))))), '-a');
            }
        }
        elsif($MOD eq "rel")
        {
            return Triples::triples(CONLL::conll(Parser::parse(AdapterFreeling::adapter(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])))))), '-fa')));
        }
        elsif($MOD eq "tagger")
        {
            if ($OUTPUT eq "ner")
            {
                return Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])))));
            }
            elsif($OUTPUT eq "nec")
            {
                return Nec::nec(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT]))))));
            }
            else
            {
                return Tagger::tagger(Lemma::lemma(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])))));
            }
        }
        elsif($MOD eq "coref")
        {
            my $Mentions_id = {};#<ref><hash><integer>
            if($OUTPUT eq "crnec")
            {
                return Coref::coref(0, 1, Nec::nec(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])))))), 500, $Mentions_id);
            }
            else
            {
                return Coref::coref(1, 0, Nec::nec(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])))))), 500, $Mentions_id);
            }
        }
        elsif($MOD eq "mwe")
        {
            if($OUTPUT eq "log")
            {
                return Mwe::mwe(SixTokens::sixTokens(FiltroGalExtra::filtro(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT]))))))),"-log",1);
            }
            elsif($OUTPUT eq "scp")
            {
                return Mwe::mwe(SixTokens::sixTokens(FiltroGalExtra::filtro(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT]))))))),"-scp",1);
            }
            elsif($OUTPUT eq "mi")
            {
                return Mwe::mwe(SixTokens::sixTokens(FiltroGalExtra::filtro(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT]))))))),"-mi",1);
            }
            elsif($OUTPUT eq "cooc")
            {
                return Mwe::mwe(SixTokens::sixTokens(FiltroGalExtra::filtro(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT]))))))),"-cooc",1);
            }
            else
            {
                return Mwe::mwe(SixTokens::sixTokens(FiltroGalExtra::filtro(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT]))))))),"-chi",1);
            }
        }
        elsif($MOD eq "key")
        {
            Keywords::load($LING);
            return Keywords::keywords(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT]))))));
        }
        elsif($MOD eq "sent")
        {
            Nbayes::load($LING);
            my $result = Nbayes::nbayes(Tagger::tagger(Ner::ner(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT]))))));    
            my $idontknow = Nbayes::end(); # I don't know why this is stored to a variable
           return $result;
        }
        elsif($MOD eq "recog")
        {
            my %Peso = ();
            return LanRecog::langrecog(Tokens::tokens(Sentences::sentences([$TEXT])), \%Peso);
        }
        elsif($MOD eq "tok")
        {
            if($OUTPUT eq "sort")
            {
                my %count = ();
                my $list = Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])));
                for my $token (@{$list})
                {
                    $count{$token} = $count{$token} ? $count{$token} + 1 : 1;
                }
                my @sorted_tokens;
                for my $result (sort {$count{$b} <=> $count{$a}} keys %count){
                    next if $result eq "";
                    push(@sorted_tokens, "$count{$result}\t$result");
                }
                return(\@sorted_tokens);
            }
            elsif($OUTPUT eq "split")
            {
                return Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT])));
            }
            else
            {
                return Tokens::tokens(Sentences::sentences([$TEXT]));
            }
        }
        elsif($MOD eq "seg")
        {
            return Sentences::sentences([$TEXT]);
        }
        elsif($MOD eq "lem")
        {
            return Lemma::lemma(Splitter::splitter(Tokens::tokens(Sentences::sentences([$TEXT]))));
        }
        elsif($MOD eq "kwic")
        {
            return Kwic::kwic(Sentences::sentences([$TEXT]),$OUTPUT);
        }
        elsif($MOD eq "sum")
        {
            return Summarizer::summarizer($TEXT,$LING,$OUTPUT);
        }
    };
}

sub plog
{
    my $msg = shift;
    my $facility = "syslog";
    my $severity = "warning";

    open(my $fh, "| logger -p $facility.$severity");
    print $fh $msg;
    close($fh);
}

sub now
{
    return strftime ("%a %b %d %Y - %H:%M", localtime), " ";
}

do { run; dance } unless caller();
