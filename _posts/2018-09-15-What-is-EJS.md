---
layout: post
title: What is EJS?
bigimg: /img/path.jpg
tags: [Node.js]
---

## Table of Contents
- [1. Definition of EJS](1-definition-of-ejs)
- [2. Basic implementation in EJS](#2-basic-implementation-in-ejs)

<br>

## 1. Definition of EJS
EJS - Embedded JavaScript, is a simple templating language that lets you generate HTML markup with plain Javascript.

One of the most important features in EJS is its use of partials. Partials allow you to define something once, and then apply it to any page in our application. 

<br>

## 2. Basic implementation in EJS
- Declare the variable in EJS
    
    You can use syntax: 

    Example: 
    ```Javascript
    <% var numberOfStudent = 5; %>
    ```

- Print the variable in EJS
  
    Using the syntax: 

    Example: 
    ```Javascript 
    <h2>The value of b variable: <%= b %> </h2>
    ```


    When you want EJS that will appear the statement of HTML, using the "-" before "%". 

    Example: 
    ```Javascript
    <% var y = "<h2 style='color: red'> hello </h2>"; %>
    <%- y %>
    ```

The following are common syntaxes. Let's take a look:

- <%    means 'Scrriptlet' tag, for control flow, no output. 

- <%_   means "Whitespace Slurping" Scriptlet tag, strips all whitespace before it. 

- <%=   means Outputs the value into the template (HTML escaped)

- <%-   means Outputs the unescaped value into the template

- <%#   means Comment tag, no execution, no output

- <%%   means Outputs a literal '<%>'

- -%>   means Trim-mode ('newline slurp') tag, trims following new line.
  
- %>    means Plain ending tag

- _%>   means "Whitespace Slurping" ending tag, removes all whitespace after it.

Example: 

```Javascript
<%- include('header'); -%>
<h1>Title</h1>
<p>My page</p>
<%- include('footer'); -%>
```

```Javascript
<ul>
    <% users.forEach(function(user){ %>
        <%- include('user/show', {user: user}); %>
    <% }); %>
</ul>
```

Thanks for your reading.