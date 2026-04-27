import importlib
import sys
import types
import unittest
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))


def _stub_matplotlib():
    """Allow importing valuation modules without external dependency."""
    matplotlib = types.ModuleType("matplotlib")
    pyplot = types.ModuleType("pyplot")
    pyplot.figure = lambda *args, **kwargs: None
    pyplot.bar = lambda *args, **kwargs: None
    pyplot.xlabel = lambda *args, **kwargs: None
    pyplot.ylabel = lambda *args, **kwargs: None
    pyplot.title = lambda *args, **kwargs: None
    pyplot.show = lambda *args, **kwargs: None
    matplotlib.pyplot = pyplot
    sys.modules["matplotlib"] = matplotlib
    sys.modules["matplotlib.pyplot"] = pyplot


_stub_matplotlib()

check_valuation = importlib.import_module("check_valuation")
compute_rough_valuation = importlib.import_module("compute_rough_valuation")
generate_valuations = importlib.import_module("generate_valuations")


class ValuationClampTests(unittest.TestCase):
    def test_qb_clamped_at_zero_when_penalty_dominates(self):
        qb = {"position": "QB", "YDS": 0, "PCT": 0, "TD": 0, "INT": 999}
        self.assertEqual(check_valuation.compute_valuation(qb), 0)
        self.assertEqual(compute_rough_valuation.compute_valuation(qb), 0)

    def test_all_positions_return_non_negative(self):
        players = [
            {"position": "QB", "YDS": 10, "PCT": 20, "TD": 0, "INT": 999},
            {"position": "RB", "YDS": 1, "CAR": 1, "TD": 0, "LONG": 0},
            {"position": "WR", "YDS": 1, "REC": 1, "TD": 0, "LONG": 0},
            {"position": "LB", "SACKS": 0, "SOLO": 0, "TOT": 0, "TFL": 0},
            {"position": "S", "SOLO": 0, "TOT": 0, "INT": 0, "PD": 0},
            {"position": "PK", "FGA": 0, "FGM": 0, "LONG": 0, "PTS": 0},
        ]
        for player in players:
            with self.subTest(position=player["position"]):
                self.assertGreaterEqual(check_valuation.compute_valuation(player), 0)
                self.assertGreaterEqual(compute_rough_valuation.compute_valuation(player), 0)

    def test_unknown_position_defaults_to_zero(self):
        self.assertEqual(check_valuation.compute_valuation({"position": "TE"}), 0)
        self.assertEqual(compute_rough_valuation.compute_valuation({"position": "TE"}), 0)


class TriggerGuardTests(unittest.TestCase):
    def test_all_trigger_valuations_are_clamped(self):
        trigger_sql = (PROJECT_ROOT / "scraping-and-sql/add_triggers.sql").read_text()
        self.assertNotIn("SET @valuation = FLOOR(", trigger_sql)
        self.assertEqual(trigger_sql.count("SET @valuation = GREATEST(0, FLOOR("), 12)


class FormulaCorrectnessTests(unittest.TestCase):
    def test_final_formula_outputs_match_expected_values(self):
        cases = [
            (
                "QB",
                {"position": "QB", "YDS": 300, "PCT": 50, "TD": 2, "INT": 1},
                int(0.656 * 300 + 262 * 50 + 26 * 2 - 26 * 1),
            ),
            (
                "RB",
                {"position": "RB", "YDS": 120, "CAR": 20, "TD": 1, "LONG": 30},
                120 + 4 * 20 + 35 * 1 + 9 * 30,
            ),
            (
                "WR",
                {"position": "WR", "YDS": 140, "REC": 8, "TD": 1, "LONG": 35},
                140 + 5 * 8 + 40 * 1 + 10 * 35,
            ),
            (
                "LB",
                {"position": "LB", "SACKS": 2, "SOLO": 5, "TOT": 8, "TFL": 3},
                73 * 2 + 24 * 5 + 12 * 8 + 48 * 3,
            ),
            (
                "S",
                {"position": "S", "SOLO": 6, "TOT": 10, "INT": 1, "PD": 4},
                30 * 6 + 15 * 10 + 119 * 1 + 30 * 4,
            ),
            (
                "PK",
                {"position": "PK", "FGA": 3, "FGM": 2, "LONG": 45, "PTS": 9},
                3 * 3 + 10 * 2 + 10 * 45 + 5 * 9,
            ),
        ]
        for position, player, expected in cases:
            with self.subTest(position=position):
                self.assertEqual(check_valuation.compute_valuation(player), expected)

    def test_stars_boundary_conditions(self):
        self.assertEqual(generate_valuations.get_stars(-1), 1)
        self.assertEqual(generate_valuations.get_stars(0), 1)
        self.assertEqual(generate_valuations.get_stars(299), 1)
        self.assertEqual(generate_valuations.get_stars(300), 2)
        self.assertEqual(generate_valuations.get_stars(599), 2)
        self.assertEqual(generate_valuations.get_stars(600), 3)
        self.assertEqual(generate_valuations.get_stars(1199), 4)
        self.assertEqual(generate_valuations.get_stars(1200), 5)
        self.assertEqual(generate_valuations.get_stars(999999), 5)


if __name__ == "__main__":
    unittest.main()
