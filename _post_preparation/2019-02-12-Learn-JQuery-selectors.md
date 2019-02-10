---
layout: post
title: Learn JQuery - Selectors
bigimg: /img/path.jpg
tags: [front-end]
---

JQuery is a library that is designed from Javascript. It helps developers to construct many functionalities that use Javascript easily. Almost websites, 99% percentage, is utilizing JQuery.

JQuery has some primary modules.
- Ajax 
- Attributes : it used to accessing the attributes of elements HTML.
- Effect
- Event
- Form
- DOM
- Selector

Today, we will talk about Selector module in JQuery. 

## Table of contents
- [Basic selectors](#basic-selectors)
- []()



<br>

## Basic selectors
- All selector
    - Syntax: $("*")
    - Selects all elements
    - Find every element (including head, body, etc) in the document. If your browser has an extension/add-on enabled that inserts a \<script\> or \<link\> element into the DOM, that element will be counted as well.
    - The all, or universal, selector is extremely slow, except when used by itself.

- ID selector
    - Syntax: $("#id")
    - Selects a single element with the given id attribute.
    - For id selectors, jQuery uses the JavaScript function ```document.getElementById()```, which is extremely efficient. 
    
        When another selector is attached to the id selector, such as ```h2#pageTitle```, JQuery performs an additional check before identifying the element as a match.
    - Calling ```jQuery()``` or ```$()``` with an id selector as its argument will return a jQuery object containing a collection of either zero or one DOM element.
    - Each ```id``` value must be used only once within a document. 
    
        If more than one element has been assigned the same ID, queries that use that ID will only select the first matched element in the DOM. 
        
        This behavior should not be relied on, however; a document with more than one element using the same ID is invalid.

- Class selector
    - Syntax: $(".class")
    - Selects all elements with the given class.
    - jQuery uses Javascript's native ```getElementByClassName()``` function if the browser supports it.

- Element selector
    - Syntax: $("element")
    - Selects all elements with the given tag name.
    - Javascript's ```getElementsByTagName()``` function is called to return the appropriate elements when this expression is used.

- Multiple Selector
    - Syntax: $("selector1, selector2, selectorN")
    - Selects the combined results of all the specified selectors.
    - We can specify any number of selectors to combine into a single result.
    - This multiple expression combinator is an efficient way to select disparate elements. 
    - The order of the DOM elements in the returned jQuery object may not be identical, as they will be in document order.

<br>

## 




Thanks for your reading

<br>

Refer:

[https://api.jquery.com/category/selectors/basic-css-selectors/](https://api.jquery.com/category/selectors/basic-css-selectors/)