#!usr/bin/perl -w

# game1.plx for LA Kings
# written for ESPN "shotXMLbuilder"

$gameno = 290421025;

$url = "http://sports.espn.go.com/nhl/shotchart/shotXMLbuilder?gameId=$gameno";
$write_path = 'game2.txt';

use LWP::Simple;
@page = get($url);


open INFILE, "game1.txt" or die $!;
open OUTFILE, " > $write_path" or die $!;
select OUTFILE;

# help out the next file by including the game information
#$year = substr $gameno, 0, 2;
#$month = substr $gameno, 2, 2;
#$day	= substr $gameno, 4, 2;
#$home = substr $gameno, 6, 2;

@teams = ("Boston", "Buffalo", "Calgary" ,"Chicago", "Detroit", "Edmonton", "Carolina", "Los Angeles",
		"Dallas", "Montreal", "New Jersey", "New York Islanders", "New York Rangers", "Ottawa",
		"Philadelphia", "Pittsburgh", "Colorado", "San Jose", "St. Louis", "Tampa Bay", "Carolina", "Vancouver", 
		"Washington", "Phoenix", "Anaheim", "Florida", "Nashville", "Atlanta", "Columbus", "Minnesota");


#print "<gamenumber>\n$gameno\n</gamenumber>";

while (<INFILE>)
{
	# this file just adds lines between the tags	
	$liner = $_;
	$liner =~ s/>/> \n/g;
	$liner =~ s/<\// \n<\//g;

	print "$liner \n";		
}

