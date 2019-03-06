---
layout: post
title: The architecture of JPA
bigimg: /img/path.jpg
tags: [front-end]
---

In Java web, we always do work with database such as SQL Server, MySQL, Oracle, ... Then, there are so many ways to implement with database like some implementations of ORM (Object Relational Mapping) such as Hibernate, EclipseLink, TopLink, Spring Data JPA.

Therefore, understanding about architecture of JPA is benefical for us. In this article, we will discuss about the architecture of JPA. 

<br>

## Table of contents
- [Introduction to JPA](#introduction-to-jpa)
- [JPA Providers](#jpa-providers)
- [What is Java persistence](#what-is-java-persistence)
- 
- 
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

## What is Java persistence




<br>

## Wrapping up

<br>

Refer:

[http://www.javaguides.net/2018/12/jpa-architecture.html](http://www.javaguides.net/2018/12/jpa-architecture.html)

[https://en.wikibooks.org/wiki/Java_Persistence/What_is_Java_persistence%3F](https://en.wikibooks.org/wiki/Java_Persistence/What_is_Java_persistence%3F)
