import json
import statistics
import matplotlib.pyplot as plt

def compute_valuation(player_dict):
    #sum up the four stats for each player based on their position
    #returns a valuation value, an int

    position = player_dict["position"]


    if position == "QB":
        valuation = (
            to_int(player_dict.get("YDS"))
            + 400 * to_int(player_dict.get("PCT"))
            + 40 * to_int(player_dict.get("TD"))
            - 40 * to_int(player_dict.get("INT"))
        )
        return int(valuation)

    elif position == "RB":
        valuation = (
            to_int(player_dict.get("YDS"))
            + 5 * to_int(player_dict.get("CAR"))
            + 40 * to_int(player_dict.get("TD"))
            + 10 * to_int(player_dict.get("LONG"))
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
            30 * to_int(player_dict.get("SACKS"))
            + 10 * to_int(player_dict.get("SOLO"))
            + 5 * to_int(player_dict.get("TOT"))
            + 20 * to_int(player_dict.get("TFL"))
        )
        return valuation        

    elif position == "S":
        valuation = (
            10 * to_int(player_dict.get("SOLO"))
            + 5 * to_int(player_dict.get("TOT"))
            + 40 * to_int(player_dict.get("INT"))
            + 10 * to_int(player_dict.get("PD"))
        )
        return valuation

    elif position == "PK":
        valuation = (
            5 * to_int(player_dict.get("FGA"))
            + 20 * to_int(player_dict.get("FGM"))
            + 20 * to_int(player_dict.get("LONG"))
            + 10 * to_int(player_dict.get("PTS"))
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
                "min": min(values),
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