module.exports = {
  apps: [
    {
      name: 'api',
      script: 'dist/apps/api-gateway/main.js',
      watch: true,
    },
    {
      name: 'user',
      script: 'dist/apps/user/main.js',
      watch: true,
    },
  ],
};
