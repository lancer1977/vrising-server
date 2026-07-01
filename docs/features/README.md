---
title: Feature Index
status: done
owner: @DreadBreadcrumb
priority: high
complexity: 1
created: 2026-03-22
updated: 2026-03-22
tags: [documentation, vrising-server]
---

# Feature Index

This directory documents the stable, user-facing capabilities of `vrising-server`. State is tracked in front matter so the index stays lightweight.

## Infra Shape

- `V0`: Dockerized server, support/readback boundary, deployment lane, and smoke checks
- `V1`: canonical support home lives in `../vrising-support`

## Server / Deployment Features

- [V Rising Dedicated Server](./v-rising-dedicated-server.md) - the primary Dockerized server packaging and runtime contract.
- [Core Capabilities](./core-capabilities.md) - shared automation and containerization capabilities.
- [ServerGameSettings.json PvP Rules, Rates, Limits](./servergamesettings-json-pvp-rules-rates-limits.md) - the gameplay tuning contract exposed through configuration.
- [Version Coverage Map](./version-coverage-map.md)

## Existing Sub-modules

- [Sub-module: settings](./sub-module-settings.md)
- [Sub-module: scripts](./sub-module-scripts.md)
- [Sub-module: library](./sub-module-library.md)

## Beyond the App

- Shared utilities and local development tools, while reusable support contracts stay in `../vrising-support`.
