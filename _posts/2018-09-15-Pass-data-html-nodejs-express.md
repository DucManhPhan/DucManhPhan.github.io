---
layout: post
title: Pass data from backend to html in Node.js - Express framework
bigimg: /img/path.jpg
tags: [Express, Node.js]
---

Hi everyone!

Assuming that you have a project using express framework. In order to pass data from backend to front-end, you can see the following steps: 

Firstly, find the "routes" folder. In this folder, there are two files ending with .js, such as index.js, users.js. 

And then, open the index.js file. You can see something like: 

```javascript
var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
```

The first parameter of the get function, it is "/", means the home page of website. All the codes means that when you access to the home page, node.js will render file "index.ejs" in "views" folder. And the "title" variable will be pass to the html, the title variable's value will be replace to the "title" in html. 


Now, you want to pass the array into file html, you can do the following: 

Example: 

```Javascript
router.get('/coracle-beach', function(req, res, next) {
  var data = {studentList: ["Johnson", "Mary", "Peter", "Chin-su"]};
  res.render('coracle-beach', {students: data});
})
```

Similarly, you can receive the JSON file, and process at this steps. Next, pass this data into html. 

Thanks for reading to the end. 