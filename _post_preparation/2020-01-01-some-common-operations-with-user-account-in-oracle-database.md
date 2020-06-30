---
layout: post
title: Some common operations with user account in Oracle database
bigimg: /img/image-header/yourself.jpeg
tags: [Oracle]
---



<br>

## Table of contents
- [Connection to SQL Plus](#connection-to-sql-plus)
- [Create user account](#create-user-account)
- [Grant roles](#grant-roles)
- [Grant privileges](#grant-privileges)
- [Wrapping up](#wrapping-up)


<br>

## Connection to SQL Plus

In reality, we have two ways to utilize SQL Plus tool.
1. Using Termial on Linux or CMD on Windows

    - Typing **cmd** on **Window + R** dialog

    - After that, running command.

        ```java
        sqlplus / as sysdba
        ```

        ![](../img/oracle/12c/open-sql-plus-3.png)

2. Open directly SQL Plus

    - On Window taskbar, typing the SQL plus and enter it.

        ![](../img/oracle/12c/open-sql-plus.png)

    - Then, we have SQL plus's UI like the below image.

        ![](../img/oracle/12c/open-sql-plus-1.png)

    - Enter username as **sys as sysdba**, and password that we type when setting up Oracle database.

        ![](../img/oracle/12c/open-sql-plus-2.png)
        
<br>

## Create user account

According to [Oracle's website](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_8003.htm), we have the flow for creating user.

![](../img/oracle/12c/create_user.gif)

Then, we will run the below command.

```sql
CREATE USER weblogic123 IDENTIFIED BY weblogic123;
```

Sometimes, we will encounter a problem like:

![](../img/oracle/12c/error-create-user.png)

The reason why Oracle causes this error is that it need the prefix **c##** of username.

In order to solve this error, we have two solutions:
1. Using prefix **c##** with username

    ```java
    CREATE USER c##weblogic123 IDENTIFIED BY weblogic123;
    ```

2. Setting the **"_ORACLE_SCRIPT"=true**

    ```java
    ALTER SESSION SET "_ORACLE_SCRIPT"=true;
    ```

    Then, we will continue creating our new user.

    ```java
    CREATE USER weblogic123 IDENTIFIED BY weblogic123;
    ```

    The drawback of this solution:
    - Using hidden parameter **_ORACLE_SCRIPT** is dangerous in a production system and might also invalidate our support contract.

<br>

## Grant roles

Belows are some roles that we need to assign for users.
- **CONNECT** role
- **RESOURCE** role allows a user to create named types for custom schemas.
- **DBA** role allows the user to not only create custom named types, but alter and destroy them as well.

```java
GRANT CONNECT, RESOURCE, DBA TO weblogic123;
```

<br>

## Grant privileges

1. Grant a privilege to connect to oracle database

    ```java
    GRANT CREATE SESSION TO weblogic123;

    GRANT CREATE SESSION GRANT ANY PRIVILEGE TO weblogic123;
    ```

2. Grant a privilege that a user can have a disk space to modify or create tables or data.

    ```java
    GRANT UNLIMITED TABLESPACE TO weblogic123;
    ```

3. Grant a privilege for operations with table

    To know more about the table privileges, we can refer [https://docs.oracle.com/database/121/DBSEG/authorization.htm#DBSEG99919](https://docs.oracle.com/database/121/DBSEG/authorization.htm#DBSEG99919).

    ```java
    GRANT SELECT, INSERT, UPDATE, DELETE, CREATE ON database_name TO username;
    ```

4. Grant all privileges

    ```java
    GRANT ALL PRIVILEGES TO weblogic123;
    ```

<br>

## Wrapping up

- Understanding about how to create user account and grant privilege for users in Oracle database.

<br>

Refer:

[https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_8003.htm](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_8003.htm)

[https://stackoverflow.com/questions/33330968/error-ora-65096-invalid-common-user-or-role-name-in-oracle](https://stackoverflow.com/questions/33330968/error-ora-65096-invalid-common-user-or-role-name-in-oracle)

[https://www.oracletutorial.com/oracle-administration/oracle-grant-all-privileges-to-a-user/](https://www.oracletutorial.com/oracle-administration/oracle-grant-all-privileges-to-a-user/)

[https://docs.oracle.com/cd/A97630_01/server.920/a96524/c24privs.htm](https://docs.oracle.com/cd/A97630_01/server.920/a96524/c24privs.htm)