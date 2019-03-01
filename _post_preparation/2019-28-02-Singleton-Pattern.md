---
layout: post
title: Singleton Pattern
bigimg: /img/path.jpg
tags: [creational pattern, design pattern]
---







<br>

## Table of contents
- [Given Problem](#given-problem)
- [Solution of Singleton Pattern](#solution-of-singleton-pattern)
- [When to use](#when-to-use)
- [Why not to use](#why-not-to-use)
- [Benefits & Drawback](#benefits-&-drawback)
- [Replace singleton pattern with single instance](#replace-singleton-pattern-with-single-instance)
- [Code C++ /Java / Javascript](#code-c++-java-javascript)
- [Application & Examples](#application-&-examples)
- [Wrapping up](#wrapping-up)


<br>

## Given Problem 
When we only need one instance for a class and global access for this instance, simply because this class is responsible for managing one state, or single functionality, ... So we do not need to make many instances for their case. 

For example: setting part in programming software, logging, ...

<br>

## Solution of Singleton Pattern
Singleton pattern is a creational design pattern that restricts the instantiation of a class to one object.

In Singleton, there are two ways to create instance.
- pre-initialized - it means that this instance will be instantiate before somecone call the method ```getInstance()```.
- lazy-initialized - it means that this instance will be instantiate during the first call of the method ```getInstance()```.


![Singleton Pattern with UMML](../img/design-pattern/singleton-pattern/singleton.png)

In this UML diagram, Singleton pattern has some parts:
- ```instance: Singleton```: Singleton class has the unique instance.
- ```getInstance(): Singleton```: This is a public method to provide the only way to get the unique instance of Singleton. This method can be called from anywhere since it's a class method.
- ```Singleton()```: It is a private constructor to prevent someone creating additional an object of this Singleton class.
- In Singleton, there are some methods to implement business logic.


<br>

## When to use
- When we need only one resources (a database connection, a socket connection, ...)
- To avoid multiple instances of a stateless class to avoid memory waste.
- For business reasons.


<br>

## Why not to use
- Singleton hides the dependencies between classes  instead of exposing them through the interface. This means we need to read the code of each method to know if a class is using another class.

- Singleton violates the ```Single Responsibility Principle```, they control their own creation and lifecycle (using lazy initialization, the Singleton chose when it is created). A class should only focus on what it is used to do.

    If we have Singleton that manages people, it should only manage people and not how/when it is created. 

- They inherently cause code to be tightly coupled. This makes faking or mocking them for unit testing very difficult.

- They carry states around for the lifetime of the application (for stateful singletons).
    - It makes unit testing difficult since we can end up with a situation where tests need to be ordered which is a piece of nonsence. By definition, each unit test should be independent from each other. 
    - Moreover, it makes the code less predictable. 


<br>

## Benefits & Drawback



<br>

## Replace singleton pattern with single instance






<br>

## Code C++ /Java / Javascript



<br>

## Application & Examples



<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer: 
