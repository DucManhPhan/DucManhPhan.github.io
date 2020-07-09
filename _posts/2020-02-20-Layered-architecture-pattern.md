---
layout: post
title: Layered architecture pattern
bigimg: /img/image-header/yourself.jpeg
tags: [Architecture Pattern]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Layered architecture pattern](#solution-of-layered-architecture-pattern)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Normally, in an small application, we write everything such as creating UI in some Swing components, event handler for each component, ... Assuming that we have a ListBox component to display data from database, in event handler of the specific button, we will use JDBC to load them and paste to ListBox component.

It makes our logic code, and persistence code that is embbeded into the presentation code.

When we have the huge number of components, we will encounter some problems:
- Our code becomes mess.
- It is not easy to maintain.
- The duplicated code increases.

Therefore, how do we deal with it?

<br>

## Solution of Layered architecture pattern

1. Introduction to Layered architecture pattern

    To overcome the above drawbacks, we will use layered architecture pattern. It uses **Seperation of Concerns principle** to implement.

    According to this principle, we have:

    ```
    Don't write your program as one solid block, instead, break up the code into chunks that are finalized tiny pieces of the system each able to complete a simple distinct job.
    ```

    So, below is the common three layered pattern that interacts between web services.

    ![](..\img\Architecture-pattern\layered-architecture\common-layers.png)

    The functionalities of each layer:
    - Web layer

        It is used to receive all requests from Users. In this layer, we will process Http request to get body data, or request parameters.

    - Domain

        This layer will contain all business logic of our application, and domain objects - is centric things that we need to take care.

    - Persistence

        If we interact with some database, it will contain entities that map with tables based on some JPA providers.

        Also, if we want to touch with other persistence systems such as Redis, Memcache, Apache Solr, ... we will use domain objects to work with it.

2. The rule in Layered architecture pattern

    In a layered system, each layer:
    - depends on the layers beneath it.
    - is independent of the layers on top of it, having no knowledge of the layers using it.

    If we applied this rule strictly, it means that a layer only knows about the layer directly beneath it, it makes us to create multiple proxy classes in the intermediate layers and the performance of our system decreases when we need to go though a bunch of unneccessary layers.

    To deal with it, we can use the soft rule: a layer can access any layer beneath it. But it has some problems when using this soft rule.
    - If we allow the Web layer access directly to the Persistence layer, then modifications by using SQL query within the Persistence layer would influence both the Domain layer and the Web layer. Then it produces tightly coupled application with lots of interdependencies between components.

    So, we have some concepts to reduce the above problems.
    - Layers of isolation

        The layers of isolation means that changes made in one layer of the architecture generally do not impact or affect components in other layers.

        It also means that each layer is independent of the other layers, thereby having little or no knowledge of the inner workings of other layers in the architecture.

    - Closed layer

        A closed layer means that as a request moves from layer to layer, it must go through the layer right below it to get the next layer below that one.

    - Opened layer

        A opened layer means that requests are allowed to by pass this layer and go directly to the layer below it.

    To make document about the layered architecture pattern, we need to use these concepts to define the relationship between layers and request flows, helps people to understand the various layer access restrictions.

<br>

## When to use

- When we want to develop an immediate application.

- When we want to develop parallel between multiple teams.

<br>

## Benefits and Drawbacks
1. Benefits

    - Creating an application quickly.
    - Easy to understand the functionality of each layer.

2. Drawbacks

    - Degrade performance of system when we have so many layers.
    - When the business logic of system increases quickly, it makes us creating multiple packages for each layer. So it's difficult to control it.

<br>

## Wrapping up

- Understanding the Seperation of Concerns principle to apply into Layered architecture pattern.


<br>

Refer:

[Software architecture pattern]()

[Learning modular programming](http://file.allitebooks.com/20170627/Learning%20Modular%20Java%20Programming.pdf)

[https://herbertograca.com/2017/08/03/layered-architecture/](https://herbertograca.com/2017/08/03/layered-architecture/)