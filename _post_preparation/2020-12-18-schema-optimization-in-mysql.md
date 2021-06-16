---
layout: post
title: Schema optimization in MySQL
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Database, MySQL]
---




<br>

## Table of contents
- [Solution with Data types](#solution-with-data-types)
- [Solution with Default value](#solution-with-default-value)
- [Solution with String data type](#solution-with-string-data-type)
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

- InnoDB stores NULL with a single bit, so it can be pretty space-efficient for sparsely populated data. This doesn't apply to MyISAM, though.

So, to avoid the NULL value, we can use default value or set that column to **NOT NULL**.

<br>

## Solution with String data type

Since MySQL 4.1, each string column can have its own character set and set of sorting rules for that character set, or collation.

1. VARCHAR and CHAR type

    The implementation of these types are storage engine-dependent. So, we will concentrate largely on the InnoDB storage engine or MyISAM.

    - VARCHAR

        VARCHAR stores variable-length character strings and is the most common string data type. It can require less storage space than fixed-length types, because it uses only as much space as it needs. The exception is a MyISAM table created with ROW_FORMAT=FIXED, which uses a fixed amount of space on disk for each row and can thus waste space.

        VARCHAR uses 1 or 2 extra bytes to record the value's length:
        - 1 byte if the column's maximum length is 255 bytes or less
        - 2 byte if it's more.

        VARCHAR helps performance because it saves space. However, because the rows are variable-length, they can grow when we update them, which can cause extra work. If a row grows and no longer fits in its orginal location, the behavior is storage engine-dependent.

        For example, MyISAM may fragment the row, and InnoDB may need to split the page to fit the row into it. Other engines may never update data in-place at all.

        It's usually worth using VARCHAR when the maximum column length is much larger than the average length.
        - when updates to the fields are rare, so fragmentation is not a problem
        - when we're using a complex character set such as UTF-8, where each character uses a variable number of bytes of storage.

        In version 5.0 and newer, MySQL preserves **trailing spaces** when we store and retrieve values. In versions 4.1 and older, MySQL strips trailing spaces.

        It's trickier with InnoDB, which can store long VARCHAR values as BLOBs.

    - CHAR

        CHAR is fixed-length. MySQL always allocates enough space for the specified number of characters. When storing a CHAR value, MySQL removes any trailing spaces. This was also true of VARCHAR in MySQL 4.1 and older versions - CHAR and VARCHAR were logically identical and differed only in storage format. Values are padded with spaces as needed for comparisons.

        CHAR is useful if we want to store very short strings, or if all the values are nearly the same length. For example, CHAR is a good choice for MD5 values for user passwords, which are always the same length.

        CHAR is also better than VARCHAR for data that's changed frequently, because a fixed-length row is not prone to fragmentation.

        For very short columns, CHAR is also more efficient than VARCHAR.

        For example:
        - a CHAR(1) designed to hold only Y and N values will use only one byte in a single-byte character set.
        - a VARCHAR(1) would use two bytes because of the length byte.

    The memory storage engine uses fixed-length rows, so it has to allocate the maximum possible space for each value even when it's a variable-length field. However, the padding and trimming behavior is consistent across storage engines, because the MySQL server itself handles that.

    The sibling types for CHAR and VARCHAR are BINARY and VARBINARY, which store binary strings. Binary strings are very similar to conventional strings, but they store bytes instead of characters. Padding is also different: MySQL pads BINARY values with \0 (the zero byte) instead of spaces and doesn't strip the pad value on retrieval.

    These types are useful when we need to store binary data and want MySQL to compare the values as bytes instead of characters. The advantage of byte-wise comparisons is more than just a matter of case insensitivity. MySQL literally compares BINARY strings one byte at a time, according to the numeric value of each byte. As a result, binary comparisons can be much simpler than character comparisons, so they are faster.

    For example:
    - Storing the value 'hello' requires the same amount of space in a VARCHAR(5) and a VARCHAR(200) column. Is there any advantage to using the shorter column?

        As it turns out, there is a big advantage. The larger column can use much more memory, because MySQL often allocates fixed-size chunks of memory to hold values internally. This is especially bad for sorting or operations that use in-memory temporary tables. The same thing happens with filesorts that use on-disk temporary tables.

        The best strategy is to allocate only as much space as we really need.

2. BLOB and TEXT types

    BLOB and TEXT are string data types designed to store large amounts of data as either binary or character strings, respectively.

    In fact, they are each families of data types:
    - the character types: TINYTEXT, SMALL TEXT, TEXT, MEDIUMTEXT, and LONGTEXT.

        TEXT is a synonym for SMALLTEXT.

    - the binary types: TINYBLOB, SMALLBLOB, BLOB, MEDIUMBLOB, and LONGBLOB.

        BLOB is a synonym for SMALLBLOB.

    Unlike all other data types, MySQL handles each BLOB and TEXT value as an object with its own identity. Storage engines often store them specially; InnoDB may use a separate external storage area for them when they're large. Each value requires from **one to four bytes of storage space in the row** and **enough space in external storage to actually hold the value**.

    The only difference between the BLOB and TEXT families is that BLOB types store binary data with no collation or character set, but TEXT types have a character set and collation.

    MySQL sorts **BLOB** and **TEXT** columns differently from other types: instead of sorting the full length of the string, it sorts only the first **max_sort_length** bytes of such columns. If we need to sort by only the first few characters, we can either decrease the **max_sort_length** server variable or use **ORDER BY SUBSTRING(column, length)**.

    MySQL can't index the full length of these data types and can't use the indexes for sorting.

    The problem when using BLOB and TEXT file:
    - On-Disk temporary tables and sort files

        Because the memory storage engine doesn't support the BLOB and TEXT types, queries that use BLOB and TEXT columns and need an implicit temporary table will have to use on-disk MyISAM temporary tables, even for only a few rows.

        This can result in a serious performance overhead. Even if we configure MySQL to store temporary tables on RAM disk, many expensive operating system calls will be required.

        The best solution is to avoid using the BLOB and TEXT types unless we really need them. If we can't avoid them, we may be able to use the SUBSTRING(column, length) trick everywhere a BLOB column is mentioned (including in the ORDER BY clause) to convert the values to character strings, which will permit in-memory temporary tables. Just be sure that we're using a short enough substring that the temporary table doesn't grow larger than max_heap_table_size or tmp_table_size, or MySQL will convert the table to an on-disk MyISAM table.

        The worst case length allocation also applies to sorting of values, so this trick can help with both kinds of problems:
        - creating large temporary tables and sort files.
        - creating them on disk.

3. Using ENUM instead of a string type

    An ENUM column can store a predefined set of distinct string values. MySQL stores them very compactly, packed into one or two bytes depending on the number of values in the list. It stores each value internally as an interger representing its position in the field definition list, and it keeps the **lookup table** that defines the number-to-string correspondence in the table's .frm file.

    For example:

    ```sql
    CREATE TABLE enum_test(e ENUM('fish', 'apple', 'dog') NOT NULL);
    ```

    Another surprise is that an ENUM field sorts by the internal integer values, not by the strings themselves.

    We can work around this by specifying ENUM members in the order in which we want them to sort. We can also use FIELD() to specify a sort order explicitly in our queries, but this prevents MySQL from using the index for sorting.

    If we'd defined the values in alphabetical order, we wouldn't have needed to do that.

    The biggest downside of ENUM is that the list of strings is fixed, and adding or removing strings requires the use of ALTER TABLE. Thus, it might not be a good idea to use ENUM as a string data type when the list of allowed string values is likely to change arbitrarily in the future, unless it's acceptable to add them at then end of the list, which can be done without a full rebuild of the table in MySQL 5.1.

    Because MySQL stores each value as an integer and has to do a lookup to convert it to its string representation, ENUM column have some overhead. This is usually offset by their smaller size, but not always. In particular, it can be slower to join a CHAR or VARCHAR column to an ENUM column than to another CHAR or VARCHAR column.

    The join is faster after converting the columns to ENUM, but joining the ENUM columns to VARCHAR columns is slower. In this case, it looks like a good idea to convert these columns, as long as they don't have to be joined to VARCHAR columns. It's a common design practice to use **lookup tables** with integer primary keys to avoid using character-based values in joins.

    There's another benefit to converting the columns. The primary key itself is only about half the size after the conversion. Because this is an InnoDB table, if there are any other indexes on this table, reducing the primary key size will make them much smaller, too.

<br>

## 




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

[High performance MySQL, third edition]()

[]()

[]()

[]()

[]()

[]()

