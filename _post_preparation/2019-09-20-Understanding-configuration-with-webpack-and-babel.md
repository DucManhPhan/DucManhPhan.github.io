---
layout: post
title: Understanding configuration with Webpack and Babel
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Java, Spring]
---




<br>

## Table of contents




<br>

## What is webpack ?
Webpack is a ```Module bundle```.

Webpack is used to compact all javascript files into one file.

By default, Webpack only knows how to process ```.js``` or ```.json``` files. To do with other format files, we need to use ```Loader```

Below is the content of webpack.config.js file that we need to know:

```js
const webpack = require("webpack");

module.exports = {
  // Where to start bundling
  entry: {
    app: "./src/index.js",
  },

  // Where to output
  output: {
    // Output to the same directory
    path: __dirname,    // or path.resolve(__dirname, 'dist'),

    // Capture name from the entry using a pattern
    filename: "[name].js",
  },

  // How to resolve encountered imports
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /\.js$/,
        use: "babel-loader",
        exclude: /node_modules/,
      },
      {
          test: /\.html$/,
          use: [
              {
                  loader: "html-loader"
              }
          ]
      }
    ],
  },

  // What extra processing to perform
  plugins: [
    new webpack.DefinePlugin({ ... }),
    new HtmlWebPackPlugin({
        template: "./src/index.html",
        filename: "./index.html"
    })
  ],

  // Adjust module resolution algorithm
  resolve: {
    alias: { ... },
  },
};
```


<br>

## What is babel ?





<br>

## Setup some packages Webpack and Babel
1. For webpack

    - 




2. For Babel





<br>

## Some notice about using Webpack






<br>

## Wrapping up





<br>

Refer:

[https://levelup.gitconnected.com/what-is-webpack-4fdb624597ae](https://levelup.gitconnected.com/what-is-webpack-4fdb624597ae)

[https://tech.3si.vn/2017/11/24/meo-toi-uu-hoa-webpack-bundle/](https://tech.3si.vn/2017/11/24/meo-toi-uu-hoa-webpack-bundle/)

[https://www.robinwieruch.de/webpack-setup-tutorial](https://www.robinwieruch.de/webpack-setup-tutorial)

[https://survivejs.com/webpack/what-is-webpack/](https://survivejs.com/webpack/what-is-webpack/)