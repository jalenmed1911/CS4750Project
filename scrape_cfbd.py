import cfbd
import json
from cfbd.rest import ApiException

"""
A python script to scrape from collegefootballdata.com and save the data locally.
Uses the cfbd module available from github.
"""


params = {
    "conference": "acc",
    "year": 2025
    # will also need to filter to our six positions: QB, RB, WR, LB, S, K
}

suburls = {
    "players/usage", #for lists of all players on a given team: 'id', 'name', 'position'
    "stats/player/season", #for lists of stats relating to players in the given season
    "players/search" #for player 'hometown', use 'name' to search and 'id' to filter search results
}

# will be easiest to manually add coaches and teams (just need names and descriptions for each)

allowed_positions = {"QB", "RB", "WR", "LB", "S", "K"}


# Defining the host is optional and defaults to https://api.collegefootballdata.com
# See configuration.py for a list of all supported configuration parameters.
configuration = cfbd.Configuration(
    host = "https://api.collegefootballdata.com"
)

# The client must configure the authentication and authorization parameters
# in accordance with the API server security policy.
# Examples for each auth method are provided below, use the example that
# satisfies your auth use case.

# Configure Bearer authorization: apiKey
configuration = cfbd.Configuration(
    access_token = "Gl66ANUF8zNrf/3cvBMwigZ2xq88ZVkFdQCU8ak87tpS/yyjtag84JrIQFL06lqQ"
)

# Enter a context with an instance of the API client
with cfbd.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = cfbd.PlayersApi(api_client)
"""
    # get all acc players
    api_response = api_instance.get_player_usage(year=2025, conference='acc')
    print(len(api_response))

    #filter to just have the six positions
    filtered_players = [
        p for p in api_response
        if getattr(p, "position", None) in allowed_positions
    ]
    
    # save to dicts
    player_dicts = []

    for p in filtered_players:
        player_dicts.append({
            "id": p.id,
            "name": p.name,
            "position": p.position
        })
    
    #now add hometown for each player


    for p in player_dicts:
        api_response = api_instance.search_players(p.get("name"))
        for response in api_response:
            p["hometown"] = response.hometown

    with open("filtered_players.json", "w") as f:
        json.dump(player_dicts, f, indent=2)
"""
