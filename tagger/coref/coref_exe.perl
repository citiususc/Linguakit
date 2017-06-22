#!/usr/bin/env perl

####################################################
#                                                  #
# CR Tool 0.3: Partial Coreference Resolution Tool #
#         with NER Correction Heuristics           #
#                                                  #
#              Author: Marcos Garcia               #
####################################################

#-----------------------------------------------
# Options:
# Output:
#   Coreference (default): -c
#   CR + NER Correction: -n
#-----------------------------------------------

package Coref;

#<ignore-block>
use strict; 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;
#<ignore-block>

# Pipe
my $pipe = !defined (caller);#<ignore-line> 

# Absolute path 
use File::Basename;#<ignore-line>
my $abs_path = ".";#<string>
$abs_path = dirname(__FILE__);#<ignore-line>


# Nouns
#my %PerNouns;
my %MaleNames = ();#<hash><boolean>
my %FemNames = ();#<hash><boolean>
my %TwLoc = ();#<hash><boolean>
my %TwOrg = ();#<hash><boolean>

my $FILE;
## Loads the male/female nouns (now all of them)
open($FILE, "$abs_path/lex/female_all_uniq.txt") or die ("Cannot open the female names file\n");
while (my $line = <$FILE>) {
	chomp($line);
	$FemNames{$line} = 1;
}
close($FILE);
#
open($FILE, "$abs_path/lex/male_all_uniq.txt") or die ("Cannot open the male names file\n");
while (my $line = <$FILE>) {
	chomp($line);
	$MaleNames{$line} = 1;
}
close($FILE);
## Loads LOC and ORG trigger-words (for avoiding wrong clustering)
open($FILE, "$abs_path/lex/twLOC.txt") or die ("Cannot open the twLOC.txt file\n");
while (my $line = <$FILE>) {
	chomp($line);
	$TwLoc{$line} = 1;
}
close($FILE);
#
open($FILE, "$abs_path/lex/twORG.txt") or die ("Cannot open the twORG.txt file\n");
while (my $line = <$FILE>) {
	chomp($line);
	$TwOrg{$line} = 1;
}
close($FILE);


