import cfbd
import json

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

# demarcate which of the many stats in cfbd we're using:
selected_stats = {
    "QB": {("passing", "PCT"), ("passing", "YDS"), ("passing", "TD"), ("passing", "INT")},
    "RB": {("rushing", "YDS"), ("rushing", "CAR"), ("rushing", "TD"), ("receiving", "REC")},
    "WR": {("receiving", "YDS"), ("receiving", "REC"), ("receiving", "TD"), ("receiving", "LONG")},
    "LB": {("defensive", "SACKS"), ("defensive", "SOLO"), ("defensive", "TOT"), ("defensive", "TFL")},
    "S": {("defensive", "SOLO"), ("defensive", "TOT"), ("defensive", "PD"), ("defensive", "INT")},
    "K": {("kicking", "FGA"), ("kicking", "FGM"), ("kicking", "LONG"), ("kicking", "PTS")}
}


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


def main():

    # Enter a context with an instance of the API client
    with cfbd.ApiClient(configuration) as api_client:
        # Create an instance of the API class
        api_instance = cfbd.PlayersApi(api_client)


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

        api_instance = cfbd.StatsApi(api_client)
        api_response = api_instance.get_player_season_stats(2025, conference="acc")

        player_map = {p["id"]: p for p in player_dicts}

        for player_stat in api_response:
            if player_stat.player_id in player_map.keys():
                print(player_stat.stat_type)
                position = player_map.get(player_stat.player_id, {}).get("position")
                if is_selected_stat(position, player_stat):
                    player_dict = player_map.get(player_stat.player_id)
                    player_dict[player_stat.stat_type] = player_stat.stat
        
        with open("player_map.json", "w") as f:
            json.dump(player_map, f, indent=2)


def is_selected_stat(position, stat):
    if (stat.category, stat.stat_type) in selected_stats[position]:
        return True
    else:
        return False


if __name__ == "__main__":
    main()