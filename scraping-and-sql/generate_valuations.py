import json
from check_valuation import compute_valuation

"""write the SQL to add valuations for each player in the db"""


#given the valuation value, compute the number of stars
def get_stars(valuation):
    stars = 1 + int( valuation / 300 )
    if stars > 5:
        stars = 5
    if stars < 1:
        stars = 1
    return stars


def main():
    
    with open("playerdata.json", "r") as f:
        player_map = json.load(f)

    with open("update_valuations.sql", "w") as f:
        f.write("BEGIN;\n\n")

        for id, p in player_map.items():
            valuation = compute_valuation(p)
            stars = get_stars(valuation)
            line = f"UPDATE Player SET valuation = {valuation}, stars = {stars} WHERE playerID = {id};\n"
            
            f.write(line)

        f.write("COMMIT;\n")


if __name__ == "__main__":
    main()