sub coref {

	# Mentions
	my %Mentions = ();#<hash><list><integer>
	my %MentionsForm = ();#<hash><string>
	my %MentionsPos = ();#<hash><integer>
	#my %PosMentions;
	#my %MentionsSent;
	#my %MentionsTag;
	#my %IDs;
	my %Gender = ();#<hash><string>
	
	#my %Lema;
	my %Tag = ();#<hash><string>
	#my %Head;
	#my %HeadNP;
	my %FullNP = ();#<hash><string>
	#my %FullNPLong = ();
	#my %NP = ();
	#my %MentionsPosE;
	#my $Pos_start;
	#my $Pos_end;

	# Entities
	my %FullNPEnt = ();#<hash><list><string>
	#my %HeadNPEnt; 
	my %GenderEnt = ();#<hash><string>
	#my %Size;
	my %TagEnt = ();#<hash><string>

	# Misc
	#my $GenOK;
	#my $CompNP;
	#my $CompNP_toks;
	#my $DistanceSent;

	#my $NP_i;
	#my $NP_m;
	#my $FullNP_m;
	#my $FullNP_i;
	#my @FullNP_m;
	#my $CompFN;
	#my $Constraint;
	#my $num_sentence = 0;
	my $num_mention = 0;#<integer>

	# Others
	#my $separador;
	#my $artigo;
	#my @Lines;
	my $cont_linhas = 0;#<integer>
	my $id_entity = [];#<ref><list><integer>
	my %Linhas = ();#<hash><string>

	my ($opt_c, $opt_n, #<string> 
	  $text, #<ref><list><string>
	  $limit) = @_;#<integer>
    my $cont_tok = 0; #<integer>

	my $Mentions_id;#<ref><hash><integer>
	if (@_ > 4) {
		$Mentions_id = $_[4];
	}else{
		$Mentions_id = {};
	}
	

	foreach my $l(@{$text}) {
		chomp($l);
		$cont_linhas++;
		$cont_tok++;
		if ($l !~ /^ *$/) {
			$l =~ s/^/$cont_tok /;
		}
		if ($l =~ /. . Fp$/) {
			$cont_tok = 0;
			#$num_sentence++;
			$Linhas{$cont_linhas} = $l;
		} elsif ($l =~ /^ *$/) {
			$Linhas{$cont_linhas} = "";
			$cont_tok = 0;
			#$num_sentence++;
		} else {
			$Linhas{$cont_linhas} = $l;
		}
	}
	# First Step: Mention Identification
	#-----------------------------------
	# %Mentions{mention} = 0 (no entity)
	# %MentionsPos{mention} = position
	# %MentionsForm{mention} = token(s)
	####################################
	MentionIdentify_f(\%Linhas);
	$num_mention = MentionExtract($num_mention, \%Linhas,\%Mentions,\%MentionsForm,\%MentionsPos,\%Gender,\%FullNP,\%Tag);

	# Check: if the previous modules have not found
	# any named entity in the text: finish.
	my $size_mentions = keys %Mentions;#<integer>
	if ($size_mentions < 2) {
		%Mentions = ();
    }
    
	# Coreference Modules
	#####################

	# Nominal Coreference Modules
	#############################

	# StringMatch
	#############
    # Starts in second mention and looks backwards for candidates
	foreach my $m(sort {$a <=> $b} keys %Mentions) {
		if ($m != 1) {
			my $i = $m - 1;#<integer>
			while ($i >= 1 && ($m-$i <= $limit)) {
				if (($MentionsPos{$m} != $MentionsPos{$i}) && ($m != $i)) {
					if ($MentionsForm{$m} eq $MentionsForm{$i}) {
						if ($Tag{$i} eq $Tag{$m} || $opt_n == 1) {
							my $new_tag = SelectTag($m, $i, \%Mentions, \%MentionsForm, \%Tag, \%TagEnt);#<string>
							$id_entity = Merge(\%Mentions, $m, $i, \%Gender, \%FullNP, \%FullNPEnt, \%GenderEnt, \%GenderEnt, $id_entity);
							$TagEnt{$Mentions{$m}} = $new_tag;
							$i = 0;
							}
						}
					}
				$i--;
			}
		}
	}
    
	# Proper Noun inclusion (longest proper noun of A
	# should be in longest proper noun of B -or vice-versa)
	#------------------------------------------------------
	# When selecting a mention (m), it should be
	# a singleton or the first mention of its entity
	foreach my $m(sort {$a <=> $b} keys %Mentions) {
		if ( ($m != 1) && ( ($Mentions{$m} != 0 && $Mentions{$m}[0] == $m) || ($Mentions{$m} == 0) ) ) {
			my $i = $m - 1;#<integer>
			while ($i >= 1 && ($m-$i <= $limit)) {
				if (defined $Mentions{$i}) {
					if ($Tag{$i} eq $Tag{$m} || $opt_n == 1) {
						my ($CompNP, $CompNPToks) = CompareNP($m, $i, \%Mentions, \%FullNP, \%FullNPEnt); #<string>
						if ($CompNP == 1) {
							if (CompareGN($m, $i, \%Mentions, \%Gender, \%GenderEnt) == 1 && CompareTags($opt_n, $m, $i, \%MentionsForm, \%Tag) == 1) {
								my $new_tag = SelectTag($m, $i, \%Mentions, \%MentionsForm, \%Tag, \%TagEnt);#<string>
								$id_entity = Merge(\%Mentions, $m, $i, \%Gender, \%FullNP, \%FullNPEnt, \%GenderEnt, \%GenderEnt, $id_entity);
								$TagEnt{$Mentions{$m}} = $new_tag;
								last;
							}
						}
					}
				}
				$i--;
			}
		}
	}
    
	# Relax Proper Noun inclusion (all tokens of the longest proper
	# noun of A should be in longest proper noun of B -or vice-versa)
	#------------------------------------------------------
	# When selecting a mention (m), it should be
	# a singleton or the first mention of its entity
	foreach my $m(sort {$a <=> $b} keys %Mentions) {
		if ( ($m != 1) && ( ($Mentions{$m} != 0 && $Mentions{$m}[0] == $m) || ($Mentions{$m} == 0) ) ) {
			my $i = $m - 1;#<integer>
			while ($i >= 1 && ($m-$i <= $limit)) {
				if (defined $Mentions{$i}) {
					if ($Tag{$i} eq $Tag{$m} || $opt_n == 1) {
						my ($CompNP, $CompNPToks) = CompareNP($m, $i, \%Mentions, \%FullNP, \%FullNPEnt);#<string>
						if ($CompNPToks == 1) {
							if (CompareGN($m, $i, \%Mentions, \%Gender, \%GenderEnt) == 1 && CompareTags($opt_n, $m, $i, \%MentionsForm, \%Tag) == 1) {
								my $new_tag = SelectTag($m, $i, \%Mentions, \%MentionsForm, \%Tag, \%TagEnt);#<string>
								$id_entity = Merge(\%Mentions, $m, $i, \%Gender, \%FullNP, \%FullNPEnt, \%GenderEnt, \%GenderEnt, $id_entity);
								$TagEnt{$Mentions{$m}} = $new_tag;
								last;
							}
						}
					}
				}
				$i--;
			}
		}
	}
	# End of the nominal modules (not baselines)

	# Default rules
	###############

	# Singletons
	#-----------
	foreach my $m(sort {$a <=> $b} keys %Mentions) {
		if ($Mentions{$m} == 0) {
		# Default feats
		$id_entity = [];
		$Mentions{$m} = $id_entity;
		$TagEnt{$Mentions{$m}} = $Tag{$m};
		$FullNPEnt{$Mentions{$m}}[0] = $MentionsForm{$m};
		}
	}
    
	$id_entity = [];
	#$num_sentence = 0;
	$num_mention = 0;
    
	# Get the longest NP of each entity
	###################################
	foreach my $m(sort {$a <=> $b} keys %TagEnt) {
		#my $size = ();
		my $LongNP_m;#<string>
		my $LongNPsize_m;#<string>
		#my @size = ();
		my %Size = ();#<hash><integer>
		foreach my $f(@{$FullNPEnt{$m}}) {
			if ($f =~ /_/) {
				my @size = split("_", $f);#<array><string>
				$Size{$f} = $#size + 1;
				my $first = 0;
				foreach my $n(sort {$Size{$b} <=> $Size{$a} } keys %Size ) {
					if (!$first) {
						$LongNP_m = $n;
						$LongNPsize_m = $Size{$n};
					}
					$first = 1;
				}
				@size = ();
				%Size = ();
			}
		}
		if (!$LongNP_m) {
			$LongNP_m = $FullNPEnt{$m}[0];
		}
		#$FullNPLong{$m} = $LongNP_m;
	}
    
	# Hash modification for printing
	#-------------------------------
	my $id_number = keys %{$Mentions_id};#<integer>
	foreach my $m(sort {$a <=> $b} keys %Mentions) {
		my $id_e = $Mentions_id->{$Mentions{$m}};#<integer>
		if(!defined($id_e)){
			$Mentions_id->{$Mentions{$m}} = $id_e = $id_number++;
		}

		my $final_tag = $TagEnt{$id_e};#<string>
		#my $final_lemma = $FullNPLong{$Mentions{$m}};	
		my ($ps, $tk, $lm, $tg, $cr) = split(" ", $Linhas{$MentionsPos{$m}});#<string>
		# Only Coref output
		if ($opt_c == 1) {
			$Linhas{$MentionsPos{$m}} = $ps . " " . $tk . " " . $lm . " " . $tg . " ($id_e)";
			#$Linhas{$MentionsPos{$m}} = $tk . " " . $lm . " " . $tg . " ($id_e)";
		}
		# Coreference + NER correction output
		elsif ($opt_n == 1) {
			$Linhas{$MentionsPos{$m}} = $ps . " " . $tk . " " . $lm . " " . $final_tag . " ($id_e)";
			#$Linhas{$MentionsPos{$m}} = $tk . " " . $lm . " " . $final_tag . " ($id_e)";
		}
	}
	
	#<ignore-block>
	if($pipe){
		foreach my $l(sort {$a <=> $b} keys %Linhas) {
			if ($Linhas{$l} =~ /^[0-9]+ [^ ]+ [^ ]+ [A-Z]/) {
				$Linhas{$l} =~ s/^[0-9]+ //;
			}
			print ("$Linhas{$l}\n");
		}
		print ("\n");
	}else{
	#<ignore-block>
		my @Saida = ();#<list><string>
		foreach my $l(sort {$a <=> $b} keys %Linhas) {
			if ($Linhas{$l} =~ /^[0-9]+ [^ ]+ [^ ]+ [A-Z]/) {
				$Linhas{$l} =~ s/^[0-9]+ //;
			}
			push (@Saida, $Linhas{$l});
		}
		push (@Saida, "");
		return \@Saida;
	}#<ignore-line>

} 


