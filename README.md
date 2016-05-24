#LINGUAKIT 
### ProLNat@GE Group

A linguistic tool containing:
 * dependency parser (DepPattern)
 * PoS tagger
 * NER (named entity recognition)
 * NEC (named entity classification)
 * Sentiment analysis
 * Multiword extraction
 * Language recognition

## Description
The command 'linguakit' is able to process 4 languages (Portuguese, English, Spanish, Galician), and allows you to run the following linguistic tools:

* Dependency parser (flag "dep"): It runs 4 default parsers for 4 languages: English, Spanish, Galician, and Portuguese. The parsers were implemented in PERL and are stored in the 'parsers' file. The parsers were compiled from formal grammars (more information in https://github.com/gamallo/DepPattern). The parsers are provided with several types of output: basic triplets (-a), triplets with morphological information (-fa), the same output as the input (-c) for correction purpose, and CoNLL format (-conll). 

* PoS tagger (flag "tagger"): the software also provides the PoS tagger 'CitiusTools". It is provided with two submodules: NER (-ner) and NEC (-nec). The NEC module returns semantic tags for named entities: NP0SP00 (Person), NP00G00 (Location), NP00O00 (Organization), NP00V00 (Miscelaneous)

* Multiword extraction (flag "mwe"): It extracts multiwords from PoS tagged text. There are several options, each one being a specific lexical association measure for ranking the candidate terms: chi square ("chi", by default measure), loglikelihood ("log"), mutual information ("mi"),  symmetrical conditional probability ("scp"), simple co-occurrences ("cooc").

* Sentiment analysis (flag "sent"): It returns POSITIVE, NONE or NEGATIVE, using a polarity lexicon and a classifier trained from annotated tweets. The input should be a sentence or a small paragraph.

* Language recognition (flag "recog"): It returns the language of the input text: en, es, pt, gl, gz (agal galician variety), fr, eu, ca, bn (bengali), ur (urdu), hi (hindi), ta (tamil). This module is also used to recognize the language of a text before being processed by another module (only for the four languages that can be processed: pt, en, es, gl).

## Requirements
GNU/LINUX (bash + perl)
*Storable* Perl module. To install, you may use CPAN:
```
cpan>install Storable
```

## How to install
```
git clone https://github.com/gamallo/CitiusLinguakit.git
sh install-linguakit.sh
```
Pay attention: do not install the package in a directory whose name contain blank spaces!

## How to use
 linguakit <lang> <module> <file> [options]
      
      language = gl, es, en, pt, none
      module = dep, tagger, mwe, recog, sent
      file = path of the file input 

      Available command-line options:

      -a       by default output of the parser: simple dependency analysis (only with 'dep' module)
      -fa      parser output: full dependency analysis  (only with 'dep' module)
      -c       parser output: correct tagged text (only with 'dep' module)
      -conll   parser output: CoNLL style (only with 'dep' module)
      -noner   by default PoS tagger output: no NER or NEC is processed (only with 'tagger' module)
      -ner     PoS tagger with Named Entity Recognition - NER (only with 'tagger' module)
      -nec     PoS tagger with Named Entity Classification - NEC (only with 'tagger' module)
      -chi     by default co-occurrence measure: chi-square (only with 'mwe' module)
      -log     co-occurrence measure: loglikelihood (only with 'mwe' module)
      -scp     co-occurrence measure: symmetrical conditional probability  (only with 'mwe' module)
      -mi      co-occurrence measure: mutual information  (only with 'mwe' module)
      -cooc    co-occurrence measure: co-occurrence counting  (only with 'mwe' module)
      -s       the input <file> is just a string (only with both 'sent' and 'recog' modules)


## Examples of use

```
./linguakit pt dep tests/pt.txt -conll
```
(this returns a dependency-based analysis in CoNLL format)

```
 ./linguakit en tagger tests/en.txt -nec
```
(this returns the PoS tags with NEC information for named entities)

```
./linguakit en sent "I don't like the film" -s
```
(this returns a sentiment value)  

```
./linguakit none mw tests/pt.txt -mi
```
(this identifies the language of the input text and then makes multiword extraction ranked with mutual information)

## Input file

The input must be in plain text format, and codified in UTF8.


## Lexicons

Lexicons (electronic dictionaries) are in tagger/$lang/lexicon/dicc.src files (where $lang is en, es, pt, gl). If you modify them, then you should compile them as follows:
```
sh lexicon_compiler.sh
```
(Remember you need the *Storalbe* Perl package)


## Dependency parser 

### Output format
* Option -a means that the dp.sh generates a file with a dependency-based analysis. Each analysed sentence consists of two elements:

1. a line containing the POS tagged lemmas of the sentence. This line begins with the tag SENT. The set of tags used here are listed in file TagSet.txt. All lemmas are identified by means of a position number from 1 to N, where N is the size of the sentence.

2. All dependency triplets identified by the grammar. A triplet consists of:

(relation;head_lemma;dependent_lemma)

For instance, the sentence "I am a man." generates the following output:

```
SENT::<I_PRO_0_<number:0|lemma:I|possessor:0|case:0|genre:0|person:0|politeness:0|type:P|token:I|> am_VERB_1_<number:0|mode:0|lemma:be|genre:0|tense:0|person:0|type:S|token:am|> a_DT_2_<number:0|lemma:a|possessor:0|genre:0|person:0|type:0|token:a|> man_NOUN_3_<number:S|lemma:man|genre:0|person:3|type:C|token:man|> ._SENT>
(Lobj;be_VERBF_1;I_PN_0)
(Spec;man_NOM_3;a_DT_2)
(Robj;be_VERBF_1;man_NOM_3)
```

* Option -fa gives rise to a full represention of the depedency-based analysis. Each triplet is associated with two pieces of information: morpho-syntactic features of both the head and the dependent. 

* Option -c allows dp.sh to generate a file with the same input (a tagged text) but with some corrections proposed by the grammar. This option is useful to identify and correct regular errors of PoS taggers using grammatical rules. 

* Option -conll  gets an output file with the format defined by CoNLL-X, inspired by Lin (1998). This format was adopted by the evaluation tasks defined in CoNLL.

For more information: http://gramatica.usc.es/pln/tools/deppattern.html

## PoS tagger

We follow the EAGLES convention:
https://talp-upc.gitbooks.io/freeling-user-manual/content/tagsets.html	

For more information on our PoS tagger and NERC: http://gramatica.usc.es/pln/tools/CitiusTools.html

## Sentiment analysis
The input can be either a file (by default) or a string (option -e). The output is POSITIVE, NONE, OR NEGATIVE, and a score between 0 and 1. 
The classifier was trained with tweets, so the input should be just one sentence or a small paragraph. 

For more information: http://gramatica.usc.es/pln/tools/CitiusSentiment.html

## Multiword Extraction
For more information: http://gramatica.usc.es/~gamallo/gale-extra/index2.1.htm

## Language identification:
It returns the language of the input text: en, es, pt, gl, gz (agal galician variety), fr, eu, ca, bn (bengali), ur (urdu), hi (hindi), ta (tamil). This module is also used to recognize the language of a text before being processed by another module (only for the four languages that can be processed: pt, en, es, gl).

For more information: http://gramatica.usc.es/~gamallo/quelingua/QueLingua.htm

## Documentation and bibliography
More information on the modules can be found in papers you'll find in directory ".docs".

### References:

* Dependency analysis:

Gamallo P. , González I. (2011) A Grammatical Formalism Based on Patterns of Part-of-Speech Tags , International Journal of Corpus Linguistics , 16(1), 45-71. ISNN:1384-6655 

Gamallo, P. 2015. Dependency Parsing with Compression Rules, The 14th International Conference on Parsing Technologies (IWPT-2015) p. 107-117, Bilbao. ISBN 978-1-941643-98-3 

Gamallo, P., González, I. 2012. DepPattern: A Multilingual Dependency Parser, Demo Session of the International Conference on Computational Processing of the Portuguese Language (PROPOR 2012) , April 17-20, Coimbra, Portugal. 

* PoS tagging and NEC:

Garcia, M. and Gamallo, P. 2015. Yet another suite of multilingual NLP tools, Symposium on Languages, Applications and Technologies (SLATE 2015) p. 81-90. ISBN 978-84-606-8762-7 

Abuín, José Manuel, Juan Carlos Pichel, Tomás Fernández Pena, Pablo Gamallo e Marcos Garcia (2014). Perldoop: Efficient Execution of Perl Scripts on Hadoop Clusters, IEEE International Conference on Big Data (IEEE Big Data 2014).

Gamallo P., Garcia, M. (2011) A Resource-Based Method for Named Entity Extraction and Classification , Lecture Notes in Computer Science, vol. 7026 , Springer-Verlag, 610-623. ISNN: 0302-9743 

* Sentiment analysis:

Gamallo, P. and Garcia, M. 2014. Citius: A Naive-Bayes Strategy for Sentiment Analysis on English Tweets, In Proceedings of the 8th International Workshop on Semantic Evaluation (SemEval 2014), Dublin: 171-175. 

Gamallo, P., Garcia, M. and Fernández-Lanza, S. (2013). TASS: A Naive-Bayes strategy for sentiment analysis on Spanish tweets, Proceedings of XXIX Congreso de la Sociedad Española de Procesamiento de lenguaje natural. Workshop on Sentiment Analysis at SEPLN (TASS2013), Madrid. pp. 126-132. ISBN: 978-84-695-8349-4. (FIRST system in the task of polarity detection at the entity level)

* Multiword extraction:

Barcala M., E. Domínguez-Noya, P. Gamallo, M.López, E. Moscoso, G. Rojo, P. Santalla, S. Sotelo. (2007) A Corpus and Lexical Resources for Multi-word Terminology Extraction in the Field of Economy, 3rd Language & Technology Conference(LeTC'2007), Poznan, Poland (355-359). 
