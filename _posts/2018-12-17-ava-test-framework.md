---
layout: post
title: Using ava testing framework
bigimg: /img/image-header/ravashing-beach.jpg
tags: [ava testing]
---

To developers, writing test case is a important skill that everyone have to learn and expert. Because you can not code the perfect software, when you can not cover all the case. In Node.js project, it's neccessary to use testing framework such as Ava, Jest, Jasmine, Karma, ... The testing framework will boost your performance and make your life easier. 

Today, I will completely show you how to use Ava testing framework. The content of this article is contained some parts: 
- Installing Ava
- How to use test function in Ava
- Some informations that need to note


## Installing Ava
Syntax: 

```
npm install ava --save-dev
```


## Use test() function in Ava
In order to use test() function in ava, you can use two ways to get test() function; 

```Javascript
import test from 'ava'  // ES6 syntax

or 

const test = require('ava');
```

test() function have the parameters that include title - string type, and asynchronous function. 

Title must be unique within each test file. The asynchronous function will be called when your test is run. It's passed an execution object as its first argument. 

Ex: 

```Javascript
test('', async t => {
  // prepare data for testing
  // ...

  try {
    // implement test case at here 
    // ...
  } catch (e) {
    // process when having exceptions
    // ...
  } finally {
    // process something when ending test case 
    // ...
  }
});
```

Note: In order for the enhanced assertion messages to behave correctly, the first arguments must be named t. 




## Notice






Refer: 

[Ava testing framework documentation](https://github.com/avajs/ava)

[Assertions in Ava](https://github.com/avajs/ava/blob/master/docs/03-assertions.md)

[Configuration in Ava](https://github.com/avajs/ava/blob/master/docs/06-configuration.md)

[Execution Context in Ava](https://github.com/avajs/ava/blob/master/docs/02-execution-context.md)