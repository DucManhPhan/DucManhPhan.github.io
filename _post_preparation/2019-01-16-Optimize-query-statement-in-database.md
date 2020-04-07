---
layout: post
title: Optimize the query statement in database
bigimg: /img/image-header/home-office-2.jpg
tags: [database]
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


## Table of Contents





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

