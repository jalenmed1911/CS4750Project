import json

"""
A python script to take json data from collegefootballdata.com and write a .sql file
that will load the data into a database given the json source.
"""

position_names = {"QB": "Quarterback", "RB": "Running_Back", "WR": "Wide_Receiver",
                  "LB": "Linebacker", "S": "Safety", "PK": "Kicker"}

stat_names = {"PCT": "percentage", "YDS": "yards", "TD": "touchdowns",
                  "INT": "interceptions", "CAR": "carries", "LONG": "longest",
                  "REC": "receptions", "SACKS": "sacks", "SOLO": "solo_tackles",
                  "TOT": "total_tackles", "TFL": "tackles_for_loss", "PD": "passes_defended",
                  "FGA": "fg_attempted", "FGM": "fg_made", "PTS": "points"}

stats_map = {
    "QB": {"PCT": float, "YDS": int, "TD": int, "INT": int},
    "RB": {"YDS": int, "CAR": int, "TD": int, "LONG": int},
    "WR": {"YDS": int, "REC": int, "TD": int, "LONG": int},
    "LB": {"SACKS": float, "SOLO": int, "TOT": int, "TFL": float},
    "S": {"SOLO": int, "TOT": int, "PD": int, "INT": int},
    "PK": {"FGA": int, "FGM": int, "LONG": int, "PTS": int}
}


def main():
    
    with open("playerdata.json", "r") as f:
        player_map = json.load(f)

    with open("insert_players.sql", "w") as f:
        f.write("BEGIN;\n\n")

        for id, p in player_map.items():
            line = (
                "INSERT INTO Player (playerID, name, position, hometown, valuation, stars) "
                f"VALUES ({int(id)}, "
                f"{sql_value(p.get('name'))}, "
                f"{sql_value(p.get('position'))}, "
                f"{sql_value(p.get('hometown'))}, "
                "0, 0);\n"
            )
            
            f.write(line)

            position_line = get_sql_for_position(id, p)
            f.write(position_line)

        f.write("COMMIT;\n")


def get_sql_for_position(id, player_dict):

    # given each player's position, create the appropriate SQl INSERT line for those stat types

    position_abbr = player_dict["position"]
    position_full = position_names[position_abbr]
    stats = []
    for stat_type, dtype in stats_map[position_abbr].items():
        stat_value = player_dict[stat_type]
        if dtype == int:
            stat_value = int(stat_value)
        elif dtype == float:
            stat_value = float(stat_value)
        stat_dict = {}
        stat_dict["stat_type"] = stat_names[stat_type]
        stat_dict["stat_value"] = stat_value
        stats.append(stat_dict)

    position_line = (
        f"INSERT INTO {position_full} (playerID, "
        f"{stats[0].get('stat_type')}, "
        f"{stats[1].get('stat_type')}, "
        f"{stats[2].get('stat_type')}, "
        f"{stats[3].get('stat_type')}) "
        f"VALUES ({int(id)}, "
        f"{stats[0].get('stat_value')}, "
        f"{stats[1].get('stat_value')}, "
        f"{stats[2].get('stat_value')}, "
        f"{stats[3].get('stat_value')});\n\n"
    )

    return position_line

def sql_value(val):
    if val is None:
        return "NULL"
    if isinstance(val, str):
        val = val.replace("'", "''")  # escape quotes
        return f"'{val}'"
    return str(val)


if __name__ == "__main__":
    main()