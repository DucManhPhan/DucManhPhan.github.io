---
layout: post
title: How to write simple scripts in Ubuntu
bigimg: /img/image-header/road-to-solution.jpeg
tags: [Ubuntu, Linux]
---

In this article, we will learn the most basic knowledge to program with bash script. Understanding them makes us strong into shell scripting.

Let's get started.

<br>

## Table of contents
- [Use different interpreter in script file](#use-different-interpreter-in-script-file)
- [Loop statements in bash script](#loop-statements-in-bash-script)
- [Condition statements in bash script](#condition-statement-in-bash-script)
- [Functions](#functions)
- [Some necessary operators](#some-necessary-operators)
- [Installing packages in Ubuntu](#installing-packages-in-ubuntu)
- [Wrapping up](#wrapping-up)

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

```#!/bin/bash``` or ```#!/usr/bin/python``` is known as hash bang, or shebang. Basically, it just tells the shell which interpreter to use to run the commands inside the script.

<br>

## Loop statements in bash script
- While loop

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
    if [ conditionals ]
    then
        commands
    fi
    ```

    ```bash
    if [ conditionals ]
    then
        commands
    elif [ conditionals ]
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
    if [ $1 -gt 100 ]
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

        if [ "$1" -gt 100 ]
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