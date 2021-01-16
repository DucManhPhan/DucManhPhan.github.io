---
layout: post
title: Bounded Context in DDD
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Bounded Contexts](#solution-with-bounded-contexts)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Given problem






<br>

## Solution with Bounded Contexts

1. Introduction to Bounded Context

    The term bounded context refers to the circumstances in which certain words of the ubiquitous language have certain meaning. Each context uses a particular dialect of the ubiquitous language, and each one is optimized to solve a specific problem.



2. Some examples about Bounded Contexts

- Pharmacy application

    In the pharmacy network, we found that we had three bounded context. These were ```Rebates```, ```Sales```, and ```Performance```.

    - The Rebates bounded context captured all the rules of the rebate contracts. It was primarily the domain of the account manager. They would specify the measured product groups for each of the Rebates, their measurement methods, and the awarded tiers, and they would set up the roles of the contracts.

    - The Sales bounded context recorded the sales history of each member. Information from the e-commerce and fulfillment systems fed into the sales area.

    - The Performance bounded context calculated the performance of each member toward each of the rebates. It combined the rebated specifications with the sales data to perform its calculations. It presented the outcome of these calculation in the form of report cards for the members to view online.

    We found this break down of the problem into bounded context to be preferable to modeling the entire domain as one enterprise data model. We found that for each context we were trying to solve a specific problem. We could optimize that model specifically for that problem and not have to compromise in order to allow some other context to share the model.

    For example, in the Rebate context, we were primarily interested in providing the account manager with the capability of editing the roles of a rebate contract, but once a rebate enters the performance context, it needs to be optimized for a different purpose. In Performance context it needs to be optimized for rapid calculation. The data structures that we chose in each context were subtly different to satisfy each need.

    In the Rebate context, they tended to be more mutable and interactive so that the account managers could make changes, but in the Performance context, they tended toward immutable and pluggable strategies so that we could form them into a pipeline of calculations.


    - Related to the CAP Theorem

        Bounded contexts also offer benefits over enterprise data models in terms of the CAP theorem. An enterprise data model represents one tightly interconnected cluster of nodes in the distributed system where consistency is prioritized over availability. Any party that needs a consistent view of any part of the enterprise needs to make a connection to this one cluster. The more consumers that connect to it, the less available it becomes. The only way to combat this trend is to reduce the likehood of a network partition by spending more money on expensive hardware and network management.

        An enterprise model forces us to scale up rather than scaling out, but a bounded context represents a smaller cluster of nodes. It's decoupled from the other contexts. Because it has its own model, it's not reliant upon its connection to those other contexts. It can make decisions based only on the information that it has on hand. A bounded context could be written to favor availability over consistency. If the system of record is down, then the downstream system is unaffected. It already has a cache of the data that it needs organized and optimized for the problems that it is designed to solve. This isn't automatic. We have to conscientiously choose to build this kind of capability using CQRS, Event Sourcing, or any the other patterns and techniques that we're going to look at, but this is a choice that we don't easily have if we use an enterprise data model.

<br>

## Benefits and Drawbacks

1. Benefits



2. Drawbacks



<br>

## Wrapping up




<br>

Refer:

[Modelling Bounded Contexts with the Bounded Context Canvas: A Workshop Recipe](https://medium.com/nick-tune-tech-strategy-blog/modelling-bounded-contexts-with-the-bounded-context-design-canvas-a-workshop-recipe-1f123e592ab)

[DDD Strategic Patterns: How To Define Bounded Contexts](https://codeburst.io/ddd-strategic-patterns-how-to-define-bounded-contexts-2dc70927976e)

[BoundedContext](https://martinfowler.com/bliki/BoundedContext.html)

[Practical DDD: Bounded Contexts + Events => Microservices](https://www.infoq.com/presentations/microservices-ddd-bounded-contexts/)

[https://vngeeks.com/bounded-context/](https://vngeeks.com/bounded-context/)

[https://dzone.com/articles/implementing-a-bounded-context](https://dzone.com/articles/implementing-a-bounded-context)

[Defining Bounded Contexts — Eric Evans at DDD Europe](https://www.infoq.com/news/2019/06/bounded-context-eric-evans/)

[Discovering the Domain Architecture](https://www.microsoftpressstore.com/articles/article.aspx?p=2248811)