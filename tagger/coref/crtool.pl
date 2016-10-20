#!/usr/bin/perl

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

####################################################
#                                                  #
# CR Tool 0.3: Partial Coreference Resolution Tool #
#         with NER Correction Heuristics           #
#                                                  #
#              Author: Marcos Garcia               #
####################################################

# Insert the full path for working from another folder
my $path = "./tagger/coref";

# Number of mentions to look backwards for candidates
my $limit = $ARGV[1]; #1000;
if ($limit == 0) {
    $limit = 500;
}
#-----------------------------------------------
# Options:
# Output:
#   Coreference (default): -c
#   CR + NER Correction: -n
#-----------------------------------------------

# Global variables
#-----------------
# Mentions
my (%Mentions, %MentionsForm, %MentionsPos, %PosMentions, %MentionsSent, %MentionsTag, %IDs, %Gender);
my (%Lema, %Tag, %Head, %HeadNP, %FullNP, %FullNPLong, %NP, %MentionsPosE, $Pos_start, $Pos_end);
# Entities
my (%FullNPEnt, %HeadNPEnt, %GenderEnt, %Size, %TagEnt);
# Misc
my ($GenOK, $CompNP, $CompNP_toks, $DistanceSent);
my ($NP_i, $NP_m, $FullNP_m, $FullNP_i, @FullNP_m, $CompFN, $Constraint, $num_sentence, $num_mention);
# Others
my ($separador, $artigo, @Lines, $cont_linhas, $id_entity);
my %Linhas = ();
# Nouns
my (%PerNouns, %FemNames, %MaleNames, %TwLoc, %TwOrg);

## Loads the male/female nouns (now all of them)
open(FILE, "$path/lex/female_all_uniq.txt") or die ("Cannot open the female names file\n");
while (my $line = <FILE>) {
    chomp($line);
    my $cont_fem++;
    $FemNames{$line} = $cont_fem;
}
close(FILE);
#
open(FILE, "$path/lex/male_all_uniq.txt") or die ("Cannot open the male names file\n");
while (my $line = <FILE>) {
    chomp($line);
    my $cont_male++;
    $MaleNames{$line} = $cont_male;
}
close(FILE);
## Loads LOC and ORG trigger-words (for avoiding wrong clustering)
if ($opt_n == 1) {
    open(FILE, "$path/lex/twLOC.txt") or die ("Cannot open the twLOC.txt file\n");
    while (my $line = <FILE>) {
	chomp($line);
	my $cont_loc++;
	$TwLoc{$line} = $cont_loc;
    }
    close(FILE);
    
    open(FILE, "$path/lex/twORG.txt") or die ("Cannot open the twORG.txt file\n");
    while (my $line = <FILE>) {
	chomp($line);
	my $cont_org++;
	$TwOrg{$line} = $cont_org;
    }
    close(FILE);
}
#####################################################

