#!/bin/sh


for file in linguakit*
do
    awk '$0=="MAIN_DIR=\"./Linguakit\""{print "MAIN_DIR=\"'`pwd`'\"";next}\
        {print}' $file > $file.tmp;
    mv $file.tmp $file;
done


echo 'Path variables modified in tagging scripts.'

chmod 0755 linguakit
chmod 0755 scripts/*
chmod 0755 parsers/*
chmod 0755 tagger/en/*
chmod 0755 tagger/es/*
chmod 0755 tagger/pt/*
chmod 0755 tagger/gl/*
chmod 0755 sentiment/en/*
chmod 0755 sentiment/es/*
chmod 0755 sentiment/pt/*
chmod 0755 sentiment/gl/*
chmod 0755 kwic/*
chmod 0755 keywords/*
chmod 0755 triples/*

echo "Permissions of execution, done!"

echo "Compiling lexicons"
echo "english lexicon"
./tagger/en/store_lex.perl
echo "portuguese lexicon"
./tagger/pt/store_lex.perl
echo "spanish lexicon"
./tagger/es/store_lex.perl
echo "galician lexicon"
./tagger/gl/store_lex.perl
./tagger/gl/store_split.perl

echo "Warning: if the lexicon compilation has returned error messages, please check whether the Perl module 'Storable' is installed."
echo "To install this Perl module, you may use CPAN:"
echo "          cpan> install Storable"


echo ''
echo "Installation done! You can run now `./linguakit` to see basic usage."
