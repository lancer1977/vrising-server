import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(ROOT)

from config_contracts import read_env_example, has_volume_map


class ConfigContractAdditionalTests(unittest.TestCase):
    def test_read_env_example_parses_key_value_pairs(self):
        parsed = read_env_example(".env.example")
        self.assertIn("VRISING_DATA_DIR", parsed)
        self.assertEqual(parsed["VRISING_DATA_DIR"], "./data/saves")

    def test_has_volume_map_detects_bind_mounts(self):
        lines = ["/root/.wine:/root/.wine", "- ./data:/mnt/data"]
        self.assertTrue(has_volume_map(lines, "/root/.wine"))
        self.assertTrue(has_volume_map(lines, "./data"))


if __name__ == "__main__":
    unittest.main()
