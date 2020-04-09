---
layout: post
title: New features in ES6
bigimg: /img/path.jpg
tags: [Front-End, Javascript]
---

In this article, we will talk about some new features in ES6, and how to apply this new traits into our project.

<br>

## Table of contents
- [Introduction to ES6](#introduction-to-es6)
- [Javascript let](#javascript-let)
- [Javascript const](#javascript-const)
- [Exponentiation Operator](#exponentiation-operator)
- [Array.find()](#array.find-(-))
- [Array.findIndex()](#array.findindex-(-))
- [Properties and Methods of Number](#properties-and-methods-of-number)
- [Arrow function](#arrow-function)

<br>

## Introduction to ES6
ECMAScript 6 is also known as ES6 and ECMAScript 2015.

Some new features in ES6 are:
- ```let```
- ```const```
- Exponentiation (**)
- Default parameter values
- ```Array.find()```
- ```Array.findIndex()```

<br>

## Javascript let
The ```let``` statement allows us to declare a variable with a block scope.

So, we will find out the difference between ```let``` and ```var```.
- Concepts

    ```let``` gives us the privilege to declare variables that are limited in scope to the block, statement of expression unlike ```var```.

    ```var``` is rather a keyword which defines a variable globally regardless of block scope.

- Global window object

    Even if the ```let``` variable is defined as same as ```var``` variable globally, the ```let``` variable will not be added to the global window object.

    ```javascript
    var varVariable = "this is a var variable";
    let letVariable = "this is a let variable";

    console.log(varVariable);       // this is a var variable
    console.log(letVariable);       // undefined
    ```

    So, ```let``` can not be globally accessed.

- Block

    ```let``` variables are usually used when there is a limited use of those variables. Say, in for loops, while loops or inside the scope of if conditions etc. Basically, where ever the scope of the variable has to be limited.

    ```javascript
    for(let i = 0;i < 10;i++){
        console.log(i); //i is visible thus is logged in the console as 0,1,2,....,9
    }

    console.log(i); //throws an error as "i is not defined" because i is not visible
    ```

    ```javascript
    for(var i = 0; i < 10; i++){
        console.log(i); //i is visible thus is logged in the console as 0,1,2,....,9
    }
    
    console.log(i); //i is visible here too. thus is logged as 10.
    ```

- Redeclaration

    ```let``` variables cannot be re-declared while ```var``` variable can be re-declared in the same scope.

    For example:

    ```javascript
    'use strict';
    var temp = "this is a temp variable";
    var temp = "this is a second temp variable"; //replaced easily
    ```

    ```javascript
    'use strict';
    let temp = "this is a temp variable";
    let temp = "this is a second temp variable" //SyntaxError: temp is already declared
    ```

- Function

    ```let``` and ```var``` variables work the same way when used in a function block.

    For example:

    ```javascript
    function aSampleFunction(){
        let letVariable = "Hey! What's up? I am let variable.";
        var varVariable = "Hey! How are you? I am var variable.";

        console.log(letVariable); //Hey! What's up? I am let variable.
        console.log(varVariable); //Hey! How are you? I am var variable.
    }
    ```

- Hoisting

    Variables defined with ```var``` are hoisted to the top. It means that we can use a variable before it is declared.

    Variables defined with ```let``` are not hoisted to the top. Using a ```let``` variable before it is declared will result in a ```ReferenceError```.

<br>

## Javascript const
It allows us to declare a constant.

- Assigned when declared

    It must be assigned a value when it is declared.

    ```javascript
    const PI = 3.14159265359;
    ```

- Block scope

    It also has block scope, as same as ```let``` variable.

- Not Real constants

    It does not define a constant value. It defines a constant reference to a value. Because of this, we cannot change constant primitive values, but we can change the properties of constant objects.

- Primitive values

    If we assign a primitive value to a constant, we cannot change the primitive value.

    ```javascript
     const PI = 3.141592653589793;
    PI = 3.14;      // This will give an error
    PI = PI + 10;   // This will also give an error 
    ```

- Constant Objects can Change

    We can change the properties of a constant object. But you can NOT reassign a constant object.

    ```javascript
    const car = {type:"Fiat", model:"500", color:"white"};
    car.color = "red";          // right
    car.owner = "Johnson";      // right

    car = {type: "Volvo", model:"EX60", color: "red"};      // false
    ```

- Constant Arrays can Change

    It is as same as with ```Constant Objects can Change```.

- Redeclaring

    We can redeclare a ```var``` variable, but we can not do that with redeclaring or reassigning an existing ```var``` or ```let``` variable to ```const```, in the same scope, or in the same block.

    Redeclaring a variable with ```const```, in another scope, or in another block, is allowed.

- Hoisting

    Variables defined with ```const``` are not hoisted to the top.

    A ```const``` variable cannot be used before it is declared:

    ```javascript
    carName = "Volvo";    // You can NOT use carName here
    const carName = "Volvo"; 
    ```

<br>

## Exponentiation Operator

The exponentiation operator (**) raises the first operand to the power of the second operand.

```x**y``` produces the same result as ```Math.pow(x,y)```.

```javascript
    var x = 5;
var z = x ** 2;          // result is 25 
```

<br>

## Array.find()
It will return the value of the first array element that pass a condition.

Its function takes 3 arguments:
- The item value
- The item index
- The array itself

```javascript
var num_array = [4, 9, 16, 25, 29];
var first = num_array.find(myFunction);

function myFunction(value, index, array) {
  return value > 18;
} 
```

<br>

## Array.findIndex()
It will return the index of the first array element that pass a condition.

Its function takes 3 arguments:
- The item value
- The item index
- The array itself

<br>

## Properties and Methods of Number
ES6 added the following properties to the Number object:
- EPSILON
- MIN_SAFE_INTEGER
- MAX_SAFE_INTEGER

```javascript
let x = Number.EPSILON;
```

ES6 added 2 new methods to the Number object:
- Number.isInteger()        --> return true if the argument is an integer.
- Number.isSafeInteger()    --> return true if the argument is a safe integer.

Safe integers are all integers from -(253 - 1) to +(253 - 1).

<br>

## Arrow function

```javascript
const x = (x, y) => {return x * y;}
```

Some features for arrow function
- Arrow functions do not have their own this. They are not well suited for defining object methods.
- Arrow functions are not hoisted. They must be defined before they are used.
- Using ```const``` is safer than using ```var```, because a function expression is always constant value.
- We can only omit the return keyword and the curly brackets if the function is a single statement. Because of this, it might be a good habit to always keep them.

<br>

Thanks for your reading.

Refer:

[https://www.w3schools.com/js/js_es6.asp](https://www.w3schools.com/js/js_es6.asp)

[https://codeburst.io/difference-between-let-and-var-in-javascript-537410b2d707](https://codeburst.io/difference-between-let-and-var-in-javascript-537410b2d707)