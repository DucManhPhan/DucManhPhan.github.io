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
- []()
- []()
- []()
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



<br>

## 






<br>

## Wrapping up







<br>

Refer:

[SQL "difference between" interview questions (part 1)](https://www.youtube.com/watch?v=RZc4QSRRk98&t=10s)

[]()

[]()