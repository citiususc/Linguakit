BIN=/usr/local/bin
cur="$(shell pwd)"

install:
	perl -e 'print qq(#!/bin/bash\nperl $(cur)/linguakit.perl "\$$@"\n)' > $(BIN)/linguakit
	chmod +x $(BIN)/linguakit

deps:
# FIXME -- untested
	perl -MCPAN -e 'install (Getopt::ArgParse)'
# Storable -- in the kernel	
	perl -MCPAN -e 'install (LWP::UserAgent)'
	perl -MCPAN -e 'install (HTTP::Request::Common)'
	apt install libperlio-gzip-perl


test-me:
	echo "Olá mundo!" | linguakit tagger pt -nec
	echo "Hello world!." | linguakit tagger en -nec



## git clone  https://github.com/citiususc/Linguakit.git
## cd Linguakit
## sudo make deps
## sudo make install
## make test-me

