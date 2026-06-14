# vrising-server portfolio roadmap

## Goal Path

- `V0`: bootable Dockerized server, support/readback lane, deployment, and smoke checks
- `V1`: canonical support home lives in `../vrising-support`

This repo should stay aligned with the shared infra seam in `Api.GameServerInterop`
and keep reusable support contracts in `../vrising-support`.

This lightweight roadmap captures the next validation and documentation steps for the repo's deployment pattern.

## 90-day evidence snapshot
- Commits (90 days): 7
- Files changed (90 days): 18
- Last signal: b156acb (4 days ago)
- Top modified areas: docs(7);00_agile(6);docker-compose.yml(1);README.md(1);Dockerfile(1);.gitattributes(1)
- Notes: clean_at_scan

## Current repo posture
- Stack: Other/Assets
- Docs folder: yes
- Roadmap folder: no
- Features docs: yes
- Tests indexed: no

## Shared phase model

This roadmap follows the shared `PolyhydraGames.GameServerInterop` phase ladder as a reference point:

- `V1` - deployment stability and reproducible packaging
- `V2` - confidence, compatibility, and docs/runbook hardening
- `V3` - sidecar or bridge baseline, if the repo ever adds one
- `V4` - downstream integration, if the repo ever adds one

The current repo only needs the V1 deployment baseline today.

## Discovery
- [x] Capture and timestamp recent change signal
- [x] Capture top-level area concentration
- [ ] Document owner and intent for area: docs(7)
- [ ] Add explicit release gates for next validation steps

## V1 (stability)
- [ ] Close gaps in docs and feature notes for recently touched areas
- [ ] Add or update smoke checks for changed source paths
- [ ] Validate packaging and deploy assumptions where infra/config changed

## V2 (confidence)
- [ ] Add deeper tests on highest-churn areas
- [ ] Expand runbooks for recurring operator or publishing workflows
- [ ] Standardize naming and checklist structure for future items

## V4 (scale)
- [ ] Move to a stable platform pattern with cross-repo checklist templates
- [ ] Split roadmap into discrete feature-level and initiative-level folders
- [ ] Define long-range acceptance criteria with operational and product owners

## Top touched files (90-day top 10)
- .env.example
- .gitattributes
- 00_agile/backlog/.gitkeep
- 00_agile/doing/.gitkeep
- 00_agile/done/.gitkeep
- ... and 5 more

## Follow-up ideas
- [ ] Convert area signals into one short feature roadmap within docs/features
- [ ] Add changelog notes in docs for behavior-impacting updates
- [ ] Add simple owner checklist for release readiness
