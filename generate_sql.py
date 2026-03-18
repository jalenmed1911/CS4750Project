import json

"""
A python script to take json data from collegefootballdata.com and write a .sql file
that will load the data into a database given the json source.
"""


stats_map = {
    "QB": {"PCT", "YDS", "TD", "INT"},
    "RB": {"YDS", "CAR", "TD", "LONG"},
    "WR": {"YDS", "REC", "TD", "LONG"},
    "LB": {"SACKS", "SOLO", "TOT", "TFL"},
    "S": {"SOLO", "TOT", "PD", "INT"},
    "PK": {"FGA", "FGM", "LONG", "PTS"}
}



def main():
    
    with open("player_map.json", "r") as f:
        player_map = json.load(f)







if __name__ == "__main__":
    main()