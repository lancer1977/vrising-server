# repo-state.md

- repo: vrising-server
- path: /home/lancer1977/code/vrising-server
- updated_utc: 2026-07-07T04:25:45Z
- canonical_tracker: GitHub Issues
- operational_surface: DevStudio CLI + repo-local docs
- stable_map: docs/index.md

## Current policy

- Durable work lives in GitHub Issues.
- Repo-local docs stay compact and point to the current entrypoints.
- Generated or disposable artifacts belong under `.devstudio/`.

## Current command flow

```bash
python /home/lancer1977/code/dev-forge/tools/dev_studio_validate.py --repo /home/lancer1977/code/vrising-server
```
