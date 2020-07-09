---
layout: post
title: Clean Architecture
bigimg: /img/image-header/yourself.jpeg
tags: [Architecture Pattern]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Clean architecture](#solution-with-clean-architecture)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [The relationship with other patterns](#the-relationship-with-other-patterns)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Normally, we use the three layer architecture, for example, MVC architecture pattern, to organize our project. Below is the background of this pattern.

![](../img/Architecture-pattern/clean-architecture/software-architecture-definition.png)

Below is the functionalities of each layer in an above image.
- User Interface layer or Web Service layer

    This layer will manage all user interface that can be interacted with users. Or it can communicate with the other system by using SOAP API or Restful API.

    After receiving requests from users, it will transfer requests to the below layers.

- Business Logic layer

    This layer will process requests that satisfy all business rules. If requests violate some business rules, this layer will return the result for the WebService layer or response result to users.

    If requests pass some rules, they will be pushed to the Data Access layer to persistence their states. Or this layer will call Data Access layer to get data to check information that it wants.

- Data Access layer

    Data Access layer will interac with the physical system such as database or redis, search engine, ... It will be used to save the requests's states permanently. Or it will query SQL to get the result based on the need of Business Logic layer.

    We use some ORM frameworks such as Hibernate, EclipseLink, ... to map fields of object to the table's columns. These object is called entities.

Then, we will design database for our application based on some normalizations. After we have tables, we will create entities and repositories or DAO with CRUD operations in the Data Access layer or Persistence layer.

In Business Logic layer, we will use directly entities from Data Access layer. So Business Logic layer will have strong coupling with Data Access layer. It means that we are utilizing entities as the business model. But Web Service layer or User Inteface also depends on Business Logic layer.

So our application, currently, depends on the database. Customer's requirements always change, then our database design is also modified. Our layers will break down. We need to write code again. This is a bad architecture when coping with the changes.

The another drawback of layered architecture is its rules. The current layer only knows about the beneath layers. Sometimes, we want to use common layers such as util, shared, ..., then we need to push it into the most bottom layer, it is Persistence layer. It makes Persistence layer growing rapidly. Our code becomes mess.

Bad or messy architecture is architecture that is complex, but due to accidental complexity rather that necessary complexity. Belows are some drawbacks of bad architecture that we need to know.
- It's incoherent in the sense that the parts do not seem like they fit together.
- It's rigid, that is the architecture resists change or makes it difficult to evolve the architecture over time.
- It's brittle, touching a part of the code might break another part of the code somewhere else.
- It's untestable.
- Ultimately, all of these things lead to an architecture that's unmaintainable over the life of the project 

--> So, based on the bad architecture's characteristics, we need the clean architecture.

<br>

## Solution with Clean architecture




<br>

## Source code





<br>

## Benefits and Drawbacks

1. Benefits

    We have good, clean architecture when it is simple or at least it's only as complex as is necessary, and that complexity is not accidental.

        - It's understandable, that is it's easy to reason about the software as a whole.

        - It's flexible, we can easily adapt the system to meet changing requirements.

        - It's emergent, the architecture evolves over the life of the project.

        - It's testable, the architecture makes testing easier, not harder.

        - Ultimately, all of these leads to an architecture that's more maintainable over the life of the project.


2. Drawbacks


<br>

## The relationship with other patterns




<br>

## Wrapping up




<br>

Refer:

[Get Your Hands Dirty on Clean Architecture book](https://subscription.packtpub.com/book/programming/9781839211966)

[Clean Architecture: Patterns, Practices, and Principles](https://app.pluralsight.com/library/courses/clean-architecture-patterns-practices-principles/table-of-contents)