#<ignore-block>
if ($pipe){
	use Getopt::Std;
	our($opt_c, $opt_n);
	getopts('cn');

	# Invalid options > prints the help
	if ($opt_c && $opt_n) {
		exit(1);
	} elsif ($opt_c) {
		$opt_c = 1;
	} elsif ($opt_n) {
		$opt_n = 1;
	}
	my @nec = <STDIN>;
	coref($opt_c, $opt_n, \@nec, $ARGV[1]);
}
#<ignore-block>


# First Step: Mention Identification (basic)
############################################
sub MentionIdentify_f{

	(my $Input) = @_;#<ref><hash><string>

	foreach my $linha(sort {$a <=> $b} keys %{$Input}) {
		my $prev = $linha - 1;#<integer>

		if ($Input->{$linha} =~ /^[0-9]/) {
			my ($num_tok, $token, $lema, $tag) = split(" ", $Input->{$linha});#<string>
			# Tokens in lower-case
			$token = "\L$token";

			# Personal names
			if ($tag =~ /^NP/) {
				$Input->{$linha} =~ s/$/ (0)/;
			}
			#else {
				#$Input->{$linha} =~ s/$/ _/;
			#}
		}
    }
}


# Mention Extraction
####################
sub MentionExtract{

	my ($num_mention, #<integer>
	  $Input, #<ref><hash><string>
	  $Mentions, #<ref><hash><list><integer>
	  $MentionsForm, #<ref><hash><string>
	  $MentionsPos, #<ref><hash><integer>
	  $Gender, #<ref><hash><string>
	  $FullNP, #<ref><hash><string>
	  $Tag) = @_; #<ref><hash><string>
    
	my $cont_line = 0;#<integer>
    
    foreach my $linha(sort {$a <=> $b} keys %{$Input}) {
		$cont_line++;

		if ($Input->{$linha} =~ /^[0-9]/) {
			my ($num_tok, $token, $lema, $tag, $coref) = split(" ", $Input->{$linha});#<string>
	    
			# Tokens in lower-case
			$token = "\L$token";

			# Single mentions
			if ($coref && $coref eq "(0)") {
				$num_mention++;
				$Mentions->{$num_mention} = 0;
				$MentionsForm->{$num_mention} = $token;
				$MentionsPos->{$num_mention} = $cont_line;
				#$MentionsSent{$num_mention} = $num_sentence;
				#$MentionsTag{$num_mention} = $tag;
				$Tag->{$num_mention} = $tag;
				#$Lema{$num_mention} = $lema;
				#$Head{$num_mention} = Head($token, $tag);
				#if ($token || $tag =~ /^NP00SP0/) {
				$FullNP->{$num_mention} = $token;
				#$HeadNP{$num_mention} = $HeadNP;
				#}
				if ($tag eq "NP00SP0") {
					$Gender->{$num_mention} = ExtractFeats($linha, $Input, $token); # ($Head{$num_mentions})
				}
			}
		}
    }
	return $num_mention;
}


