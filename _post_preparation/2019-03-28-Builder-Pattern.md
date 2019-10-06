---
layout: post
title: Builder Pattern
bigimg: /img/path.jpg
tags: [creational pattern, design pattern, clean code]
---





<br>

## Table of contents
- [Given Problem](#given-problem)
- [Solution of Builder Pattern](#solution-of-builder-pattern)
- [When to use](#when-to-use)
- [Benefits & Drawback](#benefits-&-drawback)
- [Code C++ /Java / Javascript](#code-c++-java-javascript)
- [Application & Examples](#application-&-examples)
- [Wrapping up](#wrapping-up)


<br>

## Given Problem 



<br>

## Solution of Builder Pattern



<br>

## When to use



<br>

## Benefits & Drawback
1. Benefits



2. Drawbacks
- Objects with the Builder pattern is typically designed to immutable.

- The pattern itself is also implemented with a static inner class.

- Designed first because unlike Protorype pattern, it is not something that is usually refactored in after the fact.

- It does add a little bit more complexity to our implementing class over what could've been done with just a constructor, but without some of the nice features of the builder patterns.

<br>

## Code C++ /Java / Javascript



<br>

## Application & Examples
- StringBuilder in Java

    The good thing about it is it is really performant, and it gives us a nicer way to build strings rather than using plus sign or the concat operator inside the string object.

    It is also a lot more performant than the StringBuffer object. The StringBuffer object does some locking much like the old vector object did compared to an array list, and this will result in faster performance for our application.


<br>

## Relations with other patterns
- Compare Buider pattern and Prototype pattern

    |             Builder            |                 Prototype                |
    | ------------------------------ | ---------------------------------------- |
    | - handles complex constructors | - implemented around a clone             |
    | - no interface required        | - avoid calling complex constructors     |
    | - can be a separate class      | - difficult to implement in legacy code  |



<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer: 
