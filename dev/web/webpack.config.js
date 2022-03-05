const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  mode: "development",
  devtool: "inline-source-map",
  entry: "./app.hxml",
  plugins: [
    new HtmlWebpackPlugin({
      title: "Development",
      template: 'index.html',
    }),
  ],
  devServer: {
    static: "./dist",
    hot: true,
  },
  output: {
    filename: "[name].bundle.js",
    path: path.resolve(__dirname, "dist"),
    clean: true,
  },
  module: {
    rules: [
      // all files with hxml extension will be handled by `haxe-loader`
      {
        test: /\.hxml$/,
        loader: "haxe-loader",
        options: {
          debug: true,
        },
      },
    ],
  },
};
