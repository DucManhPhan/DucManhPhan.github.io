---
layout: post
title: Some non-functional requirement of Distributed system
bigimg: /img/image-header/factory.jpg
tags: [System Design]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Some important non-functional requirements that we need to know](#some-non-functional-requirements-that-we-need-to-know)
- [Availability](#availability)
- [Scalability](#scalability)
- [Resilience](#resilience)
- [Reliability](#reliability)
- [Performance](#performance)
- [Durability](#durability)
- [Wrapping up](#wrapping-up)


<br>

## Given problem





<br>

## Some important non-functional requirements that we need to know

Normally, there are four types of requirements:
- Business requirement
- Stakeholder requirement
- Solution requirement
- Transition requirement

But in this article, we will focus mainly on Solution requirement that contains two types:
- Non Functional requirement

    NFRs relate to the quality, attributes of a system. It usually answers a question: **How does the system work?**.
    
    It influences UX of the end users. For example, assuming that our server can work under 100 request per second, but the number of requests at the rush hour are two times than the normal condition. So, our server can't suffer that large amount concurrent users. So, to load information from server, the clients such as mobile, web, take so much times. 

- Functional requirement

    FRs are used to describe the behaviors and functionalities that a system has to implement its Domain Business. It answers a question: **What does the system do?**.

    They are considered as the skeleton of a body.

In system design interview, belows are some important NFRs that we need to take care.
- Availability
- Scalability
- Resilience
- Reliability
- Performance

<br> 

## Availability

Availability is the probability that a system is operational at a given point in time under some conditions. In reality, we can use **uptime** word to describe the amount of time that a system is available, and **downtime** word for the contrast case.

It means that availability is calculated by the below formular:

```java
availability = uptime / (uptime + downtime)
```

Normally, availability is usually expressed as a percentage of uptime in a given year. To know more about the percentage of availability, read other article [https://en.wikipedia.org/wiki/High_availability](https://en.wikipedia.org/wiki/High_availability). After read it, we can find that the number of nines is used to measure availability.

High availability is the ability of the system guaratees that it's always working regardless of having failures at the infrastructural level in real time. The gold standard of high availability is five nines availability 99.999%, it takes 6 minutes downtime in a year. This percentage of availability is clearly written in the SLA - Service Level Aggreements of cloud platforms. 

To make a system satisfy high availability, there are some principles that we need to follow:
1. Elimination of Single point of failure
2. Reliable crossover 
3. Dectection of failures as they occur

Belows are some ways to achieve high availability.
- Fault Tolerance

    Fault tolerance is the ability of a system that still remains working when one or more components die. Then, it can recover to its original state without affecting to the other parts of a system.

    It means that our system doesn't have the down time even if a part of a system failed. This is also a distinction between fault tolerance and high availability.

- Redundancy

- Replication

    Difference between replication and caching:
    - caches don't necessarily hold collections of objects such as files in their entirely. So caching doesn't necessarily enhance availability at the application level - a user may have one needed file but not another.

<br>

## Scalability

To know more about scalability, we can refer to the following link [Understanding about Scalability in System Design](http://ducmanhphan.github.io/2020-02-10-Understanding-about-scaling-in-system-design).

<br>

## Resilience









<br>

## Reliability

Before understanding about reliability, some concepts that are vital for us:
- a fault means that one component of the system deviate from its spec.

    It's impossible to reduce the probability of a fault to zero, therefore it is usually best to design fault-tolerance mechanisms that prevent faults from causing failures.

- a failure means when the system as a whole stops providing the required service to the user.

Reliability is the ability of the system that continues working correctly under the faults of software and hardware, human errors. 

To improve reliability of the system, we 

<br>

## Performance

In system design, software engineers always want to design a high performance system work smoothly under the large amount of users. It means that performance requirements define how well a system accomplishes certain functions under specific conditions.

Belows are some essential parameters for performance requirements:
- Latency and Throughput

    **Latency** is the time that transfer data from the client to the server and vice versa. It is called the rounded-trip time. So, the **latency** is completely affected by the hardware.

    **Throughput** is the amount of completed work per the total of work in a given period of time.

- Response time

    The **response time** is calculated from the client that starts sending a request until receiving results from this request. It means that the response time is equal to the sum of rounded-trip time or the latency between client and server, and the **execution time** of business operations such as the calculation time on server and the interaction time between server and the other external parts - message queue, cache, database.

    So, we have the formula to calculate the response time:

    ```java
    response time = latency + execution time
    ```

    We can easily find that we do not change the **latency**, but we can improve the **execution time** by using caches, or using index, temporary memory table in database.

    In some books, the **execution time** can also be called as the **service time**.

- The number of TPS (Transaction Per Second) 

- Hardware's storage capacity and network

    - About network

        Bandwidth is the amount of data that can be transferred throughout the network at any given time.
        
        In network, we also have a concept of throughput, is the amount of data that can be transferred over a given period of time.

        Before jump to enhance the latency of a system, there are some causes that make the low latency and the corresponding solution for each problem.
        - network's harware device

            Firstly, it is the material that makes a cable. And then the router, takes time to analysis the header of a packet and then find the optimal path to send a destination.

            Solution for this problem:
            - Choose the suitable partner that provides good hardware devices and services, fix the problems quickly.

        - Distance between the client and the server

            Because we don't take care about the hardware devices problem, so the distance can be solvable problem. To deal with it, we will look at the below solutions.

            Solution:
            - Using CDN because it will choose resources closer to the user by caching them in multiple locations around the world.
            - Rent some supplier's servers in countries that we want to develop.

        - The amount of data

            When we have a large size of data, to transfer that data to a destination, we need to split it into enormous packets. So the latency will increase so much time.

            Solution:
            - With a large data, the first thing we need to solve it is to use browser caching for that data to reduce requests to the server.
            - Beside the browser caching way, we can use encryption to optimize the size of that data. Normally, the browser also support multiple the default encryption/decryption mode, so we need to take advantage it.
            - Using HTTP/2, gRPC, websocket, ... over HTTP/1.

                HTTP protocol will pack the raw data with multiple layer according to OSI model. So gRPC, websocket, ... will reduce them to optimize the sending data. HTTP/2 helps reduce server latency by minimizing the number of of round trips from the sender to the receiver and with parallelized transfers.

    - About hardware's storage device

        To improve the performance of system, using the higher configuration of a server.

<br>

## Durability






<br>

## Wrapping up

- 
- 
- 
- 

<br>

Refer:

[Designing Data-Intesive Applications by Martin Kleppmann]()

[https://thinhnotes.com/chuyen-nghe-ba/23-loai-non-functional-requirement-troi-noi-it-ai-de-y/](https://thinhnotes.com/chuyen-nghe-ba/23-loai-non-functional-requirement-troi-noi-it-ai-de-y/)

[https://towardsdatascience.com/availability-in-distributed-systems-adb43df78b9a](https://towardsdatascience.com/availability-in-distributed-systems-adb43df78b9a)

[https://www.slideshare.net/sumitjain2013/fault-tolerance-in-distributed-systems](https://www.slideshare.net/sumitjain2013/fault-tolerance-in-distributed-systems)

[https://www.imperva.com/learn/availability/fault-tolerance/](https://www.imperva.com/learn/availability/fault-tolerance/)

<br>

**Latency**

[https://medium.com/@sanjay.rajak/api-latency-vs-response-time-fe87ef71b2f2](https://medium.com/@sanjay.rajak/api-latency-vs-response-time-fe87ef71b2f2)

[https://www.comparitech.com/net-admin/latency-vs-throughput/](https://www.comparitech.com/net-admin/latency-vs-throughput/)

[http://www.javidjamae.com/2005/04/07/response-time-vs-latency/](http://www.javidjamae.com/2005/04/07/response-time-vs-latency/)

[https://stackoverflow.com/questions/58082389/what-is-the-difference-between-latency-and-response-time](https://stackoverflow.com/questions/58082389/what-is-the-difference-between-latency-and-response-time)

[http://www.javidjamae.com/2005/04/07/response-time-vs-latency/](http://www.javidjamae.com/2005/04/07/response-time-vs-latency/)

[https://www.keycdn.com/support/what-is-latency](https://www.keycdn.com/support/what-is-latency)

<br>

**Replication**

[Distributed system - Concepts and Design Fifth Edition](https://repository.dinus.ac.id/docs/ajar/George-Coulouris-Distributed-Systems-Concepts-and-Design-5th-Edition.pdf)