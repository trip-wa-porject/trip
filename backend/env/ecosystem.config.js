let ignorePath = ['bin', 'node_modules', 'log', '.idea', '.git'];

module.exports = {
    apps : [{
      name: "app",
      script: "./server.js",
      watch: true,
      watch_options: {
        interval: 5000,
        awaitWriteFinish: {
          stabilityThreshold: 2000,
          pollInterval: 100
        }
      },
    listen_timeout: 3000,
    kill_timeout: 30000,
    restart_delay: 5000,
    exp_backoff_restart_delay: 5000,
    instance: 1,
    ignore_watch: ignorePath,
    env: { //default
      NODE_ENV: 'docker'
    },
    env_dev: {
      NODE_ENV: "development",
    },
    env_production: {
      NODE_ENV: "production",
    }
  }]
};
