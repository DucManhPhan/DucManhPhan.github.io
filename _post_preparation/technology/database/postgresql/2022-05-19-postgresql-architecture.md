---
layout: post
title: PostgreSQL architecture
bigimg: /img/image-header/yourself.jpeg
tags: [PostgreSQL]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [The PostgreSQL Architecture](#the-postgresql-architecture)
- [Some features of PostgreSQL](#some-feature-of-postgresql)
- [The comparison between PostgreSQL and MySQL](#the-comparison-between-postgresql-and-mysql)
- [Some interesting things about PostgreSQL](#some-interesting-things-about-postgresql)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## The PostgreSQL Architecture

One of PostgreSQL's strengths derives from its architecture. In common with commercial database systems, PostgreSQL can be used in a client/server environment. This separation into client and server allows applications to be distributed. We can use a network to separate our clients from our server and develop client applications in an environment that suits the users.

![](../img/Database/PostgreSQL/architecture/architecture-1.png)



<br>

## Some features of PostgreSQL

Belows are the PostgreSQL features:
- Transactions
- Subselects
- Views
- Foreign key referential integrity
- Sophisticated locking
- User-defined types
- Inheritance
- Rules
- Multiple-version concurrency control

Since release 6.5, PostgreSQL has been very stable, with a large series of regression tests performed on each release to ensure its stability.

The release of the 7.x series brought conformance to SQL92 closer than ever, and an irksome row-size restriction was removed.

The release of PostgreSQL version 8 added several new features:
- Native Microsoft Windows version
- Table spaces
- Ability to alter column types
- Point-in-time recovery

PostgreSQL has proven to be very reliable in use. Each release is very carefully controlled, and beta releases are subject to at least a month’s testing. With a large user community and universal access to the source code, bugs can get fixed very quickly.

<br>

## The comparison between PostgreSQL and MySQL

To know more about these two database, we can refer to the following article [The comparison between MySQL and PostgreSQL](https://ducmanhphan.github.io/2019-05-12-The-comparison-between-MySQL-and-PostgreSQL/).


<br>

## Some interesting things about PostgreSQL

- PostgreSQL has won several awards, including the Linux Journal Edition's Choice Award for Best Database three times (for the years 2000, 2003, and 2004) and the 2004 Linux New Media Award for Best Database System.

- History of PostgreSQL

    PostgreSQL can trace its family tree back to 1977 at the University of California at Berkeley (UCB). A relational database called Ingres was developed at UCB between 1977 and 1985. Ingres was a popular UCB export, making an appearance on many UNIX computers in the academic and research communities. To serve the commercial marketplace, the code for Ingres was taken by Relational Technologies/Ingres Corporation and became one of the first commercially available RDBMSs.

    Today, Ingres has become CA-INGRES II, a product from Computer Associates. Interestingly, it has been recently released under an Open Source license.

    Meanwhile, back at UCB, work on a relational database server called Postgres continued from 1986 to 1994. Again, this code was taken up by a commercial company and offered for sale as a product. This time it was Illustra, since swallowed up by Informix. Around 1994, SQL features were added to Postgres, and its name was changed to Postgres95.

    By 1996, Postgres was becoming very popular, and the developers decided to open up its development to a mailing list, starting what has become a very successful collaboration of volunteers driving Postgres forward. At this time, Postgres underwent its final name change, ditching the dated “95” tag for a more appropriate “SQL,” to reflect the support Postgres now has for the query language standard. PostgreSQL was born.

    Today, a team of Internet developers develops PostgreSQL in much the same manner as other open-source software such as Perl, Apache, and PHP. Users have access to the source code and contribute fixes, enhancements, and suggestions for new features. The official PostgreSQL releases are made via http://www.postgresql.org.

- PostgreSQL does not yet have the high-availability features of a few enterprise-class commercial database systems that can spread the load across several servers, giving additional scalability and resilience. There are some PostgreSQL-sanctioned projects underway at http://gborg.postgresql.org that aim to add these features, and there are some commercial solutions available.


<br>

## Wrapping up




<br>

Refer:

[Beginning Database with PostgreSQL - From novice to Professional, second edition]()

[]()

[]()

[]()