import ast
import re
import shutil
import subprocess
import unittest
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]


class PythonSyntaxTests(unittest.TestCase):
    def test_python_files_parse(self):
        root = PROJECT_ROOT
        excluded_dirs = {".git", "__pycache__", "tests"}
        python_files = [
            p
            for p in root.rglob("*.py")
            if not any(part in excluded_dirs for part in p.parts)
        ]
        self.assertGreater(len(python_files), 0)
        for py_file in python_files:
            with self.subTest(file=str(py_file)):
                source = py_file.read_text()
                ast.parse(source)


class ValuationSqlTests(unittest.TestCase):
    def test_generated_sql_has_no_negative_valuations(self):
        sql_path = PROJECT_ROOT / "scraping-and-sql/update_valuations.sql"
        sql = sql_path.read_text()
        negatives = re.findall(r"valuation\s*=\s*-\d+", sql)
        self.assertEqual(
            negatives,
            [],
            msg=(
                "Found negative valuation updates in scraping-and-sql/update_valuations.sql. "
                "Regenerate the file after valuation clamp changes."
            ),
        )

    def test_valuation_scripts_have_non_negative_clamp(self):
        valuation_scripts = [
            "check_valuation.py",
            "compute_rough_valuation.py",
            "scraping-and-sql/check_valuation.py",
            "scraping-and-sql/compute_rough_valuation.py",
        ]
        for script in valuation_scripts:
            with self.subTest(script=script):
                content = (PROJECT_ROOT / script).read_text()
                self.assertIn("return max(0, int(valuation))", content)

    def test_generated_sql_has_transaction_wrapping(self):
        sql_path = PROJECT_ROOT / "scraping-and-sql/update_valuations.sql"
        sql = sql_path.read_text().strip()
        self.assertTrue(sql.startswith("BEGIN;"))
        self.assertTrue(sql.endswith("COMMIT;"))

    def test_generated_sql_updates_have_unique_player_ids(self):
        sql_path = PROJECT_ROOT / "scraping-and-sql/update_valuations.sql"
        sql = sql_path.read_text()
        player_ids = re.findall(r"WHERE playerID = (\d+);", sql)
        self.assertGreater(len(player_ids), 0)
        self.assertEqual(len(player_ids), len(set(player_ids)))


class PhpLintTests(unittest.TestCase):
    @unittest.skipIf(shutil.which("php") is None, "php binary not installed")
    def test_all_php_files_pass_lint(self):
        php_files = sorted(PROJECT_ROOT.rglob("*.php"))
        self.assertGreater(len(php_files), 0)
        for php_file in php_files:
            with self.subTest(file=str(php_file.relative_to(PROJECT_ROOT))):
                result = subprocess.run(
                    ["php", "-l", str(php_file)],
                    capture_output=True,
                    text=True,
                    check=False,
                )
                self.assertEqual(
                    result.returncode,
                    0,
                    msg=f"{php_file}: {result.stdout}\n{result.stderr}",
                )


if __name__ == "__main__":
    unittest.main()
