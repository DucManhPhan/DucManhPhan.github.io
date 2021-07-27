---
layout: post
title: CQRS architecture
bigimg: /img/image-header/yourself.jpeg
tags: [Architecture Pattern]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with CQRS architecture](#solution-with-cqrs-architecture)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [The relationship with other patterns](#the-relationship-with-other-patterns)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution with CQRS architecture

1. History about CQS, CQRS

    CQS - Command Query Separation pattern is introduced by Bertrand Meyer in [Object Oriented Software Construction book](https://www.amazon.com/Object-Oriented-Software-Construction-Book-CD-ROM/dp/0136291554). And CQS pattern only used for class/component in the coding aspect. It does not influence to the architectural of the system.

    Below is a table that describes the Command and Query.

    |        Command        |          Query         |
    | --------------------- | ---------------------- |
    | does something        | answers a question     |
    | should modify state   | should not modify state |
    | should not return a value | should return a value |

2. Some exceptions of CQRS

    As Martin Fowler points out, this is not always possible. For example, if we have a stack, and we want to pop the first item on the stack. the pop() method removes the top item from the stack, which is a command, and returns that top item, which is a query.

    In addition, if we want to create a new database record, we create the database record, which is a command but we might also need to return the newly created ID, which is a query, so there are clearly exceptions to this rule but in general we should strive to maintain Command-Query Separation where possible. 

3. CQRS architecture

    ![](../img/Architecture-pattern/cqrs/cqrs-architecture.png)

    Command-Query Responsibility Separation architecture expands the concept of Command-Query Separation to the architectural level. In general, we're dividing the architecture into a command stack, and a query stack, starting at the application layer.

    This is done for various reasons.
    - The primary reason is that queries should be optimized for reading data, whereas commands should be optimized for writing data. Commands execute behaviors in the domain model, mutate state, raise events, and write to the database. Queries use whatever means is most suitable to retrieve data from the database, project it into a format for presentation, and display it to the user. This change increases both the performance of the commands and queries, but equally important, it increases the clarity of the respective code.

        CQRS is domain-centric architecture done in a smart way. It knows when when to talk to the domain via commands, and when to talk directly to the database via queries.

    There are three main types of CQRS.
    - Single database CQRS

        ![](../img/Architecture-pattern/cqrs/cqrs-architecture.png)

        This type of CQRS has a single database that is either a third normal form relational database or some types of NoSQL.
        
        Commands execute behavior in the domain, which modify a state, which is then saved to the database through the persistence layer, which is often an ORM, that is an Object Relational Mapper like in Hibernate or Entity Framework.
            
        Queries are executed directly against the database using a thin data access layer, which is either an ORM using projections, LINQ to SQL, SQL scripts or stored procedures.

        This single database CQRS is the simplest of the three types of CQRS architectures.

    - Two database CQRS

        ![](../img/Architecture-pattern/cqrs/two-database-cqrs-architecture.png)

        This type of CQRS has both a read database and a write database.
        
        The command stack has its own database optimized for write operations. For example, a third normal form relational database or a NoSQL database.
        
        The query stack, however, uses a database optimized for read operations. For example, a first Normal form relational database or some other denormalized read optmize data store. The modifications to the right database are pushed into the read database either as a single coordinated transaction across both databases or using an eventual consistency pattern. That is, the two databases may be out of sync temporarily, but will always eventually becom in sync, typically on the order of milliseconds.

        This type of CQRS is more complex then the first, but can afford orders of magnitude improvements in performance on the read side of the system. This makes quite a bit of sense because we generally spend orders of magnitude more time reading from a database than we do writing to it. 

    - Event-Sourcing CQRS

        ![](../img/Architecture-pattern/cqrs/event-sourcing-cqrs-architecture.png)

        The third type of CQRS system is typically referred to as event sourcing. The main difference here is that we do not store the current state of our entities in a normalized data store. Instead, we store just the state modifications to the entities over time, represented as events that have occurred to the entities. We store this historical record of all events in a persistence medium called an event store. When we need to use an entity in its current state, we replay the events that have occurred to that entity, and we end up with the current state of the entity. Then, once we've reconstructed the current state of the entity we execute our domain logic, and modify the state of the entities accordingly.

        This new event will then be stored in our event store, so that it can be replayed as needed. Finally, we push the current state of our entity out to the read database, so our read queries will still be extremely fast. This is the most complex of the three types of CQRS, but it has some very powerful benefits in exchange for the additional costs.
        - First, since the current state of each entity can only be derived by replaying the sequence of events that have occurred to that entity, the event store acts as a complete and guaranteed to be true audit trail for the entire system. This is highly valuable in heavily regulated industries where this type of auditability is necessary.
        - Second, we can reconstruct the state of an entire entity at any point-in-time. This is useful for determining what the state of an entity was at any previous point in time in the system, and this is also very useful for debugging.
        - Third, we can replay events to observe what happened in the system. This is very useful for diagnostic and debugging. In addition, this is also very useful for load testing and regression testing in a test environment using existing production events that have occurred in the system.
        - Fourth, we can project the current state of our entities into more than one type of read optimized data store. For example, we can simultaneously populate and then query fast text indexing services like Lucene, graph databases, OLAP cubes, in-memory databases, and more. This means that each query can request data from the data store optimized for querying and presenting the corresponding data.
        - Finally, we can rebuild our production database just by playing the events. All we need to do to get the current state of our system is replay all of the events that have occurred in the past, and we end up with the current state of the system.

        These are some very powerful features if our architecture needs them, however, it can also be significant additional expense if we don't actually need any of these features. In addition, despite the fact that most people new to event sourcing assume that the right side of the system will be slow, in reality these systems are actually much faster than we would imagine. There arte also several types of optimizations that can be added, like generating periodic snapshots, if the performance of the right side of the system becomes an issue.

<br>

## When to use

- When avoiding the locking problem in database, and improve performance of the system.

- Use CQRS when we want to specify command and query for each use case. It makes our design clearly.

<br>

## Source code

The structure of packages in our source code will look like:

```bash

```

Belows are some steps that we need to implement in Event-Sourcing CQRS architectural pattern.

1. Define Command Bus pattern

    To know more about how to build this pattern, we can read about the article [Command Bus pattern](https://ducmanhphan.github.io/2020-12-02-command-bus-pattern/).

2. Define Event Bus pattern

    To know more about how to build this pattern, we can read about the article [Event Bus pattern]().

3. Define Domain Model

    Domain aggregate root is responsible for publishing domain events indicating that some internal states has changed.



4. Define an interface Domain Repository and its implementation

    The domain repository is responsible for publishing the events, this would normally be inside a single transaction together with storing the events in the event store.

    ```java
    public interface IDomainRepository {

        <T> T getById(String id);

        <T> void add(T aggregateRoot);

    }
    ```

5. 




<br>

## Benefits and Drawbacks

1. Benefits

    - If we're implementing domain-centric design, implementing CQRS is more efficient from a coding perspective. Commands are coded to use the rich domain models to modify state, and queries are coded directly against the database to read data.

    - By using CQRS, we're optimizing the performance of both the query side and the command side for their respective purposes. Depending upon which type of CQRS we implement, this can mean orders of magnitude improvements and performance.

    - By using event sourcing, we gain all of the benefits we discussed previously, and a few more that were not discussed. As systems become more complex or require high degrees of auditability, these features can become highly valuable to both the business and to the developers.

    - By persisting all happened events, we have some advantages:

        - We have an audit log for free, the events are stored and used in builiding up the Aggregate Roots they are guaranteed in sync with each other.
        - These events are write only, we will never add, alter or remove an event. So, if we encounter a bug in our system, the only way to correct it is to generate a new compensating event correcting the results of the bug.
        - We can replay all events.

    - Using CQRS architecture, we can split our work into multiple smaller parts. Then, assign them to the other teams in the project.

2. Drawbacks

    - There is an intentional inconsistency in the design of the command stack versus the query stack. Inconsistency in general makes software more complex and difficult to reason about, however we gain consistency within each stack as a tradeoff.

    - With two database CQRS, having both a read and write database is more complex, and potentially introduces an eventual consistency model to our databases.

    - Event sourcing entails higher cost to create and maintain the event sourcing features. If we'll not deriving sufficient business value from these additional features, event sourcing might not pay for itself in the long run.

## Wrapping up

- 

- 

- 

<br>

Refer:

[CQRS The example ebook - Mark Nijhof](http://leanpub.com/cqrs)

[Exploring CQRS and Event Sourcing - A journey into high scalability, availability, and maintainability with Window Azure ebook of Grey Young]()

[Clean Architecture: Patterns, Practices, and Principles by Matthew Renze](https://app.pluralsight.com/library/courses/clean-architecture-patterns-practices-principles/table-of-contents)

[https://www.slideshare.net/HanoiItlc/itlc-hanoi-cqrs-es-2210-2015](https://www.slideshare.net/HanoiItlc/itlc-hanoi-cqrs-es-2210-2015)

[https://medium.com/faun/why-we-failed-implementing-cqrs-in-microservice-architecture-5c39a2d0b2dd](https://medium.com/faun/why-we-failed-implementing-cqrs-in-microservice-architecture-5c39a2d0b2dd)

[https://medium.com/faun/four-event-driven-patterns-4b1cad5ac5e3](https://medium.com/faun/four-event-driven-patterns-4b1cad5ac5e3)

[https://medium.com/swlh/event-sourcing-as-a-ddd-pattern-fea6de35fcca](https://medium.com/swlh/event-sourcing-as-a-ddd-pattern-fea6de35fcca)

[https://martinfowler.com/bliki/ReportingDatabase.html](https://martinfowler.com/bliki/ReportingDatabase.html)

[https://itnext.io/cqrs-architecture-pattern-c7f5c613c59c](https://itnext.io/cqrs-architecture-pattern-c7f5c613c59c)

[https://itnext.io/optimize-your-data-access-by-using-cqrs-architecture-pattern-a-theoretical-and-practical-approach-part-1-b31fe259ea04](https://itnext.io/optimize-your-data-access-by-using-cqrs-architecture-pattern-a-theoretical-and-practical-approach-part-1-b31fe259ea04)