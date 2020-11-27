---
layout: post
title: grep command in Linux
bigimg: /img/image-header/road-to-solution.jpeg
tags: [Linux]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of grep command](#solution-of-grep-command)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

In Linux, we usually have to search keyword in text, or file, or folders, or the result from the other commands. It is difficult to deal with it when we have to jump directly in these files or folders to check.

The drawbacks of this solution:
- It takes so much times to search.
- We do not automatically search our keywords that accepts input from the other sources.

So how do we solve these problems?

<br>

## Solution of grep command

1. Syntax

    ```
    grep <options> <pattern> <file, folder>
    ```

    With:
    - pattern: It is used by regular expression.
    - file, folder: The file or folder that we want to search in it.


2. Some options of **grep** command

    Belows are the list of options that grep will use.
    - ```-r``` or ```-R```: recursive
    - ```-n```: display the line number that corresponding lines satisfy our pattern
    - ```-w```: It means that match the whole word
    - ```-l```: It can be added to just give the file name of matching files.
    - ```-i```: case-insensitive search
    - ```-v```: display the lines not containing the pattern.
    - ```-c```: display the count of the matching pattern.
    - ```-A```: display the n lines after the matching line.

        For example:

        ```bash
        grep -A 4 -i 'greeting' welcome.sh
        ```

    - ```-B```: display the n lines before the matching line.

        For example:

        ```bash
        grep -B 3 'greeting' welcome.sh
        ```

    - ```-C```: display the n lines around the matching line.

        For example:

        ```bash
        grep -C 3 'greeting' welcome.sh
        ```

    - ```-o```: prints only the matched parts of a matching line.

        For example:

        ```bash
        echo "text with number -2.56325" | grep -Eo '[+-]?[0-9]+([.][0-9]+)?'
        ```

        To use **-o** option correctly, we should utilize with **-E** option that means extended regex.

3. Some flags that accompany with **grep** command

    - ```--exclude```: search all files that exclude these files that satisfy pattern in this flag.

        For example:

        ```sh
        grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"
        ```

    - ```--include```: search all files that satisfy pattern in this flag.

        For example:

        ```bash
        grep --exclude=\*.o -rnw '/path/to/somewhere/' -e "pattern"
        ```

    - ```--exclude-dir```: For directories, it's possible to exclude one or more directories using the ```--exclude-dir``` parameter.

        For example:

        ```
        grep --exclude-dir={dir1,dir2,*.dst} -rnw '/path/to/somewhere/' -e "pattern"
        ```

<br>

## Wrapping up

- Understanding about how to use, when to use grep command in Linux.

<br>

Thanks for your reading.