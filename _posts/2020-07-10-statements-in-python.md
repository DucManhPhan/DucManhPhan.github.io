---
layout: post
title: Statements in Python
bigimg: /img/image-header/yourself.jpeg
tags: [Python]
---



<br>

## Table of contents
- [Conditional statement](#conditional-statement)
- [Loop statement](#loop-statement)
- [Wrapping up](#wrapping-up)


<br>

## Conditional statement

Expressions that used in **if**, **elif** statements must be estimated through **True** or **False**.

1. Use simple if statement

    ```python
    if <expression>:
        # statements
    ```

    For example:

    ```python
    age = 10
    if age > 6:
        print("Junior")
    ```

2. Use if..else statement

    ```python
    if <expression>:
        # statements
    else:
        # other statements
    ```

3. Use if .. elif .. else statement

    ```python
    if <expression>:
        # statements
    elif <expression>:
        # statements
    elif <expression>:
        # statements
    else:
        # statements
    ```

Python does not have switch statement.

<br>

## Loop statement

1. while loop

    ```python
    while <expression>:
        # statements
    ```

    For example:

    ```python
    x = 0
    while x < 10:
        x = x + 1

    print('Current value: ' + str(x))
    ```

2. For loop

    ```python
    for <iter> in <somethings>:
        # statements
    ```

    For example:

    ```python
    for letter in 'Hello, world':
        print(letter)
    ```


<br>

## Wrapping up

- Understanding about how to use the common statements in Python.

- Use **pass** statement for empty function, class, loop or if .. else statements to avoid the error notifications from interpreter.