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
    - e-commerce
    - payroll

2. Understanding about subdomain

    Using the same idea of the Divider and Conquer algorithm, Domain also need to be splitted into the multiple subdomains. It means that a large problem will be seperated into the smaller problems. But this subproblem is small enough, not too small, mainly because relied on the subdomain, we will create the corresponding [bounded contexts](https://ducmanhphan.github.io/2021-04-19-bounded-context-in-ddd), then, it may lead to some conundrums.
    - creating multiple dto, adapter classes to transfer data between bounded contexts.

        It makes our packages to become messy.

    - it's difficult to remember the work flow logic between bounded contexts.

3. Some types of subdomain

    Belows are some types of subdomain that we need to take care of when desinging an application that use Domain-Driven Design.
    - Core Domain



    - Supporting Domain



    - Generic Domain
        
        


<br>

## How to split Domains into subdomains






<br>

## Benefits and Drawbacks

1. Benefits



2. Drawbacks




<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()