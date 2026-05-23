from pathlib import Path

REQUIRED_ENV_KEYS = {
    "VRISING_DATA_DIR",
    "VRISING_SETTINGS_DIR",
}


def read_env_example(path: str = ".env.example") -> dict[str, str]:
    values: dict[str, str] = {}
    file_path = Path(path)
    for line in file_path.read_text(encoding="utf-8").splitlines():
        text = line.strip()
        if not text or text.startswith("#") or "=" not in text:
            continue
        key, value = text.split("=", 1)
        values[key.strip()] = value.strip()
    return values


def parse_docker_compose(path: str = "docker-compose.yml") -> list[str]:
    return Path(path).read_text(encoding="utf-8").splitlines()


def missing_required_env_keys(env_path: str = ".env.example") -> set[str]:
    found = set(read_env_example(env_path).keys())
    return set(REQUIRED_ENV_KEYS) - found


def has_volume_map(lines: list[str], container_path: str) -> bool:
    for line in lines:
        if container_path in line and ":" in line:
            return True
    return False
