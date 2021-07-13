---
layout: post
title: Understanding about ACID properties in database
bigimg: /img/image-header/california.jpg
tags: [Database]
---

In this article, we will learn about ACID properties that all databases have to be abided by them. These properties are very crucial to choose database's type for our distributed system.

Let's get started.

<br>

## Table of contents
- [Introduction to ACID properties of database](#introduction-to-acid-properties-of-database)
- [Atomicity](#atomicity)
- [Consistency](#consistency)
- [Isolation](#isolation)
- [Durability](#durability)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to ACID properties of database

According to [the definition of ACID on wikipedia.com](https://en.wikipedia.org/wiki/ACID), we have:

```
In computer science, ACID (atomicity, consistency, isolation, durability) is a set of properties of database transactions intended to guarantee validity even in the event of errors, power failures, etc. In the context of databases, a sequence of database operations that satisfies the ACID properties (and these can be perceived as a single logical operation on the data) is called a transaction.

For example, a transfer of funds from one bank account to another, even involving multiple changes such as debiting one account and crediting another, is a single transaction.
```

So, we can find that ACID properties has some points:
- It is relevant to the database transactions.

<br>

## Atomicity

1. Introduction to Atomicity

    A transaction is a group of database operations that is treated as an atomic unit. It means that all operations within a transaction are executed successfully, or none of them will executed.

    The rule for this properties is:

    ```
    All or Nothing Transactions
    ```

    For example, if Person T1 wants to transfer ```$20``` to Person T2. Then we have some operations for this case:
    - Read the balance of T1.       (1)
    - **balanceT1** = **balanceT1** - 20       (2)
    - Write the **balanceT1** to database.      (3)
    - Read the balance of T2.                   (4)
    - **balanceT2** = **balanceT2** + 20        (5)
    - Write the **balanceT2** to database.      (6)

    With the atomicity property, if one of the above operations is fail, our transaction is rollbacked to the initial state.

    To apply this property, database uses Commit/Rollback mechanism.

2. How to implement rollback mechanism in DBMS

    In order to revert to the previous state of our database, DBMS provides a undo log append-only structure. In Oracle, MySQL, it is called undo log. But in SQL Server, it is called transaction log. PostgreSQL does not have an undo log, but it use a multi-version table structure since tables can store multiple versions of the same row.

<br>

## Consistency

A database is initially in a consistent state, and it should remain consistent after every transaction. It means that only valid data will be written to the database.

The rule for this properties is:

```
Guaratees committed transaction state
```

For example, with the step 2 of an above example, after subtracting the money ```$20``` from the balance of Person t1, the balance is less than 0. It does not accepted for the account's balance. Then this operation will violate the rule of Consistency. So, this transaction will be rollbacked.

<br>

## Isolation

Nowadays, all databases handle multithreading, it means that at the same time, it has multi transaction works. With the isolation property, the transactions are separated from each other because it can cause race condition, inconsistent data.

The rule for this properties is:

```
Transactions are independent
```

To apply this property, database normally uses locking mechanism such as Optimistic locking or Pessimistic locking.

<br>

## Durability

The durability property means that if our database has some errors that causes crash, or failure, it has the ability to keep track the pending changes, or changes that have been committed to the database should remain, when database runs again.

The rule for this properties is:

```
Committed data is never lost
```

To apply this property, database uses redo logs. The redo log is an append-only disk-based structure that stores every change a given transaction has undergone. When a transaction commits, every data page change will be written to the redo log as well.

In PostgreSQL, it is called WAL - Write Ahead Log. In MySQL, Oracle, it is called as redo log.

<br>

## Wrapping up

- Understanding about Atomicity, Consistency, Isolation, and Durability properties.

- Understanding how these properties will be applied in our database SQL or NoSQL.

<br>

Refer:

[https://tomyrhymond.wordpress.com/2011/10/01/acid-automicity-consistency-isolation-and-durability/](https://tomyrhymond.wordpress.com/2011/10/01/acid-automicity-consistency-isolation-and-durability/)

[https://blog.sqlauthority.com/2016/04/10/acid-properties-database-interview-question-week-066/](https://blog.sqlauthority.com/2016/04/10/acid-properties-database-interview-question-week-066/)

[https://en.wikipedia.org/wiki/ACID](https://en.wikipedia.org/wiki/ACID)

[https://vladmihalcea.com/how-does-a-relational-database-work/](https://vladmihalcea.com/how-does-a-relational-database-work/)