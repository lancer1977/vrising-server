import unittest
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(ROOT)

from config_contracts import (  # noqa: E402
    has_volume_map,
    parse_docker_compose,
    missing_required_env_keys,
)


class ConfigContractTests(unittest.TestCase):
    def setUp(self) -> None:
        self.compose_lines = parse_docker_compose("docker-compose.yml")

    def test_env_example_contains_core_variables(self):
        missing = missing_required_env_keys(".env.example")
        self.assertFalse(missing, f"Missing env keys: {sorted(missing)}")

    def test_compose_file_contains_image_and_service(self):
        joined = "\n".join(self.compose_lines)
        self.assertIn("vrising", joined)

    def test_compose_file_has_expected_volume_mounts(self):
        self.assertTrue(has_volume_map(self.compose_lines, "/root/.wine"))
        self.assertTrue(any("./data" in line for line in self.compose_lines))

    def test_readme_documents_ports(self):
        with open("README.md", encoding="utf-8") as f:
            readme = f.read()
        self.assertIn("27015", readme)
        self.assertIn("27016", readme)


if __name__ == "__main__":
    unittest.main()
