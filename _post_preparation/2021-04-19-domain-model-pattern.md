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

1. Definition of Domain Model



2. Types of Domain Model

    - Anemic Domain Model

        It's a model which seperates data and operation working with them from each other. In most of the time, your domain consists of two separated classes. One is the entity, which is holding data, the other is the stateless service, which operates with an entity.

        We may use more than one service class to operates with an entity.

        Drawbacks of Anemic Domain Model:
        - Lack of discoverability may lead to duplicate already existing code.
        - When you don’t keep methods near to data, it is hard to say where exactly they are located. The developer forfeits the idea to write their own implementation of those methods, which results in duplicating some or all already existing logic.
        - Lack of encapsulation.

    - Rich Domain Model


<br>

## Source code





<br>

## When to use





<br>

## Benefits and Drawbacks





<br>

## Wrapping up




<br>

Refer:

[https://danielrusnok.medium.com/what-is-anemic-domain-model-and-why-it-can-be-harmful-2677b1b0a79a](https://danielrusnok.medium.com/what-is-anemic-domain-model-and-why-it-can-be-harmful-2677b1b0a79a)

[https://blog.pragmatists.com/domain-driven-design-vs-anemic-model-how-do-they-differ-ffdee9371a86](https://blog.pragmatists.com/domain-driven-design-vs-anemic-model-how-do-they-differ-ffdee9371a86)

[https://www.martinfowler.com/bliki/AnemicDomainModel.html](https://www.martinfowler.com/bliki/AnemicDomainModel.html)

[https://enterprisecraftsmanship.com/posts/always-valid-domain-model/](https://enterprisecraftsmanship.com/posts/always-valid-domain-model/)

[https://enterprisecraftsmanship.com/posts/domain-model-purity-lazy-loading/](https://enterprisecraftsmanship.com/posts/domain-model-purity-lazy-loading/)

[]()

[]()

[]()

[]()