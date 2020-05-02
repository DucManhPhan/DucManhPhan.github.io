---
layout: post
title: Introduction to Recursion
bigimg: /img/image-header/home-office-2.jpg
tags: [Algorithm]
---



<br>

## Table of Contents
- [Introduction to Recursion]()
- [Principle of Recursion]()
- [Recurrence Relation]()
- [Some types of Recursion](#some-types-of-recursion)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to Recursion

Recursion is an approach to solving problems using a function that calls itself as a subroutine.

You might wonder how we can implement a function that calls itself. The trick is that each time a recursive function calls itself, it reduces the given problem into subproblems. The recursion call continues until it reaches a point where the subproblem can be solved without further recursion.

A recursive function should have the following properties so that it does not result in an infinite loop:
- A simple base case (or cases) — a terminating scenario that does not use recursion to produce an answer.
- A set of rules, also known as recurrence relation that reduces all other cases towards the base case.

Note that there could be multiple places where the function may call itself.

<br>

## Recurrence Relation

There are two important things that one needs to figure out before implementing a recursive function:
- recurrence relation: the relationship between the result of a problem and the result of its subproblems.

- base case: the case where one can compute the answer directly without any further recursion calls. 

    Sometimes, the base cases are also called bottom cases, since they are often the cases where the problem has been reduced to the minimal scale, i.e. the bottom, if we consider that dividing the problem into subproblems is in a top-down manner.

Once we figure out the above two elements, to implement a recursive function we simply call the function itself according to the recurrence relation until we reach the base case.


<br>

## Some types of Recursion






<br>

## Wrapping up






<br>

Refer:

[https://gravitymodel.net/database-architecture-and-cap-theory/](https://gravitymodel.net/database-architecture-and-cap-theory/)

[https://gravitymodel.net/database-distributed-architecture/](https://gravitymodel.net/database-distributed-architecture/)