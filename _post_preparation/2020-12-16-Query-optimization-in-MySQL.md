---
layout: post
title: Query optimization in MySQL
bigimg: /img/image-header/home-office-2.jpg
tags: [Database]
---

In database management tool, especially MySQL, we will have some basic commands with common structures.

```sql
SELECT [DISTINCT] ... FROM ... [INNER JOIN | LEFT JOIN | RIGHT JOIN ...]
[WHERE ...]
[GROUP BY ... [ASC | DESC]]
[HAVING ...]
[ORDER BY ... [ASC | DESC]]
[LIMIT row_count OFFSET offset]
[INTO OUTFILE 'file_name']

INSERT INTO ... VALUES ...

UPDATE ... SET ... WHERE ...

DELETE FROM ... WHERE ...
```

But actually, to optimize the speed of accessing data in disk, implementing with database is really important for back-end developer. 

So, in this article, we will list some ways to optimize query database. 

<br>

## Table of Contents





<br>

## Introduction to MySQL's Query Manager

In order to understand about the components of Query Manager and how they works, we can read the article [How relational database works](https://ducmanhphan.github.io/2020-01-19-How-relational-database-works/).





<br>

## Some reasons that makes a query perform slow

1. The most basic reason is it's working with too much data.

    It will makes MySQL extra work, adds networks overhead, and consumes memory and CPU resources.

    In this case, we will encounter that some cases:
    - Our query fetchs more rows than needed.

        For example, select query with Customer table contains 1.000.000 records.

        ```sql
        SELECT * FROM CUSTOMER;
        ```

2. Relevant to the connection pool

    - Do not use connection pool

        When each request is sent to database, it will create a new connection. After finished, this connection is destroyed.

        So, when we have multiple requests to database, it will create multi threads to work with queries. The problem about context switching will slow down the response time.

    - Connections not closed/returned to pool in case of exceptions

        When happened SQLException exception, if that connection will not be released, then the same connection can not be used for any other purpose till the connection is timed out.

<br>

## Solution with fetching so much data than needed

1. Fetching more rows by using select  * command

    Using LIMIT clause to our query to get the number of rows, and use some specific columns that we want.

    For example:

    ```sql
    SELECT name FROM CUSTOMER LIMIT 10;
    ```

    Retrieving all columns can prevent optimizations such as covering indexes, as well as adding I/O, memory, and CPU overhead for the server.

2. Fetching more columns by using join command with multiple table

    We should select some specific columns in join commands.

    For example:

    ```sql
    -- get the customer's field
    SELECT CUSTOMER.* FROM CUSTOMER
    INNER JOIN ORDER using (id);
    ```

<br>

## 





<br>

## 





<br>

## 





<br>

## Wrapping up



<br>

Refer:

[MySQL Query Optimization and Performance tuning]()

[https://www.hungred.com/useful-information/ways-optimize-sql-queries/](https://www.hungred.com/useful-information/ways-optimize-sql-queries/)

[https://www.sqlshack.com/query-optimization-techniques-in-sql-server-tips-and-tricks/](https://www.sqlshack.com/query-optimization-techniques-in-sql-server-tips-and-tricks/)

[https://www.apriorit.com/dev-blog/381-sql-query-optimization](https://www.apriorit.com/dev-blog/381-sql-query-optimization)

[https://www.vertabelo.com/blog/technical-articles/5-tips-to-optimize-your-sql-queries](https://www.vertabelo.com/blog/technical-articles/5-tips-to-optimize-your-sql-queries)

[https://www.eversql.com/sql-performance-tuning-tips-for-mysql-query-optimization/](https://www.eversql.com/sql-performance-tuning-tips-for-mysql-query-optimization/)

[https://www.toptal.com/sql-server/sql-database-tuning-for-developers](https://www.toptal.com/sql-server/sql-database-tuning-for-developers)

[https://dzone.com/articles/7-simple-tips-to-boost-the-performance-of-your-sql](https://dzone.com/articles/7-simple-tips-to-boost-the-performance-of-your-sql)

[https://www.ibm.com/support/knowledgecenter/en/SSZLC2_7.0.0/com.ibm.commerce.developer.soa.doc/refs/rsdperformanceworkspaces.htm](https://www.ibm.com/support/knowledgecenter/en/SSZLC2_7.0.0/com.ibm.commerce.developer.soa.doc/refs/rsdperformanceworkspaces.htm)