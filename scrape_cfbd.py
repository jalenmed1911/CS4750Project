import cfbd
import json

"""
A python script to scrape from collegefootballdata.com and save the data locally in json format.
Uses the cfbd module available from github.
"""


# will be easiest to manually add coaches and teams (just need names and descriptions for each)

allowed_positions = {"QB", "RB", "WR", "LB", "S", "PK"}

# demarcate which of the many stats in cfbd we're using:
selected_stats = {
    "QB": {("passing", "PCT"), ("passing", "YDS"), ("passing", "TD"), ("passing", "INT")},
    "RB": {("rushing", "YDS"), ("rushing", "CAR"), ("rushing", "TD"), ("rushing", "LONG")},
    "WR": {("receiving", "YDS"), ("receiving", "REC"), ("receiving", "TD"), ("receiving", "LONG")},
    "LB": {("defensive", "SACKS"), ("defensive", "SOLO"), ("defensive", "TOT"), ("defensive", "TFL")},
    "S": {("defensive", "SOLO"), ("defensive", "TOT"), ("defensive", "PD"), ("defensive", "INT")},
    "PK": {("kicking", "FGA"), ("kicking", "FGM"), ("kicking", "LONG"), ("kicking", "PTS")}
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

        #get stats and players for all players in the acc
        stats_api = cfbd.StatsApi(api_client)
        api_response = stats_api.get_player_season_stats(2025, conference="acc")

        player_map = {}
        for player_stat in api_response:
            if player_stat.position in allowed_positions:
                if is_selected_stat(player_stat):
                    id = player_stat.player_id

                    if id in player_map.keys():
                        #player has existing player_map entry
                        player_map[id][player_stat.stat_type] = player_stat.stat
                    else:
                        #new player
                        new_player_dict = {}
                        new_player_dict["name"] = player_stat.player
                        new_player_dict["position"] = player_stat.position
                        new_player_dict["team"] = player_stat.team
                        new_player_dict[player_stat.stat_type] = player_stat.stat
                        player_map[id] = new_player_dict


        #not all safeties have ints. Add field with zero if that stat is absent
        for p in player_map.values():
            if p["position"] == "S" and "INT" not in p.keys():
                p["INT"] = "0"

        #now add hometown for each player
        players_api = cfbd.PlayersApi(api_client)
        
        for player_dict in player_map.values():
            api_response = players_api.search_players(player_dict.get("name"))
            for response in api_response:
                player_dict["hometown"] = response.hometown
        
        with open("playerdata.json", "w") as f:
            json.dump(player_map, f, indent=2)


def is_selected_stat(stat):
    if (stat.category, stat.stat_type) in selected_stats[stat.position]:
        return True
    else:
        return False


if __name__ == "__main__":
    main()