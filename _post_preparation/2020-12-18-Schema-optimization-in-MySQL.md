---
layout: post
title: Schema optimization in MySQL
bigimg: /img/image-header/ravashing-beach.jpg
tags: [MySQL]
---




<br>

## Table of contents
- [Solution with Data types](#solution-with-data-types)
- [Solution with Default value](#solution-with-default-value)
- []()
- []()
- [Wrapping up](#wrapping-up)


<br>

## Solution with Data types

MySQL has some data types:

|          Data Type           |         Spec        |          Data Type        |        Spec         |
| ---------------------------- | ------------------- | ------------------------- | ------------------- |
| CHAR                         | String (0 - 2^8 - 1) | INT                       | Use 4 bytes with signed int range value: -2^31 to 2^31 - 1 or unsigned int range value: 0 to 2^32 - 1 |
| VARCHAR                      | String (0 - 2^8 - 1) | BIGINT                    | Use 8 bytes with signed bigint range value: -2^63 to 2^63 - 1 or unsigned bigint range value: 0 to 2^64 - 1 |
| TINYTEXT                     | String (0 - 2^8 - 1) | FLOAT                     | Use 4 bytes with precision from 0 to 23 results |
| TEXT                         | String (0 - 2^16 - 1)| DOUBLE                    | Use 8 bytes with precision from 24 to 53 results |
| BLOB                         | String (0 - 2^16 - 1)| DECIMAL                   | "DOUBLE" stored as string |
| MEDIUMTEXT                   | String (0 - 2^24 - 1)| DATE                    | YYYY-MM-DD           | 
| MEDIUMBLOB                   | String (0 - 2^24 - 1)| DATETIME                | YYYY-MM-DD HH:MM:SS  | 
| LONGTEXT                     | String (0 - 2^32 - 1)| TIMESTAMP               | YYYYMMDDHHMMSS       | 
| LONGBLOB                     | String (0 - 2^32 - 1)| TIME                    | HH:MM:SS             |
| TINYINT                      | Use 1 byte with signed tiny int range value: -2^7 to 2^7 - 1 or unsigned tiny int range value: 0 to 2^8 - 1 | ENUM | One of preset options |
| SMALLINT                     | Use 2 bytes with signed small int range value: -2^15 to 2^15 -1 or unsigned small int range value: 0 to 2^16 -1 | SET | Selection of preset options |
| MEDIUMINT                    | Use 3 bytes with signed medium int range value: -2^23 to 2^23 - 1 or unsigned medium int range value: 0 to 2^24 - 1 | BOOLEAN | TINYINT(1) |

In MySQL, an ENUM is a string object whose value is chosen from a list of permitted values defined at the time of column creation. MySQL ENUM uses numeric indexes (1, 2, 3, …) to represents string values.

So, to optimize our schema with data types, we need to choose the suitable data types for our values. Belows are some rules for this case:
- Smaller is usually better

    For example, our variable's value is only from 0 to 24. Then, we can use TINYINT for this variable's value. We should avoid use SMALLINT, MEDIUMINT, or event INT. Because TINYINT takes 1 bytes in memory, but SMALLINT - 2 bytes, MEDIUMINT - 3 bytes, and INT - 4 bytes.

    **For storage and computational purposes, INT(1) is identical to INT(20).**

- Simple is good

    Fewer CPU cycles are typically required to process operations on simpler data types.

    For example:
    - integers are cheaper to compare than characters, because character sets and collations (sorting rules) makes comparisons complicated.
    - stores date, time in MySQL's builtin types instead of as strings.
    - use integers for IP address.

<br>

## Solution with Default value

Normally, we do not use **NOT NULL** condition to apply for multiple fields in tables. Using that way has some drawbacks that we need to know:
- When we create a table, MySQL will automatically build a B+ Tree index to opmitize queries. But if the specific field has multiple values that are NULL. It's difficult for MySQL to make indexes. Even if B+ Tree index is created, the traversal of this tree is hard, because MySQL will do some special operations to compare values.

- When a nullable column is indexed, it requires an extra byte per entry and can even cause a fixed-size index (such as an index on a single integer column) to be converted to a variable-sized one in MyISAM.

- InnoDB stores NULL with a single bit, so it can be pretty space-efficient for sparsely populated data. This doesn’t apply to MyISAM, though.

So, to avoid the null value, we can use default value or set that column to NOT NULL.


<br>

## 





<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()

[]()

[]()

