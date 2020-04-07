---
layout: post
title: How to use indexes in MySQL
bigimg: /img/image-header/home-office-1.jpg
tags: [database]
---

To improve the speed of accessing a database, one way that you can think about is to use index. The internal detail of using indexes is relevant to the B+ Tree. To understand deeply about using indexes, you can practice to make B+ tree at this [link](https://ducmanhphan.github.io/2019-01-22-B+-tree).

Using too many indexes is to make your database that is accessed data slow down when utilizing some operations such as insertion, update, deletion. In this article, we will learn how to use index correctly in MySQL.


## Table of Contents
- [How database works when calling query](#how-database-works-when-calling-query)
- [Use index in MySQL](#use-index-in-mysql)
- [Wrapping up](#wrapping-up)

<br>

## Types of Indexes in MySQL

There are different types of indexes in relational theory. Each index is designed to achieve a different goal. Old indexes, which we are implemented at the database storage level instead of database server level, hence, each index is different from each other and there is no single way to implement indexes in MySQL. In simple words, the inner workings for each index are quite different from each other.

Belows are some types of indexes that we need to know.
- B-Tree index
- Clustered index
- Hash index
- Other index types

1. Introduction to InnoDB and MyISAM

    There are many different types of storage engines available for MySQL. Index structure, performance, and features are dependent on the storage engine used under the hood of MySQL installation.

    Belows is the comparison between InnoDB and MyISAM storage engines that is usually used in production environment.

    |                   InnoDB                |                    MyISAM                   |
    | --------------------------------------- | ------------------------------------------- |
    | Default storage engine as of MySQL 5.5  | Default storage engine before MySQL 5.5     |
    | 

    

<br>

## 






<br>

## How database works when calling query






<br>

## Use index in MySQL






<br>

## Wrapping up





<br>

Refer: 

[https://techtalk.vn/ly-do-khien-uber-phai-chuyen-tu-postgres-sang-mysql.html](https://techtalk.vn/ly-do-khien-uber-phai-chuyen-tu-postgres-sang-mysql.html)

[https://dev.mysql.com/doc/refman/5.7/en/index-merge-optimization.html](https://dev.mysql.com/doc/refman/5.7/en/index-merge-optimization.html)

[https://planet.mysql.com/entry/?id=661727](https://planet.mysql.com/entry/?id=661727)

[https://techtalk.vn/nhung-kien-thuc-giup-website-cua-ban-nhanh-len-gap-n-lan.html](https://techtalk.vn/nhung-kien-thuc-giup-website-cua-ban-nhanh-len-gap-n-lan.html)

[https://www.slideshare.net/billkarwin/how-to-design-indexes-really](https://www.slideshare.net/billkarwin/how-to-design-indexes-really)

[https://cstack.github.io/db_tutorial/parts/part7.html](https://cstack.github.io/db_tutorial/parts/part7.html)

[https://dzone.com/articles/database-btree-indexing-in-sqlite](https://dzone.com/articles/database-btree-indexing-in-sqlite)

[https://use-the-index-luke.com/sql/anatomy/the-tree](https://use-the-index-luke.com/sql/anatomy/the-tree)

[https://www.geeksforgeeks.org/indexing-in-databases-set-1/](https://www.geeksforgeeks.org/indexing-in-databases-set-1/)

[http://coding-geek.com/how-databases-work/#Tree_and_database_index](http://coding-geek.com/how-databases-work/#Tree_and_database_index)

[https://chartio.com/learn/databases/how-does-indexing-work/](https://chartio.com/learn/databases/how-does-indexing-work/)

[http://www.mysqltutorial.org/mysql-index/mysql-use-index/](http://www.mysqltutorial.org/mysql-index/mysql-use-index/)

[http://www.mysqltutorial.org/mysql-index/mysql-index-cardinality/](http://www.mysqltutorial.org/mysql-index/mysql-index-cardinality/)

[https://gravitymodel.net/database-indexing-archiving-purging/](https://gravitymodel.net/database-indexing-archiving-purging/)

<br>

**How MySQL indexes works internally**

[https://guide.couchdb.org/draft/btree.html](https://guide.couchdb.org/draft/btree.html)

[https://stackoverflow.com/questions/3567981/how-do-mysql-indexes-work](https://stackoverflow.com/questions/3567981/how-do-mysql-indexes-work)