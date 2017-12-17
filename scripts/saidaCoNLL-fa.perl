#!/usr/bin/env perl

#A PARTIR DA SAIDA -fa DO PARSER, GERA A SAIDA FORMATO CONLL
package CONLL;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

sub conll{

	my @saida=();#<list><string>
	my ($text) = @_;#<ref><list><string>

	my $DepLex = "<|>|lex";#<string>
	my $DepSem = "<SEM>";#<string>
	my @listaTags;#<array><string>

	my %Deps = ();#<hash><hash><string><smart>
	my %Cats = ();#<hash><string>
	my %Heads = ();#<hash><string>
	my %Rels = ();#<hash><string>
	my %Roots = ();#<hash><string>
	my %Root_cats = ();#<hash><string>
	my %DepsSem = ();#<hash><hash><string><smart>
	my %CatsSem = ();#<hash><string>
	my %HeadsSem = ();#<hash><string>
	my %RelsSem = ();#<hash><string>
	my %RootsSem = ();#<hash><string>
	my %Root_catsSem = ();#<hash><string>

	my %Tokens = ();#<hash><string>
	my %Args = ();#<hash><string>

	foreach my $line (@{$text}) {
		chomp $line;

		my $head="";#<string>
		my $dep="";#<string>
		my $rel="";#<string>
		my $cat_h="";#<string>
		my $cat_d="";#<string>
		my $cat_r="";#<string>
		my $ref_h="";#<string>
		my $ref_d="";#<string>
		my $ref_r="";#<string>

		if ($line =~ /^SENT::/) {
			$line =~ s/^SENT::(\<)?//;
			#$line =~ s/\>//;

			@listaTags = split (" ", $line);
		} elsif ($line  =~ /^\-\-\-/) {
			for (my $i=0; $i<=$#listaTags; $i++) {#<integer>
				#print STDERR "#$i# --- #$listaTags[$i]#\n";
				$listaTags[$i] = ConvertCharLarge($listaTags[$i]);  
				my $Sem="";#<string>
				my $j=$i+1; #<integer>  
				if ($Deps{$i} ) { 
					$Heads{$i} = 0 if (!$Heads{$i});
					$Heads{$i}++;
					$HeadsSem{$i}++ if  ($HeadsSem{$i});;
					my $Deps="";#<string>
					my $Deps_lex="";#<string>
					my $found=0;#<boolean>
					my $found_sem=0;#<boolean>
					foreach my $r (keys %{$Deps{$i}}) {
						#print STDERR "$r\n";
						if ($Deps{$i}{$r} !~ /^($DepLex)$/) {
							$Deps = $r;
							$found = 1; 
						        if ($DepsSem{$i}{$r} =~ /($DepSem)$/) {
							    $found_sem = 1;
							    $Sem = $Rels{$i} . ":" . $Heads{$i} . "|" . $RelsSem{$i} . ":" . $HeadsSem{$i};
							}
						} else{
							$Deps_lex = $r;
						}
					}
					if (!$found) {
						$Deps = $Deps_lex;
						#print STDERR "--------------DEP: $Deps\n";
					}
					if (!$found_sem) {
					  $Sem = $Rels{$i} . ":" . $Heads{$i};
					  
					}
					if($pipe){#<ignore-line>
						print "$j\t$Tokens{$i}\t$Deps\t$Cats{$i}\t$Heads{$i}\t$Args{$i}\t$Rels{$i}\t$Sem\n";#<ignore-line>
					}else{#<ignore-line>
						push(@saida, "$j\t$Tokens{$i}\t$Deps\t$Cats{$i}\t$Heads{$i}\t$Args{$i}\t$Rels{$i}\t$Sem");
					}#<ignore-line>
				} elsif (defined $Roots{$i}) {
					my $Roots="";#<string>
					my $Roots_lex="";#<string>
					my $found=0;#<boolean>
					foreach my $r (keys %{$Roots{$i}}) {
						#print STDERR "$r\n";
						if ($Roots{$i}{$r} !~ /^($DepLex)$/ ) {
							$Roots = $r;
							$found=1;
							#print STDERR "--------------DEP: $Tokens{$i}-- $Roots{$i}{$r}\n";
						} else{
							$Roots_lex = $r;
						}
					}
					if (!$found) {
						$Roots = $Roots_lex;      
					}
					$Sem =  "ROOT:0";
					if($pipe){#<ignore-line>
						print "$j\t$Tokens{$i}\t$Roots\t$Root_cats{$i}\t0\t$Args{$i}\tROOT\t$Sem\n";
					}else{#<ignore-line>
						push(@saida, "$j\t$Tokens{$i}\t$Roots\t$Root_cats{$i}\t0\t$Args{$i}\tROOT\t$Sem");
					}#<ignore-line>
				} else {
					my ($token, $tag, $ref) = split ("_", $listaTags[$i]);#<string>
					#$listaTags[$i] = ConvertCharLarge($listaTags[$i]);

					my ($lema) = ($listaTags[$i] =~ /lemma:([^ <>|]+)/);#<string>
					$listaTags[$i] =~ s/^</Fz2/ ;
					#$args = "<lemma:$lema|token:$token|>";
					my ($args) = ($listaTags[$i] =~ /(<[^ ]+>)/);#<string>
					#print STDERR "#$token# :: #$args# --- #$listaTags[$i]#\n";
					$args = ReConvertCharLarge($args);

					if ($tag =~ /^SENT/) {
						$tag =~ s/>//;
						if($pipe){#<ignore-line>
							print "$j\t$token\t$token\t$tag\t_\t$args\t_\t_\n";  
						}else{#<ignore-line>
							push(@saida, "$j\t$token\t$token\t$tag\t_\t$args\t_\t_");
						}#<ignore-line>
					} else {
						$lema = ReConvertChar($lema);
						if($pipe){#<ignore-line>
							print "$j\t$token\t$lema\t$tag\t_\t$args\t_\t_\n";
						}else{#<ignore-line>
							push(@saida, "$j\t$token\t$lema\t$tag\t_\t$args\t_\t_");
						}#<ignore-line>
					}
				}    
			}
			%Deps = ();#<smart>
			%Cats = ();
			%Heads = ();
			%Rels = ();
			%Roots = ();
			%Root_cats = ();
			%DepsSem = ();#<smart>
			%CatsSem = ();
			%HeadsSem = ();
			%RelsSem = ();
			%RootsSem = ();
			%Root_catsSem = ();

			%Tokens = ();
			%Args = ();

		} elsif  ($line =~ /^\(/) {
			#tiramos as parenteses da dependencia
			$line =~ s/^\(//;
			$line =~ s/\)$//;

			#nao tomamos em conta as dependencias semanticas
			if ($line !~ /\<SEM>/ ) {
				my ($rel, $head, $dep) = split('\;', $line);#<string>


				my ($head,$cat_h,$ref_h) = split ("_", $head);#<string>
				my ($dep,$cat_d,$ref_d) = split ("_", $dep);#<string>
				if ($rel =~ /_/) {
					my ($rel,$cat_r,$ref_r) = split ("_", $rel);#<string>
					my ($rel_name, $rel) = split ("/", $rel);#<string>

					$Deps{$ref_d}{$dep} = $rel_name;
					$Heads{$ref_d} = $ref_r;
					$Rels{$ref_d} = "Term" ;
					$Cats{$ref_d} = $cat_d ;

					$Deps{$ref_r}{$rel} = $rel_name;
					$Heads{$ref_r} = $ref_h;
					$Rels{$ref_r} = $rel_name;
					$Cats{$ref_r} = $cat_r ;

					$Roots{$ref_h}{$head} = $rel_name;
					$Root_cats{$ref_h} = $cat_h;
				} else {
					$Deps{$ref_d}{$dep} = $rel; 
					$Heads{$ref_d} = $ref_h;
					$Rels{$ref_d} = $rel;
					$Cats{$ref_d} = $cat_d;

					$Roots{$ref_h}{$head} = $rel;
					$Root_cats{$ref_h} = $cat_h;
				}
			}

		       	if ($line =~ /\<SEM>/ ) {
				my ($rel, $head, $dep) = split('\;', $line);#<string>

				#print STDERR "Ok: #$line#\n";
				my ($head,$cat_h,$ref_h) = split ("_", $head);#<string>
				my ($dep,$cat_d,$ref_d) = split ("_", $dep);#<string>
				if ($rel =~ /_/) {
					my ($rel,$cat_r,$ref_r) = split ("_", $rel);#<string>
					my ($rel_name, $rel) = split ("/", $rel);#<string>

					$DepsSem{$ref_d}{$dep} = $rel_name;
					$HeadsSem{$ref_d} = $ref_r;
					$RelsSem{$ref_d} = "Term" ;
					$CatsSem{$ref_d} = $cat_d ;

					$DepsSem{$ref_r}{$rel} = $rel_name;
					$HeadsSem{$ref_r} = $ref_h;
					$RelsSem{$ref_r} = $rel_name;
					$CatsSem{$ref_r} = $cat_r ;

					$RootsSem{$ref_h}{$head} = $rel_name;
					$Root_catsSem{$ref_h} = $cat_h;
				} else {
					$DepsSem{$ref_d}{$dep} = $rel; 
					$HeadsSem{$ref_d} = $ref_h;
					$RelsSem{$ref_d} = $rel;
					$CatsSem{$ref_d} = $cat_d;

					$RootsSem{$ref_h}{$head} = $rel;
					$Root_catsSem{$ref_h} = $cat_h;
				}
			}
		} elsif  ($line =~ /^HEAD::|^DEP::|^REL::/) {
			my ($token) = ($line =~ /token:([^ _<>|]+)\|/);#<string>
			my ($args) = ($line =~ /(<[^ _<>]+>)/); #<string>
			my ($temp) = ($line =~ /::([^ <>]+)</); #<string>
			my ($tmp,$tmp,$pos) = split ("_", $temp);#<string>
			#$rel = $Rels{$pos};
			$Tokens{$pos} = $token;
			$Args{$pos} = $args;
			#$Tok{$pos}{$Head_token} = $rel ; 
			#print STDERR "$line\nH == ##$token## - ($args) ##$Token{$pos}## ###$pos### ---$temp$---\n";
		}
	}
	return \@saida;
}	

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	conll(\@lines);
}
#<ignore-block>

