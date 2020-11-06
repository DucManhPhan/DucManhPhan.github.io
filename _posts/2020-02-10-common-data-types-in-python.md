---
layout: post
title: Common data types in Python
bigimg: /img/image-header/yourself.jpeg
tags: [Python]
---




<br>

## Table of contents
- [Numeric data type](#numeric-data-type)
- [Boolean data type](#boolean-data-type)
- [String data type](#string-data-type)
- [Nothing data type](#nothing-data-type)
- [Wrapping up](#wrapping-up)


<br>

## Numeric data type

Python has three number data types:
- integer data type
- real data type
- float data type


<br>

## Boolean data type

Values of boolean data types are: True and False.

For example:

```python
male = True
female = False
x = 5 > 9
```

<br>

## String data type

1. Some ways to create string

    In Python, there are three ways of the string's creation:
    - Using the third double quotes

        ```python
        tmp = """Hello
                world
              """
        ```
    - Using single quote

        ```python
        tmp = 'Hello world'
        ```

    - Using double quotes

        ```python
        tmp = "Hi"
        ```

    In order to use the quotes in a string, there are some ways:
    - Using **\\** character

        ```python
        tmp = 'Hello, \"world\"'
        ```

    - Mixing some types of quotes

        ```python
        tmp = 'Hello "world"'
        ```

2. Some useful methods

    - Get the length of a string

        ```python
        tmp = 'Hello world'
        print(len(tmp))
        ```

    - trim spaces in a string

        Using **strip()**, **rstrip()**, **lstrip()** methods to remove the redendancy spaces. These methods will return a new string that contains our results.

        ```python
        s = ' Hello world  '
        s1 = s.rstrip()
        s2 = s.lstrip()
        s3 = s.strip()
        ```

    - compare two string

        Using some operators: ==, !=, ... that returns boolean data type.

        ```python
        s = 'Hello world'
        s1 = 'hello World'
        print(s == s1)
        ```

    - access an item in a string

        When using index's value is negative, it means that we will iterate from the last string.

        ```python
        s = 'Hello world'
        s1 = s[0:10]    # s1 = 'Hello worl'
        s2 = s[:]       # s2 = 'Hello world'
        s3 = s[-2]      # s3 = 'w'
        ```

    - Search substring in a string

        Using **find()**, **rfind()**, **index()**, **rindex()** methods.
        - **rfind()**, **rindex()** methods will search from the last string.
        - **find()**, **index()** methods search from the beginning string.

        With **find()** method, if it doesn't find a substring, it will return -1. However, the **index()** method will throw an exception ValueError if not found a substring.

        For example:

        ```python
        s = 'Hello world'
        try:
            print(s.index('Hello'))
        except ValueError as ex:
            print(ex)
        ```

    - Operator on a string

        \* operator is used to multiply a string to x times.

        ```python
        s = 'Hello world'
        print(s * 2)

        # result: Hello worldHello world
        ```

        \+ operator is used to concate multiple strings

        ```python
        print('Hello' + 'world')
        ```
        
        In Java, C++, string and number data types can be implicitly combined to a string. However, Python does not allow this way, we need to cast data types explicitly by using **int()**, **str()**, **float()** methods.

        ```python
        print('Hello world' + 2)    # cannot concate with int
        print('Hello world' + str(2))
        ```

    - Split, combine strings

        To split a string, using **split()**, **rsplit()** methods. Its result is a list of strings that is seperated from the original string.

        ```python
        # csv file
        s = 'id,name,address'
        res = s.split(',')

        # result: ['id', 'address', 'name']
        ```

        There is another way to split a string, using **partition()** method - only split at the first time when it copes with a seperated character. Its result is always a list of three elements. The first element is a segment of string that is before the seperated character, and the next element is the seperated character, the final element is a segment of string that lies after the seperated character.

        ```python
        s = 'id,name,address'
        res = s.partition(',')

        # result: ('id', ',', 'address,name')
        ```

    - Format string

        Some symbols for for string: %d, %x, %#x (adde 0x to string), %o, %e.

        ```python
        print('Hello world %d' % 2)
        print('Hello %f %s' % (2.5 'world'))
        ```

    - Useful methods

        |            Methods           |                Meaning                 |
        | ---------------------------- | -------------------------------------- |
        | upper()                      | convert all characters in a string to upper case |
        | lower()                      | convert all characters in a string to lower case |
        | swapcase()                   | lowercase --> uppercase, uppercase --> lowercase |
        | title()                      | convert first character to uppercase, the remained characters to lowercase |
        | isalpha()                    | check whether a character is a letter or not |
        | isdigit()                    | check whether a character is a number or not |
        | ljust()                      | |
        | rjust()                      | |

<br>

## Nothing data type

Using None value.

```python
s = None
```


<br>

## Wrapping up

- Understanding the common data types, especially the string data type.
