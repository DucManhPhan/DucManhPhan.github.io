---
layout: post
title: Some commands of PSQL tool in PostgreSQL
bigimg: /img/image-header/yourself.jpeg
tags: [PostgreSQL]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- []()
- []()
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Some commands in PSQL Tool

0. Authenticate to PostgreSQL

    ```bash
    psql -a -U [username] -p [port] -h [server]
    ```

1. Connect to the specific database

    ```bash
    \c [database]
    ```

2. Clear the screen

    - In Windows OS

        ```bash
        \! cls
        ```

    - In Linux OS

        ```bash
        \! clear
        ```

3. List all tables in the current database

    - Use command line of PSQL

        ```bash
        \dt

        # OR
        \d
        ```

    - Use SQL query

        ```sql
        SELECT table_name FROM information_schema;
        ```

4. 



9. Exit PSQL

    ```bash
    \q
    ```


<br>

## 





<br>

## Wrapping up




<br>

Refer:

[]()
