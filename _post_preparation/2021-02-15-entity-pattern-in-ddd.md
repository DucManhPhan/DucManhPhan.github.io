---
layout: post
title: Entity Pattern in DDD
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Entity pattern](#solution-of-entity-pattern)
- [Some types of equality](#some-types-equality)
- [The difference between Entity and Value Object](#the-difference-between-entity-and-value-object)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution of Entity pattern







<br>

## Some types of equality

There are three types of equality.
1. Reference equality

    ![](../img/Architecture-pattern/Domain-driven-design/entity-pattern/reference-equality.png)

    Reference equality means that two objects are deemed to be equal if they reference the same address in the memory.

2. Identifier equality

    ![](../img/Architecture-pattern/Domain-driven-design/entity-pattern/identifier-equality.png)

    Identifier equality implies a class has an ID field. Two instances of such a class would be equal if they have the same idenfifiers.

3. Structural equality

    ![](../img/Architecture-pattern/Domain-driven-design/entity-pattern/structural-equality.png)

    Structural equality means that there are two objects equal if all of their members match.

As I said, we can have the equality in the entities and value objects.

![](../img/Architecture-pattern/Domain-driven-design/entity-pattern/entities-value-objects-equality.png)

<br>

## The difference between Entity and Value Object

|      Property          |             Entity                                                       |                    Value Object                     |
| -----------------------| ------------------------------------------------------------------------ | --------------------------------------------------- |
| Identity               | Entity has its own inherent identity                                     | Value Object has no its own identity                |
| Changable              | It's mutable                                                             | It's immutable                                      | 
| Equality               | Using identifier equality                                                | Using structural equality                           |
| Lifespan               | Entities can live by their own. They can be persisted into the database. | Value Objects can't live by their own. They should always belong to one or several entities. It means that value objects don't have their own tables in the database | 


<br>

## When to use





<br>

## Benefits and Drawbacks




<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()