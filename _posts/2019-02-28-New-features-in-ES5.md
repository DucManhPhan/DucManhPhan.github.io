---
layout: post
title: New features in ES5
bigimg: /img/path.jpg
tags: [Front-End, Javascript]
---

In this article, we will discuss about some new features in ECMAScript 5. All browsers support some properties in ES5. So, we need to practice all things smoothly.

<br>

## Table of contents
- [Introduction to ES5](#introduction-to-es5)
- [Strict mode](#strict-mode)
- [String.trim()](#string.trim-(-))
- [Array.isArray()](#array.isArray-(-))
- [Array.forEach()](#array.forEach-(-))
- [Array.map()](#array.map-(-))
- [Array.filter()](#array.filter-(-))
- [Array.reduce()](#array.reduce-(-))
- [Array.every()](#array.every-(-))
- [Array.indexOf()](#array.indexOf-(-))
- [Array.lastIndexOf()](#array.lastIndexOf-(-))
- [JSON.parse()](#json.parse-(-))
- [JSON.stringify()](#json.stringify-(-))
- [Date.now()](#date.now-(-))
- [Property Getters and Setters](#property-getters-and-setters)
- [New Object Property Methods](#new-object-property-methods)
- [Property access on strings](#property-access-on-strings)

<br>

## Introduction to ES5
ECMAScript5 is also known as ES5 and ECMAScript 2009.

There are some new features released in 2009.
- ```use strict``` directive
- ```String.trim()```
- ```Array.isArray()```
- ```Array.forEach()```
- ```Array.map()```
- ```Array.filter()```
- ```Array.reduce()```
- ```Array.reduceRight()```
- ```Array.every()```
- ```Array.some()```
- ```Array.indexOf()```
- ```Array.lastIndexOf()```
- ```JSON.parse()```
- ```JSON.stringify()```
- ```Date.now()```
- ```Property Getters and Setters```
- ```New Object Property Methods```

Then, in the next parts, we will find out about these new features.

<br>

## Strict mode

```javascript
'use strict'
```

Putting the above line first in a file or a function to define all Javascript code should be executed in **strict mode**. And **strict mode** doesn't work with block statements enclosed in {} braces.

We can use **strict mode** in all our programs. It helps us to write cleaner code, like preventing us from using undeclared variables.

In **strict mode**, any assignment to a non-writable property, a getter-only property, a non-existing property, a non-existing variable, or a non-existing object, will throw an error.

For example:

```javascript
'use strict' 

x = 3.14;       // cause an error because x is not declared

y = {p1: 20, p2: 15};   // cause an error because y is not declared

var z = 34; 
delete z;           // cause an eror because deleting a variable (or object) is not allowed

var obj = {get x() {return 0}};   // --> get-only property
obj.x = 3;          // cause an error

var arguments = 6;  // cause an error because string "arguments" cannot be used as a variable

```

Some benefits of using ```strict mode```:
- Strict mode eliminates some JavaScript silent errors by changing them to throw errors.
- Strict mode fixes mistakes that make it difficult for JavaScript engines to perform optimizations: strict mode code can sometimes be made to run faster than identical code that’s not strict mode.
- Strict mode prohibits some syntax likely to be defined in future versions of ECMAScript.
- It prevents, or throws errors, when relatively “unsafe” actions are taken (such as gaining access to the global object).
- It disables features that are confusing or poorly thought out.
- Strict mode makes it easier to write “secure” JavaScript.

<br>

## String.trim()
It will remove whitespace from both sides of a string.

```javascript
var str = "      Hi    ";
console.log(str.trim());
```

<br>

## Array.isArray()
It checks whether an object is an array.

```javascript
var presidents = ["Obama", "Clinton", "Trump"];
console.log(Array.isArray(presidents));
```

<br>

## Array.forEach()
The ```forEach()``` method calls a function once for each array element.

Its function takes 3 arguments:
- The item value
- The item index
- The array itself

For example:

```javascript
var txt = "";
var numbers = [45, 4, 9, 16, 25];
numbers.forEach(myFunction);

function myFunction(value) {
  txt = txt + value + "<br>";
}
```

<br>

## Array.map()
It will create a new array based on the origin array.

Its function takes 3 arguments:
- The item value
- The item index
- The array itself

When a callback function uses only the value parameter, the index and array parameters can be omitted.

For example:

```javascript
var num_array = [1, 3, 5, 7];
var num_secondarray = num_array.map(function(val) {
    return val * 3;
});
```

<br>

## Array.filter()
It will create a new array from condition with the origin array.

Its function takes 3 arguments:
- The item value
- The item index
- The array itself

For example:

```javascript
var numbers = [45, 4, 9, 16, 25];
var over18 = numbers.filter(myFunction);

function myFunction(value, index, array) {
  return value > 18;
} 
```

```javascript
var num_array = [2, 4, 6, 5, 9];
var filted_array = num_array.filter(function(val) {
    return (val % 2) == 0;
});

```

<br>

## Array.reduce()
It runs a function on each array element to produce (reduce it to) a single value.

It works from left-to-right in the array. And it does not reduce the original array.

Its function takes 4 arguments:
- The total (the inital value / previously returned value)
- The item value
- The item index
- The array itself

For example:

```javascript
var num_array = [45, 4, 9, 16, 25];
var sum = num_array.reduce(myFunction);

function myFunction(total, value, index, array) {
  return total + value;
} 
```

<br>

## Array.every()
It will check if all array elements satisfy a condition. The returned value is true or false.

Its function takes 3 arguments:
- The item value
- The item index
- The array itself

When a callback function uses the first parameter only (value), the other parameters can be omitted.

For example:

```javascript
var numbers = [45, 4, 9, 16, 25];
var allOver18 = numbers.every(myFunction);

function myFunction(value) {
  return value > 18;
} 
```
<br>

## Array.indexOf()
It searches an array for an element value and returns its position.

For example:

```javascript
var fruits = ["Apple", "Orange", "Apple", "Mango"];
var a = fruits.indexOf("Apple");
```

Syntax: 

```array.indexOf(item, start)```

- item  --> Required. The item to search for.
- start --> Optional. Where to start the search. Negative values will start at the given position counting from the end, and the search to the end.


<br>

## Array.lastIndexOf()
It will search from the end of the array.

For example:

```javascript
var fruits = ["Banana", "Orange", "Apple", "Mango"];
var a = fruits.lastIndexOf("Apple");
```

<br>

## JSON.parse()
It used to convert the text into a Javascript object.

```javascript
var obj = JSON.parse('{"name":"John", "age":30, "city":"New York"}');
```

<br>

## JSON.stringify()
It is used to convert Javascript object into a string.

```javascript
var obj = {"name":"John", "age":30, "city":"New York"};
var myJSON = JSON.stringify(obj); 
```

Note about: A common use of JSON is
- to receive data from a web server.
- to send data to a web server. When sending data to a web server, the data has to be a string.

<br>

## Date.now()
It will returns the number of milliseconds since zero date (January 1. 1970 00:00:00 UTC).

```javascript
var timInMSs = Date.now();
```

<br>

## Property Getters and Setters
ES5 lets us define object methods with a syntax that looks like getting or setting a property.

```javascript
var person = {
  firstName: "John",
  lastName : "Doe",
  language : "NO",
  get lang() {
    return this.language;
  },
  set lang(value) {
    this.language = value;
  }
};

// Or

// Define object
var obj = {counter : 0};

// Define setters
Object.defineProperty(obj, "reset", {
  get : function () {this.counter = 0;}
});

Object.defineProperty(obj, "add", {
  set : function (value) {this.counter += value;}
});

```

Some benefits of getters and setters:
- It gives simpler syntax.
- It allows equal syntax for properties and methods.
- It can secure better data quality.
- It is useful for doing things behind the sences.


<br>

## New Object property methods
```Object.defineProperty()``` is a new Object method in ES5.

It lets you define an object property and/or change a property's value and/or metadata.

For example:

```javascript
var person = {
  firstName: "John",
  lastName : "Doe",
  language : "NO"
};

// Change a Property:
Object.defineProperty(person, "language", {
  get : function() { return language },
  set : function(value) { language = value.toUpperCase()}
});
```

ECMAScript 5 added a lot of new Object Methods to JavaScript:

ES5 allows the following property meta data to be changed
- writable: true or false       // property value can be changed or not
- enumerable: true or false     // property value can be enumerated or not
- configurable: true or false   // property value can be reconfigured or not

For examples:

```javascript
// Adding or changing an object property
Object.defineProperty(object, property, descriptor)

Object.defineProperty(person, "language", {value : "NO"}); 

// Adding or changing many object properties
Object.defineProperties(object, descriptors)

// Accessing Properties
Object.getOwnPropertyDescriptor(object, property)

// Returns all properties as an array
Object.getOwnPropertyNames(object)

Object.getOwnPropertyNames(person);  // Returns an array of properties 

// Returns enumerable properties as an array
Object.keys(object)

// Accessing the prototype
Object.getPrototypeOf(object)

// Prevents adding properties to an object
Object.preventExtensions(object)
// Returns true if properties can be added to an object
Object.isExtensible(object)

// Prevents changes of object properties (not values)
Object.seal(object)
// Returns true if object is sealed
Object.isSealed(object)

// Prevents any changes to an object
Object.freeze(object)
// Returns true if object is frozen
Object.isFrozen(object)
```

<br>

## Property access on strings
The ``charAt()``` method returns the character at a specified index in a string.

For example:

```javascript
var str = "Hello, everyone";
str.charAt(0);

// In ES5, we have
str[0];
```


<br>

Refer:

[https://www.w3schools.com/js/js_versions.asp](https://www.w3schools.com/js/js_versions.asp)

[http://speakingjs.com/es5/ch25.html](http://speakingjs.com/es5/ch25.html)