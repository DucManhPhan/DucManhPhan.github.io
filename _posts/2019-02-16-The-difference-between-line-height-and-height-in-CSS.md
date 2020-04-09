---
layout: post
title: The difference between line-height property and height property in CSS
bigimg: /img/image-header/california.jpg
tags: [Front-End, CSS]
---

In CSS, there are so many interesting tricks for specific problems. So, to break down these problems, we have to understand deeply about concepts. When I practice coding about html, css that is relevant to navigation, I cope with a problem about centering texts between it. It use height and line-height properties to center navigation.

In this article, we will find out about height, line-height properties, and how to apply them into our case.

<br>

## Table of contents
- [Line-height and height properties](#line-height-and-height-properties)
- [Values of line-height property](#values-of-line-height-property)
- [Sample](#sample)
- [Wrapping up](#wrapping-up)

<br>

## Line-height and height properties
```height``` is the vertical measurement of the container.

Ex: height of a div.

```line-height``` is the distance from the top of the first line of text to the top of the second.

If used with only one line of text, it produces similar results in most cases.

Using ```height``` property when we want to explicitly set the container size.

Using ```line-height``` property for typographic layout where it might be relevant if a user resizes the text.

<br>

## Values of line-height property
The following table will describe values of line-height property:

|    value    |      Description       |
| ----------- | ---------------------- |
| normal      | A normal line height. This is default. |
| number      | A number that will be multiplied with the current font-size to set the line height. |
| length      | A fixed line height in px, pt, cm, ... |
| %           | A line height in percent of the current font size. |
| initial     | Sets this property to its default value. |
| inherit     | Inherits this property from its parent element. |

<br>

## Sample
Consider a problem about centering texts in navigation bar, with the following image:

![](../img/front-end/line-height-and-height-navigation.png)

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
- To understand how ```line-height``` property works, refer this [link](http://joshnh.com/weblog/how-does-line-height-actually-work/)

- Using ```line-height``` property for typographic case.

- Using ```height``` property for the container's size.
<br>

Refer:

[https://stackoverflow.com/questions/7616618/height-vs-line-height-styling](https://stackoverflow.com/questions/7616618/height-vs-line-height-styling)

[http://joshnh.com/weblog/how-does-line-height-actually-work/](http://joshnh.com/weblog/how-does-line-height-actually-work/)