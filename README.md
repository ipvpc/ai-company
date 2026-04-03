# ai-company

Docker-based stack to run a **company of agents**: [Paperclip](https://github.com/paperclipai/paperclip) (orchestration + UI), **OpenClaw** (gateway/agents), optional **Hermes**, **Postgres**, and a **Tailscale** sidecar for shared networking. Use this repo to compose images, env, and host paths for automated workflows.

## Repository layout

| Path | Purpose |
|------|---------|
| [`docker-compose.yml`](./docker-compose.yml) | Services, ports, env wiring, volumes |
| [`.env`](./.env) / [`.env.example`](./.env.example) | Local secrets and URLs (not committed if `.env` is gitignored) |
| [`openclaw/`](./openclaw/) | Custom OpenClaw image (`Dockerfile`, `config.toml`, `openclaw.json`, `build.sh`, `test.sh`) |
| [`paperclip/paperclip/`](./paperclip/paperclip/) | Upstream Paperclip monorepo (server, UI, CLI, packages) for dev or reference |

## Stack (Compose)

| Service | Role | Notes |
|---------|------|--------|
| `db` | Postgres 17 | DB `paperclip`, user/password `paperclip`; host port **5432**; named volume `pgdata` |
| `ts-openclaw` | Tailscale (userspace) | `TS_AUTHKEY`; state under host path configured in compose |
| `openclaw` | OpenClaw gateway | Shares network with `ts-openclaw`; gateway **18789**; `.openclaw` persisted on host |
| `hermes` | Hermes agent | `gateway run`; `~/.hermes` → `/opt/data` |
| `paperclip` | Paperclip app | Host **3100** → container **8000**; data dir on host |

Images default to a private registry (`registry.alpha5.finance/...`) where noted in compose—replace or build locally as needed.

## Quick start

1. Copy `.env.example` to `.env` and set at least **`DATABASE_URL`** (Postgres connection string for Paperclip) and **`TS_AUTHKEY`** if you use Tailscale.
2. Adjust **host paths** in `docker-compose.yml` (`/data/services/...`, `~/.hermes`) for your machine or OS.
3. From this directory: `docker compose up -d` (or `docker-compose up -d`).

See Paperclip’s own [README](paperclip/paperclip/README.md) for developing the app from source.

## OpenClaw image

To build and push the custom image (see [`openclaw/build.sh`](./openclaw/build.sh)):

```bash
cd openclaw
# review Dockerfile, config.toml, openclaw.json first
./build.sh
```

Interactive shell against the image: [`openclaw/test.sh`](./openclaw/test.sh).

## Keeping this README up to date

When you change the repo, update **this file** in the same PR or commit so it stays accurate:

- **Services** added/removed/renamed in `docker-compose.yml`, or **ports** / **images** / **commands** changed
- **New or required** environment variables (document them here and in `.env.example`)
- **Host paths** or deployment assumptions (Tailscale, OpenClaw, Paperclip data dirs)
- **Openclaw** build inputs (`Dockerfile`, default config files) that operators must know about
- **Paperclip** location or version story if the nested tree or image tags change

If something in the README disagrees with `docker-compose.yml` or `.env.example`, treat the **compose and env files as source of truth** and fix the README to match.
