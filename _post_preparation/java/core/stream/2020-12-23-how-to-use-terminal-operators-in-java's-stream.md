---
layout: post
title: How to use the terminal operators in Java's stream
bigimg: /img/image-header/yourself.jpeg
tags: [Functional Programming]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of the terminal operators]()
- [forEach() operator](#forEach()-operator)
- [reduce() operator](#reduce()-operator)
- [collect() operator](#collect()-operator)
- [max() operator](#max()-operator)
- [min() operator](#min()-operator)
- [average() operator](#average()-operator)
- [anyMatch() operator](#anyMatch()-operator)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem





<br>

## Solution of the terminal operators 

Before to be aware of more about the terminal operators of the Java'stream, we can read up on about the concepts of Java's stream in [Understanding about stream in Java 8](https://ducmanhphan.github.io/2019-05-27-Understanding-about-stream-in-Java-8/).

In Java's stream, there are two types of operators:
- Intermediate operator

    These operators will support to preprocess data before sending to the terminal operators.

    Using intermediate operators doesn't make a stream works immediately. It's called lazy evaluation.

- Terminal operators

    Terminal operators are operators that when we called them, our stream will be evaluated.

In our article, we only focus mainly on how many terminal operators, and how it works, then how we can apply in our source code.

Generally speaking, there are some terminal operators that we need to know.
1. forEach() operator
2. reduce() operator
3. collect() operator
4. max() operator
5. min() operator
6. average() operator
7. anyMatch() operator
8. 
9. 
10. 

<br>

## forEach() operator




<br>

## reduce() operator


For example:

```java
List<Integer> prices = Arrays.asList(6, 3, 5, 9, 12);
final int max = prices.stream()
                      .reduce(0, Math::max);  
```



<br>

## collect() operator




<br>

## max() operator




<br>

## min() operator




<br>

## average() operator




<br>

## anyMatch() operator






<br>

## 






<br>

## 






<br>

## 






<br>

## 






<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()

[]()