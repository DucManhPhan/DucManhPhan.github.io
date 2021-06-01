---
layout: post
title: Understanding about MyISAM storage engine in MySQL
bigimg: /img/image-header/yourself.jpeg
tags: [MySQL, Database]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Introduction to InnoDB storage engine](#introduction-to-innodb-storage-engine)
- [History about InnoDB storage engine](#history-about-innodb-storage-engine)
- [Some best practice for using InnoDB](#some-best-practice-for-using-innodb)
- [The comparison between InnoDB and MyISAM storage engines](#the-comparison-between-innodb-and-myisam-storage-engines)
- [The comparison between InnoDB and storage engines](#the-comparison-between-innodb-and-storage-engines)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Introduction to InnoDB storage engine






<br>

## History about InnoDB storage engine






<br>

## Some best practice for using InnoDB






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

[https://blog.jcole.us/2013/01/07/the-physical-structure-of-innodb-index-pages/](https://blog.jcole.us/2013/01/07/the-physical-structure-of-innodb-index-pages/)

[https://blog.jcole.us/2013/01/10/btree-index-structures-in-innodb/](https://blog.jcole.us/2013/01/10/btree-index-structures-in-innodb/)