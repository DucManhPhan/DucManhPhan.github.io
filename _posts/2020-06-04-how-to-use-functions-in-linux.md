---
layout: post
title: How to use functions in Linux
bigimg: /img/image-header/yourself.jpeg
tags: [Linux]
---




<br>

## Table of contents
- [How to define functions](#how-to-define-functions)
- [How to pass values to a function](#how-to-pass-values-to-a-function)
- [Some ways to return value from functions](#some-ways-to-return-value-from-functions)
- [Wrapping up](#wrapping-up)

<br>

## How to define functions

1. Syntax

    ```bash
    function func_name {
        # nothing to do
    }
    ```

    OR

    ```bash
    func_name() {
        # nothing to do
    }
    ```

2. For example

    ```bash

    ```

<br>

## How to pass values to a function

1. Parameter variables

    If no parameters are passed, the environment variable **$#** exists but has a value of 0.

    Belows are some parameter variables that we need to know.

    |    Parameter variable      |                 Description             |
    | -------------------------- | --------------------------------------- |
    | $1, $2, ...                | The parameters given to the script      |
    | $*                         | A list of all the parameters, in a single variable, seperated by the first character in the environment variable IFS. If IFS is modified, then the way $* seperates the command line into parameters will change. |
    | $@                         | A subtle variation on $*; it does not use the IFS environment variable, so parameters are not run together even if IFS is empty |

2. Pass arguments and return value to function

    We supply the arguments directly after the function name. In function, we can access the value of arguments by using $1, $2, ...

    We will use keyword return to return our something.

    ```bash
     print_value() {
      echo "Hello $1"
      return 10
    }

    print_value world

    # Use #? contains the return status of the previously run command or function.
    echo "The returned value from above function is $?"

    # or
    value=$( print_value VietNam )
    ```

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

## Wrapping up

- Understanding about how to pass value to a function, use these parameters in a function, and return values. 
