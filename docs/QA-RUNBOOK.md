# QA Runbook — vrising-server

The shared procedure lives in the project hub and is the canonical copy:

**`~/projects/game-runtimes/docs/QA-RUNBOOK.md`**

It covers image-digest verification, the deploy/teardown checks, save
persistence, idempotent re-apply, and the physical-host smoke checklist for
every runtime in the hub. Do not fork the procedure into this file — update
the canonical copy instead.

## Values for this repo

| | |
| --- | --- |
| Image | `ghcr.io/lancer1977/vrising-server` |
| Deploy branch | `main` |
| Publishing workflow | `.github/workflows/main.yml` |
| Stack | `alienware/vrising` |
| Game container | `vrising-server` |
| Sidecar | `vrising-wg` |
| Host data | `/home/lancer1977/game_servers/vrising` |
| Player ports | `9876/udp` (game), `9877/udp` (query) |

## Repo-specific notes

- **Mount what the entrypoint reads.** `scripts/run.sh` uses
  `/home/steam/persistentdata` and `/home/steam/settings`. The Dockerfile
  still declares `VOLUME ["/mnt/vrising/server", "/mnt/vrising/persistentdata"]`,
  which nothing reads. A wrong mount here looks fine until the first restart
  regenerates the world — canonical runbook step 1.5 is the check that catches
  it.
- First start is slow: the entrypoint runs SteamCMD to install the server into
  `persistentdata` and marks completion with `steaminstalled.txt`.
- `SERVERNAME` defaults to `poly-V` and `WORLDNAME` to `world1`; both are
  overridable via the stack's `.env`.
- There is **no prior deployed digest** for this runtime. The rollback point
  in canonical step 2.4 is `none` for the first deploy — record it as such
  rather than leaving it blank.
