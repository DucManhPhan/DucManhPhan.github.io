---
layout: post
title: Basic entity class in JPA
bigimg: /img/path.jpg
tags: [front-end]
---

When we work with Java web development, we have to implement with database. Normally, we will use JDBC or JDBC template for doing this problem. But to make it easier, we will use the new technology called ORM - Object Relational Mapping. The standard version of ORM is JPA. JPA will help us to map POJO to each record in table of database. We will do not take care all queries to access database. This action will be sent to the JPA.

So, in this article, we will talk about how to configure an entity class with JPA in Spring Boot, specially these are annotations in JPA. 

<br>

## Table of contents
- [Introduction to JPA](#introduction-to-jpa)

- [Wrapping up](#wrapping-up)


<br>

## Introduction to JPA
JPA - Java Persistence API is the Java standard for mapping Java objects to a relational database. Mapping Java objects to database tables and vice versa is called Object-relational mapping (ORM). **The Java Persistence API (JPA) is one possible approach to ORM**. Via JPA, the developer can map, store, update and retrieve data from relational databases to Java objects and vice versa. JPA can be used in Java-EE and Java-SE applications.

**JPA defines only specifications, it does not provide an implementation.**

JPA implementation is provided as a reference implementation by the vendors developing O/R Mapper such as Hibernate, EclipseLink and Apache OpenJPA.

JPA permits the developer to work directly with objects rather than with SQL statements. The JPA implementation is typically called ```persistence provider```.

<br>

## JPA Providers
JPA is an open source API, therefore various enterprise vendors such as Oracle, Redhat, Eclipse, etc. provide new products by adding the JPA persistence flavor in them. 

Some of these products include: 
- Hibernate
- EclipseLink
- TopLink 
- Spring Data JPA
- ...

<br>

## 




<br>

## Wrapping up




<br>


Refer:

[https://www.oracle.com/technetwork/middleware/ias/toplink-jpa-annotations-096251.html](https://www.oracle.com/technetwork/middleware/ias/toplink-jpa-annotations-096251.html)

[http://www.javaguides.net/2019/01/introduction-to-java-persistence-api.html](http://www.javaguides.net/2019/01/introduction-to-java-persistence-api.html)