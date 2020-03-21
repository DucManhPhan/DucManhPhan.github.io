---
layout: post
title: How to use Spring Data Rest
bigimg: /img/image-header/yourself.jpg
tags: [Java]
---



<br>

## Table of contents
- [Introduction to Spring Data Rest](#introduction-to-spring-data-rest)
- [How to use Spring Data Rest](#how-to-use-spring-data-rest)
- [Some problems when using Spring Data Rest](#some-problems-when-using-spring-data-rest)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Spring Data Rest





<br>

## How to use Spring Data Rest





<br>

## Some problems when using Spring Data Rest

1. Reasons that Spring Webflux does not support Spring Data Rest

    There are no immediate plans to build a Spring Data REST based on Spring WebFlux. Here are a couple of reasons for that:

    - The support would imply a complete rewrite which would bind a significant amount of time we have as a team. We're making very heavy use of Jackson customizations and it's not clear whether all of them can be used in a non-blocking way in the first place.

    - Spring Data REST is used by slightly less than ten percent of all Spring Data users.

    - A crucial aspect of Spring Data REST is that it's supposed to work on all repository modules. However, only the MongoDB, Couchbase, Redis and Cassandra modules currently support true reactive data access. I.e. for everyone using Spring Data JPA (a huge majority of Spring Data users) the effect would be close to zero as JPA is a blocking API.

    - The kinds of APIs (true hypermedia-based REST APIs build on a domain model backed by a datastore) build on top of Spring Data REST are usually not the first candidates to benefit from reactive programming in the first place as the latter is optimizing for resource usage in pass-through scenarios (gateway style applications etc.)

    With all these constraints given, it's currently very unlikely that a WebFlux based Spring Data REST would actually have the effect that people assume it would have. That, combined with the rather huge amount of work such an implementation would imply, we decided to currently not pursue this road.

<br>

## Wrapping up




<br>

Thanks for your reading.

<br>

Refer:

[https://jira.spring.io/browse/DATAREST-933](https://jira.spring.io/browse/DATAREST-933)