import json

"""
A python script to take json data for players-teams from generate_sql.py
and write a .sql file that will load the data into a database.
"""

teams = {
    "Clemson": 1,
    "Duke": 2,
    "North Carolina": 3,
    "NC State": 4,
    "Wake Forest": 5,
    "Virginia": 6,
    "Georgia Tech": 7,
    "Florida State": 8,
    "Miami": 9,
    "Virginia Tech": 10,
    "Boston College": 11,
    "Pittsburgh": 12,
    "Syracuse": 13,
    "Notre Dame": 14,
    "Louisville": 15,
    "SMU": 16,
    "California": 17,
    "Stanford": 18
}


def main():
    
    with open("playerdata.json", "r") as f:
        player_map = json.load(f)

    with open("insert_teams.sql", "w") as f:
        f.write("BEGIN;\n\n")

        for id, p in player_map.items():
            team_id = teams[p.get("team")]
            line = (
                "INSERT INTO Plays_For (playerID, teamID) "
                f"VALUES ({int(id)}, "
                f"{int(team_id)}"
                ");\n"
            )
            
            f.write(line)

        f.write("COMMIT;\n")


if __name__ == "__main__":
    main()