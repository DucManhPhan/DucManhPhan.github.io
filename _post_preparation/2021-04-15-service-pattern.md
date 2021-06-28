---
layout: post
title: Service Pattern
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Service Pattern](#solution-of-service-pattern)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-pattern)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution of Service Pattern


Belows are some types of service pattern.
1. Application service

    - will change very often and evolve a lot.
    - 
    - 

2. Domain service

    - They are used to model primary operations.
    - i.e. publish tools for modeling processes.

        - that don't have an identity or life-cycle in our domain.
        - that is, that are not linked to one particular aggregate root, perhaps none, or several.

    - In this terminology, services are not tied to a particular person, place, or thing in the application, but tend to embody processes.
    - Main rule is to let the Domain layer focus on the business logic.
    - Named after verbs or business activities.

        - That domain experts introduce into Ubiquitous Language.

    - Should be exposed as client-oriented methods.

        - Following Interface Segregation principle.
        - As a reusable toolbox: do not leak our domain.

    - Application layer services

        - Would use the Domain services.
        - To implement the needs of client applications.

<br>

## When to use





<br>

## Benefits and Drawbacks





<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()