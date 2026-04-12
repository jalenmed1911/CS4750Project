import json
from check_valuation import compute_valuation

"""write the SQL to add valuations for each player in the db"""


def main():
    
    with open("playerdata.json", "r") as f:
        player_map = json.load(f)

    with open("update_valuations.sql", "w") as f:
        f.write("BEGIN;\n\n")

        for id, p in player_map.items():
            valuation = compute_valuation(p)
            line = f"UPDATE Player SET valuation = {valuation} WHERE playerID = {id};\n"
            
            f.write(line)

        f.write("COMMIT;\n")


if __name__ == "__main__":
    main()
