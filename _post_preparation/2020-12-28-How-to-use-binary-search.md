---
layout: post
title: How to use binary search
bigimg: /img/image-header/yourself.jpeg
tags: [Algorithm, Binary Search]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Binary Search](#solution-of-binary-search)
- [When to use](#when-to-use)
- [Source code](#source-code)
- [Some variants of Binary Search](#some-variants-of-binary-search)
- [Some examples that uses Binary Search](#some-examples-that-uses-binary-search)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution of Binary Search



1. Some steps to solve problems with Binary Search:
    
    - Pre-processing - Sort if collection is unsorted.

    - Binary Search - Using a loop or recursion to divide search space in half after each comparison.

    - Post-processing - Determine viable candidates in the remaining space.


<br>

## When to use

- When we have to search an element in a collection.

    If our collection is unordered, we can always sort it first before applying Binary Search.

- When we are given a sorted Array or LinkedList or Matrix, and we are asked to find a certain element, the best algorithm we can use is the Binary Search.

- Binary search is not about sorted array or recursion, which are all very superficial. The essence of binary search is to reduce time complexity by eliminating half of the candidates.

<br>

## Source code

1. Iterative version

    ```java

    ```


2. Recursive version

    ```java

    ```


Note:
- With ```int mid = (right + left) / 2;```, if right and left variable is large, then the expression of ```right + left``` can be overflow.

    So, we can have some solutions for this problem:
    - Use ```int mid = left + ((right - left) / 2);```.
    - Use ```int mid = (left + right) >>> 1;```. This way is only suitable for Java developer.
    - With C/C++ developer, we can use ```mid = ((unsigned int)left + (unsigned int)right)) >> 1;```.

<br>

## Some variants of Binary Search




<br>

## Some examples that uses Binary Search

- [Am I A Fibonacci Number](http://www.codechef.com/problems/AMIFIB) (Simple)

- [Codeforces:Eugeny and Play List](http://codeforces.com/problemset/problem/302/B) (Easy)

- [Codeforces:Primes on Interval](http://codeforces.com/problemset/problem/237/C) (Medium)




<br>

## Wrapping up




<br>

Refer:


