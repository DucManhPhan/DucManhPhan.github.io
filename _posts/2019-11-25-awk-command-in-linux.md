---
layout: post
title: awk command in Linux
bigimg: /img/image-header/road-to-solution.jpeg
tags: [Linux]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with AWK command](#solution-with-awk-command)
- [How to seperate complex awk command into smaller program](#how-to-separate-complex-awk-command-into-smaller-program)
- [Some control statements that are supported in awk command](#some-control-statements-that-are-supported-in-awk-command)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

When working with files, we usually use redirect I/O to read each line at one time. But in this case, we normally does not process, analysis these line, we only print their contents. It is really tedious and we have to read multiple line without extracting some useful information that we want.

So our question in this case is that how do we use text processing?

<br>

## Solution with AWK command

1. Syntax of AWK

    ```bash
    awk 'pattern { action }'
    ```

    The following an awk command is the sequence of rules. Each rule contains a pair of pattern and action. And they are seperated by newline or semicolons (;).

    An action is always enclosed in braces **{}** and this braces will contains lots of statements. **Each statement should be separated by new line or semicolons**. 

    An action will be run when pattern is satisfied our conditions that are defined. By default, a pattern is the blank or null pattern, so it can match whole record.

    In awk command, we have some types of pattern that we need to know:
    - regular expression
    - expression

        We can use conditional expressions in this pattern.

    - pattern1, pattern2

        A pair of patterns separated by a comma, of the form "begin-pattern, end-pattern", specifying a range of records. The first pattern, begin-pattern, controls where the range begin, and end-pattern controls where it ends.

        For example:

        ```bash
        # data
        start field1 field2
        run 1 2
        run 2 4
        run 5 8
        end 10 10

        # command
        awk '$1 == "start", $1 == "end" { print $2, $3 }'
        ```

    - BEGIN, END pattern

        BEGIN pattern will be called before processing any lines, and END pattern happened after the last line is read. 

        BEGIN can have multiple actions, each action will be defined in the braces **{}**.

        ```bash
        awk 'BEGIN {print "starting"} \
                {print $0} \
            END {print "the end"}'
        ```

    - empty pattern

    Belows are some statements that an action uses.
    - Expressions, such as assignment operator, arithmetic operators, increment, and decrement operators.

        - About assignment operator

            ```bash
            # assign single value
            # variable=value
            OFS="/"

            # assign a value of a arithmetic expression
            #variable=arithmetic_expression
            awk 'BEGIN {a=1+3+4; print a;}'
            ```

        - About arithmetic operators

            Below is a table that is describe operators that awk supports in its actions.

            | Operator |     Type      |         Meaning         |
            | -------- | ------------- | ----------------------- |
            | +        | Arithmetic    | Addition                |
            | -        | Arithmetic    | Subtraction             |
            | *        | Arithmetic    | Multiplication          |
            | /        | Arithmetic    | Division                |
            | %        | Arithmetic    | Modulo                  |
            | \<space\>| String        | Concatention            |
            | +=       | Arithmetic    | Add result to variable  |
            | -=       | Arithmetic    | Subtract result to variable |
            | *=       | Arithmetic    | Multiply variable by result  |
            | /=       | Arithmetic    | Divide variable by result  |
            | %=       | Arithmetic    | Apply modulo to variable  |

            We can easily find that all operators that look like in C/C++.

            For example:
            
            ```bash
            # result: 163
            awk 'BEGIN {a=1+3*5 6; print a}'

            # print lines with its length is greater than 5
            awk 'length($0) > 5' <input-file>
            ```
        
        - About increment, decrement operators

            As same as operators in C/C++, awk also supports pre, post increment operator **++** that is used to increase its value by 1, and pre, post decrement operator **--** that is used to decrease its value by 1.

            ```bash
            awk 'BEGIN {a=3; b=++a; print a, b;}'

            awk 'BEGIN {a=3; b=a--; print a, b;}'
            ```

        - About conditional expression

            | Operator |       Meaning         |
            | -------- | --------------------- |
            | ==       | is equal to           |
            | !=       | is not equal to       |
            | >        | is greater than       |
            | >=       | is greater than or equal to |
            | <        | is less than          |
            | <=       | is less than or equal to |
            | &&       | and operator for two conditional expression |
            | \|\|     | or operator for two conditional expression |
            | !        | not operator for a conditional expression |

            These operators are used to compare numbers or strings. And with comparing strings, the lower case letters are always greater than upper case letters.

            For example:

            ```bash
            awk 'BEGIN { if ("a" == "a") print "same";}'
            ```

        - About regular expression

            | Operator |       Meaning         |
            | -------- | --------------------- |
            | ~        | matches               |
            | !~       | does not match        |

            These operators are used to compare strings. To define a regular expression, we need to embed it in the slashes before these operators.

            To know more about the symbols of regular expression, we can refer to the [link](https://ducmanhphan.github.io/2019-11-11-Understanding-about-Regular-Expression/).

            ```bash
            # syntax
            word ~ /match/

            word !~ /match/

            # use with awk command
            awk -e 'word ~ /match/ { action }'
            ```

            To use find-and-replace pattern in awk, we can use sub, gsub, and gensub command.
            - sub command

                It will substitutes the first matched entity in a record with a replacement string.

                ```bash
                awk -e 'sub(/match/, replace-string)'
                ```

            - gsub command

                It will substitutes all matched entity in a record with a replacement string.

                ```bash
                awk -e 'gsub(/match/, replace-string)'
                ```
            
            - gensub command

                This command will use & operator to use the capturing group, and provides a parameter to specify how many word to replace by our string.

                ```bash
                awk -e '{ print gensub(/match/, "text-string &", num-replacement) }'
                ```

    - Control statements, used to control the flow of the program (if, for, while, switch, and more)

        For example:

        ```bash
        # check the third field of each record that is satisfied an condition
        awk '{ if ($3 == "content") print $0; }' <input-file>

        awk 'BEGIN { for(i=1;i<=6;i++) print "square of", i, "is", i*i; }'
        ```

    - Output statements, such as print and printf.
    - Compound statements, to group other statements.
    - Input statements, to control the processing of the input.
    - Deletion statements, to remove array elements.

2. Accessing fields and properties of a line

    |         Field Identifiers       |              Description            |
    | ------------------------------- | ----------------------------------- |
    | $0                              | the entire line of the text         |
    | $n                              | the nth field in a line             |
    | $NF                             | acronym as Number of Fields, it is the last field |
    | $(NF-1)                         | the field that before the last field |
    | $NR                             | acronym as Number or Records, it means that the position of a line that is processed |
    | FILENAME                        | The input file's name               |
    | FS                              | Field Separator                     |
    | RS                              | Record Separator                    |
    | OFS                             | Output Field Separator              |
    | ORS                             | Output Record Separator             |


3. Format input of awk command

    By default, the input separator character in awk command is whitespace, including tabs, space, or newline characters. To specify the different separator characters between fields in a line, we can use **FS** variable.
    
    There are two ways to use **FS** variable correctly.
    - Using the **BEGIN** pattern.

        ```bash
        #!/bin/bash
        awk 'BEGIN { FS = "," } ; { print $1 }'
        ```

    - Using **-F** option

        ```bash
        # define with awk program in a file
        awk -F, -f <awk-file> <input-file>

        awk -F: '{print $1, $6}' <input-file>
        ```

        We shouldn't have mistake about **-F** option and **-f** option because they have the different meanings. The **-f** option specifies a file that containing an awk program. Use -f option when we want to seperate our complex script to multiple smaller things.
    

4. Format output of awk command

    The output of awk command is created by using print statement. By default, a whitespace is also the separator character that print statement uses.

    ```bash
    awk 'BEGIN { OFS = ";"; ORS = "\n\n" } { print $1, $2 }' <input-file>
    ```

<br>

## How to seperate complex awk command into smaller program

Below is the script of awk command with the file name: **sample.awk**

```bash
#!/usr/bin/awk -f

BEGIN {
    # define the initialization of variables
}
{
    # list all our actions
}
END {
    # action for the end of execution
}
```

To run the above file, we can type:

```bash
awk -f sample.awk
```

<br>

## Some control statements that are supported in awk command

1. if/else statement

    - single if statement

        ```bash
        # with one action        
        if (condition)
            action

        # with lots of action
        if (condition) {
            action;
            action;
        }
        ```

    - if/else statement

        ```bash
        # use specify if/else statement
        if (condition)
            action
        else
            action

        # use tenary operator
        condition / action : action;
        ```

    - if/else if/else statement

        ```bash
        if (condition)
            action;
        else if (condition)
            action;
        else
            action;        
        ```

2. for statement

    ```bash
    for (i = 1; i < 6; ++i)
        action
    ```

3. while statement

    ```bash
    while (condition)
        action
    ```

4. do..while statement

    ```bash
    do
        action
    while (condition)
    ```

5. break and continue statements

6. exit statement

<br>

## Wrapping up

- Understanding about how to use awk command, take note about patterns, and actions.

- To define an array type in awk command, we can follow a [link](https://www.tutorialspoint.com/awk/awk_arrays.htm).

<br>

Thanks for your reading.

<br>

Refer:

[https://www3.physnet.uni-hamburg.de/physnet/Tru64-Unix/HTML/APS32DTE/WKXXXXXX.HTM](https://www3.physnet.uni-hamburg.de/physnet/Tru64-Unix/HTML/APS32DTE/WKXXXXXX.HTM)

[https://linuxize.com/post/awk-command/](https://linuxize.com/post/awk-command/)

[https://www.geeksforgeeks.org/awk-command-unixlinux-examples/?ref=lbp](https://www.geeksforgeeks.org/awk-command-unixlinux-examples/?ref=lbp)

[https://www.thegeekstuff.com/2010/01/8-powerful-awk-built-in-variables-fs-ofs-rs-ors-nr-nf-filename-fnr](https://www.thegeekstuff.com/2010/01/8-powerful-awk-built-in-variables-fs-ofs-rs-ors-nr-nf-filename-fnr)

[https://www.howtogeek.com/562941/how-to-use-the-awk-command-on-linux/](https://www.howtogeek.com/562941/how-to-use-the-awk-command-on-linux/)

[https://www.grymoire.com/Unix/Awk.html](https://www.grymoire.com/Unix/Awk.html)

[https://opensource.com/article/19/11/how-regular-expressions-awk](https://opensource.com/article/19/11/how-regular-expressions-awk)

[https://likegeeks.com/awk-command/](https://likegeeks.com/awk-command/)