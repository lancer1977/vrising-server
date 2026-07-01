# V Rising Server Docs

This docs tree keeps the V Rising server runtime boundary explicit and anchors
the repo to the shared infra ladder from `Api.GameServerInterop`. `V1` lives in
`../vrising-support`; this tree stays on the runtime lane.

Start here for routing; the paired support home lives in `../vrising-support`.

For shared layer wording and the repo fill-in format, use the canonical
template in `../Api.GameServerInterop/docs/roadmap/v-layer-goals-template.md`.

## Infra Baseline

- `V0`: bootable Dockerized server, sidecar/readback or support process,
  deployment lane, and smoke checks
- `V1`: canonical support home lives in `../vrising-support`

## Per-Repo Fill-In

- repo name: `DS-vrising`
- runtime sibling: none; this repo is the runtime lane
- support-home boundary: support home lives in `../vrising-support`; runtime-only
- local build command: `docker build -t vrising-server:latest .`
- local test/smoke command: `docker-compose up -d && docker logs -f vrising-server`
- caveats: keep the runtime boundary explicit and leave support-home ownership to `../vrising-support`

## 252 Deployment Status

- 252 deployment status: not observed on 192.168.0.252 as of 2026-06-13; see [252 Deployment Status](../../Api.GameServerInterop/docs/roadmap/252-deployment-status.md)
## Features

- [Feature Index](features/README.md) - catalog of the repo's documented capabilities and implementation notes.
- [Version Coverage Map](features/version-coverage-map.md) - runtime-lane V-layer tags.
- [V Rising Dedicated Server](features/v-rising-dedicated-server.md) - the inferred primary feature for the server package.
- [Core Capabilities](features/core-capabilities.md) - shared automation and containerization capabilities.
- [ServerGameSettings.json PvP Rules, Rates, Limits](features/servergamesettings-json-pvp-rules-rates-limits.md) - the gameplay tuning contract exposed by configuration.

## Roadmaps

- [Portfolio Roadmap](roadmaps/portfolio-roadmap.md) - the current follow-up list, release gates, and documentation cleanup path.

## Notes

This docs tree is intentionally small: the feature pages capture durable runtime
behavior, the roadmap page captures the next planning and validation steps, and
the support-home contract stays in `../vrising-support`.
