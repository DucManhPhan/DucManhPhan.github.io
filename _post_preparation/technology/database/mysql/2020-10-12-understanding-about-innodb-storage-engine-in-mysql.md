---
layout: post
title: Understanding about InnoDB storage engine in MySQL
bigimg: /img/image-header/yourself.jpeg
tags: [MySQL, Database]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Introduction to InnoDB storage engine](#introduction-to-innodb-storage-engine)
- [History about InnoDB storage engine](#history-about-innodb-storage-engine)
- [Some best practice for using InnoDB](#some-best-practice-for-using-innodb)
- [Some features of InnoDB](#some-features-of-innodb)
- [The comparison between InnoDB and MyISAM storage engines](#the-comparison-between-innodb-and-myisam-storage-engines)
- [The comparison between InnoDB and storage engines](#the-comparison-between-innodb-and-storage-engines)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Introduction to InnoDB storage engine

0. Introduction to InnoDB



1. InnoDB and the table's data

    The InnoDB storage engine stores its data in a series of one or more data files that are collectively known as a **tablespace**. A tablespace is essentially a black box that InnoDB manages all by itself.

    In MySQL 4.1 and newer versions, InnoDB can store each table's data and indexes in separate files. InnoDB can also use raw disk partitions for building its tablespace, but modern filesystems make this unnecessary.

2. InnoDB and isolation levels

    InnoDB uses MVCC to achieve high concurrency, and it implements all four SQL standard isolation levels. It defaults to the REPEATABLE READ isolation level, and it has a **next-key locking strategy** that prevents phantom reads in this isolation level, rather than locking only the rows that we need. InnoDB locks gaps in the index structure as well, preventing phantoms from being inserted.

3. InnoDB and indexes

    InnoDB tables are built on a clustered index. InnoDB's index structure are very different from those of most other MySQL storage engines. As a result, it provides very fast primary key lookups. However, secondary indexes contain the primary key columns, so if our primary key is large, other indexes will also be large. So, we need to keep small primary key if we'll have many indexes on a table.

    InnoDB includes some internal optimizations:
    - predictive read-ahead for prefetching data from disk
    - an adaptive hash index that automatically builds hash indexes in memory for very fast lookups.
    - insert buffer to speed inserts.

<br>

## History about InnoDB storage engine






<br>

## Some best practice for using InnoDB






<br>

## Some features of InnoDB

1. In MySQL 5.1

    The InnoDB storage engine was used as plugin in MySQL 5.1. Belows are some features of this version.
    - building indexes by sorting
    - drop and add indexes without rebuilding the whole table
    - a new storage format that offers compression
    - store large values such as BLOB columns
    - file format management

2. In MySQL 5.6



3. In MySQL 8.0



<br>

## When to use






<br>

## The comparison between InnoDB and MyISAM storage engines

There are many different types of storage engines available for MySQL. Index structure, performance, and features are dependent on the storage engine used under the hood of MySQL installation.

Belows is the comparison between InnoDB and MyISAM storage engines that is usually used in production environment.

|                   InnoDB                |                    MyISAM                   |
| --------------------------------------- | ------------------------------------------- |
| Default storage engine as of MySQL 5.5  | Default storage engine before MySQL 5.5     |
| ACID compliant                          | Not ACID compliant                          |
| Transactional (Rollback, Commit)        | Non-transactional                           |
| Row-level locking                       | Table-level locking                         |
| Row data stored in pages as per Primary Key order | No particular order for data stored |
| Supports Foreign Keys                   | Does not support relationship constraint    |
| No full text search                     | Full text search                            |

ACID stands for Atomicity, Consistency, Isolation and Durability. This is very crucial for data integrity.



<br>

## The comparison between InnoDB and storage engines






<br>

## Wrapping up




<br>

Refer:

[MySQL Indexing for Performance by Pinal Dave](https://app.pluralsight.com/library/courses/mysql-indexing-performance/table-of-contents)

[High performance MySQL, 3rd edition](https://www.amazon.com/High-Performance-MySQL-Optimization-Replication/dp/1449314287)

[InnoDB 1.1 for MySQL 5.5 User's Guide](https://downloads.mysql.com/docs/innodb-1.1-en.pdf)

[https://blog.jcole.us/2013/01/07/the-physical-structure-of-innodb-index-pages/](https://blog.jcole.us/2013/01/07/the-physical-structure-of-innodb-index-pages/)

[https://blog.jcole.us/2013/01/10/btree-index-structures-in-innodb/](https://blog.jcole.us/2013/01/10/btree-index-structures-in-innodb/)