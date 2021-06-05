---
layout: post
title: Understanding about Hash Index in RDBMS
bigimg: /img/image-header/yourself.jpeg
tags: [Database]
---

In this article, we will learn how to use Hash Index and when to use it in our database. Let's get started.

<br>

## Table of contents
- [Introduction to Hash Index](#introduction-to-hash-index)
- [Introduction to Adaptive Hash Index](#introduction-to-adaptive-hash-index)
- [How Hash Index works](#how-hash-index-works)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Applications and Examples](#applications-and-examples)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to Hash Index

Belows are some characteristics of Hash Index:
- A Hash Index is built on a Hash Table.
- It increases performance for exact lookups.
- For each row, a hash code is generated.

    - Generally different keys generate different hash codes.
    - It stores hash codes in index with pointer to each row in a hash table.
    - If there are multiple values with the same hash code, it will also contain their own pointers in linked list. It looks like hash index has very similar logic as hash algorithm.

- Memory storage engine in MySQL supports explicit hash tables.
- Hash indexes are very fast and effective as it resides in memory.

<br>

## Introduction to Adaptive Hash Index

In MySQL, InnoDB storage engine supports adaptive hash index. This is an automatic process, it does not give us any control to configure it. So, we can disable adaptive hash index, but we can't do any modification in this algorithm.

Hash Indexes are built in-memory on the top of frequently used B-Tree indexes. MySQL engines automatically figures out which are the most frequently used B-Tree indexes. It will takes those B-Tree indexes and values and put them into memory. In the memory, it will build hash index on the top of it. Now, our storage engine has definitely B-Tree indexes and on the top of it, there are hash indexes in memory. When MySQL engines receives any query, it will evaluate it for hash index as well as B-Tree index. If there are scan or any other situation where we have used different operators than equal to, it will directly use B-Tree indexes. However, there is a direct lookup of any particular value, MySQL engine will use in memory hash index to get data immediately.

In other words, adaptive hash index gives B-Tree indexes very fast hash lookups for improved performance. This is one of reasons why InnoDB storage engine is getting more popular into various installations of MySQL and more, more people are migrating from MyISAM to InnoDB for performance.

If our storage engine does not support Hash Indexes, we can also simulate them ourself manually. However, this process is very complicated and maintaince of those hash indexes can be a nightmare sometimes.

<br>

## How Hash Index works

Let's assume that we have a single table, it has six rows.

![](../img/Database/MySQL/index/hash-index/ex-hash-index-works.png)

Assuming that our query is on FirstName. For example:

```sql
SELECT FirstName, LastName FROM TableName WHERE FirstName="Jeff";
```

It means that we are going to lookup for FirstName is equal to "Jeff" in the FirstName column.

Let's build hash index on FirstName column. We applied a random hash function on our FirstName column and below is a table that describe it.

![](../img/Database/MySQL/index/hash-index/ex-hash-index-works-1.png)

The hash function generates a different value for each row in our table. The first two column, FirstName and LastName, are the original table. HashFn and Value are columns from our hash index. Column Value will contain a pointer to the row on which hash function is applied.

In our case, we are looking for Jeff Ross as an answer to our query. Now let's understand how a query works internally.

![](../img/Database/MySQL/index/hash-index/ex-hash-index-works-2.png)

On the left side, we have a hash index and on the right side, we have the original table. First, our hash function is applied on value "Jeff". It will return as value 4786. Now, the same query is internally rewritten as ```SELECT Value FROM TableName WHERE HashFn() = 4786```. That will return us the value of **Value** column - **Pointer to row 5**. MySQL engine will lookup internally row 5 and give us value "Jeff Ross" as our final result.


<br>

## When to use






<br>

## Benefits and Drawbacks

1. Benefits

2. Drawbacks

    - It only contains hash code, row pointers - not real data in the index. As Hash Index does not contain original data, it is not effective in sorting, and partial matching.

        For example, The partial matching queries would be find all the first names starting with the letter A.

    - Hash Index only supports Equal To ("=") operator. If we have any other operator in our query, hash indexes will not be effective or useful.

    - Generally a different case generates different hash codes, but due to any reason, if our table is huge, it's quite possible to have multiple rows with the same hash code. Multiple values with the same hash code will result in slower performance.

        - This is because the storage engine will follow each row pointer in the linked list and compare the value to the lookup values to get necessary data.

        - Slow maintaince.

<br>

## Wrapping up

- Using hash index is very efficient and it improves the performance of the query massively.


<br>

Refer:

[MySQL Indexing for Performance by Pinal Dave](https://app.pluralsight.com/library/courses/mysql-indexing-performance/table-of-contents)