---
title: Version Coverage Map
status: draft
owner: @DreadBreadcrumb
priority: high
complexity: 2
created: 2026-06-30
updated: 2026-07-03
tags: [feature, vrising, v-layer, runtime]
established_versions: [V0]
delegated_versions: [V1, V2, V3, V4, V5]
---

# Version Coverage Map

This page maps the `DS-vrising` runtime lane onto the shared V-layer ladder.
This repo owns runtime packaging and deployment shape; support-home versions are
delegated to `../vrising-support`.

## Coverage Summary

| Layer | Tag | Current coverage | Evidence | Next proof |
| --- | --- | --- | --- | --- |
| `V0` infra baseline | `established` | Runtime image source, startup script, port/env docs, volume docs, compose, syntax checks, and validation script exist | `Dockerfile`, `scripts/run.sh`, `docker-compose.yml`, README, `scripts/validate.sh` | Add a faster container smoke or live host lifecycle proof when practical |
| `V1` support-home boundary | `delegated` | Canonical support home lives outside this repo | `../vrising-support` references | Keep this repo runtime-only |
| `V2` read-only support proof | `delegated` | Support-sidecar/readback contracts belong in the support home | `../vrising-support` | Runtime lane can provide logs, ports, and server lifecycle proof |
| `V3` control truth | `delegated` | Capability/action classification belongs in support/plugin contracts | `../vrising-support`, `Api.GameServerInterop` | Do not add gameplay authority to this runtime repo |
| `V4` public/operator projection | `delegated` | Operator/public projection belongs in support/UI layers | `../vrising-support`, `cc-sidecar` | Runtime can feed read-only state only after support integration |
| `V5` approval-gated gameplay proof | `delegated` | Gameplay proof belongs in support/plugin/runtime integration, not the image lane alone | support/plugin lane | Runtime repo can host the server target, but approval/audit policy lives elsewhere |

## Runtime Boundary

`V0` is established for this runtime lane at the source/config level because the
repo contains a Dockerfile, startup script, documented ports, environment
variables, volume mounts, entrypoint syntax validation, and compose validation.

This does not prove live deployment on `192.168.0.252`, and it does not widen
the runtime repo into support-sidecar, plugin, policy, or operator ownership.

## Validation

Current validation anchor:

```bash
bash scripts/validate.sh
```

This validates the runtime source/config shape. Full live proof still requires
building/running the image and observing the server lifecycle in an appropriate
runtime environment.
