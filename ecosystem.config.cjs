const path = require('path');

module.exports = {
  apps: [
    {
      name: 'freedomtree-web',
      cwd: path.join(__dirname, 'apps', 'web'),
      script: 'pnpm',
      args: 'exec next start --port 3001',
      interpreter: 'none',
      instances: 1,
      watch: false,
      max_memory_restart: '512M',
      env_production: {
        NODE_ENV: 'production',
        PORT: '3001',
      },
      out_file: '/var/log/pm2/freedomtree-web-out.log',
      error_file: '/var/log/pm2/freedomtree-web-err.log',
      merge_logs: true,
      log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
    },
  ],
};
