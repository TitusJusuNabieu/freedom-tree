#!/usr/bin/env bash
# Freedom Tree — deploy script
# Run this on the DigitalOcean server from the repo directory:
#   bash scripts/deploy.sh
set -euo pipefail

# ── Configuration ─────────────────────────────────────────────────────────────
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BRANCH="${DEPLOY_BRANCH:-main}"
ENV_FILE="$APP_DIR/apps/web/.env.production.local"
LOG_PREFIX="[freedomtree-deploy]"

# ── Helpers ───────────────────────────────────────────────────────────────────
info()  { echo "$LOG_PREFIX  $*"; }
ok()    { echo "$LOG_PREFIX ✓ $*"; }
fail()  { echo "$LOG_PREFIX ✗ $*" >&2; exit 1; }

# ── Pre-flight checks ─────────────────────────────────────────────────────────
info "Starting deployment from $APP_DIR (branch: $BRANCH)"

command -v pnpm  >/dev/null 2>&1 || fail "pnpm not found. Run scripts/server-setup.sh first."
command -v pm2   >/dev/null 2>&1 || fail "pm2 not found. Run scripts/server-setup.sh first."
command -v node  >/dev/null 2>&1 || fail "node not found. Run scripts/server-setup.sh first."

if [[ ! -f "$ENV_FILE" ]]; then
  fail "Production env file missing: $ENV_FILE
Create it with:
  cp $APP_DIR/scripts/.env.production.example $ENV_FILE
  nano $ENV_FILE   # fill in real values"
fi

# ── Create PM2 log directory if needed ────────────────────────────────────────
sudo mkdir -p /var/log/pm2
sudo chown "$(whoami)" /var/log/pm2

# ── Pull latest code ──────────────────────────────────────────────────────────
info "Pulling $BRANCH from origin..."
cd "$APP_DIR"
git fetch origin
git checkout "$BRANCH"
git pull origin "$BRANCH"
ok "Code updated to $(git rev-parse --short HEAD)"

# ── Install dependencies ──────────────────────────────────────────────────────
info "Installing dependencies..."
pnpm install --frozen-lockfile
ok "Dependencies installed"

# ── Run database migrations ───────────────────────────────────────────────────
info "Running database migrations..."
# Prisma schema is at repo root but DATABASE_URL lives in apps/web/.env.production.local
# Export it explicitly so prisma can find it from any working directory
DATABASE_URL="$(grep '^DATABASE_URL=' "$ENV_FILE" | cut -d'=' -f2- | tr -d '"')"
export DATABASE_URL
[[ -z "$DATABASE_URL" ]] && fail "Could not read DATABASE_URL from $ENV_FILE"
# prisma migrate deploy applies pending migrations without prompting — safe for production
pnpm exec prisma migrate deploy
ok "Migrations applied"

# ── Build Next.js ─────────────────────────────────────────────────────────────
info "Building web app..."
pnpm --filter web build
ok "Build complete"

# ── Restart / start via PM2 ───────────────────────────────────────────────────
info "Reloading PM2 process..."
# reload first (zero-downtime); fall back to start on first deploy
pm2 reload "$APP_DIR/ecosystem.config.cjs" --env production 2>/dev/null \
  || pm2 start "$APP_DIR/ecosystem.config.cjs" --env production

pm2 save
ok "PM2 process running"

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
info "Deployment complete!"
pm2 show freedomtree-web | grep -E "status|pid|uptime|memory" || true
echo ""
info "Tail logs with:  pm2 logs freedomtree-web"
info "Reload Caddy:    sudo systemctl reload caddy"
