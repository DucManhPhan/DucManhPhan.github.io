---
layout: post
title: The architecture of JPA
bigimg: /img/path.jpg
tags: [Hibernate]
---

In Java web, we always do work with database such as SQL Server, MySQL, Oracle, ... Then, there are so many ways to implement with database like some implementations of ORM (Object Relational Mapping) such as ```Hibernate```, ```EclipseLink```, ```TopLink```, ```Spring Data JPA```.

Therefore, understanding about architecture of JPA is benefical for us. In this article, we will discuss about the architecture of JPA. 

<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of JPA](#solution-of-jpa)
- [The architecture of JPA](#the-architecture-of-jpa)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Before JPA was born, we used JDBC to work with databases. It uses facade pattern to abstract all types of databases. It makes developers to only take care about tables of databases without their differences.

But JDBC has still some drawbacks that we need to know.
- We map a data member to a table column. This is not object-centric.
- No default mapping is available in JDBC with table.
- JDBC works using the basics of SQL. So we can use some special functionalities in each RDBMS.
- JDBC uses database-specific code.
- No automatic versioning or timestamping is available.


<br>

## Solution of JPA

1. Definition of JPA

    To solve all the drawbacks of JDBC, we will have the Object Relational Mapping - ORM technique. And JPA, iBatis, ... are some ORM techniques that we need to know.

    JPA - Java Persistence API is the Java standard for mapping Java objects to a relational database. Mapping Java objects to database tables and vice versa is called Object-relational mapping (ORM). **The Java Persistence API (JPA) is one possible approach to ORM**. Via JPA, the developer can map, store, update and retrieve data from relational databases to Java objects and vice versa. JPA can be used in Java-EE and Java-SE applications.

    **JPA defines only specifications, it does not provide an implementation.**

    JPA implementation is provided as a reference implementation by the vendors developing O/R Mapper such as Hibernate, EclipseLink and Apache OpenJPA.

    JPA permits the developer to work directly with objects rather than with SQL statements. The JPA implementation is typically called ```persistence provider```.

2. JPA Providers

    JPA is an open source API, therefore various enterprise vendors such as Oracle, Redhat, Eclipse, etc. provide new products by adding the JPA persistence flavor in them. 

    Some of these products include: 
    - Hibernate
    - EclipseLink
    - TopLink
    - Spring Data JPA
    - ...

<br>

## The architecture of JPA




<br>

## Benefits and Drawbacks

1. Benefits

    - Maps an object to the table.
    - It supports its own query language instead of SQL.
    - Less database-dependent code.
    - Low maintaince code.
    - Optmizes the performance by providing caching.
    - Provides ways for automatic versioning and timestamping.

<br>

## Wrapping up
- In Hibernate, the ```Session``` interface follows the ```Repository``` pattern. However, by introducing our own repository interfaces, we decouple our domain objects from the hibernate implementation, make the domain model package easy to test and reuse.


<br>

Refer:

[Spring with JPA and Hibernate](https://app.pluralsight.com/library/courses/spring-jpa-hibernate/table-of-contents)

[http://www.javaguides.net/2018/12/jpa-architecture.html](http://www.javaguides.net/2018/12/jpa-architecture.html)

[https://en.wikibooks.org/wiki/Java_Persistence/What_is_Java_persistence%3F](https://en.wikibooks.org/wiki/Java_Persistence/What_is_Java_persistence%3F)