##funcions especias para tratar os caracteres problematicos: "|", "<", ">"
sub ConvertChar {
    my ($string) = @_ ;#<string>

    $string =~ s/\>/\*Fz1\*/g; 
    $string =~ s/\</\*Fz2\*/g;
    $string =~ s/\|/\*Fz\*/g;

   return $string;
}

sub ConvertCharLarge {
    my ($string) = @_ ;#<string>

    $string =~ s/\\>/\*Fz1\*/g; 
    $string =~ s/tok\\>/token:\*Fz1\*/g; 
    $string =~ s/lemma:\\</lemma:\*Fz2\*/g;
    $string =~ s/token:\\</token:\*Fz2\*/g; 
    $string =~ s/lemma:\\\|/lemma:\*Fz\*/g;
    $string =~ s/token:\\\|/token:\*Fz\*/g; 
   # print STDERR "+++ $string\n";
   return $string;
}

sub ReConvertCharLarge {
    my ($string) = @_ ;#<string>

    $string =~ s/lemma:\*Fz1\*/lemma:\\>/g; 
    $string =~ s/lemma:\*Fz2\*/lemma:\\</g; 
    $string =~ s/lemma:\*Fz\*/lemma:\\|/g; 
    $string =~ s/token:\*Fz1\*/token:\\>/g; 
    $string =~ s/token:\*Fz2\*/token:\\</g; 
    $string =~ s/token:\*Fz\*/token:\\|/g; 
    
    return $string;
}

sub ReConvertChar {
    my ($string) = @_ ;#<string>

    $string =~ s/\*Fz1\*/\\>/g; 
    $string =~ s/\*Fz2\*/\\</g; 
    $string =~ s/\*Fz\*/\\|/g; 
    
    return $string;
}

