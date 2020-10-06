---
layout: post
title: How to write simple shell scripts in Linux
bigimg: /img/image-header/road-to-solution.jpeg
tags: [Linux]
---

In this article, we will learn the most basic knowledge to program with bash script. Understanding them makes us strong into shell scripting.

Let's get started.

<br>

## Table of contents
- [Introduction to Shell](#introduction-to-shell)
- [Use different interpreter in script file](#use-different-interpreter-in-script-file)
- [How to provide permission to run script file](#how-to-provide-permission-to-run-script-file)
- [Variables](#variables)
- [Loop statements in bash script](#loop-statements-in-bash-script)
- [Condition statements in bash script](#condition-statement-in-bash-script)
- [Functions](#functions)
- [Some necessary operators](#some-necessary-operators)
- [Installing packages in Ubuntu](#installing-packages-in-ubuntu)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to Shell

A Shell is a program that works between us and the Linux system, enabling us to enter commands for the OS to execute.

In Linux, the standard shell is **bash** - the GNU Bourne-Again SHell, from the GNU suite of tools, is installed in the **/bin/sh**. In the most Linux distributions, the program **/bin/sh**, the default shell, is actually a link to the program **/bin/bash**.

Belows are some shell programs that we can use.

|           Shell Name            |                history               |
| ------------------------------- | ------------------------------------ |
| sh (Bourne)                     | The original shell from early version of UNIX |
| csh, tcsh, zsh                  | The C shell, and its derivatives, originally created by Bill Joy of Berkeley UNIX fame. The C Shell is probably the third most popular type of shell after bash and the Korn shell |
| ksh, pdksh                      | The Korn shell and its public domain cousin. Written by David Korn, this is the default shell on many commercial UNIX versions. |
| bash                            | The Linux staple shell from the GNU project. bash, or Bourne Again SHell, has the advantage that the source  code is freely available, and even if it's not currently running on our UNIX system, it has probably been ported to it. bash has many similarities to the Korn shell. |

<br>

## Use different interpreter in script file

- Use bash script

    ```bash
    #!/bin/bash
    echo "Hello, world!"
    echo "User - $USER, Directory - $HOME"
    ```

- Use Python interpreter

    ```bash
    #!/usr/bin/python
    ...
    ```

The **#!** characters tell the system that the argument that follows on the line is the program to be used to execute this file.

```#!/bin/bash``` or ```#!/usr/bin/python``` is known as hash bang, or shebang. Basically, it just tells the shell which interpreter to use to run the commands inside the script.

<br>

## How to provide permission to run script file

To run our script file, there are two ways:
- Invoke the shell with the name of the script file as a parameter

    For example, **/bin/sh hello-world.sh**

- Running our script file by calling its name

    Before doing it, we need to change the file mode to make the file executable for all users by using the **chmod** command.

    ```bash
    chmod +x hello-world.sh
    ```

    Then, we can run this script file by calling ```./hello-world.sh```.

<br>

## Variables

1. The declaration of variables

    In Linux, we do not need to declare variables in the shell before using them. The easiest way is that when we want to use them, create them such as assigning an initial value to them.

    By default, all variables are stored as strings, even when they are assigned numeric values. The shell and some utilities will convert numeric strings to their values in order to operate on them as required.

2. Access their value

    To get the the variables's value, we insert **$** symbol before their name.

    For example:

    ```sh
    strHelloWorld="hello world"
    echo $strHelloWorld
    ```

    A string must be surrounded with double quotes if it contain spaces.

    Note:
    - The behavior of variables inside quotes depends on the type of quotes we use.

        - If we enclose a $ variable expression in double quotes, then it's replaced with its value when the line is executed.

        - If we enclose it in single quotes, then no substitution takes place.

        - We can remove the special meaning of the **$** symbol by prefacing it with a **\**.

        For example:

        ```sh
        #!/bin/sh

        str="Hello, world!"

        echo $str
        echo "$str"
        echo '$str'
        echo \$str
        ```

3. Environment variables

    |  Environment variable  |          Description           |
    | ---------------------- | ------------------------------ |
    | $HOME                  | The home directory of the current user |
    | $PATH                  | A colon-seperated list of directories to search for command |
    | $PS1                   | A command prompt, frequently $, but in bash we can use some more complex values. |
    | $PS2                   | A secondary prompt, used when prompting for additional input; usually > |
    | $IFS                   | An input field seperator. This is a list of characters that are used to seperate words when the shell is reading input, usually space, tab, and newline characters. |
    | $0                     | The name of the shell script |
    | $#                     | The number of parameters passed |
    | $$                     | The process ID of the shell script, often used inside a script for generating unique temporary filenames; for example: /tmp/tmpfile_$$ |

<br>

## Loop statements in bash script
- **While** loop

    Syntax:
    
    ```bash
    while [ condition ]
    do 
        commands
    done
    ```
    For example: 

    ```bash
    #!/bin/bash
    valid=true
    count=1

    while [ $valid ]
    do
        echo $count
        if [ $count -eq 10 ];
        then
            break
            # continue
        fi
        ((count++))
    done
    ```

- For loop

    Syntax: 

    ```bash
    for var in <list>
    do 
        commands
    done
    ```

    Ex:

    ```bash
    #!/bin/bash
    names='Obama Trump Clinton'
    for name in $names
    do
        echo $name
    done

    echo 'Done.'
    ```

- Until loop

    Syntax:

    ```bash
    until [ condition ]
    do
        commands
    done
    ```

    Ex:

    ```bash
    #!/bin/bash
    counter=1

    until [ $counter -gt 5 ]
    do
        echo $counter
        ((counter++))
    done
    ```

- Ranges

    ```bash
    for value in {1..5}
    do
        echo $value
    done
    ```

## Condition statements in bash script

- If statement

    Syntax:

    ```bash
    if [ conditionals ];
    then
        commands
    fi
    ```

    ```bash
    if [ conditionals ];
    then
        commands
    elif [ conditionals ];
    then
        commands
    else
        commands
    fi
    ```

    For exampple:

    ```bash
    #!/bin/bash

    # $1 means the first command line argument
    if [ $1 -gt 100 ];
    then
        echo 'Your number is greater than one hundred.'
        pwd
    fi

    date
    ```

    - Nested if statement
        
        Ex:

        ```bash
        #!/bin/bash

        if [ "$1" -gt 100 ];
        then
            echo Hey that\'s a large number

            if (( $1 % 2 == 0 ))
            then
                echo And is also an even number
            fi
        fi
        ```

        If we do not use double quote for ```$1``` like ```"$1" -gt 100```, then when ```$1``` is empty we are getting ```if [ -gt 100 ]``` which is a syntax error.

- Boolean operations

    ```bash
    #!/bin/bash

    # use && or || to express boolean operations
    if [ -r $1 ] && [ -s $1 ]
    then
        echo 'This file is existed and can be read.'
    fi
    ```

- Case statement

    Syntax:

    ```bash
    case <variable> in
    <pattern 1>)
        commands
        ;;
    <pattern 2>)
        commands
        ;;
    esac
    ```

    Ex:

    ```bash
    case $1 in
    start)
        echo 'starting'
        ;;
    stop)
        echo 'stopping'
        ;;
    restart)
        echo 'restarting'
        ;;
    *)  # * represents any number of any characters.
        echo 'do not know'
        ;;
    esac
    ```

    Belows are a table that describes some operators in shell script.

    |          String Comparison        |          Result             |
    | --------------------------------- | --------------------------- |
    | string1 = string2                 | True if the strings are equal |
    | string1 != string2                | True if the strings are not equal |
    | string1 \\< string2                | True if the string1 is less than string2 |
    | string1 \\> string2                | True if the string1 is greater than string2 |
    | -n string                         | True if the string is not null |
    | -z string                         | True if the string is null (an empty string) |


    |       Arithmetic Comparison       |         Result           |
    | --------------------------------- | ------------------------ |
    | expression1 -eq expression2       | True if the expressions are equal |
    | expression1 -ne expression2       | True if the expressions are not equal |
    | expression1 -gt expression2       | True if expression1 is greater than expression2 |
    | expression1 -ge expression2       | True if expression1 is greater than or equal to expression2 |
    | expression1 -lt expression2       | True if expression1 is less than to expression2 |
    | expression1 -le expression2       | True if expression1 is less than or equal to expression2 |
    | !expression                       | True if the expression is false, and vice versa |

    |       File Conditional            |           Result             |
    | --------------------------------- | ---------------------------- |
    | -d file                           | True if the file is a directory |
    | -e file                           | True if the file exists. Note that historically the -e option has not been portable, so -f is usually used. |
    | -f file                           | True if the file is a regular file |
    | -g file                           | True if set-group-id is set on file |
    | -r file                           | True if the file is readable  |
    | -s file                           | True if the file nonzero size |
    | -u file                           | True if set-under-id is set on file |
    | -w file                           | True if the file is writable |
    | -x file                           | True if the file is executable |


<br>

## Functions

Syntax:

```bash
function_name() {
    commands
}

# or
function function_name {
    commands
}
```

- Parameter variables

    If no parameters are passed, the environment variable **$#** exists but has a value of 0.

    Belows are some parameter variables that we need to know.

    |          Parameter variable         |                  Description               |
    | ----------------------------------- | ------------------------------------------ |
    | $1, $2, ...                         | The parameters given to the script         |
    | $*                                  | A list of all the parameters, in a single variable, seperated by the first character in the environment variable IFS. If IFS is modified, then the way $* seperates the command line into parameters will change. |
    | $@                                  | A subtle variation on $*; it does not use the IFS environment variable, so parameters are not run together even if IFS is empty |

- Pass arguments and return value to function

    We supply the arguments directly after the function name. In function, we can access the value of arguments by using ```$1```, ```$2```, ...

    We will use keyword ```return``` to return our something.

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

- Local variable in functions

    We should use keyword ```local```.

    ```bash
    #!/bin/bash

    calc_tax() {
        local tax_percent=0.1
        return $1 * tax_percent
    }

    calc_tax 100
    ```


<br>

## Some necessary operators
- Comparation opertor

    ```=``` = used to compare two string

    ```!=``` = used to compare two string

    ```-eq``` = check whether the value is equal to something.
    
    ```-ne``` = not equal
    
    ```-gt``` = greater than
     
     ```-ge``` = greater than or equal

     ```-lt``` = less than

     ```-n STRING``` = The length of STRING is greater than zero.

     ```-z STRING``` = The length of STRING is zero.

    ```=``` is slightly different to ```-eq```. [ 001 = 1 ] will return false as ```=``` does a string comparison (ie. character for character the same) whereas ```-eq``` does a numerical comparison meaning [ 001 -eq 1 ] will return true.

- File operator

    ```-d FILE``` = FILE exists and is a directory

    ```-e FILE``` = FILE exists

    ```-r FILE``` = FILE exists and the read permission is granted.

    ```-s FILE``` = FILE exists and its size is greater than zero

    ```-w FILE``` = FILE exists and the write permission is granted.

    ```-x FILE``` = FILE exists and the execute permission is granted.

    When we refer to ```FILE``` above we are actually meaning a path. Remember that a path may be absolute or relative and may refer to a file or a directory.

<br>

## Installing packages in Ubuntu

```bash
#!/bin/bash

# Install Apache if it's not already present
if [ -f /usr/sbin/apache2 ]; then
    sudo apt install -y apache2
    sudo apt install -y libapache2-mod-php7.2
    sudo a2enmod php
    sudo systemctl restart apache2
fi
```

- Check for existence of the apache2 library

    Use ```-f``` option specifies that we're looking for a file.

    If we want to check for existence of a directory, use ```-d``` option.

    ```!``` operator - exclamation mark is an inverse, it means we're checking if something is not present.

- Install packages

    We can use ```-y``` option to omit some confirmation that process's installing package is required.

- ```if``` statement

    We should close out ```if``` statement with the word fi backward - ```fi```. If we forgot to do this, the script will fail.

<br>

## Wrapping up

- Understanding some basic statements and operators in Bash script.
- Split function into smaller function to help us easily maintainable and readable code.

<br>

Refer:

[https://linuxhint.com/bash-while-loop-examples/](https://linuxhint.com/bash-while-loop-examples/)

[https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php](https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php)