---
layout: post
title: Understanding about scaling in system design
bigimg: /img/image-header/factory.jpg
tags: [Distributed System]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Scalability](#solution-with-scalability)
- [Vertical scaling](#vertical-scaling)
- [Horizontal scaling](#horizontal-scaling)
- [Best practices for scalability](#best-practices-for-scalability)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Nowadays, when we are working as the back-end developer for web application, we always want to design a system that can suffer from multiple requests over the world. The problem of the system that has one thousand requests is very different than the system that has one million requests.

Some problems that we will encounter:
- each request will be needed to process and it takes space in our servers.

    In Java Servlet, each request will correspond to one thread. So, one server does not have enough resources to serve million requests at the same time.

- bandwidth for multiple requests

    Each server will have the limit number of bandwith. Therefore, multiple requests come to one server take so much bandwidth. And we do not calculate the round-trip time between client and server. It is easy to make our system has the high latency.

    If we do not handle them, it makes users have the bad experience.

- multiple requests will create multiple conflicts in the persistence tier such as database.

    In relational database, we have a transaction concept that satisfies ACID properties. Then it has shared lock and exclusive lock to protect data in database to reduce race condition case.

    But using lock will decrease our system's performance.

<br>

## Solution with Scalability

To solve all problems, 



<br>

## Vertical scaling

1. Introduction to vertical scaling





2. Benefits and Drawbacks

    - Benefits

        - 
        - 
        - 

    - Drawbacks

        - 
        - 
        - 

<br>

## Horizontal scaling

1. Introduction to horizontal scaling




2. Some configurations to implement horizontal scaling

    - Active-Passive



    - Master-Slave



    - Cluster



    - Sharding



3. Benefits and Drawbacks

    - Benefits

        - 
        - 
        - 

    - Drawbacks

        - 
        - 
        - 


<br>

## Best practices for scalability







<br>

## Wrapping up




<br>

Refer:

[https://www.oshyn.com/blog/2011/11/mysql-scaling-options](https://www.oshyn.com/blog/2011/11/mysql-scaling-options)

[]()

[]()

[]()