sub coref {

    my ($opt_c, $opt_n, @text) = @_;
    my $cont_tok = 0;
    foreach my $l(@text) {
	chomp($l);
	$cont_linhas++;
	$cont_tok++;
	if ($l !~ /^ *$/) {
	    $l =~ s/^/$cont_tok /;
	}
	if ($l =~ /. . Fp$/) {
	    $cont_tok = 0;
	    $num_sentence++;
	    $Linhas{$cont_linhas} = $l;
	} elsif ($l =~ /^ *$/) {
	    $Linhas{$cont_linhas} = "";
	    $cont_tok = 0;
	    $num_sentence++;
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
    %Linhas = MentionIdentify_f(%Linhas);
    %Linhas = MentionExtract(%Linhas);
    
    # Check: if the previous modules have not found
    # any named entity in the text: finish.
    my $size_mentions = keys %Mentions;
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
	    my $i = $m - 1;
	    while ($i >= 1 && ($m-$i <= $limit)) {
		if (($MentionsPos{$m} != $MentionsPos{$i}) && ($m != $i)) {
		    if ($MentionsForm{$m} eq $MentionsForm{$i}) {
			if ($Tag{$i} eq $Tag{$m} || $opt_n == 1) {
			    my $new_tag = SelectTag($m, $i);
			    my $Mentions = Merge(\%Mentions, $m, $i);
			    %Mentions = %$Mentions;
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
	if ( ($m != 1) &&
	     ( ($Mentions{$m} != 0 && $Mentions{$m}[0] == $m) || ($Mentions{$m} == 0) ) ) {
	    my $i = $m - 1;
	    while ($i >= 1 && ($m-$i <= $limit)) {
		if (defined $Mentions{$i}) {
		    if ($Tag{$i} eq $Tag{$m} || $opt_n == 1) {
			my ($CompNP, $CompNPToks) = CompareNP($m, $i); 
			if ($CompNP == 1) {
			    if (CompareGN($m, $i) == 1 && CompareTags($m, $i) == 1) {
				my $new_tag = SelectTag($m, $i);
				my $Mentions = Merge(\%Mentions, $m, $i);
				%Mentions = %$Mentions;
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
	if ( ($m != 1) &&
	     ( ($Mentions{$m} != 0 && $Mentions{$m}[0] == $m) || ($Mentions{$m} == 0) ) ) {
	    my $i = $m - 1;
	    while ($i >= 1 && ($m-$i <= $limit)) {
		if (defined $Mentions{$i}) {
		    if ($Tag{$i} eq $Tag{$m} || $opt_n == 1) {
			my ($CompNP, $CompNPToks) = CompareNP($m, $i); 
			if ($CompNPToks == 1) {
			    if (CompareGN($m, $i) == 1 && CompareTags($m, $i) == 1) {
				my $new_tag = SelectTag($m, $i);
				my $Mentions = Merge(\%Mentions, $m, $i);
				%Mentions = %$Mentions;
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
	    $id_entity++;
	    $Mentions{$m} = $id_entity;
	    $TagEnt{$Mentions{$m}} = $Tag{$m};
	    $FullNPEnt{$Mentions{$m}}[0] = $MentionsForm{$m};
	}
    }
    
    $id_entity = 0;
    $num_sentence = 0;
    $num_mention = 0;
    
    # Get the longest NP of each entity
    ###################################
    foreach my $m(sort {$a <=> $b} keys %TagEnt) {
	#my $size = ();
	my $LongNP_m = ();
	my $LongNPsize_m = ();
	#my @size = ();
	my %Size = ();
	foreach my $f(@{$FullNPEnt{$m}}) {
	    if ($f =~ /_/) {
		my (@size) = split("_", $f);
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
	$FullNPLong{$m} = $LongNP_m;
    }
    
    # Hash modification for printing
    #-------------------------------    
    foreach my $m(sort {$a <=> $b} keys %Mentions) {
	my $id_e = $Mentions{$m};
	my $final_tag = $TagEnt{$id_e};
	my $final_lemma = $FullNPLong{$Mentions{$m}};	
	my ($ps, $tk, $lm, $tg, $cr) = split(" ", $Linhas{$MentionsPos{$m}});
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

   
#    # Hash printing
#    #--------------
#    foreach my $l(sort {$a <=> $b} keys %Linhas) {
#	if ($Linhas{$l} =~ /^[0-9]+ [^ ]+ [^ ]+ [A-Z]/) {
#	    $Linhas{$l} =~ s/^[0-9]+ //;
#	}
#	print "$Linhas{$l}\n";
#    }
#    print "\n";
    
    ####################################
    
    # Cleans the entity arrays
    foreach my $e(values %Mentions) {
	@$e = ();
    }
    
    $cont_linhas = 0;
    
    # Mentions
    %Mentions = ();
    %MentionsPos = ();
    %MentionsTag = ();
    %PosMentions = ();
    %MentionsForm = ();
    %Gender = ();
    %HeadNP = ();
    %FullNP = ();
    %Tag = ();
    %TagEnt = ();
    %IDs = ();		
    
    # Entities
    %GenderEnt = ();
    %FullNPEnt = ();
    %HeadNPEnt = ();

    # END
    return \%Linhas;
    %Linhas = ();
} 
####################################


# SUB
#####

# First Step: Mention Identification (basic)
############################################
sub MentionIdentify_f{

    my %Input = @_;

    foreach my $linha(sort {$a <=> $b} keys %Input) {
	my $prev = $linha - 1;

	if ($Input{$linha} =~ /^[0-9]/) {
	    my ($num_tok, $token, $lema, $tag) = split(" ", $Input{$linha});
	    # Tokens in lower-case
	    $token = "\L$token";

	    # Personal names
	    if ($tag =~ /^NP/) {
		$Input{$linha} =~ s/$/ (0)/;
	    }
	    #else {
	    #$Input{$linha} =~ s/$/ _/;
	    #}
	}
    }
    return %Input;
}


# Mention Extraction
####################
sub MentionExtract{

    my %Input = @_;
    my $cont_line = 0;
    
    foreach my $linha(sort {$a <=> $b} keys %Input) {
	$cont_line++;

	if ($Input{$linha} =~ /^[0-9]/) {
	    my ($num_tok, $token, $lema, $tag, $coref) = split(" ", $Input{$linha});
	    
	    # Tokens in lower-case
	    $token = "\L$token";

	    # Single mentions
	    if ($coref && $coref eq "(0)") {
		$num_mention++;
		$Mentions{$num_mention} = 0;
		$MentionsForm{$num_mention} = $token;
		$MentionsPos{$num_mention} = $cont_line;
		$MentionsSent{$num_mention} = $num_sentence;
		$MentionsTag{$num_mention} = $tag;
		$Tag{$num_mention} = $tag;
		$Lema{$num_mention} = $lema;
		$Head{$num_mention} = Head($token, $tag);
		#if ($token || $tag =~ /^NP00SP0/) {
		$FullNP{$num_mention} = $token;
		#$HeadNP{$num_mention} = $HeadNP;
		#}
		if ($tag eq "NP00SP0") {
		    $Gender{$num_mention} = ExtractFeats($linha, \%Input, $token); # ($Head{$num_mentions})
		}
	    }
	}
    }
    return %Input;
}



# Extracts the Head of a mention
# (single token / compound proper noun)
#######################################
sub Head{

    my ($token, $tag) = @_;

    my $HeadNP = ();
    my $NP = ();
    
    # Proper Noun
    #------------

    # Person
    if ($tag =~ /^NP00SP0/) {
	# Compound Proper Noun: 1st token
	if ($token =~ /_/) {
	    (my @toks) = split("_", $token);
	    if ($toks[1] =~ /^d.s?$/) {
		$HeadNP = $toks[1]
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
    my ($pos, $token) = @_;
    my $gender = ();

    if (defined $FemNames{$token}) {
	$gender = "F";
    } elsif (defined $MaleNames{$token}) {
	$gender = "M";
    }
#    else {
#	if ($Input{$pos-1} =~ /^[0-9]/) {
#	    if ($Input{$pos-1} =~ /(NCMS|AQ0MS|VMP00SM)/) {
#		$gender = "M";
#	    } elsif ($Input{$pos-1} =~ /(NCFS|AQ0FS|VMP00SF)/) {
#		$gender = "F";
#	    }
#	}
#    }
    return $gender;
}



# SelectTag (NE)
################
sub SelectTag {

    my ($m, $i) = @_;
    my %Count = ();
    my $Tag_m = ();
    my $Tag_i = ();
    my $count_m = 0;
    my $count_i = 0;
    my $final_tag = ();

    # Get tag from mention/entity
    # First (m)
    if ($Mentions{$m} == 0) {
	$Tag_m = $Tag{$m};
	$count_m = 1;
    } else {
	foreach my $e(@{$Mentions{$m}}) {
	    # Get the most frequent tag of the entity
	    if ($Tag{$e} eq "NP00SP0") {
		$Count{$Tag{$e}}++;
	    } elsif ($Tag{$e} eq "NP00O00") {
		$Count{$Tag{$e}}++;
	    } elsif ($Tag{$e} eq "NP00G00") {
		$Count{$Tag{$e}}++;
	    } elsif ($Tag{$e} eq "NP00V00") {
		$Count{$Tag{$e}}++;
	    }
	}
	my $first = 0;
	foreach my $n(sort {$Count{$b} <=> $Count{$a}} keys %Count ) {
	    if (!$first) {
		$Tag_m = $n;
		$count_m = $Count{$n};
	    }
	    $first = 1;
	}
    }

    # Second (i)
    if ($Mentions{$i} == 0) {
	$Tag_i = $Tag{$i};
	$count_i = 1;
    } else {
	foreach my $e (@{$Mentions{$i}}) {
	    # Get the most frequent tag of the entity	    
	    if ($Tag{$e} eq "NP00SP0") {
		$Count{$Tag{$e}}++;
	    } elsif ($Tag{$e} eq "NP00O00") {
		$Count{$Tag{$e}}++;
	    } elsif ($Tag{$e} eq "NP00G00") {
		$Count{$Tag{$e}}++;
	    } elsif ($Tag{$e} eq "NP00V00") {
		$Count{$Tag{$e}}++;
	    }
	}
	my $first = 0;
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
    if ($Mentions{$m} == 0 && $MentionsForm{$m} =~ /_/ && $MentionsForm{$i} !~ /_/) {
	$final_tag = $Tag_m;
    } elsif ($Mentions{$i} == 0 && $MentionsForm{$i} =~ /_/ && $MentionsForm{$m} !~ /_/) {
	$final_tag = $Tag_i;
    }
    #
    elsif ($count_m > $count_i) {
	$final_tag = $Tag_m;
    } elsif ($count_i > $count_m) {
	$final_tag = $Tag_i;
    } else {
	if ($TagEnt{$Mentions{$i}}) {
	    $final_tag = $TagEnt{$Mentions{$i}};
	} elsif ($TagEnt{$Mentions{$m}}) {
	    $final_tag = $TagEnt{$Mentions{$m}};
	} else {
	    if (length($MentionsForm{$m}) > length($MentionsForm{$i})) {
		$final_tag = $Tag_m;
	    } elsif (length($MentionsForm{$i}) > length($MentionsForm{$m})) {
		$final_tag = $Tag_i;
	    }
	    else {
		$final_tag = $Tag_i; #default
	    }
	}
    }
    return $final_tag;
}



# Merge Entities 1
##################
sub Merge {

    my ($Mentions, $m, $i) = @_;
    my %Mentions = %$Mentions;
    # New ID (both mentions without entity)
    if ($Mentions{$m} == 0 && $Mentions{$i} == 0) {
	$id_entity++;

	$Mentions{$m} = $id_entity;
	$Mentions{$i} = $id_entity;
	push(@$id_entity, $m);
	push(@$id_entity, $i);

	MergeGender($m, $i);

	push(@{$FullNPEnt{$id_entity}}, $FullNP{$m});
	push(@{$FullNPEnt{$id_entity}}, $FullNP{$i});
    } else {
	# One of them doesn't have entity
	if ($Mentions{$m} == 0) {
	    my $new_id = $Mentions{$i};
	    $Mentions{$m} = $new_id;
	    push(@$new_id, $m);

	    MergeGender($m, $i);
	    
	    push(@{$FullNPEnt{$new_id}}, $FullNP{$m});
	    push(@{$FullNPEnt{$new_id}}, $FullNP{$i});
	} elsif ($Mentions{$i} == 0) {
	    my $new_id = $Mentions{$m};
	    $Mentions{$i} = $new_id;
	    push(@$new_id, $i);

	    MergeGender($m, $i);

	    push(@{$FullNPEnt{$new_id}}, $FullNP{$m});
	    push(@{$FullNPEnt{$new_id}}, $FullNP{$i});    
	}
	# Both mentions have ID: chose the lower one
	else {
	    my $new_id = ();
	    my $old_id = ();
	    if ($Mentions{$m} > $Mentions{$i}) {
		$new_id = $Mentions{$i};
		$old_id = $Mentions{$m};
		$Mentions{$m} = $new_id;
	    } else {
		$new_id = $Mentions{$m};
		$old_id = $Mentions{$i};
		$Mentions{$i} = $new_id;
	    }
	    my $Mentions_tmp = MergeEntities($new_id, $old_id, \%Mentions);
	    %Mentions = %$Mentions_tmp;
	}
    }

    # Sort the mentions in the entity array
    # (Only the first is chosen in further modules)
    foreach my $e(sort {$a <=> $b} values %Mentions) {
	if ($e != 0) {
	    @$e = sort {$a <=> $b} (@$e);
	}
    }
    return \%Mentions;
}



# Compares Proper nouns: Full Name and Tokens
#############################################
sub CompareNP {

    my ($m, $i) = @_;

    my $CompNP = 0;
    my $FullNP_m = ();
    my $FullNP_i = ();
    my $NP_m = ();
    my $NP_i = ();
    my $CompNP_toks = 0;
    my $ToksNP_m = 0;
    my $ToksNP_i = 0;
    my $LongNPsize_m = 0;
    my $LongNPsize_i = 0;
    my $LongNP_m = ();
    my $LongNP_i = ();

    # Chooses the longest proper noun of each mention
    # (then compared with the FullNP in the entity, if any)
    if ($FullNP{$m}) {
	$NP_m = $FullNP{$m};
	if ($NP_m =~ "_") {
	    my (@NPs_m) = split("_", $NP_m);
	    $ToksNP_m = $#NPs_m + 1;
	} else {
	    $ToksNP_m = 1;
	}
    } else {
	$ToksNP_m = 0;
	$NP_m = ();
    }
    if ($FullNP{$i}) {
	$NP_i = $FullNP{$i};
	if ($NP_i =~ "_") {
	    my (@NPs_i) = split("_", $NP_i);
	    $ToksNP_i = $#NPs_i + 1;
	} else {
	    $ToksNP_i = 1;
	}
    } else {
	$ToksNP_i = 0;
	$NP_i = ();
    }

    # Longest proper noun of the first entity
    if ($FullNPEnt{$Mentions{$m}}) {
	my %size = ();
	foreach my $f(@{$FullNPEnt{$Mentions{$m}}}) {
	    if ($f =~ /_/) {
		my (@size) = split("_", $f);
		$size{$f} = $#size + 1;
		my $first = 0;
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
    my $Comp_m = ();
    my $size_m = 0;
    if ($NP_m && ($ToksNP_m >= $LongNPsize_m)) {
	$Comp_m = $NP_m;
	$size_m = $ToksNP_m;
    } else {
	$Comp_m = $FullNP_m;
	$size_m = $LongNPsize_m;
    }

    # Longest proper noun of the second entity
    if ($FullNPEnt{$Mentions{$i}}) {
	my %size = ();
	foreach my $f(@{$FullNPEnt{$Mentions{$i}}}) {
	    if ($f =~ /_/) {
		my (@size) = split("_", $f);
		$size{$f} = $#size + 1;
		my $first = 0;
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
    my $Comp_i = ();
    my $size_i = 0;

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
    }
    elsif ($Comp_m =~ /(^|_|-)$Comp_i/ || $Comp_i =~ /(^|_|-)$Comp_m/ && $size_m != $size_i) {
	unless ( ($Comp_m =~ /(^|_)jr./ && $Comp_i !~ /(^|_)jr./) ||
		 ($Comp_m !~ /(^|_)jr./ && $Comp_i =~ /(^|_)jr./) ){
	    $CompNP = 1;
	}
    }
    
    #(previous)
    #    if ($Comp_m =~ /(^|_|-)$Comp_i/ || $Comp_i =~ /(^|_|-)$Comp_m/) {
    #	unless ( ($Comp_m =~ /(^|_)jr./ && $Comp_i !~ /(^|_)jr./) ||
    #		 ($Comp_m !~ /(^|_)jr./ && $Comp_i =~ /(^|_)jr./) ){
    #	    $CompNP = 1;
    #	}
    #    }
    #}
    # Token comparison (same order)
    else {
	my $Comp_a = ();
	my $Comp_b = ();
	my $size_a = ();
	my $size_b = ();
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
	
	my (@Toks_m) = split("_", $Comp_a);
	my (@Toks_i) = split("_", $Comp_b);
	
	my $found = 0;
	my $all = 0;
	my $ci = 0;
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

    my ($m, $i) = @_;
    
    $GenOK = 0;
    my $Gen_m = ();
    my $Gen_i = ();

    if ($Mentions{$m} == 0) {
	$Gen_m = $Gender{$m};
    } else {
	$Gen_m = $GenderEnt{$Mentions{$m}};
    }
    if ($Mentions{$i} == 0) {
	$Gen_i = $Gender{$i};
    } else {
	$Gen_i = $GenderEnt{$Mentions{$i}};
    }

    # Only blocks different (M/F) genders
    if ( ($Gen_m eq "F" && $Gen_i eq "M") ||
	 ($Gen_m eq "M" && $Gen_i eq "F") ) {
	$GenOK = 0;
    } else {
	$GenOK = 1;
    }
    return $GenOK;
}


# CompareTags (NE)
##################
sub CompareTags {

    my ($m, $i) = @_;
    my $TagOK = 0;

    if ( ($Tag{$m} eq "NP00G00" && $Tag{$i} eq "NP00O00") ||
	 ($Tag{$m} eq "NP00O00" && $Tag{$i} eq "NP00G00") ) {
	$TagOK = 0;
    } else {
	my $m_head = $MentionsForm{$m};
	my $i_head = $MentionsForm{$i};
	if ($MentionsForm{$m} =~ /_/) {
	    my (@mtoks) = split("_", $MentionsForm{$m});
	    $m_head = $mtoks[0];
	}
	if ($MentionsForm{$i} =~ /_/) {
	    my (@itoks) = split("_", $MentionsForm{$i});
	    $i_head = $itoks[0];
	}
	
	# ORG vs other tag
	if ((defined $TwOrg{$m_head} && $Tag{$i} ne "NP00O00") ||
	    (defined $TwOrg{$i_head} && $Tag{$m} ne "NP00O00")
	    ) {
	    $TagOK = 0;
	}
	# LOC vs other tag
	elsif ((defined $TwLoc{$m_head} && $Tag{$i} ne "NP00G00") ||
	       (defined $TwLoc{$i_head} && $Tag{$m} ne "NP00G00")
	    ) {
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

    my ($m, $i) = @_;
    
    if ($Gender{$i} =~ /^(F|M)/ && $Gender{$m} !~ /^(F|M)/) {
	$GenderEnt{$id_entity} = $Gender{$i};
    } else {
	$GenderEnt{$id_entity} = $Gender{$m};
    }
}



# Merge Entities 2
##################
sub MergeEntities {

    my ($new_id, $old_id, $Mentions) = @_;
    my %Mentions = %$Mentions;
    my $Gender_tmp = ();

    # Verifies the features of each mention
    # Choose the gender and number of the new entity
    if (($Gender{$new_id} =~ /^M$/ && $Gender{$old_id} !~ /^M$/) || ($Gender{$old_id} =~ /^M$/ && $Gender{$new_id} !~ /^M$/)) {
	$Gender_tmp = "M";
	$GenderEnt{$new_id} = "M";
    } elsif (($Gender{$new_id} =~ /^F$/ && $Gender{$old_id} !~ /^F$/) || ($Gender{$old_id} =~ /^F$/ && $Gender{$new_id} !~ /^F$/)) {
	$Gender_tmp = "F";
	$GenderEnt{$new_id} = "F";
    }

    # Every mention of the entities are merged (same entity id)
    foreach my $m(sort {$a <=> $b} keys %Mentions) {
	if ($Mentions{$m} != 0) {
	    if ($Mentions{$m} == $old_id) {
		$Mentions{$m} = $new_id;

		# Merge features
		# Gender
		if ($Gender_tmp) {
		    $Gender{$m} = $Gender_tmp;
		}
		# In HeadsNP and FullNP: pop the NPs from the old_id?
		#####################################################
		# HeadsNP
		if ($HeadNP{$m}) {
		    push(@{$HeadNPEnt{$new_id}}, $HeadNP{$m});
		}
		# FullNP
		if ($FullNP{$m}) {
		    push(@{$FullNPEnt{$new_id}}, $FullNP{$m});
		    #push(@{$FullNPEnt{$new_id}}, $FullNP{$i}); # Check
		}
	    }
	}
    }
    # Entity features
    $GenderEnt{$new_id} = $Gender_tmp;
    return \%Mentions;
}
