#!usr/bin/perl -w

#use strict;

# game2.plx for LA Kings
# written for ESPN "shotXMLbuilder" but I am too dumb to figure out how to do this in
# fewer than two steps.

my $write_path = 'game2008.txt';

open INFILE, "game2.txt" or die $!;
open OUTFILE, " > $write_path" or die $!;
select OUTFILE;

$startcounting = 0;

#let's put headers at the top...
print "Game Number/Goal \t Shooter ID \t x coord \t y coord \t period \t time \t picture \t Shooter Name | Position \t Assist? \t Strength \t Length \t Shot Type \t Event Type \n";
# STRENGTH:   701: Even  702: Power Play  703: Shorthanded  902: Penalty Shot 903: Empty Net
# SHOT TYPE:  801: Slap  802: Snap 803: Wrist 804: Wraparound 805: Tip-in 806: Backhand  807: Deflection
# EVENT TYPE: 505: Goal 506: Shot

while (<INFILE>)
{
	#let's get the information about the game at the top
	if ($_ =~ m/^<gamenumber>/)
	{
	$startcounting = 1;
	}
	
	#each shot starts with a "shot" tag.  also "goals"
	if ($_ =~ m/^<shot>/ | $_ =~ m/^<goal>/)
	# BEGIN 2
	{
	$startcounting = 1;
		# keep track which are shots and which are goals
		if ($_ =~ m/^<shot>/)
		{
		push @shotline, "0";
		push @shotline, "\t";
		}
		if ($_ =~ m/^<goal>/)
		{
		push @shotline, "1";
		push @shotline, "\t";
		}
	}

#	if ($_ =~ m/^<gamenumber>)
	#END 2

	#if we are within a shot tag, let's get rid of the tags
	if ($startcounting && $_ !~ m/^</)
	{
	chomp;
	push @shotline, $_;
	push @shotline, "\t";
	}

	# let's find the </shot> tag (or the </goal> tag
	if (/<\/shot>/ | /<\/goal>/)
	{
	print "@shotline \n";
	$startcounting = 0;
	$#shotline = -1;
	}

	#PERL seems to be a little too picky
	if (/<\/gamenumber>/)
	{
	chomp @shotline;
	chomp @shotline;
	print "@shotline \n";
	$startcounting = 0;
	$#shotline = -1;
	}
}
