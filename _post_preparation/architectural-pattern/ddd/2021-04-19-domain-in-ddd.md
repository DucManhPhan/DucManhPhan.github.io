---
layout: post
title: Domain in DDD
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Domain concept in DDD](#solution-with-domain-concept-in-ddd)
- [How to split Domains into subdomains](#how-to-plit-domain-into-subdomains)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution with Domain concept in DDD

1. Introduction to Domain concept

    In reality, Domain represents a problem in business.

    For example:
    - E-commerce
    - Payroll

2. Understanding about subdomain

    Using the same idea of the Divider and Conquer algorithm, Domain also need to be splitted into the multiple subdomains. It means that a large problem will be seperated into the smaller problems. But this subproblem is small enough, not too small, mainly because relied on the subdomain, we will create the corresponding [bounded contexts](https://ducmanhphan.github.io/2021-04-19-bounded-context-in-ddd), then, it may lead to some conundrums.
    - creating multiple dto, adapter classes to transfer data between bounded contexts.

        It makes our packages to become messy.

    - it's difficult to remember the work flow logic between bounded contexts.

3. Some types of subdomain

    Belows are some types of subdomain that we need to take care of when desinging an application that use Domain-Driven Design.
    - Core Domain

        It is the most important part of the system. It means that this core domain expresses the true business logic of our domain. Our system can't live without this core domain. It means that if we seperate this core domain, the system doesn't work correctly.

        For example:
        - In the online course registration application, the Scheduler subdomain is the core domain.

    - Supporting Domain



    - Generic Domain
        
        


<br>

## When to use Domain-Drive Design in a project

- When the project we are working on has a lot of complex business rules. Donmain-driven design help us if we work with big data, need to achieve outstanding performance, or program against hardware systems.

    So the only purpose of DDD is to tackle business logic complexity.

<br>

## Benefits and Drawbacks

1. Benefits

    - It extracts the central part of the problem domain and simplify it, removing most the necessary complexity. The ability to express business logic in the clearest way possible is a single trait that makes domain-driven design so appealing in enterprise-level applications. Uncontrollable growth of complexity is one of the biggest reasons why software projects fail.
    - 
    - 

2. Drawbacks

    - 
    - 
    - 


<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()