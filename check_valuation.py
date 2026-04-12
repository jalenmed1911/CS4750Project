import json
import statistics
import matplotlib.pyplot as plt

"""Using the rough valuation results from compute_rough_valuation.py,
   this file checks the final valuation functions (which are scaled
   to be comparable across positions)"""


def compute_valuation(player_dict):
    #sum up the four stats for each player based on their position
    #returns a valuation value, an int

    position = player_dict["position"]


    if position == "QB":
        valuation = (
            0.656 * to_int(player_dict.get("YDS"))
            + 262 * to_int(player_dict.get("PCT"))
            + 26 * to_int(player_dict.get("TD"))
            - 26 * to_int(player_dict.get("INT"))
        )
        return int(valuation)

    elif position == "RB":
        valuation = (
            to_int(player_dict.get("YDS"))
            + 4 * to_int(player_dict.get("CAR"))
            + 35 * to_int(player_dict.get("TD"))
            + 9 * to_int(player_dict.get("LONG"))
        )
        return valuation

    elif position == "WR":
        valuation = (
            to_int(player_dict.get("YDS"))
            + 5 * to_int(player_dict.get("REC"))
            + 40 * to_int(player_dict.get("TD"))
            + 10 * to_int(player_dict.get("LONG"))
        )
        return valuation

    elif position == "LB":
        valuation = (
            73 * to_int(player_dict.get("SACKS"))
            + 24 * to_int(player_dict.get("SOLO"))
            + 12 * to_int(player_dict.get("TOT"))
            + 48 * to_int(player_dict.get("TFL"))
        )
        return valuation        

    elif position == "S":
        valuation = (
            30 * to_int(player_dict.get("SOLO"))
            + 15 * to_int(player_dict.get("TOT"))
            + 119 * to_int(player_dict.get("INT"))
            + 30 * to_int(player_dict.get("PD"))
        )
        return valuation

    elif position == "PK":
        valuation = (
            3 * to_int(player_dict.get("FGA"))
            + 10 * to_int(player_dict.get("FGM"))
            + 10 * to_int(player_dict.get("LONG"))
            + 5 * to_int(player_dict.get("PTS"))
        )
        return valuation

    return 0


def to_int(value):
    try:
        return int(float(value))
    except:
        return 0


def main():

    with open("playerdata.json", "r") as f:
        player_map = json.load(f)

    results_dict = {
        "QB": [],
        "RB": [],
        "WR": [],
        "LB": [],
        "S": [],
        "PK": []
    }

    # calculate valuation for each player and place in a list for that position
    for id, p in player_map.items():
        position = p.get("position")
        valuation = compute_valuation(p)

        results_dict[position].append(valuation)

    # compute summary stats
    summary = {}

    for position, values in results_dict.items():
        if len(values) > 0:
            summary[position] = {
                "mean": statistics.mean(values),
                "median": statistics.median(values),
                "stdev": statistics.stdev(values),
                "max": max(values)
            }

    # print results
    for pos, stats in summary.items():
        print(f"{pos}: {stats}")

    # bar graph of means
    positions = list(summary.keys())
    means = [summary[pos]["mean"] for pos in positions]

    plt.figure()
    plt.bar(positions, means)
    plt.xlabel("Position")
    plt.ylabel("Mean Valuation")
    plt.title("Mean Player Value by Position")
    plt.show()


if __name__ == "__main__":
    main()