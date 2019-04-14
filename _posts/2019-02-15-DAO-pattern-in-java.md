---
layout: post
title: DAO pattern in Java
bigimg: /img/image-header/home-office-1.jpg
tags: [structural pattern, design pattern]
---

We have known that the Spring framework 4.0.3 has a seven-layered architecture that includes a core container, context, Aspect-Oriented Programming (AOP), Data Access Object (DAO), Object-relational mapping (ORM), Web, and Model-View-Controller (MVC). So, to master about Spring framework, we should study each layer architecture. 

In this article, we will find out about DAO pattern, some interesting informations in this pattern. 

Let's get started!

<br>

## Table of Contents
- [Given Problem](#given-problem)
- [Solution with DAO pattern](#solution-with-dao-pattern)
- [When to use DAO pattern](#when-to-use-dao-pattern)
- [The advantages / disadvantages](#the-advantages-/-disadvantages)
- [Source code C++ / Java / Javascript](#source-code-c++-/-java-/-javascript)
- [Wrapping up](#wrapping-up)

<br>

## Given Problem
Assuming that we have a web application project that utilize MySQL database to follow the requirements from customer. So, we will use driver of MySQL to interact with database. But in other beautiful day, the customer want to use additional database such as PostgreSQL, then, we have to modify our code to compatible with this database. It makes our layers that has tightly coupling with persistence layer when we change to other database. 

Therefore, what is solution to prevent the tightly coupling of other layers with persistence layer?

<br>

## Solution with DAO pattern
The DAO pattern is a structural pattern that allow us to isolate the application/business layer from the persistence layer (usually a relational database, but it could be any other persistence mechanism) using an abstract API.

DAO pattern is based on design principles such as **abstraction** and **encapsulation**. It will protect the rest of application from many operations in persistence layer. For example, change database from MySQL to PostgreSQL, change storage by file to database.

The DAO pattern is commonly used pattern to persist domain objects into a database. The most common form of a DAO pattern is a class that contains CRUD methods for a particular domain entity type.

So, DAO class is an intermediate layer to help other layers to communicate with persistence layers regardless of any storage mechanism such as file, database management, ..., then, performs some operations such as CRUD.

For example:

DAO pattern can be represented with many ways such as Java Persistence API (JPA), Enterprise Java Bean (EJB), Object-Relational Mapping (ORM) with many specific implementations such as Hibernate, iBATIS, Spring JPA, ...

<br>

## Source code C++ / Java / Javascript
Now, we will use Java language to describe the DAO pattern. And based on these code, we will analyze the advantages and disadvantages of DAO pattern.

```java
// Domain class


// DAO class


// Implementation of DAO class



// Main Application



```

<br>

## When to use DAO pattern
- When we need to change the current database to the other database such as Oracle, MySQL, MariaDB, SQL Server, MongoDB.
- When we want to separate application into specific parts.
- 

<br>

## The advantages / disadvantages
1. Advantages
    - It separeates the domain logic that use it from any particular persistence mechanism or APIs --> loose coupling between layers.

    - The interface methods signature are independent of the content of the Domain class. When we add some fields to the Domain class, we do not need to change the DAO interface nor its caller.

    - Testing our service that calls the DAO: We can write a mock DAO that behaves just as we need it in the test (Ex: simulate that there is no DB connection, which is hard to reproduce automatically).

    - Generate some layers around our DAO: We could use Aspect Oriented Programming - AOP to generate caching or transaction handling around our DAO methods. In this case, we have an object that implements the DAOs interface but has nothing to do with the original implementation.

    - Switching the DB technology: if we switch from MySQL to DB2, we just need to write another implementation of the interface and switch the MySQL DAO and the DB2 DAO.

2. Disadvantages
    - 

<br>

## Wrapping up




<br>

Refer:

[https://thinkinginobjects.com/2012/08/26/dont-use-dao-use-repository/](https://thinkinginobjects.com/2012/08/26/dont-use-dao-use-repository/)

[https://www.oracle.com/technetwork/java/dataaccessobject-138824.html](https://www.oracle.com/technetwork/java/dataaccessobject-138824.html)

[https://www.journaldev.com/16813/dao-design-pattern](https://www.journaldev.com/16813/dao-design-pattern)

[https://www.baeldung.com/java-dao-pattern](https://www.baeldung.com/java-dao-pattern)

[https://thinkinginobjects.com/2012/08/26/dont-use-dao-use-repository/](https://thinkinginobjects.com/2012/08/26/dont-use-dao-use-repository/)