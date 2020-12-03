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
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Source code](#source-code)
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





<br>

## Benefits and Drawbacks




<br>

## Source code





<br>

## Wrapping up




<br>

Refer:

[CQRS The example ebook - Mark Nijhof](http://leanpub.com/cqrs)

[https://github.com/andreschaffer/event-sourcing-cqrs-examples](https://github.com/andreschaffer/event-sourcing-cqrs-examples)

[https://github.com/dathoangse/java-cqrs-commandbus](https://github.com/dathoangse/java-cqrs-commandbus)

[https://github.com/asc-lab/java-cqrs-intro](https://github.com/asc-lab/java-cqrs-intro)