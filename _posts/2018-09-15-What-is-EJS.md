---
layout: post
title: What is EJS
---




To declare the variable in EJS, you can use syntax: 

Example: 
```Javascript
<% var numberOfStudent = 5; %>
```

To print the variable in EJS, using the syntax: 

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