---
layout: post
title: Session in Spring
bigimg: /img/image-header/yourself.jpeg
tags: [Spring]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Introduction to Session in Spring](#introduction-to-session-in-spring)
- [Spring Session architecture](#spring-session-architecture)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Introduction to Session in Spring






<br>

## Spring Session architecture

- Create a new Servlet filter.
- Add the filter to the filter chain of your servlet
- Connect the filter to the Redis connection (or an other [MapSessionRepository](https://docs.spring.io/spring-session/docs/1.0.1.RELEASE/reference/html5/#api-mapsessionrepository) backed by Hazelcast, GemFire, Coherence or any other data grid that can give us a Map reference)






<br>

## Wrapping up




<br>

Refer:

**Problems with Session**

[https://www.javacodegeeks.com/2012/07/rest-spring-security-session-problem.html](https://www.javacodegeeks.com/2012/07/rest-spring-security-session-problem.html)

[https://content.pivotal.io/blog/why-is-session-state-management-so-hard-with-spring-session-it-doesnt-have-to-be](https://content.pivotal.io/blog/why-is-session-state-management-so-hard-with-spring-session-it-doesnt-have-to-be)

[https://owasp.org/www-project-cheat-sheets/cheatsheets/Session_Management_Cheat_Sheet](https://owasp.org/www-project-cheat-sheets/cheatsheets/Session_Management_Cheat_Sheet)