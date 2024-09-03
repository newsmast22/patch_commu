const { environment } = require('@rails/webpacker');
const { resolve } = require('path');

// Add Babel loader for JSX files
environment.loaders.append('babel', {
  test: /\.(js|jsx)$/,
  exclude: /node_modules/,
  use: {
    loader: 'babel-loader',
    options: {
      presets: ['@babel/preset-env', '@babel/preset-react']
    }
  }
});

// Ensure the engine's components are resolved properly
environment.config.resolve.alias = {
  ...environment.config.resolve.alias,
  posts: resolve(__dirname, '../../community_gem/app/javascript') // Adjust path as needed
};

module.exports = environment;