import unittest

from config_contracts import parse_docker_compose


class ComposeContractTests(unittest.TestCase):
    def test_parse_docker_compose_includes_lines(self):
        lines = parse_docker_compose("docker-compose.yml")
        self.assertTrue(any("version:" in line for line in lines))
        self.assertTrue(any("services:" in line for line in lines))


if __name__ == "__main__":
    unittest.main()
