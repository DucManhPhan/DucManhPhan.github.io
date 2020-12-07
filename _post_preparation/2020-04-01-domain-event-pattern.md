---
layout: post
title: Domain Event pattern
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of Contents
- [Given problem](#given-problem)
- [Solution with Domain Event pattern](#solution-with-domain-event-pattern)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Source code](#source-code)
- [How to implement Domain Event with Spring Data JPA](#how-to-implement-domain-event-with-spring-data-jpa)
- [Some problems with Domain Event pattern](#some-problems-with-domain-event-pattern)
- [The relationship with other patterns](#the-relationship-with-other-patterns)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution with Domain Event pattern

Before understanding how to implement it, we need to be aware of where to start with Domain Event.
- Domain Aggregate Root is responsible for publishing Domain Events indicating that some internal states has changed.

- State changes within our Aggregate Root are only allowed through such Domain Events. The internal event handlers are not allowed to have any sort of business logic in them, they are only supposed to set or update the internal state of the Aggregate Root directly from the data that the event carries.

    Using these rules we completely separate the business logic from the state changes. This separation enables us to replay historical Domain Events without any business logic being triggered bringing it back to the same state as the original Aggregate Root.

- Domain Events can also be used to signal something to the outside world (taken from the Aggregate Root view point) that something has happened without having an actual state change. When persisting our Domain Events, we would not differentiate between those two different Domain Events.

- All Domain Events should be named with the Ubiquitous language, meaning that they should closely represent what the user intended to do in the same language as the user would use to explain it to us.

<br>

## When to use

- 
- 
- 

<br>

## Benefits and Drawbacks

1. Benefits

    - 
    - 
    - 


2. Drawbacks

    - 
    - 
    - 


<br>

## Source code





<br>

## How to implement Domain Event with Spring Data JPA





<br>

## Some problems with Domain Event pattern

1. 





2. 




<br>

## The relationship with other patterns




<br>

## Wrapping up

- Understanding about why we need to use Domain Event pattern, how to implement it from scratch.

<br>

Refer:

[CQRS The example ebook - Mark Nijhof](http://leanpub.com/cqrs)

[https://github.com/andreschaffer/event-sourcing-cqrs-examples](https://github.com/andreschaffer/event-sourcing-cqrs-examples)

[https://github.com/dathoangse/java-cqrs-commandbus](https://github.com/dathoangse/java-cqrs-commandbus)

[https://github.com/asc-lab/java-cqrs-intro](https://github.com/asc-lab/java-cqrs-intro)

[https://github.com/tfredrich/Domain-Eventing](https://github.com/tfredrich/Domain-Eventing)

[https://zoltanaltfatter.com/2017/06/09/publishing-domain-events-from-aggregate-roots/](https://zoltanaltfatter.com/2017/06/09/publishing-domain-events-from-aggregate-roots/)