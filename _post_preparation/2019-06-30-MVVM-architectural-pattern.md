---
layout: post
title: MVC architecture pattern
bigimg: /img/image-header/home-office-1.jpg
tags: [architecture pattern, design pattern]
---




<br>

## Table of contents
- [Given Problem](#given-problem)
- [Analysis Problem](#analysis-problem)
- [Definition of MVVM Pattern](#definition-of-mvvm-pattern)
- [When to use](#when-to-use)
- [Code C++/Javascript](#code-C++/Javascript)
- [Application & Examples](#application-&-examples)


<br>

## Given Problem 




<br>

## Analysis Problem



<br>

## Definition of MVVM Pattern




<br>

## When to use



<br>

## Benefits & Drawback
- Benefits

    - MVVM facilitates easier parallel development of a UI and the building blocks that power it.
    - MVVM abstracts the View and thus reduces the quantity of business logic (or glue) required in the code behind it.
    - The ViewModel can be easier to unit test than in the case of event-driven code.
    - The ViewModel (being more Model than View) can be tested without concerns of UI automation and interaction.

- Drawbacks

    - For simpler UIs, MVVM can be overkill.
    - While data bindings can be declarative and nice to work with, they can be harder to debug than imperative code where we simply set breakpoints.
    - Data bindings in non-trivial applications can create a lot of bookkeeping. We also don't want to end up in a situation where bindings are heavier than the objects being bound to.
    - In larger applications, it can be more difficult to design the ViewModel up front to get the necessary amount of generalization.

<br>

## Code C++/Javascript




<br>

## Application & Examples





<br>

## Wrapping up



<br>

Refer: