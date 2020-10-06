---
layout: post
title: How to use variable in Linux
bigimg: /img/image-header/yourself.jpeg
tags: [Linux]
---




<br>

## Table of contents





<br>

## How to define variables

To understand the basic thing of variables in Linux, we can visit the article [How to write simple shell scripts in Linux](https://ducmanhphan.github.io/2019-11-02-How-to-write-simple-scripts-in-linux/).


1. Some types of variables

    There are two types of variables that are defined in bash script.
    - User-defined variables

        ```bash
        path="./home/user"
        num=3
        ```

        To declare a variable, typing its name and set its value by using **equal** sign. There are no spaces between the variable name and the equals sign, or between the equals sign and the value. If existing space, shell will consider the definition of variables as a command.

    - Environment variables

        To see the definitions of environment variables, we can use **printenv** command.

        ```bash
        # list all environment variables
        printenv

        # display a value of HOME variable
        printenv HOME
        ```

2. Variable scope

    - Accessing a variable in two script files

        ```bash
        # define script1.sh
        #!/bin/bash
        name="google.com.vn"
        export name
        ./script2.sh    # call the script2 to work

        # define script2.sh
        echo $name
        ```


<br>

## Declaration of an array

1. Syntax

    ```bash
    # 1st way - enclosing elements between brackets
    arr=(hello world what are you doing?)

    # 2nd way - using declare keyword
    declare -a arr=("hello" "world" "what" "are" "you" "doing?")

    # or declare an array in multiple lines
    declare -a arr=(
        "hello"
        "world"
        "what"
        "are"
        "you"
        "doing?"
    )
    ```

    The starting index of an array is 0.


2. Some useful operations

    - Get the length of an array

        ```bash
        count=${#arr[@]}
        ```


    - Print the array elements, using an asterisk

        ```bash
        echo ${arr[*]}
        ```

    - Remove a specific element from an array

        ```bash
        # remove all elements
        unset arr

        # remove the first element
        unset arr[0]
        ```

    - iterate all elements from an array

        ```bash
        # 1st way
        for i in "${arr[@]}"
        do
            echo "$i"
        done

        # 2nd way
        count=${#arr[@]}
        for (( idx=1; idx<${count}+1; idx++ ));
        do
            echo $idx " / " ${count} " : " ${arr[$idx-1]}
        done
        ```

<br>

## Declaration of an associative data structure

1. Syntax



2. Some useful operations


<br>

## Wrapping up




<br>

Refer:

[http://tiebing.blogspot.com/2008/01/bash-programming-reference-card.html](http://tiebing.blogspot.com/2008/01/bash-programming-reference-card.html)