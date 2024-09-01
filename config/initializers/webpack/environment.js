const { environment } = require('@rails/webpacker')
const babelLoader = {
  test: /\.jsx?$/,
  exclude: /node_modules/,
  use: {
    loader: 'babel-loader',
    options: {
      presets: ['@babel/preset-env', '@babel/preset-react']
    }
  }
}

environment.loaders.append('babel', babelLoader)
module.exports = environment
