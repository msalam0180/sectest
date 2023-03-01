const { merge } = require('webpack-merge');
const TerserJsPlugin = require('terser-webpack-plugin');
const ESLintPlugin = require('eslint-webpack-plugin');
const common = require('./webpack.common');

module.exports = merge(common, {
  mode: 'production',
  optimization: {
    // TODO: splitChunks was disabled because it currently breaks js on the Drupal site, but still works on storybook - https://github.com/storybookjs/storybook/issues/6391#issuecomment-493140869
    // splitChunks: {
    //   chunks: 'all',
    //   name: 'js/common',
    //   minChunks: 2,
    // },
    minimizer: [
      new TerserJsPlugin({
        terserOptions: {
          format: {
            comments: false,
          },
        },
      }),
    ],
  },
  devtool: false,
  plugins: [new ESLintPlugin()],
});
