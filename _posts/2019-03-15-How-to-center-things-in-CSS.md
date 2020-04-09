---
layout: post
title: How to center things in CSS
bigimg: /img/path.jpg
tags: [Front-End, CSS]
---

Sometimes, in CSS, we want to center everthing rapidly. But to do this, we have to think about it slowly, simply because, we must choose some properties such as postion, top, left, right, bottom, vertical align, text align, ...

So, in this article, we will talk about some ways to center in our website's content.

<br>

## Table of contents
- [Centering lines of text](#centering-lines-of-text)
- [Centering a block or image](#centering-a-block-or-image)
- [Centering vertically](#centering-vertically)
- [Use line-height and height for centering elements in navigation](#use-line-height-and-height-for-centering-elements-in-navigation)
- [Centering object with html, css vertically and horizontally](#centering-object-with-html-css-vertically-and-horizontally)
- [Centering in the viewport with CSS3](#centering-in-the-viewport-with-css3)


<br>

## Centering lines of text
Normally, it is used for lines of text in a paragraph or in a heading.

```css
p {
    text-align: center;
}

h2 {
    text-align: center;
}
```

<br>

## Centering a block or image
We can get it by to set the margins to ```auto```. This is normally used with a block of fixed width, because if the block itself is flexible, it will simply take up all the available width. Here is an example: 

```html
<P class="blocktext">This rather narrow block of text is centered. Note that the lines inside the block are not centered (they are left-aligned), unlike in the earlier example. 
```

```css
p.blocktext {
    margin-left: auto;
    margin-right: auto;
    width: 8em;
}
```

With image, we have:

```html
<img class="displayed" src="..." alt="...">
```

```css
img.displayed {
    display: block;
    margin-left: auto;
    margin-right: auto;
}
```

<br>

## Centering vertically
- In CSS2, we have:

    ```html
    <div class="container">
    <p>This small paragraph is vertically centered.</p>
    </div>
    ```

    ```css
    div.container {
        min-height: 10em;
        display: table-cell;
        vertical-align: middle;
    }
    ```

- In CSS3, we have:

    ```html
    <div class="container">
        <p>This small paragraph is vertically centered.</p>
    <div>
    ```

    ```css
    div.container {
        height: 10em;
        position: relative;         // (1)
    }

    div.container p {
        margin: 0;
        position: absolute;         // (2)
        top: 50%;                   // (3)
        transform: translate(0, -50%);      // (4)
    }
    ```

    In the above code, we have some essential rules:
    - Make the container ```relatively positioned```, which declares it to be a container for absolutely positioned elements. 
    - Make the element itself ```absolutely positioned```.
    - Place it halfway down the container with 'top: 50%'. (Note that 50%' here means 50% of the height of the container.)
    - Use a translation to move the element up by half its own height. (The '50%' in 'translate(0, -50%)' refers to the height of the element itself.) 

- Another way to achive this problem.

    ```html
    <div class="container">
        <p>This small paragraph is vertically centered.</p>
    <div>
    ```

    ```css
    div.container {
        height: 10em;
        display: flex;
        align-items: center;
    }

    div.container5 p {
        margin: 0;
    }
    ```

<br>

## Use line-height and height for centering elements in navigation
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

## Centering object with html, css vertically and horizontally
In this part, we will usually use this below code into the problem that is relevant to center something in a screen.

```css
.centered {
  position: fixed;
  top: 50%;
  left: 50%;  
  transform: translate(-50%, -50%);
}
```

For example:

```html
<div class=container>
  <p>Centered!
</div>
```

```css
div.container {
    height: 10em;
    position: relative;
}

div.container p {
    margin: 0;
    background: yellow;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
}
```

Or we can use this way:

```html
<div class=container>
  <p>Centered!
</div>
```

```css
div.container {
  height: 10em;
  display: flex;
  align-items: center;
  justify-content: center;
}

div.container p {
  margin: 0;
}
```

<br>

## Centering in the viewport with CSS3
The default container for absolutely positioned elements is the viewport. 

```html
<html>
  <style>
    body {
        background: white;
    }

    section {
        background: black;
        color: white;
        border-radius: 1em;
        padding: 1em;
        position: absolute;
        top: 50%;
        left: 50%;
        margin-right: -50%;
        transform: translate(-50%, -50%);
    }
  </style>
  <section>
    <h1>Nicely centered</h1>
    <p>This text block is vertically centered.
    <p>Horizontally, too, if the window is wide enough.
  </section>
</html>
```

The ```margin-right: -50%;``` is needed to compensate the ```left: 50%```. The ```left``` rule reduces the available width for the element by 50%. The renderer will thus try to make lines that are no longer than half the width of the container. 

By saying that the right margin of the element is further to the right by that same amount, the maximum line length is again the same as the container's width.

<br>

Thanks for your reading.

<br>

Refer:

[https://css-tricks.com/quick-css-trick-how-to-center-an-object-exactly-in-the-center/](https://css-tricks.com/quick-css-trick-how-to-center-an-object-exactly-in-the-center/)

[https://www.w3.org/Style/Examples/007/center.en.html](https://www.w3.org/Style/Examples/007/center.en.html)