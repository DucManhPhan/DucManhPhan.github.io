---
layout: post
title: Ubiquitous Language in DDD
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Ubiquitous Langage](#solution-with-ubiquitous-language)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Normally, when creating a base project for an application, we usually use Layered architecture pattern.

![](../img/Architecture-pattern/layered-architecture/common-layers.png)

The drawback of this pattern:
- We only know the above layer of the business logic, without the underlying concept in the logic. At the startup, a project develops so quickly. But our project, especially source code, become a fat project.
- The logic will be clutter through multiple layers. So there's a small change, we need to search to fix them.

So, how Domain-Driven Design solve these problems?

<br>

## Solution with Ubiquitous Language

1. Introduction to Ubiquitous Language

    Before creating an application that use Domain-Drive Design as its architecture, the first thing we need to to is to utilize a ubiquitous language for both the developers and the business owners.

    Then, there are multiple meetings to exchange the knowledge about the organization's domain for developers. This is the hard time to work because the developer's mind set always concentrate only on the technologies such as programming paradigm, which database to choose, servers, ... But beside the business logic of the domain, developers need to know exactly the new concepts. It's tedious for them. Without these concepts, business logic, developers does not reflect the real world into their code.

    All of the code is modeled and written using the terms from this ubiquitous language, so any change to the ubiquitous language necessitates a change to the model. That indicates that the understanding has evolved in some way, and so the model has to evolve to capture that new understanding.

    A ubiquitous language allows developers and business owners to communicate with one another without having to translate. Assumptions tend to get lost in the translation because each party assigns their own meaning to the words that they use to communicate with the other, but by agreeing upon a ubiquitous language that forces the two parties to define their terms and flushes assumption into the light.

2. Some examples about Ubiquitous Language

    - Football industry

        In the football field, it's difficult to communicate with people when talking about some situtations in a match.
        - Goalkeeper - the player who stands in the team's goal to try to stop the other team from scoring
        - Defender - the player that prortects a goal against attack from the other team
        - Winger - the player whose position is at either of the two sides of the field in a team game
        - Striker - the player tries to score goals rather than to prevent the opposing team from scoring
        - Midfielder - the player that plays in midfield
        - Referee - a person who is in charge of a sport games and who makes certain that the rules are followed

    - Pharmacy application

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

    - Airplaine flight control system project

        - Air traffic controller
        - Route - the path of flight that contains Departure and Destination
        - Fix - a point on Earth surface uniquely determined by latitude and longtitude

        Below is the diagram to describe our concepts:

        ![](../img/Architecture-pattern/Domain-driven-design/ubiquitous-language-aircraft.jpg)

    - E-commerce application

        In this system, we have a class called Product, which is an atomic sale unit.

        But with the domain experts refer to this elements as both Product and Package.

<br>

## Benefits and Drawbacks

1. Benefits

    - Reduce the time to understand between developers and business owner.
    - It makes our code focus only on business logic, easy to change when we need to change or update logic.
    - Without concerning about technical aspect, we can easily switch to multiple technologies.

2. Drawbacks

    - It takes so much time to dig into knowledge in a domain, and multiple meetings to confirm about business logic.

<br>

## Wrapping up

- The concepts of ubiquitous language means we should keep our code base in sync with this single terminology and name all our classes and tables in the database after the terms in the ubiquitous language.

- Understanding about Ubiquitous Language in DDD, how to apply it in our project.

<br>

Refer:

[Domain-Driven Design in Practice by Vladimir Khorikov](https://app.pluralsight.com/library/courses/domain-driven-design-in-practice/table-of-contents)

[Domain Driven Design Quickly by Vernon Vaughn](https://www.amazon.com/Domain-Driven-Design-Distilled-Vaughn-Vernon-ebook/dp/B01JJSGE5S)

[Implementing Domain Driven Design by Vernon Vaughn](https://www.amazon.com/Implementing-Domain-Driven-Design-Vaughn-Vernon/dp/0321834577)

[Domain-Driven Design: Tackling Complexity in the Heart of Software by Eric Evans](https://www.amazon.com/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)