---
layout: post
title: Some useful SQL queries in PostgreSQL
bigimg: /img/image-header/yourself.jpeg
tags: [PostgreSQL]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [SQL Queries for a database](#sql-queries-for-a-database)
- [SQL Queries for table](#sql-queries-for-table)
- [SQL Queries for indexes](#sql-queries-for-indexes)
- [SQL Queries for slow query](#sql-queries-for-slow-query)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Sometimes, in our project, we need to verify a database, a table, or even indexes to investigate a specific issue. But we didn't know any useful queries to improve the speed of investigation.

So today, I will share some interesting queries that I use them a lot in daily basis. These queries will be updated frequently. Let's get started.


<br>

## SQL Queries for a database

1. Calculate the size of a database (by bytes).

    ```SQL
    SELECT pg_database_size(current_database())/1000000000 as database_size_per_gb;
    ```

2. Calculate the size of all databases.

    ```SQL
    SELECT SUM(pg_database_size(datname)/1000000000) as all_databases_size_per_gb
    FROM pg_database;
    ```

3. Get version of PostgreSQL.

    ```SQL
    -- 1st way
    SELECT version();

    -- 2nd way
    SHOW server_version;
    ```


<br>

## SQL Queries for table

1. List all tables in a database.

    ```SQL
    SELECT * FROM pg_database;
    ```

2. List column name and its data type in a table.

    ```SQL
    SELECT column_name, data_type FROM information_schema.COLUMNS
    WHERE table_name = 'table-name';
    ```

3. Calculate the size (per bytes) of a table.

    ```SQL
    SELECT pg_relation_size('table-name');

    -- make the size more pretty
    SELECT pg_size_pretty(pg_relation_size('table-name'));
    ```

4. List the biggest tables.

    ```SQL
    SELECT table_name, pg_relation_size(table_schema || '.' || table_name)/1000000 as size_per_mb
    FROM information_schema.tables
    WHERE table_name NOT IN ('information_schema', 'pg_catalog')
    ORDER BY size_per_mb DESC
    LIMIT 10;
    ```


<br>

## SQL Queries for indexes

1. List indexes of each table in a table.

    ```SQL
    SELECT tablename, indexname, indexref
    FROM pg_indexes
    WHERE schemaname = 'public'
    ORDER BY
        tablename,
        indexname;
    ```

2. Verify unused indexes.

    ```SQL
    SELECT schemaname, relname, indexrelname, idx_scan
    FROM pg_stat_user_indexes
    ORDER BY idx_scan;
    ```

3. Check the size of an index.

    ```SQL
    SELECT pg_size_pretty(pg_relation_size('index-name'));
    ```


<br>

## SQL Queries for slow query

1. Verify the current state of slow query logging.

    ```SQL
    SELECT * FROM pg_settings
    WHERE name = 'log_min_duration_statement';
    ```

2. Get queries that has execute time is greater than specific duration.

    ```SQL
    SELECT query, calls(total_time/calls)::integer as avg_time_ms
    FROM pg_stat_statements
    WHERE calls > 1000
    ORDER BY avg_time_ms DESC
    LIMIT 10;
    ```

    Notes: need to check whether we have installed `pg_stat_statements` extension yet.


<br>

## Wrapping up




