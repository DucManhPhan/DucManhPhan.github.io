---
layout: post
title: Some useful commands in AQL of Aerospike
bigimg: /img/image-header/factory.jpg
tags: [Multithreading, Java]
---



<br>

## Table of contents
- [Some important parts in Aerospike](#some-important-parts-in-aerospike)
- [Common commands](#common-commands)
- [Data Query Language](#data-query-language)
- [Data Definition Language](#data-definition-language)
- [Data Manipulation Language](#data-manipulation-language)
- [Data Control Language](#data-control-language)
- [Wrapping up](#wrapping-up)


<br>

## Some important parts in Aerospike






<br>

## Common commands
1. Log in with AQL

    ```sql
    aql -h <ip_addr> -p <port_number> -U<user_name> -P<password>
    ```

2. Show all namespaces or database in Aerospike

    ```sql
    show namespaces;
    ```

3. Show all sets or tables

    ```sql
    show sets;
    ```

4. Show all bins or columns

    ```sql
    show bins;
    ```

5. List record details

    ```sql
    explain select * from <ns>.<set> where PK=<primary key value>
    ```

<br>

## Data Query Language
1. Select

    ```sql
    select * from <ns>.<set> where PK=<primary key value>
    ```


<br>

## Data Definition Language
1. Create



2. Alter



3. Drop



4. Rename




5. Truncate

    This is the command for deleting all the data in a namespace or a set:

    ```sql
    TRUNCATE <ns>[.<set>] [upto <LUT>]
    ```

    Where
    - ```<ns>``` is the namespace to truncate.
    - ```<set>``` is the set name to truncate.
    - ```<LUT>``` is the last update time upto which namespace or set needs to be truncated. LUT is either nanosecond since Unix epoch like 1513687224599000000 or a date string in format "Dec 19 2017 12:40:00"


6. Comment



<br>

## Data Manipulation Language
1. Insert

    ```sql
    INSERT INTO <ns>[.<set>] (PK, <bins>) VALUES (<key>, <values>)
    ```

    Where
    - ```<ns>``` is the namespace for the record.
    - ```<set>``` is the set name for the record.
    - ```<key>``` is the record's primary key.
    - ```<bins>``` is a comma-separated list of bin names.
    - ```<values>``` is comma-separated list of bin values, which may include type cast expressions. Set to NULL (case insensitive & w/o quotes) to delete the bin.

    For example:

    ```sql
    aql> INSERT INTO test.testset (PK, a, b) VALUES ('xyz', 'abc', 123)
    ```

    - Define data type

        The datatype of a bin value (e.g. MAP, LIST, GeoJSON etc) needs to be specified when the record is created. Once created, all the record operations such as INSERT, DELETE and queries are valid. The two options of specifying are as follows:

        - Using the datatype by defining itself as is.

            ```sql
            INSERT INTO test.testset(PK, a,b) VALUES ('xyz9', 'abc10', MAP('{"map":1, "of":2, "items":3}'))
            INSERT INTO test.demo (PK, gj) VALUES ('key1', GEOJSON('{"type": "Point", "coordinates": [123.4, -456.7]}'))
            ```

        - Using the CAST expression

            ```sql
            INSERT INTO test.testset (PK, a, b) VALUES ('xyz11', 'abc11', CAST('{"map":100, "of":200, "items":300}' AS MAP))
            INSERT INTO test.testset(PK, a,b) VALUES ('xyz12', 'abc12', CAST('{"type": "Point", "coordinates": [123.4, -456.7]}' as GEOJSON))
            ```

2. Delete

    ```sql
    DELETE FROM <ns>[.<set>] WHERE PK=<key>
    ```

    Where
    - ```<ns>``` is the namespace for the record.
    - ```<set>``` is the set name for the record.
    - ```<key>``` is the record's primary key.

    For example:

    ```sql
    aql> DELETE FROM test.testset WHERE PK='xyz'
    ```

3. Operate on a Record

    ```sql
    OPERATE <op(<bin>, params...)>[with_policy(<map policy>),] [<op(<bin>, params...)> with_policy (<map policy>) ...] ON <ns>[.<set>] where PK=<key>
    ```

    Where

    - ```<op>``` name of operation to perform.
    - ```<bin>``` is the name of a bin.
    - ```<params>``` parameters for operation.
    - ```<map policy>``` map operation policy.
    - ```<ns>``` is the namespace for the records to be queried.
    - ```<set>``` is the set name for the record to be queried.
    - ```<key>``` is the record's primary key.

    For example:

    ```sql
    aql> OPERATE LIST_APPEND(listbin, 1), LIST_APPEND(listbin2, 10) ON test.demo where PK = 'key1'
    aql> OPERATE LIST_POP_RANGE(listbin, 1, 10) ON test.demo where PK = 'key1'
    ```

<br>

## Data Control Language
1. Grant



2. Revoke



<br>

## Wrapping up
- In order to select all records that satisfy our condition, the bin of record must be indexed.


<br>

Refer:

[https://www.aerospike.com/docs/tools/aql/data_management.html](https://www.aerospike.com/docs/tools/aql/data_management.html)

[https://www.aerospike.com/docs/tools/aql/record_operations.html](https://www.aerospike.com/docs/tools/aql/record_operations.html)
