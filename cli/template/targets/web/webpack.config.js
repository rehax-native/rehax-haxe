const path = require("path");
const fs = require("fs/promises");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  mode: "development",
  entry: {
    index: "./src/rhx.js",
  },
  devtool: "inline-source-map",
  devServer: {
    static: "./dist",
  },
  plugins: [
    {
      apply(compiler) {
        async function compile() {
          const content = `
function component() {
  const element = document.createElement('div');
  element.innerHTML = 'Hello Rehax!';
  return element;
}

document.body.appendChild(component());
`;

          const filePath = path.join("src", "rhx.js");
          const existing = await fs.readFile(filePath, "utf-8");
          if (existing !== content) {
            await fs.writeFile(path.join("src", "rhx.js"), content);
          }
        }
        compiler.hooks.run.tap("RehaxNativeCompile", compile);
        compiler.hooks.watchRun.tap("RehaxNativeCompile", compile);
      },
    },
    new HtmlWebpackPlugin({
      title: "Development",
    }),
  ],
  output: {
    filename: "[name].bundle.js",
    path: path.resolve(__dirname, "dist"),
    clean: true,
  },
};