# Extracts the Head of a mention
# (single token / compound proper noun)
#######################################
sub Head{

	my ($token, $tag) = @_;#<string>

	my $HeadNP = "";#<string>
	my $NP = "";#<string>

	# Proper Noun
	#------------

	# Person
	if ($tag =~ /^NP00SP0/) {
		# Compound Proper Noun: 1st token
		if ($token =~ /_/) {
			my @toks = split("_", $token);#<array><string>
			if ($toks[1] =~ /^d.s?$/) {
				$HeadNP = $toks[1];
			} else {
				$HeadNP = $toks[0];
			}
		}
		# Single Proper Noun, Head = token
		else {
			$HeadNP = $token;
		}
	}
	return $HeadNP;
}


# Extracts Features
# Gender and Number
# (only gender now...)
###################
sub ExtractFeats {

	#my ($pos, $Input, $token) = @_;
	#my %Input = %$Input;
	my ($pos, $token) = @_;#<string>
	my $gender = "";#<string>

	if (defined $FemNames{$token}) {
		$gender = "F";
	} elsif (defined $MaleNames{$token}) {
		$gender = "M";
	}
	#else {
		#if ($Input{$pos-1} =~ /^[0-9]/) {
			#if ($Input{$pos-1} =~ /(NCMS|AQ0MS|VMP00SM)/) {
				#$gender = "M";
			#} elsif ($Input{$pos-1} =~ /(NCFS|AQ0FS|VMP00SF)/) {
				#$gender = "F";
			#}
		#}
	#}
    return $gender;
}


