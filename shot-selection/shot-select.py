# Parameters that you can use to adjust.
pickteam = "SAS"
numberofgames = 10

# preamble
# from bs4 import BeautifulSoup as bs
import urlopen
import urllib
import re
import pandas as pd
import numpy as np
# import datetime
# import time
# from scipy.misc import imread

%matplotlib inline
from matplotlib.patches import Circle, Rectangle, Arc
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import seaborn as sb

# for the api part.
import requests
import base64
import configparser

# let's be secure and keep authorization details secret.
APIKEYS = configparser.ConfigParser()
APIKEYS.read('./APIKeys.ini');

# Get the keyname (client_id?) and actual API key.
usern = APIKEYS['mysportsfeeds']['usern']
passw = APIKEYS['mysportsfeeds']['passw']

team_url = "https://api.mysportsfeeds.com/v1.1/pull/nba/2017-2018-regular/team_gamelogs.json?team=" + pickteam
team_raw =  requests.get(url=team_url,
                         headers={"Authorization": "Basic " + 
                                  base64.b64encode('{}:{}'.format(usern,passw).encode('utf-8')).decode('ascii')})

# Just in case!
print(team_raw.status_code)

# Convert to JSON
team_js = team_raw.json()

# Now we have the schedule.
team_sked = pd.DataFrame(team_js['teamgamelogs']['gamelogs'])

# Loop over the games and get the correct ID (YYYYMMDD-AWAY-HOME)
for i in range(numberofgames):
    team_sked.loc[i,'away'] = team_sked['game'][i]['awayTeam']['Abbreviation']
    team_sked.loc[i,'home'] = team_sked['game'][i]['homeTeam']['Abbreviation']
    team_sked.loc[i,'gamedate'] = team_sked['game'][i]['date'].replace("-","")

team_sked = team_sked.assign(gameid = team_sked['gamedate'] + "-" + team_sked['away'] + "-" + team_sked['home'])
team_sked = team_sked.drop(['game','stats','team'], 1)
team_urls = team_sked.drop(['away','home','gamedate'], 1)
team_urls = team_sked.assign(gameURL = "https://api.mysportsfeeds.com/v1.1/pull/nba/2016-2017-regular/game_playbyplay.json?gameid=" + 
                             team_sked['gameid'] )