#!/usr/bin/env bash
# Freedom Tree — one-time server setup
# Run this once on a fresh DigitalOcean Ubuntu droplet (22.04 LTS or later).
# After this script finishes, clone the repo and run scripts/deploy.sh.
set -euo pipefail

LOG_PREFIX="[ft-setup]"
info() { echo "$LOG_PREFIX  $*"; }
ok()   { echo "$LOG_PREFIX ✓ $*"; }

NODE_MAJOR=22   # LTS — change if you need a different version

# ── System packages ───────────────────────────────────────────────────────────
info "Updating system packages..."
sudo apt-get update -qq
sudo apt-get install -y -qq \
  curl wget git build-essential unzip \
  postgresql postgresql-contrib \
  debian-keyring debian-archive-keyring apt-transport-https
ok "System packages installed"

# ── Node.js (via NodeSource) ──────────────────────────────────────────────────
if ! command -v node >/dev/null 2>&1 || [[ "$(node -e 'process.stdout.write(process.version.split(".")[0].slice(1))')" -lt "$NODE_MAJOR" ]]; then
  info "Installing Node.js $NODE_MAJOR..."
  curl -fsSL "https://deb.nodesource.com/setup_${NODE_MAJOR}.x" | sudo -E bash -
  sudo apt-get install -y nodejs
  ok "Node.js $(node --version) installed"
else
  ok "Node.js $(node --version) already present"
fi

# ── pnpm ─────────────────────────────────────────────────────────────────────
if ! command -v pnpm >/dev/null 2>&1; then
  info "Installing pnpm..."
  npm install -g pnpm@9
  ok "pnpm $(pnpm --version) installed"
else
  ok "pnpm $(pnpm --version) already present"
fi

# ── PM2 ───────────────────────────────────────────────────────────────────────
if ! command -v pm2 >/dev/null 2>&1; then
  info "Installing PM2..."
  npm install -g pm2
  ok "PM2 $(pm2 --version) installed"
else
  ok "PM2 $(pm2 --version) already present"
fi

# ── Caddy ─────────────────────────────────────────────────────────────────────
if ! command -v caddy >/dev/null 2>&1; then
  info "Installing Caddy..."
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' \
    | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' \
    | sudo tee /etc/apt/sources.list.d/caddy-stable.list
  sudo apt-get update -qq
  sudo apt-get install -y caddy
  ok "Caddy $(caddy version) installed"
else
  ok "Caddy already present"
fi

# ── PM2 startup (persist across reboots) ────────────────────────────────────
info "Configuring PM2 startup..."
pm2 startup | tail -1 | bash || true   # runs the generated sudo command
ok "PM2 startup configured"

# ── PostgreSQL: create database and user ─────────────────────────────────────
info "Setting up PostgreSQL..."
DB_NAME="freedomtree_prod"
DB_USER="freedomtree"

sudo -u postgres psql -tc "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'" \
  | grep -q 1 || sudo -u postgres psql -c "CREATE USER $DB_USER WITH PASSWORD 'changeme';"

sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'" \
  | grep -q 1 || sudo -u postgres psql -c "CREATE DATABASE $DB_NAME OWNER $DB_USER;"

ok "PostgreSQL database '$DB_NAME' ready (user: $DB_USER)"

# ── Log directory ─────────────────────────────────────────────────────────────
sudo mkdir -p /var/log/pm2
sudo chown "$(whoami)" /var/log/pm2

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
ok "Server setup complete!"
echo ""
echo "Next steps:"
echo "  1. Clone the repo:"
echo "       git clone git@github.com:YOUR_ORG/freedomtree.git /var/www/freedomtree"
echo ""
echo "  2. Create production env file:"
echo "       cp /var/www/freedomtree/scripts/.env.production.example \\"
echo "          /var/www/freedomtree/apps/web/.env.production.local"
echo "       nano /var/www/freedomtree/apps/web/.env.production.local"
echo "       # Set DATABASE_URL=postgresql://freedomtree:YOUR_DB_PASS@localhost:5432/freedomtree_prod"
echo "       # Set NEXTAUTH_URL=http://YOUR_SERVER_IP:8080"
echo "       # Generate secrets with: openssl rand -base64 32"
echo ""
echo "  3. Add Caddy config:"
echo "       sudo nano /etc/caddy/Caddyfile"
echo "       # Paste the block from /var/www/freedomtree/scripts/Caddyfile.snippet"
echo "       sudo caddy fmt --overwrite /etc/caddy/Caddyfile"
echo "       sudo systemctl reload caddy"
echo ""
echo "  4. Deploy:"
echo "       cd /var/www/freedomtree"
echo "       bash scripts/deploy.sh"
echo ""
echo "  ⚠  Change the PostgreSQL password from 'changeme':"
echo "       sudo -u postgres psql -c \"ALTER USER freedomtree PASSWORD 'STRONG_PASSWORD';\""
echo "     Then update DATABASE_URL in .env.production.local to match."
