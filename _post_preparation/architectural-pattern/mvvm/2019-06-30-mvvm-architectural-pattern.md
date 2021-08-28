---
layout: post
title: MVC architecture pattern
bigimg: /img/image-header/home-office-1.jpg
tags: [Architecture Pattern]
---




<br>

## Table of contents
- [Analysis Problem](#analysis-problem)
- [Definition of MVVM Pattern](#definition-of-mvvm-pattern)
- [When to use](#when-to-use)
- [Code C++/Javascript](#code-C++/Javascript)
- [Application & Examples](#application-&-examples)


<br>

## Analysis Problem



<br>

## Definition of MVVM Pattern


Below is the image about MVVP pattern.

![](../img/Architecture-pattern/MVVM-pattern/MVVM-Pattern.png)

<br>

## When to use
- Our screen holds many Views, at this point, it is easier to make each View subscribe on it's data source in the ViewModel and handle itself when this data source changes.

- Our screen has a One-Directional-Flow, it means that the events are coming from the Model, and affecting the View without any user interactions.

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
You can refer to the following repository:

[https://github.com/DucManhPhan/AutoCAD/tree/master/Draw_Balloon_NET](https://github.com/DucManhPhan/AutoCAD/tree/master/Draw_Balloon_NET)

<br>

## Application & Examples
- WPF
- Silver Light
- KnockoutJS
- Angular

<br>

## Wrapping up
- View hold a reference to the ViewModel, but ViewModel is not aware of the View. So, one ViewModel can have multiple Views.

- Unlike the MVC pattern, MVVM pattern have the Model that is coupled from the View. ViewModel interacts with the Model and push data to the View.

<br>

References:

[]()

[]()

[]()

[]()