# SelectTag (NE)
################
sub SelectTag {

    my ($m, $i, #<integer>
	  $Mentions, #<ref><hash><list><integer>
	  $MentionsForm, #<ref><hash><string>
	  $Tag, #<ref><hash><string>
	  $TagEnt) = @_; #<ref><hash><string>

	my %Count = ();#<hash><integer>
	my $Tag_m = "";#<string>
	my $Tag_i = "";#<string>
	my $count_m = 0;#<integer>
	my $count_i = 0;#<integer>
	my $final_tag = "";#<string>

	# Get tag from mention/entity
	# First (m)
	if ($Mentions->{$m} == 0) {
		$Tag_m = $Tag->{$m};
		$count_m = 1;
	} else {
		foreach my $e(@{$Mentions->{$m}}) {
			# Get the most frequent tag of the entity
			if ($Tag->{$e} eq "NP00SP0") {
				$Count{$Tag->{$e}}++;
			} elsif ($Tag->{$e} eq "NP00O00") {
				$Count{$Tag->{$e}}++;
			} elsif ($Tag->{$e} eq "NP00G00") {
				$Count{$Tag->{$e}}++;
			} elsif ($Tag->{$e} eq "NP00V00") {
				$Count{$Tag->{$e}}++;
			}
		}
		my $first = 0;#<integer>
		foreach my $n(sort {$Count{$b} <=> $Count{$a}} keys %Count ) {
			if (!$first) {
				$Tag_m = $n;
				$count_m = $Count{$n};
			}
			$first = 1;
		}
	}

	# Second (i)
	if ($Mentions->{$i} == 0) {
		$Tag_i = $Tag->{$i};
		$count_i = 1;
	} else {
		foreach my $e (@{$Mentions->{$i}}) {
			# Get the most frequent tag of the entity	    
			if ($Tag->{$e} eq "NP00SP0") {
				$Count{$Tag->{$e}}++;
			} elsif ($Tag->{$e} eq "NP00O00") {
				$Count{$Tag->{$e}}++;
			} elsif ($Tag->{$e} eq "NP00G00") {
				$Count{$Tag->{$e}}++;
			} elsif ($Tag->{$e} eq "NP00V00") {
				$Count{$Tag->{$e}}++;
			}
		}
		my $first = 0;#<integer>
		foreach my $n(sort {$Count{$b} <=> $Count{$a}} keys %Count ) {
			if (!$first) {
				$Tag_i = $n;
				$count_i = $Count{$n};
			}
			$first = 1;
		}
	}

	# Select most frequent
	# Tag of the longest entity: NER is more reliable
	# with larger entities: "Brandia: ORG vs Manuel_Brandia: PER"
	# (1º: tag of entity_i; 2º: tag of mention_i)

	#
	if ($Mentions->{$m} == 0 && $MentionsForm->{$m} =~ /_/ && $MentionsForm->{$i} !~ /_/) {
		$final_tag = $Tag_m;
	} elsif ($Mentions->{$i} == 0 && $MentionsForm->{$i} =~ /_/ && $MentionsForm->{$m} !~ /_/) {
		$final_tag = $Tag_i;
	} elsif ($count_m > $count_i) {
		$final_tag = $Tag_m;
	} elsif ($count_i > $count_m) {
		$final_tag = $Tag_i;
	} elsif ($TagEnt->{$Mentions->{$i}}) {
		$final_tag = $TagEnt->{$Mentions->{$i}};
	} elsif ($TagEnt->{$Mentions->{$m}}) {
		$final_tag = $TagEnt->{$Mentions->{$m}};
	} elsif (length($MentionsForm->{$m}) > length($MentionsForm->{$i})) {
		$final_tag = $Tag_m;
	} elsif (length($MentionsForm->{$i}) > length($MentionsForm->{$m})) {
		$final_tag = $Tag_i;
	} else {
		$final_tag = $Tag_i; #default
	}
	return $final_tag;
}


# Merge Entities 1
##################
sub Merge {

	my ($Mentions, #<ref><hash><list><integer>
	  $m, $i, #<integer>
	  $Gender, #<ref><hash><string>
	  $FullNP, #<ref><hash><string>
	  $FullNPEnt, #<ref><hash><list><string>
	  $GenderEnt, #<ref><hash><string>
	  $id_entity) = @_; #<ref><list><integer>
	
	# New ID (both mentions without entity)
	if ($Mentions->{$m} == 0 && $Mentions->{$i} == 0) {
		$id_entity=[];

		$Mentions->{$m} = $id_entity;
		$Mentions->{$i} = $id_entity;
		push(@$id_entity, $m);
		push(@$id_entity, $i);

		MergeGender($m, $i, $Gender, $GenderEnt, $id_entity);

		push(@{$FullNPEnt->{$id_entity}}, $FullNP->{$m});
		push(@{$FullNPEnt->{$id_entity}}, $FullNP->{$i});
    } else {
		# One of them doesn't have entity
		if ($Mentions->{$m} == 0) {
			my $new_id = $Mentions->{$i}; #<ref><list><integer>
			$Mentions->{$m} = $new_id;
			push(@$new_id, $m);

			MergeGender($m, $i, $Gender, $GenderEnt, $id_entity);
 
			push(@{$FullNPEnt->{$new_id}}, $FullNP->{$m});
			push(@{$FullNPEnt->{$new_id}}, $FullNP->{$i});
		} elsif ($Mentions->{$i} == 0) {
			my $new_id = $Mentions->{$m}; #<ref><list><integer>
			$Mentions->{$i} = $new_id;
			push(@$new_id, $i);

			MergeGender($m, $i, $Gender, $GenderEnt, $id_entity);

			push(@{$FullNPEnt->{$new_id}}, $FullNP->{$m});
			push(@{$FullNPEnt->{$new_id}}, $FullNP->{$i});    
		}
		# Both mentions have ID: chose the lower one
		else {
			my $new_id; #<ref><list><integer>
			my $old_id; #<ref><list><integer>
			if ($Mentions->{$m} > $Mentions->{$i}) {
				$new_id = $Mentions->{$i};
				$old_id = $Mentions->{$m};
				$Mentions->{$m} = $new_id;
			} else {
				$new_id = $Mentions->{$m};
				$old_id = $Mentions->{$i};
				$Mentions->{$i} = $new_id;
			}
			MergeEntities($new_id, $old_id, $Mentions, $Gender, $FullNP, $FullNPEnt, $GenderEnt);
		}
	}

	# Sort the mentions in the entity array
	# (Only the first is chosen in further modules)
	foreach my $e(sort {$a <=> $b} values %{$Mentions}) {
		if ($e != 0) {
			@$e = sort {$a <=> $b} (@$e);
		}
	}
	return $id_entity;
}


