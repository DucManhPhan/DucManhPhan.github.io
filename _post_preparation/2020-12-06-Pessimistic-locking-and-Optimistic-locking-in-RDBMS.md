---
layout: post
title: Pessimistic locking and Optimistic locking in RDBMS
bigimg: /img/image-header/yourself.jpeg
tags: [Database]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of locking in RDBMS](#solution-of-locking-in-rdbms)
- [Pessimistic locking](#pessimistic-locking)
- [Optimistic locking](#optimistic-locking)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

In single tier architecture, we have all things in one computer. It will include user interface, backend business logic, and database. With this architecture, normally we will only have one user to use this application. So, our database only takes care about containing data.

But from two tier architecture, n-tier architecture, we have multiple users in our system. It means that at the same time, we will have multiple requests to interact with our database. There are many problems will raise in this context, especially resolving conflicts of read/write operations between multiple requests at the same table or rows in database.

Belows are some problems that we have to deal with.
- Lost update

    Assuming that we have Person 1 and Person 2 that interact with our database such as Employee table.

    |   Time   |        Person 1        |        Person 2        |
    | -------- | ---------------------- | ---------------------- |
    | T1       | Read row with id = 1   |                        |
    | T2       |                        | Read row with id = 1   |
    | T3       | Write this changed row to DB |                  |
    | T4       |                        | Write this changed row to DB |

    We can find that Person 1's update of the database has been lost by some changes of Person 2. So, we can called it as the lost update syndrome.

    If it happens in the blocks of database, we can take the negative consequence of it.

- Uncommitted dependency problem

    This problem is related to the Commit/Rollback mechanism of the transaction management.

    For example, assuming that we have two transaction T1 and T2.

    |               T1              |               T2              |
    | ----------------------------- | ----------------------------- |
    | SELECT * FROM customer;       |                               |
    |                               | UPDATE customer SET name = 'Johnson'; Rollback; | 
    | SELECT * FROM customer;       |                               |

    Based on the above example, we can find that the result of the second query of T1 transaction is different than the first query's result of T1 transaction.

    Because T1 transaction can see the uncommitted data from T2 transaction.

- Inconsistent analysis problem

<br>

## Solution of locking in RDBMS

To overcome this problem, we need to protect our data from multiple requests that interact the same table or row. So we need locking.




<br>

## Pessimistic locking

1. Given problem



2. Solution



3. Implementations of pessimistic locking

    - Two phase locking


<br>

## Optimistic locking

1. Given problem



2. Solution




2. Some implementations of optimistic locking

    - The timestamp-based concurrecy control

        The timestamp-based algorithm assigns a single (more correctly one for each kind of operation, read and write) timestamp to each object, denoting the last transaction that accessed it. So each transaction checks during the operation, if it conflicts with the last transaction that accessed the object.

    - The multi-version concurrecy control

        The multi-version approach maintains multiple versions of each object, each one corresponding to a transaction. As a result, the multi-version approach manages to have fewers aborts than the first approach, since a potentially conflicting transaction can write a new version, instead of aborting in some cases. However, this is achieved at the cost of more storage required for all the versions.

<br>

## Comparison between Pessimistic locking and Optimistic locking





<br>

## Understanding about transaction management

Database transactions are designed to prevent the database being left in an inconsistent state regardless of the circumstances of the attempted update.

A transaction is a group of database operations that is treated as an atomic unit, for example: they are all completed or none of them is completed.

The commit statement signals the successful end of a series of updates within one transaction. It tells the DBMS to save all the amended data and to terminate the current transaction.

The rollback statement aborts the current transaction. All updates, within the current transaction, are cancelled and the database reverts to its state before the start of transaction.


<br>

## Wrapping up




<br>

Refer:

[http://git@github.com.github.com/blog/2013/05/13/exclusivelock-sharedlock/](http://git@github.com.github.com/blog/2013/05/13/exclusivelock-sharedlock/)

[https://mjabr.wordpress.com/2011/06/10/differences-between-pessimistic-and-optimistic-locking/](https://mjabr.wordpress.com/2011/06/10/differences-between-pessimistic-and-optimistic-locking/)

[https://convincedcoder.com/2018/09/01/Optimistic-pessimistic-locking-sql/](https://convincedcoder.com/2018/09/01/Optimistic-pessimistic-locking-sql/)

[https://stackoverflow.com/questions/5751271/optimistic-vs-multi-version-concurrency-control-differences/39269085](https://stackoverflow.com/questions/5751271/optimistic-vs-multi-version-concurrency-control-differences/39269085)

[https://en.wikipedia.org/wiki/Timestamp-based_concurrency_control](https://en.wikipedia.org/wiki/Timestamp-based_concurrency_control)

[https://en.wikipedia.org/wiki/Multiversion_concurrency_control](https://en.wikipedia.org/wiki/Multiversion_concurrency_control)

[https://en.wikipedia.org/wiki/Two-phase_locking](https://en.wikipedia.org/wiki/Two-phase_locking)