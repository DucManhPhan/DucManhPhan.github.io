---
layout: post
title: Some interview questions about SQL Query
bigimg: /img/path.jpg
tags: [Database, Interview question]
---



<br>

## Table of contents





<br>

## The difference between WHERE clause and HAVING clause

1. WHERE clause

    This clause is used to filter rows. It works on the row's data, not on aggregated data.

    For example:

    ```sql
    SELECT * FROM EMPLOYEE WHERE score >= 50;
    ```

2. HAVING clause

    This clause will only work on aggregate data.

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

    |      employeeId       |       Salary       |
    | --------------------- | ------------------ |
    



<br>

## 





<br>

## 






<br>

## Wrapping up







<br>

Refer: