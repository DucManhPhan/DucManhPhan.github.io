---
layout: post
title: Learn about Join operators in SQL
bigimg: /img/image-header/california.jpg
tags: [Database]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Introduction to Join operators](#introduction-to-join-operators)
- [Merge Join](#merge-join)
- [Hash Join](#hash-join)
- [Nested Loop Join](#nested-loop-join)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Assuming that we have a join query such as:

```sql
SELECT customer.* FROM customer
INNER JOIN order
ON order.customer_id = customer.id;
```

Basically, we only understand that RDBMS will merge all fields of customer and order table, then select some specific fields of customer table.

But how does join operation work? Because of be aware of it, we can optmize our join query to improve performance of system.


<br>

## Introduction to Join operators





<br>


## Merge Join





<br>


## Hash Join





<br>

## Nested Loop Join





<br>

## Wrapping up





<br>

Refer:

[http://coding-geek.com/how-databases-work/](http://coding-geek.com/how-databases-work/)

[https://mysqlserverteam.com/hash-join-in-mysql-8/](https://mysqlserverteam.com/hash-join-in-mysql-8/)

[https://www.vertica.com/docs/9.2.x/HTML/Content/Authoring/AnalyzingData/Optimizations/HashJoinsVs.MergeJoins.htm](https://www.vertica.com/docs/9.2.x/HTML/Content/Authoring/AnalyzingData/Optimizations/HashJoinsVs.MergeJoins.htm)

[https://use-the-index-luke.com/sql/join/hash-join-partial-objects](https://use-the-index-luke.com/sql/join/hash-join-partial-objects)

[https://dzone.com/articles/understanding-hash-joins-in-mysql-8](https://dzone.com/articles/understanding-hash-joins-in-mysql-8 )