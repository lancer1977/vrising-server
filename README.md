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

The following paths are mounted from the host:

| Container Path | Host Path | Purpose |
|----------------|-----------|---------|
| `/root/.wine/.../VRisingServer/Saves` | `./saves` | World save data |
| `/root/.wine/.../VRisingServer/Settings` | `./settings` | Server configuration |

### Customizing Volume Paths

To customize mount paths, edit the `volumes` section in `docker-compose.yml`:

```yaml
volumes:
  - /your/custom/saves:/root/.wine/drive_c/users/root/AppData/LocalLow/Stunlock Studios/VRisingServer/Saves
  - /your/custom/settings:/root/.wine/drive_c/users/root/AppData/LocalLow/Stunlock Studios/VRisingServer/Settings/
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
