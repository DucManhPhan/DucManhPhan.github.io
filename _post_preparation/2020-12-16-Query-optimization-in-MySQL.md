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
- [Introduction to performance tuning](#introduction-to-performance-tuning)
- [Introduction to MySQL's Query Manager](#introduction-to-mysql's-query-manager)
- [Some reasons that makes a query perform slow](#some-reasons-that-makes-a-query-perform-slow)
- [Solution with SELECT command](#solution-with-select-command)
- [Solution with MySQL's logical operators](#solution-with-mysql's-logical-operators)
- [Solution with conditional opertors](#solution-with-conditional-operators)
- [Solution with ORDER BY command](#solution-with-order-by-command)
- [Solution with functions](#solution-with-functions)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to performance tuning





<br>

## Introduction to MySQL's Query Manager







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

        So, when we have multiple requests to database, it will create multiple threads to work with queries. The problem about context switching will slow down the response time.

    - Connections not closed/returned to pool in case of exceptions

        When happened SQLException exception, if that connection will not be released, then the same connection can not be used for any other purpose till the connection is timed out.

<br>

## Solution with SELECT command

1. Fetching more rows by using select * command

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

## Solution with MySQL's logical operators

1. LIKE operator

    This operator will use wildcard operator to compare two values. With like operator, we have three types:
    - full wildcard

        ```sql
        SELECT * FROM CUSTOMER WHERE CUSTOMER_NAME LIKE '%John%';
        ```

    - postfix wildcard

        ```sql
        SELECT * FROM CUSTOMER WHERE CUSTOMER_NAME LIKE 'John%';
        ```

    - prefix wildcard

        ```sql
        SELECT * FROM CUSTOMER WHERE CUSTOMER_NAME LIKE '%John';
        ```

    With full wildcard and prefix wildcard or **substr()** method, its time complexity is O(n) - n is the max length of target, based on the KMP algorithm for pattern matching.

    With postfix wildcard, its time complexity is O(m) - m is the length of the pattern to search.

    So, we can easily find that using postfix wildcard is the optimization way to deal with this problem.

2. OR operator

    Assuming that we have an select query like the below code:

    ```sql
    SELECT * FROM CUSTOMER WHERE CUSTOMER_NAME LIKE 'Marry%' OR CITY LIKE 'New%';
    ```

    To understand the drawbacks of OR operator, we can refer about this article [Optimizing OR (union) operations in MySQL](https://www.techfounder.net/2008/10/15/optimizing-or-union-operations-in-mysql/).

    So, the optimizationay for this problem is to split the OR condition and combine it by using UNION clause because we can index for our field to improve performance of each query.

    ```sql
    SELECT * FROM CUSTOMER WHERE CUSTOMER_NAME LIKE 'Marry%'
    UNION
    SELECT * FROM CUSTOMER WHERE CITY LIKE 'New%';
    ```

    By default, UNION is usually went with DISTINCT keyword, it means that each result's row will be unique, so RDBMS will compare the current row with the previous rows, this way will reduce RDBMS's performance.

    Then, we can use UNION ALL to replace with UNION. But using UNION ALL will makes our result to have some duplicated rows.

3. NOT operator



<br>

## Solution with conditional opertors

1. Use simple columns or literals as operands in a conditional expression, means that avoid the use of conditional expressions with functions whenever possible.

    - Comparing the contents of a single column to a literal is faster than comparing to expression.

        Ex: price >= 10.00 is faster than price >= base_price * 2.30 because RDBMS must evaluate the **base_price * 2.30** expression first.

    - The use of function in expressions also adds to the total query execution time.

2. Numeric field comparisons are faster than character, date, and NULL comparisons.

    In search conditions, comparing a numeric attribute to a numeric literal is faster than comparing a character attribute to a character literal. In general, the CPU handles numeric comparisons (integer and decimal) faster than character and date comparisons. Because indexes do not store references to null values, NULL conditions involve additional processing, and therefore, tend to be the slowest of all conditional operands.

3. Equality comparisons are faster than inequality comparisons.

    For example, price = 10.00 is processed faster because the RDBMS can do a direct search using the index in the column. If there are no exact matches, the condition is evaluated as false. However, if we use an inequality symbol (>, >=, <=, <), the RDBMS must perform additional processing to complete the request. The reason is that there will almost always be more **greater than** or **less than** values than exactly **equal** values in the index.

4. Whenever possible, transform conditional expressions to use literals.

    For example, price - 10 = 7, change it to read price = 17.

    If we have a composite condition such as: ```a < b AND b = c AND a = 10``` change it to read: ```a = 10 AND b = c AND b > 10```.

5. When using multiple conditional expressions, write the equality conditions first.

6. If we use multiple AND conditions, write the condition most likely to be false first.
    
    If we use this technique, the RDBMS will stop evaluating the rest of the conditions as soon as it finds a conditional expression that is evaluated as false.

7. When using multiple OR conditions, put the condition most likely to be true first.

    By doing this, the RDBMS will stop evaluating the remaining conditions as soon as it finds a conditional expression that is evaluated as true.

8. Whenever possible, try to avoid the use of the NOT logical operator.

    It is best to transform SQL expression containing a NOT logical operator into an equivalent expression.

    For example, ```NOT(price > 10)``` can be written as ```price <= 10```.

<br>

## Solution with ORDER BY command





<br>

## Solution with functions





<br>

## Wrapping up

- Database performance tuning refers to a set of activities and procedures designed to reduce the response time of the database system, that is, to ensure that an end-user query is processed by the RDBMS by the DBMS in the minimum amount of time.

    The time required by a query to return a result set depends on many factors. Those factors tend to be wide-ranging and to vary from environment to environment and from vendor to vendor. The performance of a typical DBMS is constrained by three main factors:
    - CPU processing power
    - available primary memory RAM
    - input/output (hard disk and network) throughput.

- The majority of performance-tuning activities focus on minimizing the number of I/O operations because using I/O operations in many times slower than reading data from the data cache.

    For example, as of this writing, RAM access times range from 5 to 70 ns, while hard disk access times range from 5 to 15 ms. This means that hard disks are about six orders of magnitude (a million times) slower than RAM.

    |              Operation            |                       Description                      |
    | --------------------------------- | ------------------------------------------------------ |
    | Table scan (full)                 | Reads the entire table sequentially, from the first row to the last row, one row at a time (slowest) |
    | Table access (Row ID)             | Reads a table row directly, using the row ID value (fastest) |
    | Index scan (range)                | Reads the index first to obtain the row IDs and then accesses the table rows directly (faster than a full table scan) |
    | Index acess (unique)              | Used when a table has a unique index in a column |
    | Nested Loop                       | Reads and compares a set of values to another set of values, using a nested loop style (slow) |
    | Merge                             | Merges two data sets (slow) |
    | Sort                              | Sorts a data set (slow)     |


<br>

Refer:

[MySQL Query Optimization and Performance tuning]()

[Database System: Design, Implementation, and Management ebook]()

[https://medium.com/better-programming/using-select-in-an-sql-query-is-a-bad-practice-a8f6beeca1da](https://medium.com/better-programming/using-select-in-an-sql-query-is-a-bad-practice-a8f6beeca1da)

[https://www.sqlshack.com/query-optimization-techniques-in-sql-server-tips-and-tricks/](https://www.sqlshack.com/query-optimization-techniques-in-sql-server-tips-and-tricks/)

[https://www.apriorit.com/dev-blog/381-sql-query-optimization](https://www.apriorit.com/dev-blog/381-sql-query-optimization)

[https://www.vertabelo.com/blog/technical-articles/5-tips-to-optimize-your-sql-queries](https://www.vertabelo.com/blog/technical-articles/5-tips-to-optimize-your-sql-queries)

[https://www.eversql.com/sql-performance-tuning-tips-for-mysql-query-optimization/](https://www.eversql.com/sql-performance-tuning-tips-for-mysql-query-optimization/)

[https://www.toptal.com/sql-server/sql-database-tuning-for-developers](https://www.toptal.com/sql-server/sql-database-tuning-for-developers)

[https://dzone.com/articles/7-simple-tips-to-boost-the-performance-of-your-sql](https://dzone.com/articles/7-simple-tips-to-boost-the-performance-of-your-sql)

[https://www.ibm.com/support/knowledgecenter/en/SSZLC2_7.0.0/com.ibm.commerce.developer.soa.doc/refs/rsdperformanceworkspaces.htm](https://www.ibm.com/support/knowledgecenter/en/SSZLC2_7.0.0/com.ibm.commerce.developer.soa.doc/refs/rsdperformanceworkspaces.htm)