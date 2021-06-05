---
layout: post
title: Some interview questions about SQL Query
bigimg: /img/path.jpg
tags: [Database, Interview question]
---



<br>

## Table of contents
- [The difference between WHERE clause and HAVING clause](#the-difference-between-where-clause-and-having-clause)
- []()
- []()
- []()
- []()
- [Wrapping up](#wrapping-up)


<br>

## The difference between WHERE clause and HAVING clause

|            WHERE clause                |               HAVING clause             |
| -------------------------------------- | --------------------------------------- |
| WHERE clause is used to filter the records from the table based on the specified condition | HAVING clause is used to filter the records from the groups based on the specified condition |
| WHERE clause can be used without GROUP BY clause | HAVING clause can't be used without GROUP BY clause |
| 


1. WHERE clause

    This clause is used to filter rows. It works on the row's data, not on aggregated data.

    For example:

    ```sql
    SELECT * FROM EMPLOYEE WHERE score >= 50;
    ```

    It can be used with SELECT, UPDATE, DELETE statements.

    WHERE clause will be used before GROUP BY clause.

    WHERE clause will be used with the single row function like UPPER, LOWER, ...

    WHERE clause can't contain the aggregate function.

2. HAVING clause

    This clause will only work on aggregated data, not on normal rules.

    THe aggregated data is created by the aggregation function. In order to be aware of how to use aggregation function, then we have:
    - to perform calculations on multiple rows of a single columns.
    - it returns a single value.
    - it is used to summarize data.

    Belows are some aggregation functions:
    - count()
    - max()
    - min()
    - avg()
    - sum()

    For example:

    Belows are the data of employees about salary.

    |      employeeId       |       Salary       |
    | --------------------- | ------------------ |
    | 101                   | 1000               |
    | 102                   | 2000               |
    | 105                   | 5000               |
    | 106                   | 6000               |
    | 108                   | 3000               |

    To get an employee that has max salary, we have:

    ```sql
    SELECT MAX(salary) FROM EMPLOYEE HAVING employeeId > 105;
    ```

    HAVING clause only used with SELECT statements.

    HAVING clause is used after GROUP BY clause.

    HAVING clause is used with the multiple row functions like SUM, COUNT, ...

    HAVING clause can contain the aggregate functions.

<br>

## The difference between TRUNCATE and DELETE

|            TRUNCATE clause             |               DELETE clause             |
| -------------------------------------- | --------------------------------------- |
| 



<br>

## 






<br>

## Wrapping up







<br>

Refer:

[SQL "difference between" interview questions (part 1)](https://www.youtube.com/watch?v=RZc4QSRRk98&t=10s)

[]()

[]()