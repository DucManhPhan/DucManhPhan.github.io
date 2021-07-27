---
layout: post
title: Proxy pattern
bigimg: /img/path.jpg
tags: [Structural Pattern, Design Pattern]
---

<br>

## Table of contents
- [Given Problem](#given-problem)
- [Solution of Proxy Pattern](#solution-of-proxy-pattern)
- [When to use](#when-to-use)
- [Benefits & Drawback](#benefits-&-drawback)
- [Code C++ /Java / Javascript](#code-c++-java-javascript)
- [Application & Examples](#application-&-examples)
- [Wrapping up](#wrapping-up)


<br>

## Given Problem






<br>

## Solution of Proxy Pattern

The proxy pattern that acts as an interface to something else. We wrap a real object with a proxy for various reasons. We create an interface to an object by wrapping it with a class to create that proxy. It can also add more functionality to that wrapped object.

A proxy can be used to solve multiple problems such as security or simplifying an interface for something, a remote service call, or just an expensive object to create, we'll oftentimes wrap it with a proxy and display loading message or something like that for an expensive object that we're trying to display to our UI or just load into memory.

The proxy itself is called to access the real object. So we'll have an interface, then a proxy that's wrapping the real object, and then the underlying real object.

Below is a UML diagram of Proxy pattern.

![](../img/design-pattern/proxy-pattern/proxy-pattern.png)

In this diagram, we start off with a Client class that's going to make a reference call to some object, Subject, and rather than it retrieving the real object that we want, it's going to be intercepted with this proxy. So that Subject would be an interface to whatever the implementation class is that we want to retrieve. 

The Proxy using an InvocationHandler, the Proxy class in Java, intercepts that call and makes the call to the RealSubject, or if it's a case like security would deny it or do something different, and turns around and sees if it needs to load that, if it's going to pull it from a cache, or whatever it's going to do, so it then decides to load RealSubject, and returns that back to the Client.

<br>

## Types of Proxy pattern



1. Virtual proxy




2. Remote proxy




3. Smart proxy




4. Protective proxy





<br>

## When to use

- When we want to wrap a real object with a proxy for various reasons.

    




<br>

## Benefits & Drawback






<br>

## Code C++ /Java / Javascript






<br>

## Application & Examples

Some examples of the Proxy pattern in Java.
- java.lang.reflect.Proxy object is a mechanism to facilitate creating proxy patterns using Java.

- java.rmi.* package is focused around proxy and remote method invocation, that is accessing remote objects and retrieving object later.

- Many frameworks like Spring, some uses of Hibernate, and other various dependency injection frameworks use it.


<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer: 

