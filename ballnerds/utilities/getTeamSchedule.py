'''
Gets the team's schedule using the mysportsfeeds API.
'''

import requests
import json
import pandas as pd

def getTeamSchedule(pickteam, numberofgames):
    
    team_url = "https://api.mysportsfeeds.com/v1.1/pull/nba/2017-2018-regular/team_gamelogs.json?team=" + pickteam
    team_raw =  requests.get(url=team_url,
                             headers={"Authorization": "Basic " + 
                                      base64.b64encode('{}:{}'.format(usern,passw).encode('utf-8')).decode('ascii')})

    # Just in case!
    print("URL API status: " + str(team_raw.status_code))

    # Convert to JSON
    team_js = team_raw.json()

    # Now we have the schedule.
    team_sked_raw = pd.DataFrame(team_js['teamgamelogs']['gamelogs'])
    team_sked = pd.DataFrame(columns=['away','home','gamedate'])


    # team_sked_raw.loc[:,'game']
    # Loop over the games and get the correct ID (YYYYMMDD-AWAY-HOME)
    for i in range(numberofgames):
        team_sked.loc[i,:] =  [team_sked_raw.loc[i,'game']['awayTeam']['Abbreviation'],   
                               team_sked_raw.loc[i,'game']['homeTeam']['Abbreviation'], 
                               team_sked_raw.loc[i,'game']['date'].replace("-","")]

    team_sked = team_sked.assign(gameid = team_sked['gamedate'] + "-" + team_sked['away'] + "-" + team_sked['home'])
    # team_sked = team_sked.drop(['game','stats','team'], 1)
    team_urls = team_sked.drop(['away','home','gamedate'], 1)
    team_urls = team_urls.assign(gameURL = "https://api.mysportsfeeds.com/v1.1/pull/nba/2017-2018-regular/game_playbyplay.json?gameid=" + 
                                 team_sked['gameid'] )
#     return team_js
    return team_urls