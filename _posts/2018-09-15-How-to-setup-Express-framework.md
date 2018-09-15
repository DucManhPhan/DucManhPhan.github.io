---
layout: post
title: How to setup Express framework. 
---

Hi, everyone. Today, I will guide you some information about setting Express framework.

1. Download module Express from npm.

```
npm install express-generator -g
```

When it has finished completely, module express will be contain in node-modules of npm. 

2. Make the directory of express project. 
Now, you want to make the project using Express framework. 

Typing command in Visual Studio Code's terminal or Command Prompt.

```
express name_project -e
```

Parameter e is something that you want to use template engine javascript - EJS. 
To find out some information about EJS, you can read about the article: [https://ducmanhphan.github.io/2018-09-15-What-is-EJS/](What is EJS?)

At this moment, you have the directory that looks same as the below image. 

[/img/sample_express.png](Directory of Express project)

3. Install the Node.js's packages in this folder. 
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
