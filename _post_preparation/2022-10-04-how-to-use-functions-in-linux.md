---
layout: post
title: How to use functions in Linux
bigimg: /img/image-header/yourself.jpeg
tags: [Linux]
---




<br>

## Table of contents





<br>

## How to define functions

1. Syntax

    ```bash
    function func_name() {
        # nothing to do
    }
    ```


2. For example



<br>

## Some ways to return value from functions

1. Using global variables

    ```bash
    function useGlobalVar() {
        myresult='hello, world'
    }

    useGlobalVariable
    echo $myresult
    ```

2. Define local variables and using command substitution

    - Command Substitution

        A command substitution means storing the output of a command execution in a variable.

        There are two ways to perform a command substitution:
        - Using the backtick character (')

            ```bash
            dir='pwd'
            echo $dir
            ```

        - Using the dollar sign format - **$()**

            ```bash
            dir=$(pwd)
            echo $dir
            ```

    - How to use

        ```bash
        function useLocalVar() {
            local localVar="Fuck you with local variables"
            echo "$localVar"
        }

        result=$(useLocalVar)
        echo $result 
        ```

3. Using parameters as variables that receive result

    ```bash
    function passVarAsParam() {
        local _resultVar=$1
        local localVar='Hello, world! What do you want?'

        eval $_resultVar="'$localVar'"  # lack single quote in double quote string --> it is not working.
    }

    passVarAsParam result
    echo $result
    ```


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

[]()

[]()

[]()

[]()