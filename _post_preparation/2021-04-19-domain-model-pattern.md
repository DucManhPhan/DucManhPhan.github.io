---
layout: post
title: Domain Model pattern
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Domain Model pattern](#solution-with-domain-model-pattern)
- [Source code](#source-code)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Given problem






<br>

## Solution with Domain Model pattern

To summary about some patterns of Domain-Driven Design, we can refer to the below image.

![](../img/Architecture-pattern/Domain-driven-design/Background-DDD.png)

But in this article, we only concentrate mostly on the Domain Model pattern.
1. Definition of Domain Model



2. Types of Domain Model

    - Anemic Domain Model

        It's a model which seperates data and operation working with them from each other. In most of the time, our domain consists of two separated classes. One is the entity, which is holding data, the other is the stateless service, which operates with an entity. We may use more than one service class to operates with an entity.

        Entity is simply a class that contains some necessary information that will be saved to database. Normally, we use entity to map a record from a table to an object in our program by taking advantage of ORM framework such as Hibernate, Eclipse Link, Entity framework, ...

        Stateless service is a class that implements business logic, not contains data model. Normally, it is only a method, and interact with an entity. A stateless service can be called the other stateless services, or call the DAO in the persisten layer to communicate with a database.

        Drawbacks of Anemic Domain Model:
        - Lack of discoverability may lead to duplicate already existing code.
        - When you don't keep methods near to data, it is hard to say where exactly they are located. The developer forfeits the idea to write their own implementation of those methods, which results in duplicating some or all already existing logic.
        - Lack of encapsulation.

            To know more about [encapsulation in object-oriented programming](https://ducmanhphan.github.io/2019-12-19-encapsulation-in-object-oriented-programming/).

        - Difficult to maintain because the business logic will be used to expand in multiple layers. So when we want to add a new functionality or fix an existed feature, it is a conundrom.

    - Rich Domain Model



        ![](../img/Architecture-pattern/Domain-driven-design/domain-model/anemic_model.jpg)

<br>

## Source code





<br>

## When to use





<br>

## Benefits and Drawbacks





<br>

## Wrapping up

- Business logic contains domain logic and application logic.

    - Domain logic does something purely with the problem domain such as strategies for calculating revenue recognition on a contract. Domain logic contains validation, calculations, and business rules.

    - Application logic has to do with application responsibilities such as notifying contract administrators, and integrated applications, or revenue recognition calculations.

        Application logic is sometimes referred to as **workflow logic**:

<br>

Refer:

[https://danielrusnok.medium.com/what-is-anemic-domain-model-and-why-it-can-be-harmful-2677b1b0a79a](https://danielrusnok.medium.com/what-is-anemic-domain-model-and-why-it-can-be-harmful-2677b1b0a79a)

[https://blog.pragmatists.com/domain-driven-design-vs-anemic-model-how-do-they-differ-ffdee9371a86](https://blog.pragmatists.com/domain-driven-design-vs-anemic-model-how-do-they-differ-ffdee9371a86)

[https://www.martinfowler.com/bliki/AnemicDomainModel.html](https://www.martinfowler.com/bliki/AnemicDomainModel.html)

[https://enterprisecraftsmanship.com/posts/always-valid-domain-model/](https://enterprisecraftsmanship.com/posts/always-valid-domain-model/)

[https://enterprisecraftsmanship.com/posts/domain-model-purity-lazy-loading/](https://enterprisecraftsmanship.com/posts/domain-model-purity-lazy-loading/)

[https://martinfowler.com/bliki/AnemicDomainModel.html](https://martinfowler.com/bliki/AnemicDomainModel.html)

[]()

[]()

[]()