---
layout: post
title: Understanding about Domain Driven Design
bigimg: /img/image-header/california.jpg
tags: [Architecture Pattern]
---



<br>

## Table of contents
- [Introduction to Domain Driven Design](#introduction-to-domain-driven-design)
- [The structure of Domain Driven Design](#the-structure-of-domain-driven-design)
- [Core concepts - Ubiquitous Language](#core-concepts-ubiquitous-language)
- [Core concepts - Bounded Contexts](#core-concepts-bounded-context)
- [Core concepts - Aggregate Roots](#core-concepts-aggregate-roots)
- [Layered architecture](#layered-architecture)
- [Aggregate Boundaries](#aggregate-boundaries)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#Benefits-and-Drawbacks)
- [Code Java](#code-java)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to Domain Driven Design




<br>

## The structure of Domain Driven Design




<br>

## Core concepts - Ubiquitous Language

The process of Domain Driven Design begins by agreeing upon a ubiquitous language between the developers and the business owners. This isn't something that we can just jot down in one or two meetings. This is a continuous cultivation and curation of language over the entire lifetime of the project.

All of the code is modeled and written using the terms from this ubiquitous language, so any change to the ubiquitous language necessitates a change to the model. That indicates that the understanding has evolved in some way, and so the model has to evolve to capture that new understanding.

A ubiquitous language allows developers and business owners to communicate with one another without having to translate. Assumptions tend to get lost in the translation because each party assigns their own meaning to the words that they use to communicate with the other, but by agreeing upon a ubiquitous language that forces the two parties to define their terms and flushes assumption into the light.

For example:

Assuming that we encountered an application of a pharmaceutical network by using DDD. **The network negotiates rebates from pharmaceutical manufacturers on behalf of their members. The members log into the application to track their sales performance towards earning these rebates**. This started with agreeing upon a ubiquitous language. Here are some of the terms that we had to come to agree upon.
- Rebate - A contract negotiated by the network with manufacturers on behalf of members.

    To developer, a rebate was just an instance of receiving money for sending in a receipt, but the business owners this was a very different terms.

- ProductGroup - A collection of products all by the same manufacturer, the sales of which are measured for a rebate.
- Drug Class - A collection of product groups from different manufacturers that compete in the marketplace.
- Method - A formula for calculating performance against the rebate based on sales.

    The term Method was particularly difficult to agree upon. At first the business owners referred to this as a Rebate Type. The development team had a hard time understanding what exactly a rebate type meant. The word type is just too generic. It doesn't indicate what differentiates one type from another. Maybe one type of rebate awards a fixed dollar amount while another type offers a discounted price.

    Only by asking for several different examples of rebate types did the development team glean a clearer understanding of its intent. In this case, the term rebate type only referred to the method by which performance was calculated, so we pushed back and asked for a change in the ubiquitous language.

    Now, coming from a developer background, the term that made sense to us was performance strategy. After all, the strategy pattern allows us to replace one means of calculation with another at runtime, and this was in fact the design pattern that we chose to apply to solve this problem, but the business owners didn't have the background of design pattern. They would have to conform to a developer way of thinking for this to make sense to them, so in the end we came to agree on the term method. This was a compromise that satisfied both parties. On the one hands, the developers were satisfied that we didn't have to have an ill-defined term like type in the ubiquitous language, but on the other hand, we didn't force the business owners to conform to development word like strategy.

    In most projects, we would have just simply allowed the term rebate type to appear in the specifications and then replaced it with performance strategy in the code, but by taking the time to agree upon a ubiquitous language we had a clearer communication among all the members of the team without hidden assumptions that would go along with each the terms.

- Measurement Period - A duration of time over which sales are aggregated to determine performance.


<br>

## Core concepts - Bounded Contexts

The term bounded context refers to the circumstances in which certain words of the ubiquitous language have certain meaning. Each context uses a particular dialect of the ubiquitous language, and each one is optimized to solve a specific problem.

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

## Core concepts - Aggregate Roots

Each bounded context has its own domain model. A domain model is made up of entities and value objects.
- An entity is something that has inherent identity and that can change over time.

    - Identity
    - Mutalbe

- A value object has no identity of its own, and it's immutable.

When modeling the entities and value objects in a bounded context, Evans describes them in terms of aggregates. An aggregate is made up of several different objects composed into a single business unit. Business operations are performed on this aggregate rather than on the individual entities and value objects within the unit. The top level entity within this unit of objects is called the aggregate root. There are a few rules that Evans lays out related to aggregates and aggregate roots. We can categorize these rules as identity rules, reference rules, and operation rules.

- Identity

    The root of an aggregate is an entity, not a value object, and the root has global identity whereas other entities within the aggregate have a local identity. So, the root is an entity, and the root has global identity.

    Remember the difference between entities and value objects. Entities have identity, and value objects don't.

    Identity is the property of an object that uniquely differentitates it from other objects. It allows us to act upon one object without affecting another one, so this first rule ensures that we can uniquely identify the root of an aggregate and differentiate it from any other aggregate root in the system. That second rule is further starting that we cannot global identify any other identity in the aggregate. We can't search for one of the child objects in order to find which aggregate it belongs to. We have to identity the root, and then we can walk down to the child.

- Reference

    - The root is the only member of an aggregate that outside objects can hold a reference to.
    - Objects within an aggregate can hold references to one another.
    - Objects within an aggregate can hold references to other aggregate root.

    So if we take these three rules together, then we should be able to draw a boundary around an aggregate where only the root is on the boundary. All the other objects are completely inside the boundary and wholly owned by the root. Any references, any arrows that are coming into the aggregate can only point at the root. They can't cross the boundary and point at any of the children. Now, we could have references coming from the children out of the aggregate pointing to other aggregate roots, but we can't have any arrows that are pointing into the boundary.

- Operation

    - First of all, the query operation. Only aggregate roots can be obtained through database queries.
    - And then we have the update operations. Invariants are enforced only within the scope of a single aggregate.
    - Finally, it's the delete operation. Deleting an aggregate root must delete all other objects within the boundary.

So this set of rules tell us how we can query, alter, and delete aggregates. We can only query for aggregate roots. We cannot query for children.

Remember only the aggregate root has global identity, so all of other entities must have local identity, and that means we can't query for them. Second, when we alter the aggregate, the aggregate root is responsible for validating its invariants. An invariant is a rule that relates all the objects within the aggregate, and this rule must always be true. An aggregate root can relate the objects within the aggregate, but it cannot enforce behaviors outside of the aggregate boundary. And then the third rule. Since a child object is wholly owned by the aggregate root, then deleting the root must also delete all of the objects within the aggregate, all of the children.

So, these are the three sets of rules.
- Identity rules say that the root has global identity whereas all of the other entities only have local identity.
- With Reference rules, we can't have any arrows coming through the boundary to the children.
- With Operation rules, it tell us how we can query alter, and delete an aggregate.

<br>

## Layered architecture

Each bounded context is a separate solution. It's likely that a different development team is going to be working on each individual bounded context even if it doesn't start out that way. They'll be working for different product owners and on different schedules, and by keeping them in separate solutions we give each of the teams the flexibility they need to brach, version, and release their own code.

We've created a separate solution for Performance, Rebates, and Sales.

![](../img/Architecture-pattern/Domain-driven-design/layered-architecture/contexts-ex.png)

While we put them all in the same source code repository, it's equally likely that we'll put each one in separate repository. This will make it even easier for the individual teams to branch them independently. Let us dive into the Performance solution so that we can take a closer look.

![](../img/Architecture-pattern/Domain-driven-design/layered-architecture/Performance-context-ex.png)

One thing that we should notice is that each of the projects within the solution is completely owned by its bounded context. We don't have any references to projects outside of this context. That's just another benefit of having separate solution for each bounded context. It discourages interdependencies between them. A bounded context should be just that, bounded. It should have strict boundaries so that it remains unaffected. Keeping the solutions separate makes it abundantly clear when we've crossed those context boundaries. Within each solution, the projects are organized into layers.

Eric Evan talks about four layers in his book, and we have three of them represented here. These are Domain, Application, and Presentation.
- The Domain layer contains the model. It has all of the entities and value objects of the problem domain. All of these objects are expressed in terms of the ubiquitous language. A business owner looking at this model will be able to verify whether it's accurate or not.

- Above the Domain layer we have the Application layer. This layer contains all of the business services. These are the behaviors that don't necessarily belong to a specific entity. For example, PerformanceCalculator is a service that creates ReportCard entities.

    ![](../img/Architecture-pattern/Domain-driven-design/layered-architecture/ex-Performance-ctx-Application-layer.png)

    It would be inappropriate to make this a responsibility of the ReportCard itself because that's the product of this factory. So this service, PerformanceCalculator, is separated from the Domain and moved up into the Application layer.
    
- At the top above the application layer, we have the Presentation layer. This exposes all of the services and domain objects to the outside users. The Presentation for some bounded context is a user interface. For example, the Performance.

    Presentation layer is a web application that displays ReportCards to members or the Presentation layer might be an API that some client application or external system uses in order to access the bounded context. For example, the Rebates.
    
    ![](../img/Architecture-pattern/Domain-driven-design/layered-architecture/Rebates-context-ex.png)

    Presentation layer is a WCF service that the rich client application can use to setup the Rebates. Now remember that Eric Evans talked about four layers in his book. We've only seen three. The fourth layer that he talks about is infrastructure. We didn't represent that here inside of the Domain solution because infrastructure is not domain specific. Any sort of infrastructure components that we'll need to build, we'll build off in a separate solution and bring those in as external dependencies.

<br>

## Aggregate Boundaries




<br>

## When to use





<br>

## Benefits and Drawbacks
1. Benefits

    https://www.udemy.com/course/domain-driven-design-complete-software-architecture-course/

2. Drawbacks



<br>

## Code Java





<br>

## Wrapping up




<br>

Thanks for your reading

<br>

Refer:

[Domain-Driven Design in Practice by Vladimir Khorikov](https://app.pluralsight.com/library/courses/domain-driven-design-in-practice/table-of-contents)

[Practical Domain-Driven Design in Enterprise Java](http://file.allitebooks.com/20200217/Practical%20Domain-Driven%20Design%20in%20Enterprise%20Java.pdf)

[https://blog.sapiensworks.com/tags.html](https://blog.sapiensworks.com/tags.html)

**Series about Domain Driven Design**

[https://blog.fedecarg.com/2009/03/11/domain-driven-design-and-mvc-architectures/](https://blog.fedecarg.com/2009/03/11/domain-driven-design-and-mvc-architectures/)

[https://blog.fedecarg.com/2009/03/12/domain-driven-design-and-data-access-strategies/](https://blog.fedecarg.com/2009/03/12/domain-driven-design-and-data-access-strategies/)

[https://blog.fedecarg.com/2009/03/15/domain-driven-design-the-repository/](https://blog.fedecarg.com/2009/03/15/domain-driven-design-the-repository/)

[https://blog.fedecarg.com/2009/03/22/domain-driven-design-sample-application/](https://blog.fedecarg.com/2009/03/22/domain-driven-design-sample-application/)

<br>

**Best practice - An Inroduction to Domain Driven Design**

[https://msdn.microsoft.com/en-us/magazine/dd419654.aspx](https://msdn.microsoft.com/en-us/magazine/dd419654.aspx)

<br>

[https://edwardthienhoang.wordpress.com/2017/04/08/domain-drive-development-ddd-first-thought-part-1/](https://edwardthienhoang.wordpress.com/2017/04/08/domain-drive-development-ddd-first-thought-part-1/)

[https://www.infoq.com/minibooks/domain-driven-design-quickly](https://www.infoq.com/minibooks/domain-driven-design-quickly)

[https://www.slideshare.net/nikitakova/domain-driven-design-introduction](https://www.slideshare.net/nikitakova/domain-driven-design-introduction)

[https://www.slideshare.net/manatok/refactoring-for-domain-driven-design](https://www.slideshare.net/manatok/refactoring-for-domain-driven-design)

[https://www.slideshare.net/mathiasverraes/why-domaindriven-design-matters](https://www.slideshare.net/mathiasverraes/why-domaindriven-design-matters)

[https://www.slideshare.net/PascalLaurin/implementing-ddd-with-c](https://www.slideshare.net/PascalLaurin/implementing-ddd-with-c)

