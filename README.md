# V Rising Dedicated Server

Dockerized V Rising game server for homelab deployment.

Runtime lane for the V Rising dedicated server image.

First read: [docs/README.md](./docs/README.md).

## Infra Goal Path

This repo is the deployable V Rising runtime lane. It should stay explicit about
the `V0` infra baseline and the `V1` support-home boundary in
`../vrising-support` so the server can be reviewed folder by folder without
redefining the shape each time.

- `V0`: bootable Dockerized server, support/readback path, deployment lane, and
  smoke checks that prove the server comes up
- `V1`: canonical support home lives in `../vrising-support`; this repo stays
  on the runtime lane

The shared seam and ladder are defined in `Api.GameServerInterop`; this repo
keeps the V Rising server/runtime boundary and Docker bring-up behavior.

For the shared ladder and fill-in format, use the canonical V-layer template in
`../Api.GameServerInterop/docs/roadmap/v-layer-goals-template.md`.

## Per-Repo Fill-In

- repo name: `DS-vrising`
- runtime sibling: none; this repo is the runtime lane
- support-home boundary: support home lives in `../vrising-support`; keep this repo runtime-only
- local build command: `docker build -t vrising-server:latest .`
- local test/smoke command: `docker-compose up -d && docker logs -f vrising-server`
- caveats: do not fold support-home contracts or operator policy into the runtime lane

## 252 Deployment Status

- 252 deployment status: not observed on 192.168.0.252 as of 2026-06-13; see [252 Deployment Status](../Api.GameServerInterop/docs/roadmap/252-deployment-status.md)
## Tags

- game
- vrising-server
- game-server
- server
- docker
- docs

## Quick Start

```bash
# Build the image
docker build -t vrising-server:latest .

# Run with compose (recommended)
docker-compose up -d
```

## Purpose

This repo contains a Dockerized dedicated server for V Rising, a vampire survival MMO. The server runs in a Wine container and is managed via Docker Compose for easy deployment and updates.

## V1 baseline

- The Compose-first deployment path is documented.
- Server name, world, port, and volume settings are exposed through environment variables.
- V1 means a new operator can stand the server up and understand where config lives.

## Current shape

- Dockerized dedicated server image and Compose deployment path
- environment variable configuration for server name, world, and ports
- volume mount guidance for saves and settings
- project docs for features, roadmaps, and operational notes

## Project Docs

- [Docs Home](./docs/README.md)
- [Feature Index](./docs/features/README.md)
- [Version Coverage Map](./docs/features/version-coverage-map.md)
- [Roadmaps](./docs/roadmaps/README.md)

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `TZ` | UTC | Server timezone |
| `SERVERNAME` | poly-V | Server display name |
| `WORLDNAME` | world1 | World save name |
| `GAMEPORT` | 27015 | Custom game port |
| `QUERYPORT` | 27016 | Custom query port |

## Volume Mounts

The server uses environment variables for flexible path configuration. By default, data is stored in `./data/`:

| Container Path | Default Host Path | Purpose |
|----------------|-------------------|---------|
| `/root/.wine/.../VRisingServer/Saves` | `./data/saves` | World save data |
| `/root/.wine/.../VRisingServer/Settings` | `./data/settings` | Server configuration |

### Customizing Volume Paths

Create a `.env` file (copy from `.env.example`) to customize paths:

```bash
# Copy example config
cp .env.example .env

# Edit with your preferred paths
nano .env
```

Environment variables:

| Variable | Default | Description |
|----------|---------|-------------|
| `VRISING_DATA_DIR` | `./data/saves` | World save data directory |
| `VRISING_SETTINGS_DIR` | `./data/settings` | Server configuration directory |

Example `.env` for custom paths:

```env
VRISING_DATA_DIR=/mnt/games/vrising/saves
VRISING_SETTINGS_DIR=/mnt/games/vrising/settings
```

**Note:** Ensure the host directories exist before starting the container:

```bash
mkdir -p ./data/saves ./data/settings
```

## Ports

| Port | Protocol | Purpose |
|------|----------|---------|
| 27015 | UDP | Game traffic |
| 27016 | UDP | Query/Steam |

## Configuration Files

Place these in the `settings/` directory:

- `ServerGameSettings.json` - PvP rules, rates, limits
- `ServerHostSettings.json` - Server name, password, max slots
- `adminlist.txt` - Admin Steam IDs (one per line)
- `banlist.txt` - Banned Steam IDs (one per line)

## Logs & Management

```bash
# View logs
docker logs -f vrising-server

# Stop server
docker-compose down

# Restart (updates server via SteamCMD on start)
docker-compose restart
```

## Full Documentation

For detailed architecture and analysis, see the vault documentation:

📁 [V Rising Server Docs](https://github.com/lancer1977/polyhydra-code/tree/main/04-docs/repos/vrising-server)


## Documentation

- [Feature Index](./docs/features/README.md)
- [Version Coverage Map](./docs/features/version-coverage-map.md)
- [Core Capabilities](./docs/features/core-capabilities.md)

## Quality Goal

Non-UI and non-web library code should generally aim for 80%+ unit test coverage. When modifying shared/core libraries, prefer adding or updating tests as part of the change.
