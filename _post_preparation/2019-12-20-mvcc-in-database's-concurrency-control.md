---
layout: post
title: MVCC in Database's concurrency control
bigimg: /img/image-header/factory.jpg
tags: [Database]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution when using MVCC](#solution-when-using-mvcc)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution when using MVCC

1. How MVCC works




2. 



3. The relationship between MVCC and isolation level

    MVCC works only with the REPEATABLE READ and READ COMMITTED isolation levels.

    READ UNCOMMITTED isn't MVCC compatible because queries don't read the row version that's appropriate for their transaction version. They read the newest version, no matter what.

    SERIALIZABLE isn't MVCC-compatible because reads lock every row they return.

<br>

## When to use





<br>

## Benefits and Drawbacks

1. Benefits

    - 
    - 
    - 

2. Drawbacks

    - Using MVCC way makes our storage engine contains more data with each row, simply because a row can have multiple versions.

        - When we only use single database, it's fine for our system.
        - Using this data redundancy in each row of our database, the problems arise when applying some techniques such as master-slave model. 

            In master-slave architecture, the master node will be responsible for writing data. Then, to replica each change in the master to the other slave node, our database will read them in the bin log, and forward them to the slave nodes. The more we have the data redundancy, the more we encounter conundrums.

            To be more specific, we can read up on about the following [article of Uber engineering](https://eng.uber.com/postgres-to-mysql-migration/).

<br>

## Wrapping up






<br>

Refer:

[High performance in MySQL](https://www.amazon.com/High-Performance-MySQL-Optimization-Replication/dp/1449314287)

[https://en.wikipedia.org/wiki/Multiversion_concurrency_control](https://en.wikipedia.org/wiki/Multiversion_concurrency_control)

[https://en.wikipedia.org/wiki/Snapshot_isolation](https://en.wikipedia.org/wiki/Snapshot_isolation)

[]()
