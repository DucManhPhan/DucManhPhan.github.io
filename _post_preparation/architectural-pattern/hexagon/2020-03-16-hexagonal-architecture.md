---
layout: post
title: Hexagonal architectural pattern
bigimg: /img/image-header/yourself.jpeg
tags: [Architectural Pattern]
---




<br>

## Table of contents
- [Given problem of Layered architecture](#given-problem-of-layered-architecture)
- [Solution of Hexagonal architecture](#solution-of-hexagonal-architecture)
- [Source code](#source-code)
- [When to use](#when-to-use)
- [Benefis and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem of Layered architecture

Normally, when we want to make our website, in back-end, we use layer architecture to separate our project into components that each component will be taken on one responsibility.

Below is an commom layer architecture that we usually use in our projects.

![](../img/Architecture-pattern/layered-architecture/common-layers.png)

- At the top rectangle, we have a **Web layer**, or sometimes, it called as **Ws layer**, which receives requests.

- The second thing that is **Domain layer**, or **Business layer**, requests from **Web layer** will be routed to a service in the **Domain layer**. The service does some business logic and calls components from the **Persistence layer** to implement some queries such as get, update, create, ... with records in database.

- The third thing is **Persistence layer**, that manages the communication between our application and other external devices such as database, redis, elastic search, file, ... Usually, we will use **Repository pattern** (used in Domain Drive Design) and DAO - **Data Access Object pattern**.

But the first thought that we have in mind is that we need to analysis and create our database. Then, we will create entities to map tables in database. Then, create services in **Domain layer** that can be used in **Web layer**.

So, the web layer depends on the **Domain layer**, which in turn depends on the **Persistence layer**, and thus the database.

It's called Database-driven design. Then we have some disadvantages when we design our project driven by database.
- The Domain layer is allowed to access those entities in the Persistence layer. If we do not want to use directly entities, we convert entities to dto - data transfer object. But it still creates a strong coupling between the Persistence layer and the Domain layer.

    Our services use entities as their business model and not only have to deal with the domain logic but also eager lazy loading, database transactions, flushing caches, and similar housekeeping tasks.

    So, it's hard to change one without the other.

- It's prone to shortcuts

    The rule of layered architecture is the above layer can be access its components or components in the beneath layers.

    So, if we want to access the above layer's components, we need to put its components to the beneath layer. So, the bottom-most layer will grow fat as we push components down through the layers.

How to deal with it?

<br>

## Solution of Hexagonal Architecture

1. History of Hexagonal

    The hexagonal architecture was invented by ```Alistair Cockburn``` in an attempt to avoid known structural pitfalls in object-oriented software design, such as undesired dependencies between layers and contamination of user interface code with business logic, and published in **2005**.

2. Introduction to Hexagonal architecture

    ![](../img/Architecture-pattern/hexagonal/hexagonal-architecture.jpg)

    - Ports

        Ports form the outer layer of the architecture. They acts as an interface, an API to all the external requests. They prevent any external request to have any sort of direct interaction with an application resource.

    - Adapters


3. The package structure of Hexagonal Architecture

    ```
    com.manhpd
        |
        |--- bounded_context_name
        |           |
        |           |--- adapter
        |           |       |--- in
        |           |       |     |--- web  
        |           |       |
        |           |       |--- out
        |           |             |
        |           |             |--- persistence
        |           |             
        |           |--- domain             
        |           |
        |           |--- application
        |           |         |--- service  
        |           |         |
        |           |         |--- port
        |           |         |      |
        |           |         |      |--- in
        |           |         |      |  
        |           |         |      |--- out
    ```

<br>

## Source code





<br>

## When to use






<br>

## Benefis and Drawbacks
1. Benefits



2. Drawbacks


<br>

## Wrapping up




<br>

Refer:

**Author Alistair Cockburn**

[https://alistair.cockburn.us/hexagonal-architecture/](https://alistair.cockburn.us/hexagonal-architecture/)

<br>

[Implementing Ports and Adapters](https://yuriktech.com/2020/02/01/Implementing-Ports-and-Adapters/)

[http://wiki.c2.com/?HexagonalArchitecture](http://wiki.c2.com/?HexagonalArchitecture)

[https://fideloper.com/hexagonal-architecture](https://fideloper.com/hexagonal-architecture)

[https://reflectoring.io/spring-hexagonal/](https://reflectoring.io/spring-hexagonal/)

[https://en.wikipedia.org/wiki/Hexagonal_architecture_(software)](https://en.wikipedia.org/wiki/Hexagonal_architecture_(software))

[https://hackernoon.com/hexagonal-architecture-introduction-part-i-e51h36id](https://hackernoon.com/hexagonal-architecture-introduction-part-i-e51h36id)

[https://culttt.com/2014/12/31/hexagonal-architecture/](https://culttt.com/2014/12/31/hexagonal-architecture/)

[https://herbertograca.com/2017/09/14/ports-adapters-architecture/](https://herbertograca.com/2017/09/14/ports-adapters-architecture/)

[https://silkandspinach.net/2005/03/22/the-middle-hexagon-should-be-independent-of-the-adapters/](https://silkandspinach.net/2005/03/22/the-middle-hexagon-should-be-independent-of-the-adapters/)

[https://blog.ndepend.com/hexagonal-architecture/](https://blog.ndepend.com/hexagonal-architecture/)

[https://blog.octo.com/en/hexagonal-architecture-three-principles-and-an-implementation-example/](https://blog.octo.com/en/hexagonal-architecture-three-principles-and-an-implementation-example/)

[https://blog.ploeh.dk/2016/03/18/functional-architecture-is-ports-and-adapters/](https://blog.ploeh.dk/2016/03/18/functional-architecture-is-ports-and-adapters/)

[https://dzone.com/articles/hexagonal-architecture-what-is-it-and-how-does-it](https://dzone.com/articles/hexagonal-architecture-what-is-it-and-how-does-it)

[https://dzone.com/articles/hello-hexagonal-architecture-1](https://dzone.com/articles/hello-hexagonal-architecture-1)

[https://dzone.com/articles/hexagonal-architecture-is-powerful](https://dzone.com/articles/hexagonal-architecture-is-powerful)

[https://marcus-biel.com/hexagonal-architecture/?cn-reloaded=1](https://marcus-biel.com/hexagonal-architecture/?cn-reloaded=1)

[https://culttt.com/2014/12/31/hexagonal-architecture/](https://culttt.com/2014/12/31/hexagonal-architecture/)

[https://www.infoq.com/news/2014/10/exploring-hexagonal-architecture/](https://www.infoq.com/news/2014/10/exploring-hexagonal-architecture/)

[https://java-design-patterns.com/patterns/hexagonal/](https://java-design-patterns.com/patterns/hexagonal/)

[https://java-design-patterns.com/blog/build-maintainable-systems-with-hexagonal-architecture/](https://java-design-patterns.com/blog/build-maintainable-systems-with-hexagonal-architecture/)

[https://www.freecodecamp.org/news/implementing-a-hexagonal-architecture/](https://www.freecodecamp.org/news/implementing-a-hexagonal-architecture/)

[https://herbertograca.com/2017/08/24/ebi-architecture/](https://herbertograca.com/2017/08/24/ebi-architecture/)

[https://softwarecampament.wordpress.com/portsadapters/](https://softwarecampament.wordpress.com/portsadapters/)

<br>

**Sample of Hexagonal architecture**

[Get Your Hands Dirty on Clean Architecture book](https://subscription.packtpub.com/book/programming/9781839211966)

[https://github.com/thombergs/buckpal](https://github.com/thombergs/buckpal)

[https://medium.com/codefountain/a-quick-introduction-to-hexagonal-architecture-484358c038b8](https://medium.com/codefountain/a-quick-introduction-to-hexagonal-architecture-484358c038b8)

[https://itnext.io/hexagonal-architecture-principles-practical-example-in-java-364bb2e50075](https://itnext.io/hexagonal-architecture-principles-practical-example-in-java-364bb2e50075)

[https://github.com/hirannor/spring-boot-hexagonal-architecture](https://github.com/hirannor/spring-boot-hexagonal-architecture)

[https://vaadin.com/learn/tutorials/ddd/ddd_and_hexagonal](https://vaadin.com/learn/tutorials/ddd/ddd_and_hexagonal)
