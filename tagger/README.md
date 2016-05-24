# CitiusTools: PoS-Tagger and NERC

Author:

Pablo Gamallo, Marcos Garcia, Susana Sotelo<br>
[ProLNat Group](http://gramatica.usc.es/pln/)<br>
[University of Santiago de Compostela](http://www.usc.es)<br>
Galiza, Spain<br>

**WORK IN PROGRESS!!!!!**


## REQUIREMENTS

* Perl and bash interpreters 
* Optionally, you may install [Freeling](http://garraf.epsevg.upc.es/freeling/) (>= 3.0).

## HOW TO INSTALL

```
tar  xzvf  CitiusTool.tar.gz
sh install-citiustool.sh
```

**Pay attention**: do not install the package in a directory whose name contains blank spaces!

## HOW TO USE

```
nec.sh <lang> <file>
```

  language=pt, es, en, gl
  file=path of the input file

## INPUT FILE

The input file must be in plain text format. 
File codification must be UTF-8.

## EXAMPLE OF USE

```
./nec.sh pt test/pt.txt
```
