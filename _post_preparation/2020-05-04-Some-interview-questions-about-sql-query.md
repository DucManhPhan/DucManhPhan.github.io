---
layout: post
title: Some interview questions about SQL Query
bigimg: /img/path.jpg
tags: [Database, Interview question]
---



<br>

## Table of contents
- [The difference between WHERE clause and HAVING clause](#the-difference-between-where-clause-and-having-clause)
- [The difference between TRUNCATE and DELETE](#the-difference-between-truncate-and-delete)
- [The difference between UNION and UNION ALL](#the-difference-between-union-and-union-all)
- [The difference between JOIN and UNION](#the-difference-between-join-and-union)
- [The difference between DROP and TRUNCATE](#the-difference-between-drop-and-truncate)
- [Wrapping up](#wrapping-up)


<br>

## The difference between WHERE clause and HAVING clause

Before going straight forward the difference between WHERE and HAVING clause, below is a format of an SQL statement:

```sql
SELECT
FROM
WHERE
GROUP BY
HAVING
```

The order of execution of SQL statements will happen from top to bottom. That means the WHERE clause is first applied to the result and then, the remaining rows summarized according to the GROUP BY.

|            WHERE clause                |               HAVING clause             |
| -------------------------------------- | --------------------------------------- |
| WHERE clause is used to filter the records from the table based on the specified condition | HAVING clause is used to filter the records from the groups, that are constructed by GROUP BY clause, based on the specified condition |
| WHERE clause can be used without GROUP BY clause | HAVING clause can't be used without GROUP BY clause |
| WHERE clause implements in row operations | HAVING clause implements in column operations |
| WHERE clause can't contain aggregate function | HAVING clause can contain aggregate function |
| WHERE clause can be used with SELECT, UPDATE, DELETE statement | HAVING clause can only be used with SELECT statement |
| WHERE clause is used before GROUP BY clause | HAVING clause is used after GROUP BY clause |
| WHERE clause is used with single row function like UPPER, LOWER, ... | HAVING clause is used with multiple row function like SUM, COUNT, ... |

For example:

Belows are the data of employees about salary.

|      employeeId       |       Salary       |
| --------------------- | ------------------ |
| 101                   | 1000               |
| 102                   | 2000               |
| 105                   | 5000               |
| 106                   | 6000               |
| 108                   | 3000               |

Some examples that use the above clauses:
- WHERE clause

    ```sql
    SELECT * FROM EMPLOYEE WHERE salary >= 1000;
    ```

- HAVING clause

    To get an employee that has max salary, we have:

    ```sql
    SELECT MAX(salary) FROM EMPLOYEE HAVING employeeId > 105;
    ```

    The aggregated data is created by the aggregation function. In order to be aware of how to use aggregation function, then we have:
    - to perform calculations on multiple rows of a single columns.
    - it returns a single value.
    - it is used to summarize data.

    Belows are some aggregation functions:
    - count()
    - max()
    - min()
    - avg()
    - sum()

<br>

## The difference between TRUNCATE and DELETE

|            DELETE clause               |               TRUNCATE clause             |
| -------------------------------------- | --------------------------------------- |
| DELETE command is used to delete specified rows | TRUNCATE command is used to delete all the rows from a table |
| It is a DML - Data Manipulation Language command, hence, requires explicit commit to make its effect permanent | It is a DDL - Data Definition Language command, so it doesn't require a commit to make the changes permanent. And this is a reason why rows deleted by TRUNCATE couldn't rollbacked |
| There may be WHERE clause in DELETE command in order to filter the records | There may not be WHERE clause in TRUNCATE command |
| In the DELETE command, a tuple is locked before removing it | In TRUNCATE command, data page is locked before removing the table data |
| DELETE statement removes rows one at a time and records an entry in the transaction log for each delete row | TRUNCATE statement removes the data by deallocating the data pages used to store the table data and records only the page deallocations in the transaction log |
| DELETE command is slower than TRUNCATE command because DELETE command must read the records, check constraints, update the block, update indexes, and generate redo/unlo log | TRUNCATE command is faster than DELETE command because it simply adjusts a pointer in the database for the table (the High Water Mark) and proof the data is gone |
| To use DELETE command, we need delete the permission on the table | To use TRUNCATE on a table, we need at least ALTER permission on the table |
| Identity of the column retains the identity after using DELETE statement on table | Identity of the column is reset to its seed value if the table contains an identity column |
| DELETE command can be used with indexed views | TRUNCATE command can't be used with indexed views |
| DELETE activities a trigger because the operation are logged individually | TRUNCATE can't activate a trigger because the operation doesn't log individual row deletions |
| DELETE table is a logged operation. So the deletion of each row gets logged in the transaction log, which makes it slow | TRUNCATE table also deletes all the rows in a table, but it won't log the deletion of each row instead it logs the deallocation of the data pages of the table, which makes it faster |
| DELETE command can be rolled back | TRUNCATE also can be rolled back provided that it is enclosed in a transaction block and session is not closed. Once session is closed, we won't be able to roll back truncate |

For example:

```sql
// TRUNCATE command
TRUNCATE TABLE employee;

// DELETE command
DELETE FROM employee WHERE salary <= 500;
```

<br>

## The difference between UNION and UNION ALL

Supposed that we have the Customer and Supplier tables that looks like:

|   customerId   |    address     |      contact      |
| -------------- | -------------- | ----------------- |
| 101            | London         | 123               |
| 103            | New York       | 345               |
| 105            | California     | 672               |

|   supplierId   |    address     |      contact      |
| -------------- | -------------- | ----------------- |
| 100            | Singapore      | 648               |
| 101            | Kuala Lampua   | 645               |
| 107            | Singapore      | 649               |

For example:

```sql
SELECT * FROM customer
UNION
SELECT * FROM supplier;

SELECT * FROM customer
UNION ALL 
SELECT * FROM supplier;
```

|            UNION statement          |               UNION ALL statement                |
| ----------------------------------- | ------------------------------------------------ |
| It removes duplicate values in the data | It doesn't remove duplicate values from the data, instead, it just selects all the rows from all the tables which meets the conditions of our specific queries and combine them into the result table |
| UNION will be slower than UNION ALL | UNION ALL will be faster than UNION              |
| It is sorted                        | It is unsorted                                   |
| UNION doesn't work with a column that has Text data type | UNION ALL works with all data type columns |

Note:
- UNION operator combines result set of two or more select statements

    each select statement must have:
    - same number of columns
    - columns must have similar data types
    - columns must be in same order

<br>

## The difference between JOIN and UNION

|               JOIN statement                |                       UNION statement                      |
| ------------------------------------------- | ---------------------------------------------------------- |
| JOIN combines data from many tables based on a matched condition between them | SQL combines the result-set of two or more SELECT statements |
| It combines data into new columns           | It combines data into new rows                             |
| Number of columns selected from each table may not be same | Number of columns selected from each table should be same |
| Data types of corresponding columns selected from each table can be different | Data types of corresponding columns selected from each table should be same |
| It may not return distinct columns          | It returns distinct rows                                   |


<br>

## The difference between DROP and TRUNCATE

|         DROP statement           |                  TRUNCATE statement                    |
| -------------------------------- | ------------------------------------------------------ |
| DROP command is used to remove table definition and its content | TRUNCATE command is used to delete all the rows from the table |
| In the DROP command, table space is freed from memory | TRUNCATE command doesn't free the table space from memory |
| DROP is DDL - Data Definition Language command | TRUNCATE is also DDL - Data Definition Language command |
| In the DROP command, view of table doesn't exist | In the TRUNCATE command, view of table exist |
| In the DROP command, integrity constraints will be removed | In the TRUNCATE command, integrity constraints won't be removed |
| In the DROP command, undo space isn't used | In the TRUNCATE command, undo space is used but less than DELETE |
| The DROP command is quick to perform but gives rise to complications | The TRUNCATE command is faster than DROP command |

<br>

## The difference between INNER JOIN and OUTER JOIN

|              INNER JOIN            |                    OUTER JOIN                 |
| ---------------------------------- | --------------------------------------------- |
| It returns the combined tuple between two or more tables | It returns the combined tuple from a specified table even join condition will fail |
| Used clause INNER JOIN and JOIN    | Used clause LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN, ... |
| When any attributes are not common, then it will return nothing | It doesn't depend upon the command attributes. If the attribute is blank, then here already placed NULL |
| If tuples are more. Then INNER JOIN works faster than OUTER JOIN | Generally, the OUTER JOIN is slower than INNER JOIN. But except for some special cases |
| It is used when we want detailed information about any specific attribute | It is used when we want to complete information |
| JOIN and INNER JOIN both clause work the same | FULL OUTER JOIN and FULL JOIN both clauses work the same |

Syntax of INNER JOIN and OUTER JOIN:

```sql
// INNER JOIN statement
SELECT * FROM table1 JOIN table2
ON table1.column_name = table2.column_name;

// OUTER JOIN statement
SELECT * FROM table1 LEFT OUTER JOIN/RIGHT OUTER JOIN/FULL OUTER JOIN table2
ON table1.column_name = table2.column_name;
```

Note:
- A LEFT JOIN is absolutely not faster than INNER JOIN. In fact, it's slower; by definition, an OUTER JOIN (LEFT JOIN, RIGHT JOIN) has to do all the work of an INNER JOIN plus the extra work of null-extending the results. It would also be expected to return more rows, further increasing the total execution time simply due to the larger size of the result set.

    Reflecting further on this, I could think of one circumstance under which a LEFT JOIN might be faster than an INNER JOIN, and that is when:
    - Some of the tables are very small (say, under 10 rows);
    - The tables do not have sufficient indexes to cover the query.

    Consider this example:

    ```sql
    CREATE TABLE #Test1
    (
        ID int NOT NULL PRIMARY KEY,
        Name varchar(50) NOT NULL
    )
    INSERT #Test1 (ID, Name) VALUES (1, 'One')
    INSERT #Test1 (ID, Name) VALUES (2, 'Two')
    INSERT #Test1 (ID, Name) VALUES (3, 'Three')
    INSERT #Test1 (ID, Name) VALUES (4, 'Four')
    INSERT #Test1 (ID, Name) VALUES (5, 'Five')

    CREATE TABLE #Test2
    (
        ID int NOT NULL PRIMARY KEY,
        Name varchar(50) NOT NULL
    )
    INSERT #Test2 (ID, Name) VALUES (1, 'One')
    INSERT #Test2 (ID, Name) VALUES (2, 'Two')
    INSERT #Test2 (ID, Name) VALUES (3, 'Three')
    INSERT #Test2 (ID, Name) VALUES (4, 'Four')
    INSERT #Test2 (ID, Name) VALUES (5, 'Five')

    SELECT *
    FROM #Test1 t1
    INNER JOIN #Test2 t2
    ON t2.Name = t1.Name

    SELECT *
    FROM #Test1 t1
    LEFT JOIN #Test2 t2
    ON t2.Name = t1.Name

    DROP TABLE #Test1
    DROP TABLE #Test2
    ```

    If you run this and view the execution plan, you'll see that the INNER JOIN query does indeed cost more than the LEFT JOIN, because it satisfies the two criteria above. It's because SQL Server wants to do a hash match for the INNER JOIN, but does nested loops for the LEFT JOIN; the former is normally much faster, but since the number of rows is so tiny and there's no index to use, the hashing operation turns out to be the most expensive part of the query.

    You can see the same effect by writing a program in your favourite programming language to perform a large number of lookups on a list with 5 elements, vs. a hash table with 5 elements. Because of the size, the hash table version is actually slower. But increase it to 50 elements, or 5000 elements, and the list version slows to a crawl, because it's O(N) vs. O(1) for the hashtable.

    But change this query to be on the ID column instead of Name and you'll see a very different story. In that case, it does nested loops for both queries, but the INNER JOIN version is able to replace one of the clustered index scans with a seek - meaning that this will literally be an order of magnitude faster with a large number of rows.

    So the conclusion is more or less what I mentioned several paragraphs above; this is almost certainly an indexing or index coverage problem, possibly combined with one or more very small tables. Those are the only circumstances under which SQL Server might sometimes choose a worse execution plan for an INNER JOIN than a LEFT JOIN.

<br>

## Wrapping up







<br>

Refer:

[SQL "difference between" interview questions (part 1)](https://www.youtube.com/watch?v=RZc4QSRRk98&t=10s)

<br>

**TRUNCATE and DELETE**

[https://stackoverflow.com/questions/139630/whats-the-difference-between-truncate-and-delete-in-sql](https://stackoverflow.com/questions/139630/whats-the-difference-between-truncate-and-delete-in-sql)

[https://www.geeksforgeeks.org/difference-between-delete-and-truncate/](https://www.geeksforgeeks.org/difference-between-delete-and-truncate/)

<br>

**UNION and UNION ALL**

[https://intellipaat.com/community/1505/what-is-the-difference-between-union-and-union-all](https://intellipaat.com/community/1505/what-is-the-difference-between-union-and-union-all)

[https://www.c-sharpcorner.com/UploadFile/ff2f08/difference-between-union-and-union-all-in-sql-server/](https://www.c-sharpcorner.com/UploadFile/ff2f08/difference-between-union-and-union-all-in-sql-server/)

[]()

[]()

<br>

**JOIN and UNION**

[https://www.geeksforgeeks.org/difference-between-join-and-union-in-sql/](https://www.geeksforgeeks.org/difference-between-join-and-union-in-sql/)

[]()

[]()

[]()

<br>

**DROP and TRUNCATE**

[https://www.geeksforgeeks.org/difference-between-drop-and-truncate-in-sql/](https://www.geeksforgeeks.org/difference-between-drop-and-truncate-in-sql/)

[]()

[]()

[]()

<br>

**JOIN**

[https://stackoverflow.com/questions/2726657/inner-join-vs-left-join-performance-in-sql-server](https://stackoverflow.com/questions/2726657/inner-join-vs-left-join-performance-in-sql-server)

[https://dba.stackexchange.com/questions/229165/why-is-this-left-join-faster-than-an-inner-join](https://dba.stackexchange.com/questions/229165/why-is-this-left-join-faster-than-an-inner-join)

[]()

[]()

[]()