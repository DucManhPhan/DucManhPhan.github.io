---
layout: post
title: Understanding this keyword in Javascript
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Front-End, Javascript]
---

In C++, ```this``` keyword usually refer to the object ifself. It always uses in the method of class. And there are no any tricks with ```this``` keyword. But in Javascript, ```this``` keyword is affected by many things such as context of object, the usage of functions, ...

So, in this article, we will discuss about ```this``` keyword to make our concern more clear about ```this``` keyword.

<br>

## Table of contents
- [Introduction to this keyword](#introduction-to-this-keyword)
- [Simple rule for this keyword](#simple-rules-for-this-keyword)
- [Examples for this keyword](#examples-for-this-keyword)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to this keyword
According to the [w3school.com](https://www.w3schools.com/js/js_this.asp), we have:
- The JavaScript ```this``` keyword refers to the object it belongs to. 
- It has different values depending on where it is used:
    - In a method, ```this``` refers to the owner object.
    - Alone, ```this``` refers to the global object.
    - In a function, ```this``` refers to the global object.
    - In a function, in strict mode, ```this``` is undefined.
    - In an event, ```this``` refers to the element that received the event.
    - Methods like call(), and apply() can refer ```this``` to any object.

<br>

## Simple rules for this keyword
So, with the previous section, we will have a rule: 

```
this keyword will refer to the object or context that is the nearest to it.
```

<br>

## Examples for this keyword
- Regular function

    ```javascript
    function foo() {
        console.log("Simple function call");
        console.log(this === window);
    }

    foo()
    ```

    Because, ```foo()``` is a regular function, so the ```this``` will refer to the global object - ```window```.

    Result: 

    ```
    Simple function call
    true
    ```

    But if we use strict mode, we have:

    ```javascript
    function foo() {
        'use strict';
        console.log("Simple function call");
        console.log(this === window);
    }

    foo()
    ```

    So, we have a result will look something like;

    ```
    Simple function call
    false
    ```

    Now, ```this``` will refer to ```undefined```, not ```window``` object.

- Constructor function

    ```javascript
    function Person(first_name, last_name) {
        this.first_name = first_name;
        this.last_name = last_name;

        this.displayName = function() {
            console.log(`Name: ${this.first_name} ${this.last_name}`);
        }
    }

    let john = new Person('John', 'Reid');
    john.displayName();
    ```

    When we call ```new``` on ```Person``` constructor function, Javascript will create a new object inside the ```Person``` constructor function and save it as ```this```. Then, the ```first_name```, ```last_name``` and ```displayName``` properties will be added on the newly created this object. 

- Simple object

    ```javascript
    function simpleFunction () {
        console.log("Simple function call")
        console.log(this === window); 
    }

    let user = {
        count: 10;
        simpleFunction: simpleFunction, 
        anotherFunction: function() {
            console.log(this === window);
        }
    };
    ```

    When we call ```user.simpleFunction()``` or ```user.anotherFunction()```, we have a result:

    ```
    Simple function call
    false
    ```

    Because ```this``` now refer to the ```user``` object.

    But if we do something like:

    ```javascript
    let ourFunction = user.anotherFunction();
    ourFunction();
    ```

    Then, we have:

    ```
    Simple function call
    true
    ```

    Because ```ourFunction()``` is a regular function, so ```this``` will refer to the global object - window. 

- Embedded regular function into method class

    ```javascript
    var john = {
        name: 'john',
        yearOfBirth: 1990,
        calculateAge: function() {
            console.log(this);
            console.log(2016 - this.yearOfBirth);

            function innerFunction() {
                console.log(this);
            }
            innerFunction();
        }
    }
    ```

    When we call ```john.calculateAge()```, the ```this``` will be implicitly passed into a register. So, ```calculateAge()``` function is called, CPU will get value form that register and assign to the ```this``` keyword such as ```this```, ```this.yearOfBirth````.

    But, inside the ```innerFunction()``` function, ```this``` will not refer to the ```john``` object, mainly because it is a regular function. Therefore, ```this``` in ```innerFunction()``` will refer to global object - ```window```.

- Use arrow function

    Unlike regular function, arrow functions do not get their own ```this``` keyword. They simply use the ```this``` keyword of the function they are written in.

    ```javascript
    var box = {
        color: 'green', // 1
        position: 1, // 2
        clickMe: function() { // 3
            document.querySelector('body').addEventListener('click', function() {
                var str = 'This is box number ' + this.position + ' and it is ' + this.color; // 4
                alert(str);
            });
        }
    }
    ```

    When we call ```box.clickMe()``` method, a result we have:

    ```
    This is box number undefined and it is undefined
    ```

    Because inside the ```clickMe()``` function, ```this``` keyword also is passed to it. But in callback function, ```this``` keyword of ```box``` object do not pass. So, ```this``` in callback function will be ```undefined````.

    To solve this problem, we need to save the ```this``` keyword of ```box``` object into the other variable of ```clickMe()``` function.

    ```javascript
    var box = {
        color: 'green', // 1
        position: 1, // 2
        clickMe: function() { // 3
            let self = this;

            document.querySelector('body').addEventListener('click', function() {
                var str = 'This is box number ' + self.position + ' and it is ' + self.color; // 4
                alert(str);
            });
        }
    }
    ```

    So, we have:

    ```
    This is box number 1 and it is green
    ```

    Another solution is to use arrow function.

    ```javascript
    var box = {
        color: 'green', // 1
        position: 1, // 2
        clickMe: function() { // 3          
            document.querySelector('body').addEventListener('click', () => {
                var str = 'This is box number ' + this.position + ' and it is ' + this.color; // 4
                alert(str);
            });
        }
    }
    ```

    The amazing thing about arrow functions is that they share the lexical ```this``` keyword of their surroundings.

    Then, we have:

    ```
    This is box number 1 and it is green
    ```

    And we still have other case for arrow function such ash.

    ```javascript
    var box = {
        color: 'green', // 1
        position: 1, // 2
        clickMe: () => { // 3          
            document.querySelector('body').addEventListener('click', () => {
                var str = 'This is box number ' + this.position + ' and it is ' + this.color; // 4
                alert(str);
            });
        }
    }
    ```

    When we have ```box.clickMe()```, we have:

    ```
    This is box number undefined and it is undefined
    ```

    The ```this``` keyword of the click event listener’s closure shares the value of the ```this``` keyword of its surroundings. Its surroundings in this case is the arrow function ```clickMe()```. The ```this``` keyword of the ```clickMe``` arrow function refers to the global object, in this case the ```window``` object. 
    
    So, ```this.position``` and ```this.color``` will be ```undefined``` because our ```window``` object does not know anything about the ```position``` or the ```color``` properties.

- Some ways to pass ```this``` in ```map``` function

    Come back to the previous example, we have:

    ```javascript
    function Person(firstName, lastName) {
        this.firstName = firstName;
        this.lastName = lastName;

        this.displayName = function() {
            console.log(`Name: ${this.firstName} ${this.lastName}`);
        }
    }

    Person.prototype.myFriends = function(friends) {
        var arr = friends.map(function(friend) {
            return this.firstName + ' is friends with ' + friend;
        });
        console.log(arr);
    }

    let john = new Person("John", "Watson");
    ```

    So, call ```john.myFriends(["Emma", "Tom"])``` we have a result:

    ```
    "undefined is friends with Emma", "undefined is friends with Tom"
    ```

    Because ```this``` in callback function of ```map``` will refer to the global object - ```window```. 

    To fix this problem, we have 3 solutions: 
    - Save ```this``` keyword inside the other variable in ```myFriends()``` function.

        ```javascript
        Person.prototype.myFriends = function(friends) {
            let self = this;

            var arr = friends.map(function(friend) {
                return self.firstName + ' is friends with ' + friend;
            });
            console.log(arr);
        }
        ```

    - Using ```bind``` on the ```map``` function's closure.

        ```javascript
        Person.prototype.myFriends = function(friends) {            
            var arr = friends.map(function(friend) {
                return this.firstName + ' is friends with ' + friend;
            }.bind(this));

            console.log(arr);
        }
        ```

        Calling ```bind``` will return a new copy of the ```map``` callback function but with a ```this``` keyword mapped to the outer ```this``` keyword, which is, in this case, will be the ```this``` keyword referring to the object calling ```myFriends```.

    - Using arrow function for map function's closure

        ```javascript
        Person.prototype.myFriends = function(friends) {            
            var arr = friends.map(friend => {
                `${this.firstName} is friends with ${friend}`;
            });

            console.log(arr);
        }
        ```

<br>

## Wrapping up
- In regular function, ```this``` refer to global object.
- Arrow function will retain the ```this``` keyword of outer function.


<br>

Thanks for your reading.

<br>

Refer: 

[https://itnext.io/the-this-keyword-in-javascript-demystified-c389c92de26d](https://itnext.io/the-this-keyword-in-javascript-demystified-c389c92de26d)