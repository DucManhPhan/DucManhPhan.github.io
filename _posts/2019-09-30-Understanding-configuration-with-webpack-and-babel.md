---
layout: post
title: Understanding configuration with Webpack and Babel
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Java, Spring]
---

In this article, we will learn how to configure a project that use Webpack and Babel in front-end. It is a first step to work with larger project in the future. So, let's get started.


<br>

## Table of contents
- [What is Webpack ?](#what-is-webpack-?)
- [What is Babel ?](#what-is-babel-?)
- [Setup some packages Webpack and Babel](#setup-some-packages-webpack-and-babel)
- [Wrapping up](#wrapping-up)

<br>

## What is Webpack ?
- Definition of Webpack

  Webpack is a ```Module bundle```. It takes a bunch of assets such as source, images, css, ... to turn them into something that we will send to client. It means that it will package all dependencies into bundles that browser can understand.

  By default, Webpack only knows how to process ```.js``` or ```.json``` files. To do with other format files, we need to use ```Loader``` such as ```HtmlWebPackPlugin``` for html file, ...

  ![](../img/Webpack/webpack-bundle-our-scripts.png)

- Some functionalities in webpack

  - Hot module reloading: updates React component without refresh website.
  - Lazy loading
  - Bundle splitting
  - Hashing
  - Source maps: debug minified version.

- Folder structure of Js application that use Webpack and Babel

  ```js
  - node_modules
  - dist/
  - index.html
  - src/
  - index.js
  - package.json
  - webpack.config.js
  ```

  When Webpack run, Javascript files in source folder ```/src``` will be bundled into a single Javascript file which will be placed automatically into the ```/dist``` folder.

  ```/dist``` will be used to serve our applicatioin to the browser.

- Below is the content of webpack.config.js file that we need to know:

  ```js
  const webpack = require("webpack");

  module.exports = {
    // Where to start bundling
    entry: {
      app: "./src/index.js",
      home: './src/home.js',
      contact: './src/contact.js'
    },

    // Where to output
    output: {
      // Output to the same directory
      path: __dirname,    // or path.resolve(__dirname, 'dist'),
      publicPath: '/',
      // Capture name from the entry using a pattern
      filename: "[name].js"
    },

    // How to resolve encountered imports
    module: {
      rules: [
        {
          test: /\.css$/,
          use: ["style-loader", "css-loader"],
        },
        {
          test: /\.(js|jsx)$/,
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
        },
        {
          test: /\.scss$/,
          use: [
            'style-loader',
            'css-loader',
            'postcss-loader',
            'sass-loader'
          ]
        }
      ],
    },

    // What extra processing to perform
    plugins: [
      new webpack.DefinePlugin({ ... }),
      new uglifyJsPlugin(),
      new HtmlWebPackPlugin({
          template: "./src/index.html",
          filename: "./index.html"
      }),
      new CleanWebpackPlugin(),
      new webpack.HotModuleReplacementPlugin()
    ],

    // Adjust module resolution algorithm
    resolve: {
      alias: { ... },
    },
  };
  ```


- Some modes in Webpack

  There are two modes:
  - development: This mode will remain the structure of file, so, we can easily read source code.

    In order to use development mode, we can configure in package.json file:

    ```json
    "scripts": {
      "start": "webpack-dev-server --mode development --open --hot",
      "build": "webpack --mode development"
    }
    ```

  - production:

    To production mode, all files will be minified. So, these files will be reduced the files's size.

  ![](../img\Webpack\execution-process.png)

<br>

## What is Babel ?

[Babel](https://babeljs.io/docs/en/) is a toolchain that is mainly used to convert ECMAScript 2015+ code into a backwards compatible version of JavaScript in current and older browsers or environments.

<br>

## Setup some packages Webpack and Babel
1. For webpack

    To work with Webpack easily, we need to install some additional packages.

    - webpack

      ```js
      npm install --save-dev webpack
      ```

      Webpack does not compile anything. It simply bundles all things together.

      ```--save-dev``` will saves these packages to devDependencies of package.json, which means these are development packages and user may avoid installing these packages.

    - webpack-dev-server

      ```js
      npm install --save-dev webpack-dev-server
      ```

      ```webpack-dev-server``` is a localhost server which we will use to preview how our web application works. The server will automatically send reload events to the browser to refresh the pages as soon as we make changes to the code. This should be used for development only.

      To run our project with ```webpack-dev-server```, we need to configure in package.json file:

      ```json
      "script": {
        "start:dev": "webpack-dev-server --config ./webpack.config.js --mode development",
        "build": "webpack --config ./webpack.config.js --mode production"
      }
      ```

      And run the following command in our terminal/console:

      ```js
      npm run start:dev
      ```

    - ```webpack-cli```

      ```js
      npm install --save-dev webpack-cli
      ```

      It provides a flexible set of commands for developers to increase speed when setting up a custom webpack project.

      We can refer the [link of Webpack CLI](https://webpack.js.org/api/cli/)

    - uglifyjs-webpack-plugin

      ```npm install --save-dev uglifyjs-webpack-plugin

      It will be used to minify Javascript bundle made by Webpack.

    - ```html-webpack-plugin``` and ```html-loader```

      ```html-loader``` is used to process html file. And ```html-webpack-plugin``` will inject js, css into html files, and it is reponsible for create output files in ```./dist``` folder. And ```html-webpack-plugin``` is needed by webpack-dev-server to launch a web preview of our plugin.

      ```js
      npm install --save-dev html-webpack-plugin html-loader
      ```

      If we want to remove the ```/dist``` folder with every Webpack build, it means that the automatic generated ```dist/bundle.js``` file should be removed, and ```dist/index.html``` file will be added automatically. We do not want to create ```dist/index.html``` file manually for every Webpack build again, so, we can use ```html-webpack-plugin```.

      It will simplify creation of HTML files to serve our webpack bundles. This is especially useful for webpack bundles that include a hash in the filename which changes every compilation.

      We can refer [link about html-webpack-plugin](https://github.com/jantimon/html-webpack-plugin).

      Update some plugins in webpack.config.js file:

      ```js
      const HtmlWebPackPlugin = require("html-webpack-plugin");
      module.exports = {
        module: {
          rules: [
            {
              test: /\.(js|jsx)$/,
              exclude: /node_modules/,
              use: {
                loader: "babel-loader"
              }
            },
            {
              test: /\.html$/,
              use: [
                {
                  loader: "html-loader"
                }
              ]
            }
          ]
        },
        plugins: [
          new HtmlWebPackPlugin({
            template: "./src/index.html",
            filename: "./index.html"
          })
        ]
      };
      ```

    - clean-webpack-plugin

        Because of automatically generating ```dist/index.html``` and ```dist/bundle.js``` files, we can delete the content of our ```/dist``` folder with every Webpack build. So, we need to install ```clean-webpack-plugin```.

        ```js
        npm install --save-dev clean-webpack-plugin
        ```

    - react-hot-loader

        If we want to use hot loading module when we have changes in our files, we should use ```react-hot-loader```.

        ```
        npm install --save-dev react-hot-loader
        ```

        Add this plugin into webpack.config.js file:

        ```js
        plugins: [
          new webpack.HotMoudleReplacementPlugin()
        ],
        devServer: {
          contentBase: './dist',
          hot: true
        }
        ```

        In ```src/index.js``` file, we need to define that hot reloading is available:

        ```js
        import React from 'react';
        import ReactDOM from 'react-dom';
        const title = 'React with Webpack and Babel';

        ReactDOM.render(
          <div>{title}</div>,
          document.getElementById('app')
        );

        module.hot.accept();
        ```

    - CSS loader

      - sass-loader and node-sass

        ```js
        npm install --save-dev sass-loader node-sass
        ```

        To load .scss files into Javascript file using ES6 import syntax and compile them to CSS, we need to install ```sass-loader``` and ```node-sass``` which will do actual compilation.

      - postcss-loader, cssnano, and autoprefixer

        ```js
        npm install --save-dev postcss-loader cssnano autoprefixer
        ```

        To minify and add prefixes to CSS (for browser compatibility) we need to use ```postcss-loader``` and some its dependencies such as ```cssnano```, ```autoprefixer``` to do its actual works.

      - css-loader and style-loader

        ```js
        npm install --save-dev css-loader style-loader
        ```

        We will use ```css-loader``` and ```style-loader``` to import ```.css``` file into Javascript file (which ```sass-loader``` generates) and finally inject into DOM in ```style``` tag.ss



2. For Babel

    - babel-loader

        It is the Webpack loader responsible for taking in the ES6 code and making it understandable by the browser. It will load ES6 modules in node.js using import syntax (node.js does not support ```import``` syntax). So, we need to install ```babel-loader``` and ```@babel/core```.

        ```js
        npm install --save-dev babel-loader @babel/core
        ```

        A loader has basic three parts:
        - test - use regex to determine the type of files
        - exclude - the folders that we want Webpack omits
        - use: loader - the loader that we want to Webpack use to process files.

    - @babel/preset-env

        It is used to compile Javascript ES6 down to ES5. And ```babel-preset-es2015``` package is deprecated.

        ```js
        npm install --save-dev @babel/preset-env
        ```

    - @babel/preset-react

        In order that the syntax of React will be understood by other browsers, so we need Babel to transpile React code ```JSX``` to Javascript.

        ```js
        npm install --save-dev @babel/preset-react
        ```

        Then, we will find ```.babelrc``` file to add some configuration lines:

        ```json
        {
          "presets": [
            "@babel/preset-env",
            "@babel/preset-react"
          ]
        }
        ```

        Finally, let's inform Webpack in webpack.config.js file about files with JSX extension to make sure that they run through the transpiling step:

        ```js
        module.exports = {
          entry: './src/index.js',
          module: {
            rules: [
              {
                test: /\.(js|jsx)$/,
                exclude: /node_modules/,
                use: ['babel-loader']
              }
            ]
          },
          resolve: {
            extensions: ['*', '.js', '.jsx']
          },
          output: {
            path: __dirname + '/dist',
            publicPath: '/',
            filename: 'bundle.js'
          },
          devServer: {
            contentBase: './dist'
          }
        };
        ```

    - babel-preset-transform-object-rest-spread

      ```js
      npm install --save-dev babel-preset-transform-object-rest-spread
      ```

      It is a plugin to support Object rest/spread syntax if our babel preset doesn't support it.

3. For React.js

    Install some packages for react.js:

    ```js
    npm install react react-dom

    // use Prop-types to document our React components
    // https://reactjs.org/docs/typechecking-with-proptypes.html
    npm install --save-dev prop-types
    ```

<br>

## Wrapping up
- Understanding how Webpack works, we can easily configure all project that use Webpack and Babel.
- Remember that all above plugins or loaders that are necessary to work.


<br>

Refer:

[https://www.valentinog.com/blog/babel/](https://www.valentinog.com/blog/babel/)

[https://www.valentinog.com/blog/webpack/](https://www.valentinog.com/blog/webpack/)

[https://levelup.gitconnected.com/what-is-webpack-4fdb624597ae](https://levelup.gitconnected.com/what-is-webpack-4fdb624597ae)

[https://tech.3si.vn/2017/11/24/meo-toi-uu-hoa-webpack-bundle/](https://tech.3si.vn/2017/11/24/meo-toi-uu-hoa-webpack-bundle/)

[https://www.robinwieruch.de/webpack-setup-tutorial](https://www.robinwieruch.de/webpack-setup-tutorial)

[https://survivejs.com/webpack/what-is-webpack/](https://survivejs.com/webpack/what-is-webpack/)

[https://www.robinwieruch.de/webpack-advanced-setup-tutorial](https://www.robinwieruch.de/webpack-advanced-setup-tutorial)

[https://www.robinwieruch.de/minimal-react-webpack-babel-setup](https://www.robinwieruch.de/minimal-react-webpack-babel-setup)

[https://www.robinwieruch.de/minimal-react-webpack-babel-setup#react-webpack](https://www.robinwieruch.de/minimal-react-webpack-babel-setup#react-webpack)

[https://www.robinwieruch.de/webpack-babel-setup-tutorial](https://www.robinwieruch.de/webpack-babel-setup-tutorial)

[http://vuilaptrinh.com/2018-05-25-huong-dan-viet-code-javascript-tot-hon-voi-webpack/](http://vuilaptrinh.com/2018-05-25-huong-dan-viet-code-javascript-tot-hon-voi-webpack/)