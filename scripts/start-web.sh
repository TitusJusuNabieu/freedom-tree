#!/usr/bin/env bash
# Sources the production env file before starting Next.js so PM2 inherits all vars.
set -a
# shellcheck disable=SC1091
source "$(cd "$(dirname "$0")/.." && pwd)/apps/web/.env.production.local"
set +a
exec pnpm exec next start --port "${PORT:-3001}"
