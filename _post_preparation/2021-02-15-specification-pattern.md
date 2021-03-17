---
layout: post
title: Specification Pattern
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Specification Pattern](#solution-with-specification-pattern)
- [Source code](#source-code)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Given problem






<br>

## Solution with Specification Pattern

Specification pattern is a pattern that helps achieve two goals.
- First, it helps avoid domain knowledge duplication in certain scenarios, in other words, adhere to the DRY principle.
- Second, it enables a declarative approach, which in turn increases maintainability of our code base.

This pattern was introduced by Eric Evans and Martin Fowler in the early 2000s, and Eric referred this pattern in his book: **Domain-Driven Design: Tackling complexity in the heart of software**.

The basic idea behind this pattern is that when we have some piece of domain knowledge we can encapsulate this knowledge into a single unit, specification, and then reuse in different parts of our code base.


Belows are three main use cases of the Specification pattern:
1. In-memory validation

    When we need to check if an object fits some criteria. This is useful in scenarios with validating in common input requests from users, or third-party assistence.

2. Retrieving data from the database

    It means that we will find records that match the specification.

3. Construction-to-order

    Creating new objects complies with the criteria. This is helpful in scenarios where we don't care about the actual content of the objects, but still need them to have certain attributes.

<br>

## Source code







<br>

## When to use





<br>

## Benefits and Drawbacks

1. Benefits

    - It helps reduce the duplication code.

2. Drawbacks

<br>

## Wrapping up




<br>

Refer:

[https://enterprisecraftsmanship.com/posts/cqrs-vs-specification-pattern/](https://enterprisecraftsmanship.com/posts/cqrs-vs-specification-pattern/)

[https://enterprisecraftsmanship.com/posts/specification-pattern-c-implementation/](https://enterprisecraftsmanship.com/posts/specification-pattern-c-implementation/)

[https://enterprisecraftsmanship.com/posts/specification-pattern-c-implementation/](https://enterprisecraftsmanship.com/posts/specification-pattern-c-implementation/)

[https://www.martinfowler.com/apsupp/spec.pdf](https://www.martinfowler.com/apsupp/spec.pdf)

[https://deviq.com/design-patterns/specification-pattern](https://deviq.com/design-patterns/specification-pattern)