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





<br>

## Scalability




<br>

## Resilience






<br>

## Reliability






<br>

## Performance

In system design, software engineers always want to design a high performance system work smoothly under the large amount of users. It means that performance requirements define how well a system accomplishes certain functions under specific conditions.

Belows are some essential parameters for performance requirements:
- Response time

    The response time is calculated from the client that starts sending a request until receiving results from this request. It means that the response time is equal to the sum of rounded-trip time between client and server, and the execution time of business operations such as the calculation time on server and the interaction time between server and the other external parts - message queue, cache, database.

- Latency and Throughput

    Latency 

- The number of TPS (Transaction per Second) 

- Storage capacity



<br>

## Durability






<br>

## Wrapping up




<br>

Refer:

[https://thinhnotes.com/chuyen-nghe-ba/23-loai-non-functional-requirement-troi-noi-it-ai-de-y/](https://thinhnotes.com/chuyen-nghe-ba/23-loai-non-functional-requirement-troi-noi-it-ai-de-y/)

<br>

**Latency**

[https://medium.com/@sanjay.rajak/api-latency-vs-response-time-fe87ef71b2f2](https://medium.com/@sanjay.rajak/api-latency-vs-response-time-fe87ef71b2f2)

[https://www.comparitech.com/net-admin/latency-vs-throughput/](https://www.comparitech.com/net-admin/latency-vs-throughput/)

[http://www.javidjamae.com/2005/04/07/response-time-vs-latency/](http://www.javidjamae.com/2005/04/07/response-time-vs-latency/)

[https://stackoverflow.com/questions/58082389/what-is-the-difference-between-latency-and-response-time](https://stackoverflow.com/questions/58082389/what-is-the-difference-between-latency-and-response-time)