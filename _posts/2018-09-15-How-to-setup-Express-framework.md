---
layout: post
title: How to setup Express framework
bigimg: /img/path.jpg
tags: [Express, node.js] 
---

Hi, everyone. Today, I will guide you some information about setting Express framework.


## Table of Contents
- [Download module Express from npm.](#download-module-express-from-npm)
- [Make the directory of express project.](#make-the-directory-of-express-project)
- [Install the Node.js's packages in this folder.](#install-the-node.js's-package-in-this-folder)


## Download module Express from npm.

```
npm install express-generator -g
```

When it has finished completely, module express will be contain in node-modules of npm. 


## Make the directory of express project. 
Now, you want to make the project using Express framework with template engine EJS. 

Typing command in Visual Studio Code's terminal or Command Prompt.

```
express name_project -e
```

Parameter e is something that you want to use template engine javascript - EJS. 
To find out some information about EJS, you can read about the article: [What is EJS?](https://ducmanhphan.github.io/2018-09-15-What-is-EJS/)

At this moment, you have the directory that looks same as the below image. 

![Directory of Express project](/img/sample_express.png)


## Install the Node.js's packages in this folder. 
You can see some codes in the app.js

```Javascript
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
```

All packages do not still install in this project. You have to install with yourself. Use the following command:

``` 
npm install 
```

The above steps are the skeleton to install express framework. Now, you can confidently code your project. 

In the next lesson, I will help you to make successfully some part of project. 
