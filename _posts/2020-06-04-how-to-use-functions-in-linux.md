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
    #!/bin/bash

    function is_dir_git_repo {
        if git rev-parse --git-dir > /dev/null 2>&1; then
            echo 'using git repo'
            return 1
        else
            echo 'not using git repo'
            return 0
        fi 
    }

    is_directory() {
        if [ -d "$1" ]; then
            return 1
        else
            return 0
        fi
    }

    is_directory() {
        [ -d "$1" ]
    }
    ```

<br>

## How to pass values to a function

1. Parameter variables

    If no parameters are passed, the environment variable **$#** exists but has a value of 0.

    Belows are some parameter variables that we need to know.

    |    Parameter variable      |                 Description             |
    | -------------------------- | --------------------------------------- |
    | $0                         | The file name of the current script     |
    | $1, $2, ...                | The parameters given to the script      |
    | $#                         | The number of arguments supplied to a script |
    | $*                         | A list of all the parameters, in a single variable, seperated by the first character in the environment variable IFS. If IFS is modified, then the way $* seperates the command line into parameters will change. |
    | $@                         | A subtle variation on $*; it does not use the IFS environment variable, so parameters are not run together even if IFS is empty |
    | $$                         | The process number of the current shell. |
    | $?                         | The exit status of the last command      |
    | $!                         | The process number of the last background command |

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

4. Out of all above ways, we can use **$?** symbol to get the result from a command.

    **$?** symbol is the exit status of the last command. Exit status is a numerical value that is returned by a command.

    ```bash
    0 - successful
    1 - fail
    ```

    ```bash
    run_some_command
    EXIT_STATUS=$?

    if [ "$EXIT_STATUS" -eq "0" ]
    then
        # Do work when command exists on success
    else
        # Do work for when command has a failure exit
    fi
    ```

    Or we can embedded a command in a condition of if, while statements.

    ```bash
    if run_some_command
    then
        # Do work when command exists on success
    else
        # Do failure exit work
    fi
    ```

    Use the second way is faster because we does not use temporary variable to receive our result.

<br>

## Wrapping up

- Understanding about how to pass value to a function, use these parameters in a function, and return values. 
