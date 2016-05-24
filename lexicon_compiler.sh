#!/bin/sh



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
echo "Installation done!"
