---
layout: post
title: Learn basic bootstrap
bigimg: /img/image-header/ravashing-beach.jpg
tags: [bootstrap]
---

In order to the speed of making the website, I think that I have to learn about Bootstrap framework immediately. Because with bootstrap, you can easily make the website fast.

The belows is some basic titles about Bootstrap. 


## Use bootstrap framework

There are two ways to use the bootstrap, it includes: 
- Use the link to bootstrap files in the internet. 

```Html
<!doctype html>
<html lang="en">
<head>
    <!-- ... -->
    <!-- the compression css file of bootstrap 4 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
 
</head>
<body>
    <!-- ... -->
    <div class="container-fluid">
      <!-- do something here -->
    </div>
 
    <!-- The compression Jquery library is used for bootstap.min.js -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <!-- The compression popper library is used for bootstrap.min.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.min.js"></script>
    <!-- The compression js file of bootstrap 4, it should be lied before body tag-->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</body>
</html>
```

- Download the bootstrap 4 at [Link bootstrap 4](https://getbootstrap.com/docs/4.0/getting-started/download/)
In order to download all necessary files in bootstrap 4, you can get from the links:
  - file bootstrap.min.js and bootstrap.min.css: it is in the **Compiled CSS and JS** of website https://getbootstrap.com/docs/4.0/getting-started/download/
  - file popper.min.js: https://github.com/FezVrasta/popper.js
  - file jquery.min.js: you can google for this file.


## Container 
There are two container classes to choose from: 
- .container class provides a responsive fixed width container.
- .container-fluid class provides a full width container, spanning the entire width of the viewport.


## Grid system
Bootstrap's grid system is built with flexbox and allows up to 12 columns across the page. 

The columns will re-arrange automatically depending on the screen size. 

Grid system has 5 classes: 
- .col-   (extra small devices)
- .col-sm (small devices)
- .col-md (medium devices)
- .col-lg (large devices)
- .col-xl (xlarge devices)

You have to create a row. Then, add the desired number of columns.

Ex: 

```html
<div class="row">
    <div class="col-sm-4">.col-sm-4</div>
    <div class="col-sm-8">.col-sm-8</div>
</div>
```


## 