# Compares Proper nouns: Full Name and Tokens
#############################################
sub CompareNP {

	my ($m, $i, #<integer>
	  $Mentions, #<ref><hash><list><integer>
	  $FullNP,  #<ref><hash><string>
	  $FullNPEnt) = @_; #<ref><hash><list><string>

	my $CompNP = 0; #<integer>
	my $FullNP_m = 0; #<integer>
	my $FullNP_i =0; #<integer>
	my $NP_m = ""; #<string>
	my $NP_i = ""; #<string>
	my $CompNP_toks = 0; #<integer>
	my $ToksNP_m = 0; #<integer>
	my $ToksNP_i = 0; #<integer>
	my $LongNPsize_m = 0; #<integer>
	my $LongNPsize_i = 0; #<integer>
	my $LongNP_m = 0; #<integer>
	my $LongNP_i = 0; #<integer>

	# Chooses the longest proper noun of each mention
	# (then compared with the FullNP in the entity, if any)
	if ($FullNP->{$m}) {
		$NP_m = $FullNP->{$m};
		if ($NP_m =~ "_") {
			my @NPs_m = split("_", $NP_m);#<array><string>
			$ToksNP_m = $#NPs_m + 1;
		} else {
			$ToksNP_m = 1;
		}
	} else {
		$ToksNP_m = 0;
		$NP_m = "";
	}
    if ($FullNP->{$i}) {
		$NP_i = $FullNP->{$i};
		if ($NP_i =~ "_") {
			my @NPs_i = split("_", $NP_i);#<array><string>
			$ToksNP_i = $#NPs_i + 1;
		} else {
			$ToksNP_i = 1;
		}
	} else {
		$ToksNP_i = 0;
		$NP_i = "";
	}

	# Longest proper noun of the first entity
	if ($FullNPEnt->{$Mentions->{$m}}) {
		my %size = (); #<hash><integer>
		foreach my $f(@{$FullNPEnt->{$Mentions->{$m}}}) {
			if ($f =~ /_/) {
				my @size = split("_", $f); #<array><string>
				$size{$f} = $#size + 1;
				my $first = 0; #<integer>
				foreach my $n(sort {$size{$b} <=> $size{$a} } keys %size) {
					if (!$first) {
						$LongNP_m = $n;
						$LongNPsize_m = $size{$n};
					}
					$first = 1;
				}
			}
		}

		if ($LongNP_m) {
		$FullNP_m = $LongNP_m;
		} else {
		$LongNPsize_m = 1;
		}
	}

	# Entity to compare
	# (from entity or mention)
	my $Comp_m = ""; #<string>
	my $size_m = 0; #<integer>
	if ($NP_m && ($ToksNP_m >= $LongNPsize_m)) {
		$Comp_m = $NP_m;
		$size_m = $ToksNP_m;
	} else {
		$Comp_m = $FullNP_m;
		$size_m = $LongNPsize_m;
	}

	# Longest proper noun of the second entity
	if ($FullNPEnt->{$Mentions->{$i}}) {
		my %size = (); #<hash><integer>
		foreach my $f(@{$FullNPEnt->{$Mentions->{$i}}}) {
			if ($f =~ /_/) {
				my @size = split("_", $f); #<array><string>
				$size{$f} = $#size + 1;
				my $first = 0; #<integer>
				foreach my $n(sort {$size{$b} <=> $size{$a}} keys %size ) {
					if (!$first) {
						$LongNP_i = $n;
						$LongNPsize_i = $size{$n};
					}
					$first = 1;
				}
			}
		}
		if ($LongNP_i) {
			$FullNP_i = $LongNP_i;
		} else {
			$LongNPsize_i = 1;
		}
	}

	# Entity to compare
	# (from entity or mention)
	my $Comp_i = ""; #<string>
	my $size_i = 0; #<integer>

	if ($NP_i && ($ToksNP_i >= $LongNPsize_i)) {
		$Comp_i = $NP_i;
		$size_i = $ToksNP_i;
	} else {
		$Comp_i = $FullNP_i;
		$size_i = $LongNPsize_i;
	}

	# Verifies if the longest proper noun of an entity
	# contains all the tokens (except stop words) of the
	# longest proper noun of the other entity

	# Might have same start (not ending)
	# "Guille - Guillermo" vs "Mazinho - Zinho"
	# Not in PrepPhrases: "Portugal: LOC - Campeonato_de_Portugal: MISC"

	#if ($size_m != $size_i) {
	if ( ($Comp_m =~ /_(de|por|em|en|do|da|dos|das)_?(o|os|a|as|el|la|los|las|the)?_$Comp_i/) ||
	  ($Comp_i =~ /_(de|por|em|en|do|da|dos|das)_?(o|os|a|as|el|la|los|las|the)?_$Comp_m/) && $size_m != $size_i) {
		$CompNP = 0;
	} elsif ($Comp_m =~ /(^|_|-)$Comp_i/ || $Comp_i =~ /(^|_|-)$Comp_m/ && $size_m != $size_i) {
		unless ( ($Comp_m =~ /(^|_)jr./ && $Comp_i !~ /(^|_)jr./) ||
		  ($Comp_m !~ /(^|_)jr./ && $Comp_i =~ /(^|_)jr./) ){
			$CompNP = 1;
		}
	}
	#(previous)
	#if ($Comp_m =~ /(^|_|-)$Comp_i/ || $Comp_i =~ /(^|_|-)$Comp_m/) {
		#unless ( ($Comp_m =~ /(^|_)jr./ && $Comp_i !~ /(^|_)jr./) ||
		  #($Comp_m !~ /(^|_)jr./ && $Comp_i =~ /(^|_)jr./) ){
			#$CompNP = 1;
		#}
	#}

	# Token comparison (same order)
	else {
		my $Comp_a = ""; #<string>
		my $Comp_b = ""; #<string>
		my $size_a = 0; #<integer>
		my $size_b = 0; #<integer>
		if ($size_m < $size_i) {
			$Comp_a = $Comp_m;
			$Comp_b = $Comp_i;
			$size_a = $size_m;
			$size_b = $size_i;
		} elsif ($size_i < $size_m) {
			$Comp_a = $Comp_i;
			$Comp_b = $Comp_m;
			$size_a = $size_i;
			$size_b = $size_m;
		}
		
		my @Toks_m = split("_", $Comp_a); #<array><string>
		my @Toks_i = split("_", $Comp_b); #<array><string>
		
		my $found = 0; #<boolean>
		my $all = 0; #<integer>
		my $ci = 0; #<integer>
		foreach my $tm(@Toks_m) {
			if ($tm =~ /^(dr\.|sr\.|dra\.|sra\.|dom|dona)$/) {
				$size_a--;
			}
			foreach my $ti(@Toks_i) {
				if ($tm =~ /^(dr\.|sr\.|dra\.|sra\.|dom|dona)$/) {
					$all--;
				}
				$ci++;
				if (($tm eq $ti) && ($ci > $found)) {
					$found = $ci;
					$all++;
					#last;
				}
			}
		}
		if ($all == $size_a && $all > 0) {
			$CompNP_toks = 1;
		}
#	}
	}
	return($CompNP, $CompNP_toks);
}


