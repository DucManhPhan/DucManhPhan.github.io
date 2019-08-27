---
layout: post
title: Observer Pattern
bigimg: /img/path.jpg
tags: [Design Pattern, Behavioral Pattern]
---

# Given Problem


# Analysis Problem


# Definition of Observer Pattern


# When to use


# Benefits & Drawback
1. Benefits
- abstract coupling between subject and observer. Each can be extended and reused individually.
- dynamic relationship between subject and observer, can be established at run time (can hot-swap views, ...) gives a lot more programming flexibility.
- broadcast communication: notification is broadcast automatically to all interested objects that subscribed to it.
- observer can be used to implement Model-View separation in Java more easily.


# Code C++/Javascript



# Application & Examples
- Write a model class that extends Observable

    have the model notify its observers when anything significant happens.

- make all views of that model (E.g: GUI panels that draw the model on screen) into observers.


Refer: 

Head First Design Pattern

[https://sourcemaking.com/design_patterns/observer](https://sourcemaking.com/design_patterns/observer)

