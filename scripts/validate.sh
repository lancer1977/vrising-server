#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

required_paths=(
  "README.md"
  "Dockerfile"
  "docker-compose.yml"
  "scripts/run.sh"
  "docs/README.md"
  "docs/features/README.md"
  "docs/features/version-coverage-map.md"
  "deploy/docker-compose.local.yml"
  "deploy/nginx/docker-compose.local.yml"
  "deploy/nginx/docker-compose.portainer.yml"
  "deploy/portainer-stack.yml"
)

for path in "${required_paths[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "Missing required path: $path" >&2
    exit 1
  fi
done

grep -q "../vrising-support" README.md docs/README.md docs/features/version-coverage-map.md
grep -q "established_versions: \\[V0\\]" docs/features/version-coverage-map.md
grep -q "delegated_versions: \\[V1, V2, V3, V4, V5\\]" docs/features/version-coverage-map.md
grep -q "app_update 1829350 validate" scripts/run.sh
grep -q "VRisingServer.exe" scripts/run.sh
grep -q "SERVERNAME" README.md scripts/run.sh
grep -q "GAMEPORT" README.md scripts/run.sh
grep -q 'set -- "$settings" -serverName "$SERVERNAME"' scripts/run.sh
grep -q 'set -- "$@" -gamePort "$GAMEPORT"' scripts/run.sh
grep -q 'set -- "$@" -queryPort "$QUERYPORT"' scripts/run.sh
grep -q 'rm -f /tmp/.X0-lock' scripts/run.sh
grep -q "EXPOSE 9876/udp" Dockerfile

sh -n scripts/run.sh

docker compose -f docker-compose.yml config --quiet
docker compose -f deploy/docker-compose.local.yml config --quiet
docker compose -f deploy/nginx/docker-compose.local.yml config --quiet
docker compose -f deploy/nginx/docker-compose.portainer.yml config --quiet
docker compose -f deploy/portainer-stack.yml config --quiet