# Compares gender (in the entity, if any) before the merging
############################################################
sub CompareGN {

	my ($m, $i, #<integer>
	  $Mentions, #<ref><hash><list><integer>
	  $Gender, #<ref><hash><string>
	  $GenderEnt) = @_; #<ref><hash><string>

	my $GenOK = 0; #<integer>
	my $Gen_m = ""; #<string>
	my $Gen_i = ""; #<string>

	if ($Mentions->{$m} == 0) {
		$Gen_m = $Gender->{$m};
	} else {
		$Gen_m = $GenderEnt->{$Mentions->{$m}};
	}
	if ($Mentions->{$i} == 0) {
		$Gen_i = $Gender->{$i};
	} else {
		$Gen_i = $GenderEnt->{$Mentions->{$i}};
	}

	# Only blocks different (M/F) genders
	if ( ($Gen_m eq "F" && $Gen_i eq "M") || ($Gen_m eq "M" && $Gen_i eq "F") ) {
		$GenOK = 0;
	} else {
		$GenOK = 1;
	}
	return $GenOK;
}


# CompareTags (NE)
##################
sub CompareTags {

	my ($opt_n, #<string>
	  $m, $i, #<integer>
	  $MentionsForm, #<ref><hash><string>
	  $Tag) = @_; #<ref><hash><string>

	my $TagOK = 0; #<integer>

	if ( ($Tag->{$m} eq "NP00G00" && $Tag->{$i} eq "NP00O00") ||
	  ($Tag->{$m} eq "NP00O00" && $Tag->{$i} eq "NP00G00") ) {
		$TagOK = 0;
	} else {
		my $m_head = $MentionsForm->{$m}; #<string>
		my $i_head = $MentionsForm->{$i}; #<string>
		if ($MentionsForm->{$m} =~ /_/) {
			my @mtoks = split("_", $MentionsForm->{$m}); #<array><string>
			$m_head = $mtoks[0];
		}
		if ($MentionsForm->{$i} =~ /_/) {
			my @itoks = split("_", $MentionsForm->{$i}); #<array><string>
			$i_head = $itoks[0];
		}

		# ORG vs other tag
		if ($opt_n == 1 && ((defined $TwOrg{$m_head} && $Tag->{$i} ne "NP00O00") || (defined $TwOrg{$i_head} && $Tag->{$m} ne "NP00O00"))) {
			$TagOK = 0;
		}
		# LOC vs other tag
		elsif ($opt_n == 1 && ((defined $TwLoc{$m_head} && $Tag->{$i} ne "NP00G00") || (defined $TwLoc{$i_head} && $Tag->{$m} ne "NP00G00"))) {
			$TagOK = 0;
		}
		else {
			$TagOK = 1;
		}
	}
	return $TagOK;
}


