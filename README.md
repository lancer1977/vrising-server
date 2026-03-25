# V Rising Dedicated Server

Dockerized V Rising game server for homelab deployment.

## Quick Start

```bash
# Build the image
docker build -t vrising-server:latest .

# Run with compose (recommended)
docker-compose up -d
```

## Purpose

This repo contains a Dockerized dedicated server for V Rising, a vampire survival MMO. The server runs in a Wine container and is managed via Docker Compose for easy deployment and updates.

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


## 📖 Documentation
Detailed documentation can be found in the following sections:
- [Feature Index](./docs/features/README.md)
- [Core Capabilities](./docs/features/core-capabilities.md)
