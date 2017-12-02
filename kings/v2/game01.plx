#!usr/bin/perl -w

# game1.plx for LA Kings
# written for ESPN "shotXMLbuilder"

$gameno = 290421001;
$gameno = 290922015;

$url = "http://sports.espn.go.com/nhl/shotchart/shotXMLbuilder?gameId=$gameno";
$write_path = 'game1.txt';

use LWP::Simple;
@page = get($url);

open OUTFILE, " > $write_path" or die $!;
select OUTFILE;

# help out the next file by including the game information
#$year = substr $gameno, 0, 2;
#$month = substr $gameno, 2, 2;
#$day	= substr $gameno, 4, 2;
#$home = substr $gameno, 6, 2;

#@teams = ("Boston", "Buffalo", "Calgary" ,"Chicago", "Detroit", "Edmonton", "Carolina", "Los Angeles",
#		"Dallas", "Montreal", "New Jersey", "New York Islanders", "New York Rangers", "Ottawa",
#		"Philadelphia", "Pittsburgh", "Colorado", "San Jose", "St. Louis", "Tampa Bay", "Carolina", "Vancouver", 
#		"Washington", "Phoenix", "Anaheim", "Florida", "Nashville", "Atlanta", "Columbus", "Minnesota");
#
# 001 Boston		002 Buffalo		003 Calgary		004 Chicago
# 005 Detroit		006 Edmonton		007 Carolina		008 Los Angeles
# 009 Dallas		010 Montreal		011 New Jersey	012 New York I
# 013 New York R	014 Ottawa		015 Philly		016 Pittsburgh
# 017 Colorado	018 San Jose		019 St. Louis		020 Tampa Bay
# 021 Carolina	022 Vancouver		023 Washington	024 Phoenix
# 025 Anaheim		026 Florida		027 Nashville		028 Atlanta
# 029 Columbus	030 Minnesota
#

for ($ho = 8; $ho <= 8; $ho++)
{
	for ($ye = 29; $ye <= 29; $ye++)
	{
		for ($mo = 9; $mo <= 12; $mo++)
		{ 
			if ($mo < 10 && length $mo < 2)
			{
			$mo = "0" . $mo;
			}
			for ($da = 1; $da <= 31; $da++)
			{
				if ($da < 10 && length $da < 2)
				{
				$da = "0" . $da;
				}
			$gameno = $ye . $mo . $da . "00" . $ho;
			$url = "http://sports.espn.go.com/nhl/shotchart/shotXMLbuilder?gameId=$gameno";
			@page = get($url);
			print "<gamenumber>$gameno</gamenumber>";
			print @page;

=pod;
while (<@page>)
{	
	# this file just adds lines between the tags	
	$liner = $_;
	$liner =~ s/>/> \n/g;
	$liner =~ s/<\// \n<\//g;

	print "$liner \n";		
}
=cut;
			}
		}
	}
}