---
layout: post
title: Understanding about Restful system
bigimg: /img/path.jpg
tags: [Distributed System]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of using Restful system](#solution-of-using-restful-system)
- [Idempotency in Restful API](#idempotency-in-restful-api)
- [HATEOAS constraints in Restful API](#hateoas-constraints-in-restful-api)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem





<br>

## Solution of using Restful system

1. Definition of Restful API



2. Principles of Restful API

    - Client-server

        Use this architecture to split the responsibilities between client and server. The client will only take care about UI, display information for the end user, does not contain business logic. And the server will process the business logic, communicate with the other external systems such as databases, caches, ...

        Through the Restful API, it hides all complicated implementation to the server.

        Benefits:
        - easy to scale servers when processing multiple requests at the same time.
        - improve the availability.
        - support multiple types of client such as mobile, web, other systems.

        Drawbacks:
        - less security when comparing to 1-tier architecture.

    - Stateless

        The server will not save all information of requests, so that it reduces the lack of security when the server is hacked.

    - Cacheable

    - Uniform interface

    - Layered system


<br>

## HATEOAS constraints in Restful API





<br>

## Idempotency in Restful API






<br>

## When to use






<br>

## Benefits and Drawbacks





<br>

## Wrapping up







<br>

Refer:

[https://restfulapi.net/](https://restfulapi.net/)

[https://kipalog.com/posts/Idempotency-va-Safety-trong-RESTful-web-services](https://kipalog.com/posts/Idempotency-va-Safety-trong-RESTful-web-services)

[https://www.restapitutorial.com/lessons/idempotency.html](https://www.restapitutorial.com/lessons/idempotency.html)

[https://www.baeldung.com/cs/idempotent-operations](https://www.baeldung.com/cs/idempotent-operations)

[https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/)

[https://nordicapis.com/understanding-idempotency-and-safety-in-api-design/](https://nordicapis.com/understanding-idempotency-and-safety-in-api-design/)

[https://microservices.io/patterns/communication-style/idempotent-consumer.html](https://microservices.io/patterns/communication-style/idempotent-consumer.html)