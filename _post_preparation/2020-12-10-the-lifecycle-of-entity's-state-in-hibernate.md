---
layout: post
title: The lifecycle of Entity's state in Hibernate
bigimg: /img/image-header/yourself.jpeg
tags: [Hibernate]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Hibernate framework](#solution-of-hibernate-framework)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution of Hibernate framework

Before jumping directly into the lifecycle of the entity's state in Hibernate, we need to be aware of some concepts's definition.
1. Entity Manager Factory

    It is a factory class of EntityManager. It is used to create multiple instances of EntityManager class.

    If we need to access multiple databases, we must configure one EntityManagerFactory per a database.

2. Entity Manager

    EntityManager manages the entities of the application. It provides some operations to interact with database through database driver such as CRUD operations, ...

3. Persistence Context



4. Persistence Unit

    A persistence unit specifies all entity tables, which are managed by the EntityManagers of the application. Each persistence unit contains all classes representing the data stored in a single database.

5. Entity

    An entity is a persistent domain object. Each entity class will represent a table in our database, and an entity's instance will contain the data of a single row of that table.

    Each entity will have an id field that represents the primary key in the table.

<br>

## Benefits and Drawbacks





<br>

## Wrapping up




<br>

Refer:

[https://ducmanhphan.github.io/2020-02-16-the-architecture-of-JPA/](https://ducmanhphan.github.io/2020-02-16-the-architecture-of-JPA/)

[https://medium.com/@superjunior.dev/hibernate-ph%C3%A2n-bi%E1%BB%87t-c%C3%A1c-h%C3%A0m-save-persist-update-merge-saveorupdate-c1140663bc59](https://medium.com/@superjunior.dev/hibernate-ph%C3%A2n-bi%E1%BB%87t-c%C3%A1c-h%C3%A0m-save-persist-update-merge-saveorupdate-c1140663bc59)

[https://www.baeldung.com/jpa-hibernate-persistence-context](https://www.baeldung.com/jpa-hibernate-persistence-context)

[https://docs.jboss.org/hibernate/orm/4.0/devguide/en-US/html/ch03.html](https://docs.jboss.org/hibernate/orm/4.0/devguide/en-US/html/ch03.html)

[https://stackoverflow.com/questions/19930152/what-is-persistence-context](https://stackoverflow.com/questions/19930152/what-is-persistence-context)

[https://docs.jboss.org/hibernate/entitymanager/3.6/reference/en/html_single/#architecture](https://docs.jboss.org/hibernate/entitymanager/3.6/reference/en/html_single/#architecture)