---
layout: post
title: What is EJS?
bigimg: /img/path.jpg
tags: [EJS, Node.js]
---

## 1. Definition of EJS



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