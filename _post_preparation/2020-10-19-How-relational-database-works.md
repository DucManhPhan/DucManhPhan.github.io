---
layout: post
title: How relational database works
bigimg: /img/image-header/home-office-1.jpg
tags: [Database]
---

When we are working with websites, or some applications that need to save data, it means that we need to use Relational Database Management or usually called as RDBMS. Normally, we only need to understand how to use Structure Query Language SQL or to communicate with Database management system.

But in order to write sql efficiently, we have to understand how relational database works, and some steps that we must know.

Let's get started.

<br>

## Table of contents
- [The problem that was born Relational Database](#the-problem-that-was-born-relational-database)
- [Introduction to RDBMS](#introduction-to-rdbms)
- [How relational database works](#how-relational-database-works)
- [How query SQL works](#how-query-sql-works)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## The problem that was born Relational Database
Originally, databases were flat. It means that the information was stored in one long text file, called a tab delimited file. Each entry in the tab delimited file is separated by a special character, such as a vertical bar (```|```).

Assuming that we want to save all information about customers such as name, customer number, address, ZIP Code , all things that they purchased.

For example:

```
Name, Customer Number, Address, Goods's name|Smith, 1, London, T-Shirt|Doe, 2, Arkansas, Shampoo|Brown, 3, New York, Radio
```

Each entry contains multiple pieces of information (fields) about a particular object or person grouped together as a record. The text file makes it difficult to search for specific information or to create reports that include only certain fields from each record.

And we have to search sequentially through the entire file to gather related information, such as age or salary. But when those who customer bought three times, all information would be duplicated. Data elements such as name, customer number, address and ZIP Code would be identical in all three records. Thus, the flat file would store the same information three times. From a storage standpoint, this is inefficient.

Therefore, relational database created to solve problems about inefficient storage, inefficient and slow processing.

<br>

## Introduction to RDBMS
According to wikipedia, we have the definition of Relational database:

```
A relational database is a digital database based on the relational model of data, as proposed by E.F.Codd in 1970. A software system used to maintain relational databases is a relational database management system (RDBMS). Virtually all relational database systems uses SQL for querying and maintaining the database.
```



<br>

## How relational database works

1. Background of RDBMS works

    


2. Detail of RDBMS works




<br>

## How query SQL works




<br>

## Benefits and Drawbacks
1. Benefits

    - easy to use and understand, because information is stored in tables, organized in rows and columns, much as same as a spreadsheet.

    - join table query.

    - avoid data duplication.

    - avoid inconsistent records.

    - better security. Tables can be made accessible only to those who need specific information.

    - cater for future requirements.

    - ACID properties

    - familiarity

2. Drawbacks

    - encounter difficulity when you want to insert some filed to tables.

    - Limit the length of data fields, it means when you input more information into a field than it can accommodate, the information can be lost.

    - Performance problems associated with reassembling simple data structures into their more complicated real world representations.

    - SQL is limited when accessing complex data.

    - Knowledge of the database structure is required to create ad hoc queries.

    - Lack of support for complex base types such as drawing, ...

    - Locking mechanism defined by RDBMSs do not allow design transactions to be supported.

<br>

## Wrapping up



<br>

Refer: 

[http://coding-geek.com/how-databases-work/](http://coding-geek.com/how-databases-work/)

[https://en.wikipedia.org/wiki/B%2B_tree](https://en.wikipedia.org/wiki/B%2B_tree)

[https://blog.jcole.us/2013/01/07/the-physical-structure-of-innodb-index-pages/](https://blog.jcole.us/2013/01/07/the-physical-structure-of-innodb-index-pages/)

[https://blog.jcole.us/2013/01/10/btree-index-structures-in-innodb/](https://blog.jcole.us/2013/01/10/btree-index-structures-in-innodb/)

[https://vladmihalcea.com/how-does-a-relational-database-work/](https://vladmihalcea.com/how-does-a-relational-database-work/)

[https://www.quora.com/How-does-a-relational-DBMS-internally-store-its-data-In-what-type-of-data-structure-How-does-it-offer-the-rapid-retrieval-without-loading-the-entire-database-into-the-main-memory-I-have-heard-many-DBMS-use-B-trees](https://www.quora.com/How-does-a-relational-DBMS-internally-store-its-data-In-what-type-of-data-structure-How-does-it-offer-the-rapid-retrieval-without-loading-the-entire-database-into-the-main-memory-I-have-heard-many-DBMS-use-B-trees)

[http://www.agiledata.org/essays/relationalDatabases.html](http://www.agiledata.org/essays/relationalDatabases.html)

[https://en.wikipedia.org/wiki/Database_storage_structures](https://en.wikipedia.org/wiki/Database_storage_structures)

[https://dev.to/lmolivera/everything-you-need-to-know-about-relational-databases-3ejl](https://dev.to/lmolivera/everything-you-need-to-know-about-relational-databases-3ejl)

[https://www.dmnews.com/data/news/13095668/how-relational-databases-work](https://www.dmnews.com/data/news/13095668/how-relational-databases-work)

[https://vladmihalcea.com/relational-database-sql-prepared-statements/](https://vladmihalcea.com/relational-database-sql-prepared-statements/)

[https://www.youtube.com/watch?v=wDXjOAwO5Es](https://www.youtube.com/watch?v=wDXjOAwO5Es)

<br>

**Pros and Cons of RDBMS**

[https://it.toolbox.com/blogs/craigborysowich/some-pros-cons-of-relational-databases-050108](https://it.toolbox.com/blogs/craigborysowich/some-pros-cons-of-relational-databases-050108)

[https://www.techwalla.com/articles/disadvantages-of-a-relational-database](https://www.techwalla.com/articles/disadvantages-of-a-relational-database)

[https://smallbusiness.chron.com/limitations-relational-databases-business-applications-24159.html](https://smallbusiness.chron.com/limitations-relational-databases-business-applications-24159.html)

[https://mangolassi.it/topic/4545/when-to-use-sql-or-nosql/3](https://mangolassi.it/topic/4545/when-to-use-sql-or-nosql/3)