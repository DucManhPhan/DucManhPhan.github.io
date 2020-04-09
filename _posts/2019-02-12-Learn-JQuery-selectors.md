---
layout: post
title: Learn JQuery - Selectors
bigimg: /img/path.jpg
tags: [Front-End, JQuery]
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

<br>

## Table of contents
- [Basic selectors](#basic-selectors)
- [Basic Filter](#basic-filter)
- [Child Filter](#child-filter)
- [Content Filter](#content-filter)
- [Wrapping up](#wrapping-up)

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

## Basic Filter
- ```focus``` Selector
    - Syntax: $(":focus")
    - Selects element if it is currently focused.
    - As with other pseudo-class selectors (those that begin with a ":"), it is recommended to precede ```:focus``` with a tag name or some other selector; otherwise, the universal selector ( "*" ) is implied.
    - The bare ```$( ":focus" )``` is equivalent to ```$( "*:focus" )```.
    - If you are looking for the currently focused element, ```$( document.activeElement )``` will retrieve it without having to search the whole DOM tree.
    - Sample: Adds the focused class to whatever element has focus

    ```html
    <div id="content">
        <input tabIndex="1">
        <input tabIndex="2">
        <select tabIndex="3">
            <option>select menu</option>
        </select>
        <div tabIndex="4">
            a div
        </div>
    </div>
    ```

    ```css
    .focused {
        background: #abcdef;
    }
    ```

    ```javascript
    $( "#content" ).delegate( "*", "focus blur", function() {
        var elem = $( this );
        setTimeout(function() {
            elem.toggleClass( "focused", elem.is( ":focus" ) );
        }, 0 );
    });
    ```
<br>

## Child filter
- ```:first-child``` Selector
    - Syntax: $(":first-child")
    - Selects all elements that are the first child of their parent.
    - While ```:first``` matches only a single element, the ```:first-child``` selector can match more than one. One for each parent.
    - This selector is equivalent to ```:nth-child(1)```.
    - Sample: Finds the first span in each matched div to underline and add a hover state.

        ```javascript
        $( "div span:first-child" )
        .css( "text-decoration", "underline" )
        .hover(function() {
            $( this ).addClass( "sogreen" );
        }, function() {
            $( this ).removeClass( "sogreen" );
        });
        ```

- ```:first-of-type``` Selector
    - Syntax: $(":first-of-type")
    - Selects all elements that are the first among siblings of the same element name.
    - The ```:first-of-type``` selector matches elements that have no other element with both the same parent and the same element name coming before it in the document tree.
    - Sample: Find the first span in each matched div and add a class to it.

        ```css
        span.fot {
            color: red;
            font-size: 120%;
            font-style: italic;
        }
        ```

        ```javascript
        $("span:first-of-type").addClass("fot")
        ```

- ```:nth-child``` Selector
    - Syntax: $("nth-child(index/even/odd/equation)")
    - Selects all elements that are the nth-child of their parent.
    - Then index of each child to match, starting with ```1```, the string ```even``` or ```odd```, or an equation (E.g: ```:nth-child(4n)```).
    - JQuery's implementation of ```nth-``` selectors is strictly derived from the CSS specification, the value of ```n``` is **1-indexed**, meaning that the counting starts at 1. For other selector expression such as ```:eq()``` or ```:even```, JQuery follows Javascript's **0-indexed** counting. So, given a single ```<ul>``` containing two ```<li>```s, ```$( "li:nth-child(1)" )``` selects the first ```<li>``` while ```$( "li:eq(1)" )``` selects the second.
    - With ```:nth-child(n)```, all children are counted, regardless of what they are, and the specified element is selected only if it matches the selector attached to the pseudo-class. 
    -  With ```:eq(n)``` only the selector attached to the pseudo-class is counted, not limited to children of any other element, and the (n+1)th one (n is 0-based) is selected.
    - Sample: Find the second li in each matched ul and note it.

    ```javascript
    $( "ul li:nth-child(2)" ).append( "<span> - 2nd!</span>" );
    ```
<br>

## Wrapping up
- Take care of performance problem when using JQuery functions.

<br>

Thanks for your reading

<br>

Refer:

[https://api.jquery.com/category/selectors/basic-css-selectors/](https://api.jquery.com/category/selectors/basic-css-selectors/)