---
layout: post
title: How to center things in CSS
bigimg: /img/path.jpg
tags: [front-end]
---

Sometimes, in CSS, we want to center everthing rapidly. But to do this, we have to think about it slowly, simply because, we must choose some properties such as postion, top, left, right, bottom, vertical align, text align, ...

So, in this article, we will talk about some ways to center in our website's content.

<br>

## Table of contents
- [Use line-height and height for centering elements in menu](#use-line-height-and-height-for-centering-elements-in-menu)
- [Wrapping up](#wrapping-up)


<br>

## Use line-height and height for centering elements in menu
We can use line-height and height properties for this problem. Our code will have the following state:

```html 
<div class="header">
    <h2 class="logo">Navigation</h2>
    <ul class="menu">
        <a href="#">Home</a>
        <a href="#">About</a>
        <a href="#">Services</a>
        <a href="#">Works</a>
        <a href="#">Contact</a>
    </ul>
</div>
```


```css
* {
    margin: 0;
    padding: 0; 
}

.header {
    height: 100px;
    background-color: #34495e;
    padding: 0 20px;
}

.logo {
    color: #ffffff;
    line-height: 100px;
    text-transform: uppercase;
    float: left;
}

.menu {
    float: right;
    line-height: 100px;
    background-color: #34495e;    
}

.menu a {
    text-transform: uppercase;
    text-decoration: none;
    padding: 0 10px;
    color: #ffffff;
    transition: 0.7s;
}

.menu a:hover {
  color: #219AA7;
}
```

<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

