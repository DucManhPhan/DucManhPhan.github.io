---
layout: post
title: Using ava testing framework
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Ava, Testing, Node.js]
---

To developers, writing test case is a important skill that everyone have to learn and expert. Because you can not code the perfect software, when you can not cover all the case. In Node.js project, it's neccessary to use testing framework such as Ava, Jest, Jasmine, Karma, ... The testing framework will boost your performance and make your life easier. 

Today, I will completely show you how to use Ava testing framework. 

<br>

## Table of Contents
- [Installing Ava](#installing-ava)
- [Use test() function in Ava](#use-test()-function-in-ava)
- [Running test serially](#running-test-serially)
- [Using async keyword](#using-async-keyword)
- [Running specific test](#running-specific-test)
- [Skipping test](#skipping-test)
- [Using assertion](#using-assertion)
- [Use before and after hooks](#use-before-and-after-hooks)
- [Wrapping up](#wrapping-up)

<br>

## Installing Ava
Syntax: 

```
npm install ava --save-dev
```

<br>

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
test('name_action', async t => {
  // prepare data for testing
  // ...

  try {
    // implement test case at here 
    // ... 
    // t.deepEqual(...);
    // t.is(...);
    // t.pass();
  } catch (e) {
    // process when having exceptions
    // ... 
    // console.log(e);
    // t.fail();
  } finally {
    // process something when ending test case 
    // ...
  }
});
```

Note: In order for the enhanced assertion messages to behave correctly, the first arguments must be named t. 

<br>

## Running test serially
By default, tests run concurrently. But when each test case works with I/O operations, it can cause the error. So, you want your test cases that must be run synchronously. 

Use *.serial* modifier, it will force those tests to run serially before the concurrent ones.

Note: In your one test file, you use each test case with *.serial', then test cases will run serially. But when you want to run many test files, all of test files will run concurrently if you do not set the flag *--serial*. 

```Javascript
ava --serial .\\test_folder\\*.js
```

<br>

## Using async keyword
Ava supports asyn function in the second parameter. 

```Javascript
test('action', async t => {
  // do something 
}
```

<br>

## Running specific test
If you only want to run some test cases, not all of test cases. You can use *.only* modifier. 

```Javascript
test.only('action', t => {
  // do something
});
```

Note: You can use the *.only* modifier with all tests. It cannot be used with hooks or .todo().

<br>

## Skipping test
When your test case can not be fixed, you can use the *.skip* modifier to skip this test case. 

```Javascript
test.skip('action', t => {
  // do something
});
```

<br>

## Using assertion
The below is the common assertion that you will need to use. 
- .pass([message]): passing assertion.
- .fail([message]): failing assertion.
- .is(value, expected, [message]): assert that *value* is equal to *expected*.
- .deepEqual(value, expected, [message]): assert that *value* is equal to *expected*.

<br>

## Use before and after hooks
- test.before()           : register a hook to be run before the first test in your test file. 
- test.after()            : register a hook to be run after the last test. 
- test.after.always()     : register a hook that will always run once your tests ans other hooks complete.
- test.beforeEach()       : register a hook to be run before each test in your test file. 
- test.afterEach()        : register a hook to be run after each test.
- test.afterEach.always() : register an after hook that is called even if other test hooks, or the test itself, fail.
- .before() hooks execute before .beforeEach() hooks.
- .afterEach() hooks before .after() hooks.

<br>

## Wrapping up
- Tests run concurrently.
- Each test file is run in a seperate Node.js process. It's greate performance on modern multi-core processors, allowing multiple test files to execute in parallel.

Thanks for your reading.

<br>

Refer: 

[The comparison between ava and jest](https://stackshare.io/stackups/ava-vs-jest)

[Ava testing framework documentation](https://github.com/avajs/ava)

[Assertions in Ava](https://github.com/avajs/ava/blob/master/docs/03-assertions.md)

[Configuration in Ava](https://github.com/avajs/ava/blob/master/docs/06-configuration.md)

[Execution Context in Ava](https://github.com/avajs/ava/blob/master/docs/02-execution-context.md)