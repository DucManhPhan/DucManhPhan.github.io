---
layout: post
title: Pessimistic locking and Optimistic locking
bigimg: /img/image-header/yourself.jpeg
tags: [Database, Enterprise Pattern]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of locking in RDBMS](#solution-of-locking-in-rdbms)
- [Pessimistic locking](#pessimistic-locking)
- [Optimistic locking](#optimistic-locking)
- [How to choose Pessimistic locking or Optimistic locking](#how-to-choose-pessimistic-locking-or-optimistic-locking)
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

Belows are some level lockings that we need to know:
1. Database level locking

    This level locking does not use frequently in reality because it impacts to our system when encountering multiple session at the same time.

    But it is useful in some specific cases:
    - Our DBMS want to upgrade to a new version.

2. Table level locking

    The table level locking will be used in cases:
    - When we have some modifications in all table.
    
        For example: Use in some DDL operations such as ALTER, CREATE, DROP.

    In MySQL 8.0, InnoDB engine uses intention locks, are table-level locks that indicate that which type of lock (shared or exclusive) a transaction requires later for a row in a table.
    - An intention shared lock (IS) indicates that a transaction intends to set a shared lock on individual rows in a table.
    - An intention exclusive lock (IX) indicates that a transaction intends to set an exclusive lock on individual rows in a table.

    Intention locks do not block anything except full table requests (for example, LOCK TABLES ... WRITE). The main purpose of intention locks is to show that someone is locking a row, or going to lock a row in the table.

3. Page or Block level locking

4. Row level locking

    There are two types of row-level lockings in RDBMS:
    - Shared lock permits a transaction that hold a lock to read a row.
    - Exclusive lock permits a transaction that hold a lock to update or delete a row.

5. Column level locking

In this article, we only need to consider the strategies of row-level locking:
- Pessimistic locking
- Optimistic locking

<br>

## Pessimistic locking

1. Introduction to Pessimistic locking

    The idea of pessimistic locking is that it assumes that the concurrency conflicts usually happen in our database.

    Pessimistic locking is a locking strategy that it will lock a record at the first accessing time. It ensures that only one user can do something with this record at any given time.

    Pessimistic locking exists until the transaction commits or rolls back.

2. Benefits and Drawbacks

    - Benefits
        - Processes know immediately when a locking violation occurs, rather than after the transaction is complete.

    - Drawbacks
        - It is not fully supported by all databases.
        - It consumes extra database resources because we need to remain the connection between the application and the database.
        - It can be caused deadlocks.
        - It decreases the concurrency of connection pooling when using the server session, which affects the overall scalability of your application.

3. Some implementations of Pessimistic locking

    - Two phase locking

4. Pessimistic locking with the other RDBMS

    - Oracle TopLink, an ORM framework, implements pessimistic locking by using database row-level locks, such that attempts to read a locked row either fail or are blocked until the row is unlocked, depending on the database.

    - MySQL utilizes the auto commit mode by default. It means that after we completed an update operation, it will commit data. So if we need to use Pessimistic locking, we must change this auto commit mode. 

        Beside above statements, MySQL cluster uses pessimistic record locking.

5. When to use

    - when the chance of conflict is high.
    - when the cost of locking is less than the cost of rolling back transaction.

<br>

## Optimistic locking

1. Introduction to Optimistic locking

    The idea of optimistic locking is that it assumes that the concurrency conflicts rarely happen in our database, so we don't need to lock it immediately after a user enters a record.

    Optimistic locking is a strategy locking that will lock record when a user commited or saved, not at the first time - accessing it. It is a way that a database checks whether the original record and the updated record can be conflicted or not by using signals.

    These signals can be calculated by some approaches:
    - Use an additional column with integer type or timestamp type to save the version of a record.

        It means that the database will check the version column of the original record and the updated record. If it is equal together, this updated operation will be processed successfully. Otherwise, it will be aborted.

    - Use the checksum or hash function to get a value based on the original record.

        In this approach, a database will need a checksum or hash function to calculate from the current record. It takes too much time or not depends on the algorithm that we choose.

    So, belows are some operations of Optimistic locking:
    - No locks when data is read
    - After the data is saved, our database will check for conflicts.

        If the data was changed by another transaction since it was read earlier, it usually does this by checking some version numbers on the data or by checking the individual fields.

        If there was a change, the transaction won't complete, then it will be rolled back.

    - This locking will notify the user, show them the updated values from the database and give them a chance to overwrite those values with their own changes.

2. Benefits and Drawbacks

    - Benefits
        - It doesn't require us to lock up the database resource.
        - It improves concurrency because a record is not actually locked when at first time, it is accessed by a transaction. So, the multiple applications can read a record.
        - Without locking database when reading, writing a record, it prevents deadlocks.

    - Drawbacks
        - With this locking, some applications need to take time to calculate the version of each column.

3. Some implementations of optimistic locking

    - The timestamp-based concurrecy control

        The timestamp-based algorithm assigns a single (more correctly one for each kind of operation, read and write) timestamp to each object, denoting the last transaction that accessed it. So each transaction checks during the operation, if it conflicts with the last transaction that accessed the object.

    - The multi-version concurrecy control

        The multi-version approach maintains multiple versions of each object, each one corresponding to a transaction. As a result, the multi-version approach manages to have fewers aborts than the first approach, since a potentially conflicting transaction can write a new version, instead of aborting in some cases. However, this is achieved at the cost of more storage required for all the versions.

4. Optimistic locking with the other RDBMS

    - In Oracle 10g or above, it uses the hidden **ORA_ROWSCN** based on the internal **Oracle System Clock** (SCN) that is as same as checksum, but it does not take the calculation cost when updated. In order to use this functionality, our table will need to setup in **ROWDEPENDENCIES** mode.

    - In MS SQL server, it uses READ_COMMITTED isolation level by default, Optimistic locking will allow readers and writers threads to work concurrently, but writers will block write until the blocking thread commits.

5. When to use

    - when the chance of conflict is low
    - when the cost of rolling back is lower than the cost of locking data

<br>

## How to choose Pessimistic locking or Optimistic locking

1. Pessimistic locking

    - Use this locking in the stateful or the long connection between the server and the database.

        --> So, we need to increase the connection pool of the system, and affect to the system's performance when there are the large amount of connection.

        --> Increase software and hardware to adapt it.

2. Optimistic locking

    - Take the high storage of database because we must utilize an additional version column or using checksum function --> affect to the performance of the system.

        With a table that contains fields such as LONG, RAW, BLOB, the checksum function isn't useful.

Therefore, analysis carefully our system's demand --> choose the right tools for the right jobs.

<br>

## Wrapping up

- The optimistic lock is obtained only after the transaction has committed.

- The pessimistic lock is obtained at the first accessing time.

<br>

Refer:

[http://git@github.com.github.com/blog/2013/05/13/exclusivelock-sharedlock/](http://git@github.com.github.com/blog/2013/05/13/exclusivelock-sharedlock/)

[https://mjabr.wordpress.com/2011/06/10/differences-between-pessimistic-and-optimistic-locking/](https://mjabr.wordpress.com/2011/06/10/differences-between-pessimistic-and-optimistic-locking/)

[https://convincedcoder.com/2018/09/01/Optimistic-pessimistic-locking-sql/](https://convincedcoder.com/2018/09/01/Optimistic-pessimistic-locking-sql/)

[https://stackoverflow.com/questions/5751271/optimistic-vs-multi-version-concurrency-control-differences/39269085](https://stackoverflow.com/questions/5751271/optimistic-vs-multi-version-concurrency-control-differences/39269085)

[https://en.wikipedia.org/wiki/Timestamp-based_concurrency_control](https://en.wikipedia.org/wiki/Timestamp-based_concurrency_control)

[https://en.wikipedia.org/wiki/Multiversion_concurrency_control](https://en.wikipedia.org/wiki/Multiversion_concurrency_control)

[https://en.wikipedia.org/wiki/Two-phase_locking](https://en.wikipedia.org/wiki/Two-phase_locking)

[https://enterprisecraftsmanship.com/posts/optimistic-locking-automatic-retry/](https://enterprisecraftsmanship.com/posts/optimistic-locking-automatic-retry/)

[https://vladmihalcea.com/how-does-mvcc-multi-version-concurrency-control-work/](https://vladmihalcea.com/how-does-mvcc-multi-version-concurrency-control-work/)

[https://labs.septeni-technology.jp/technote/optimistic-hay-pessimistic-locking/](https://labs.septeni-technology.jp/technote/optimistic-hay-pessimistic-locking/)

[https://nguyenminhdung.wordpress.com/2009/07/14/khoa-locking/](https://nguyenminhdung.wordpress.com/2009/07/14/khoa-locking/)

[https://docs.oracle.com/cd/B14099_19/web.1012/b15901/dataaccs008.htm](https://docs.oracle.com/cd/B14099_19/web.1012/b15901/dataaccs008.htm)

[https://blog.mimacom.com/handling-pessimistic-locking-jpa-oracle-mysql-postgresql-derbi-h2/](https://blog.mimacom.com/handling-pessimistic-locking-jpa-oracle-mysql-postgresql-derbi-h2/)

<br>

**Page or Block level locking**

[https://www.programmerinterview.com/database-sql/page-versus-block/](https://www.programmerinterview.com/database-sql/page-versus-block/)

[https://blog.couchbase.com/optimistic-or-pessimistic-locking-which-one-should-you-pick/](https://blog.couchbase.com/optimistic-or-pessimistic-locking-which-one-should-you-pick/)

[https://learning-notes.mistermicheels.com/data/sql/optimistic-pessimistic-locking-sql/](https://learning-notes.mistermicheels.com/data/sql/optimistic-pessimistic-locking-sql/)

[https://pingcap.com/blog/pessimistic-locking-better-mysql-compatibility-fewer-rollbacks-under-high-load](https://pingcap.com/blog/pessimistic-locking-better-mysql-compatibility-fewer-rollbacks-under-high-load)

[https://www.infoworld.com/article/2075406/optimistic-locking-pattern-for-ejbs.html](https://www.infoworld.com/article/2075406/optimistic-locking-pattern-for-ejbs.html)

<br>

**InnoDB locking**

[https://dev.mysql.com/doc/refman/8.0/en/innodb-locking.html](https://dev.mysql.com/doc/refman/8.0/en/innodb-locking.html)

<br>

**Two-phase locking**

[https://www.geeksforgeeks.org/two-phase-locking-protocol/?ref=rp](https://www.geeksforgeeks.org/two-phase-locking-protocol/?ref=rp)

[https://www.geeksforgeeks.org/two-phase-locking-2-pl-concurrency-control-protocol-set-3/?ref=rp](https://www.geeksforgeeks.org/two-phase-locking-2-pl-concurrency-control-protocol-set-3/?ref=rp)

[https://www.geeksforgeeks.org/moss-concurrency-control-protocol-distributed-locking-in-database/?ref=rp](https://www.geeksforgeeks.org/moss-concurrency-control-protocol-distributed-locking-in-database/?ref=rp)