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
- []()
- [Wrapping up](#wrapping-up)


<br>

## Given problem





<br>

## Solution of grep command

1. Syntax

    ```
    grep <options> <pattern> <file, folder>
    ```

    With:
    - pattern: It is used by regular expression.
    - file, folder: The file or folder that we want to search in it.


2. Some options of grep command

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


3. Some flags that accompany with grep command

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

## 





<br>

## 





<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer:

[]()

[]()