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

The basic idea behind this pattern is that when we have some pieces of domain knowledge, we can encapsulate this knowledge into a single unit, specification, and then reuse in different parts of our code base.

Belows are three main use cases of the Specification pattern:
1. In-memory validation

    When we need to check if an object fits some criteria. This is useful in scenarios with validating in common input requests from users, or third-party assistence.

2. Retrieving data from the database

    It means that we will find records that match the specification.

3. Construction of an object

    Creating new objects complies with the criteria. This is helpful in scenarios where we don't care about the actual content of the objects, but still need them to have certain attributes.

<br>

## Source code

1. Hard-coded


2. 






<br>

## When not to use

- When we have only one use case out of three in which the Specification pattern is applicable.

    For example, if we need to build sophisticated search queries, but don't need to do in-memory validation, there is no need in specification. That would be no domain knowledge duplication in this case because that knowledge is used in a single place anyway, and so we can put all the filtration logic directly to our repositories.

    Similarly, if we need to validate user requests, but don't need to write corresponding search queries, it would be just fine if we hard code the domain knowledge directly in our if statement. There would be no duplication and therefore no problem.

- The second situation where we might want to pass on the specification pattern is if our application is simple enough and its complexity is not expected to grow in the near future.

    In simple code base, there is not much sense in following all the best practices anyway, the maintaince cost is low enough already and the benefits of introducing the Specification pattern might not justify the initial investment, the amount of work we need to put into implementing it.

    So duplicating the domain knowledge could be a viable option.

<br>

## When to use

- If our code exhibits the need in at least 2 out of 3 use cases
- If our project is going to be complex enough, this pattern would be a good tool to keep the complexity of our code base under control.

<br>

## Benefits and Drawbacks

1. Benefits

    - By encapsulating business logic in Specification pattern , it helps reduce the duplication code.

2. Drawbacks

<br>

## Some common questions for Specification pattern

1. When implementing the Specification pattern, how to deal with not just a single class, but an aggregate of classes.


2. What is a strong typed specification?

    A specification that contains a single piece of domain knowledge.

<br>

## Wrapping up

- Some general guidelines for Specification pattern:

    - Avoid using ISpecification interface.
    - Make specifications as specific as possible.
    - Make specifications immutable.

- Specification should contain the domain knowledge. We should utilize a strong typed specification.

- Specification pattern usually used in persistence layer, and combine with the other patterns such as Repository pattern, Unit of Work pattern.


<br>

Refer:

[https://enterprisecraftsmanship.com/posts/cqrs-vs-specification-pattern/](https://enterprisecraftsmanship.com/posts/cqrs-vs-specification-pattern/)

[https://enterprisecraftsmanship.com/posts/specification-pattern-c-implementation/](https://enterprisecraftsmanship.com/posts/specification-pattern-c-implementation/)

[https://enterprisecraftsmanship.com/posts/specification-pattern-c-implementation/](https://enterprisecraftsmanship.com/posts/specification-pattern-c-implementation/)

[https://www.martinfowler.com/apsupp/spec.pdf](https://www.martinfowler.com/apsupp/spec.pdf)

[https://deviq.com/design-patterns/specification-pattern](https://deviq.com/design-patterns/specification-pattern)

[https://tedu.com.vn/design-pattern/trien-khai-pattern-specification-trong-c-sharp-123.html](https://tedu.com.vn/design-pattern/trien-khai-pattern-specification-trong-c-sharp-123.html)

[]()

[]()

[]()

[]()