# Merge Gender
##############
sub MergeGender {

	my ($m, $i, #<integer>
	  $Gender, #<ref><hash><string>
	  $GenderEnt, #<ref><hash><string>
	  $id_entity) = @_; #<ref><list><integer>
    
    if ($Gender->{$i} =~ /^(F|M)/ && $Gender->{$m} !~ /^(F|M)/) {
		$GenderEnt->{$id_entity} = $Gender->{$i};
	} else {
		$GenderEnt->{$id_entity} = $Gender->{$m};
    }
}


# Merge Entities 2
##################
sub MergeEntities {

    my ($new_id, $old_id, 
	  $Mentions, #<ref><hash><list><integer>
	  $Gender, #<ref><hash><string>
	  $FullNP, #<ref><hash><string>
	  $FullNPEnt, #<ref><hash><list><string>
	  $GenderEnt) = @_; #<ref><hash><string>

	my $Gender_tmp = ""; #<string>

	# Verifies the features of each mention
	# Choose the gender and number of the new entity
	if (($Gender->{$new_id} =~ /^M$/ && $Gender->{$old_id} !~ /^M$/) || ($Gender->{$old_id} =~ /^M$/ && $Gender->{$new_id} !~ /^M$/)) {
		$Gender_tmp = "M";
		$GenderEnt->{$new_id} = "M";
	} elsif (($Gender->{$new_id} =~ /^F$/ && $Gender->{$old_id} !~ /^F$/) || ($Gender->{$old_id} =~ /^F$/ && $Gender->{$new_id} !~ /^F$/)) {
		$Gender_tmp = "F";
		$GenderEnt->{$new_id} = "F";
	}

	# Every mention of the entities are merged (same entity id)
	foreach my $m(sort {$a <=> $b} keys %{$Mentions}) {
		if ($Mentions->{$m} != 0) {
			if ($Mentions->{$m} == $old_id) {
				$Mentions->{$m} = $new_id;

				# Merge features
				# Gender
				if ($Gender_tmp) {
					$Gender->{$m} = $Gender_tmp;
				}
				# In HeadsNP and FullNP: pop the NPs from the old_id?
				#####################################################
				# HeadsNP
				#if ($HeadNP{$m}) {
					#push(@{$HeadNPEnt{$new_id}}, $HeadNP{$m});
				#}
				# FullNP
				if ($FullNP->{$m}) {
					push(@{$FullNPEnt->{$new_id}}, $FullNP->{$m});
					#push(@{$FullNPEnt->{$new_id}}, $FullNP{$i}); # Check
				}
			}
		}
	}
	# Entity features
	$GenderEnt->{$new_id} = $Gender_tmp;
}
