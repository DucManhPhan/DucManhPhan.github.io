---
layout: post
title: Understanding about B-Tree index in RDBMS
bigimg: /img/image-header/yourself.jpeg
tags: [Database]
---




<br>

## Table of contents
- [Introduction to B-Tree Index](#introduction-to-b-tree-index)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Applications and Examples](#applications-and-examples)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to B-Tree Index

B-tree index is often referred as an index. Most of the MySQL storage engines support B-tree indexes.
- Each leaf node contains a link to the next node for the fast range traversals.
- Values are stored in order.
- Each leaf page is at the same distance from root level.
- Every storage engine has a different implementation of B-tree indexes.

    - For example, InnoDB storage uses B+ tree indexes.
    
    - In a B-tree, we can store both keys and data in the internal leaf nodes. However, in B+ tree, we can only store the data in a leaf node whereas internal node will contain the pointers.
    
        The key advantage in B+ tree is that intermediate node does not contain data, hence, more keys can be fit into the pages in intermediate node. Hence, the size of the entire B+ tree is much smaller than B-tree and more data can be stored into memory.
        
        Therefore, in the case of B+ tree, more numbers of indexes can be stored in the memory. Additionally, the leaf node of B+ tree are also linked, which increases the performance of the full scan or grand scan.

<br>

## When to use

- Mostly B-Tree is used as a secondary-index in a database, and B+ Tree with primary key is used as a clusted index.

    For example:
    - If a table has a primary key, MySQL will automatically create a cluster index, whose leaf nodes contains pointers to the pages in a disk. 
    - To create a B-Tree index, typing the following command:

        ```java
        CREATE INDEX idx_specific_fild ON student(specific_field);
        ```

        InnoDB storage engine in MySQL support secondary indexes on virtual column.

<br>

## Benefits and Drawbacks

1. Benefits

    - B-tree index speeds up data access.

        - The storage engine traverses from root node to leaf node with the help of pointers. In simpler words, to access any data, engine does not help to traverse in that table. It can just traverse a few nodes in the B-tree index structure and can get necessary index structure, and can get necessary data much faster.

    - B-tree index increases performance of following query patterns.

        - Full value
            
            For example, when we are searching for an entire word like "Data structure".

        - Leftmost value or column prefix

            For example, if we're searching for a word "Data" from "Data structure".

        - Range of value

            For example, if we're searching for every record, which is between 1-99, "Aaron" to "Fritz", "Aaron" to "Kei%". "%" - percentage is just a wildcard and represents that ending string can help first three letters as "Kei".

    - B-tree structure helps **ORDER BY** clause to increase the performance.

        When the B-tree structure keys are ordered the same way as what we want in ORDER By clause. We just looked at all the advantages of B-tree indexes. However, it's difficult to feel the importance of all these advantages until we understand how B-tree indexes are built.


2. Drawbacks

    - If the amount number of records in our database are small, using B-Tree index is more time-consuming than scanning table.

        So to index correctly data in a database, we need to find out the situtation in a database.

<br>

## Wrapping up

- Understanding about B-Tree helps us how database's query plan part works internally, how to choose the best query plan's time.

<br>

Refer:

[MySQL Indexing for Performance by Pinal Dave](https://app.pluralsight.com/library/courses/mysql-indexing-performance/table-of-contents)