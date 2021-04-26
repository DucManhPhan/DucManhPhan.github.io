---
layout: post
title: How to use ambiguous operators in RxJava 3.x
bigimg: /img/image-header/yourself.jpeg
tags: [Reactive Programming]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with ambiguous operators](#solution-with-ambiguous-operators)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution with ambiguous operators


1. Observable.amb() factory method

    The Observable.amb() factory (amb stands for ambiguous) accepts an Iterable<Observable<T>> object as a parameter and emits the values of the first Observable that emits, while the others are disposed of. This is helpful when there are multiple sources of the same data or events and you want the fastest one to win.

2. ambWith() operator



3. ambArray() operator

    Use ambArray() to specify a varargs array rather than Iterable<Observable<T>>.




<br>

## When to use





<br>

## Wrapping up




<br>

Refer:

