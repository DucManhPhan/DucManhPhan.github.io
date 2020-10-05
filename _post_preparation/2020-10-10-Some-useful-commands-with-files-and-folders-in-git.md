---
layout: post
title: Some useful commands with files and folders in Git
bigimg: /img/image-header/unsplash.jpg
tags: [Git]
---



<br>

## Table of Contents
- [Given problem](#given-problem)
- [Some operations with files and folders](#some-operations-with-files-and-folders)
- [Delete operation](#delete-operation)
- [Rename operation](#rename-operation)
- [Move operation](#move-operation)
- [Search operation](#search-operation)
- [Other operations](#other-operations)
- [Wrapping up](#wrapping-up)



<br>

## Given problem





<br>

## Some operations with files and folders





<br>

## Delete operation





<br>

## Rename operation





<br>

## Move operation





<br>

## Search operation

1. Search files's name that is managed by Git

    ```bash
    git ls-files | grep <file-name>
    ```

2. Search files that contain words

    ```bash
    git grep <word-pattern>

    # accompany with the number of line
    git grep -n <word-pattern>

    # only list the files's name
    git grep -l <word-pattern>

    # list the amount of word's appearance
    git grep -c <word-pattern>
    ```

3. Search the user that remove a file

    ```bash
    # When a file was removed
    git log --diff-filter=D -- <file-path>

    # find the datetime and what's commit that file was deleted
    git log --diff-filter=D --summary -- <file-path>
    ```

    The meaning of above options:
    - **--**: It is used to notify Git that it's not a branch or is an option of a command.
    - **--summary**: list files that were deleted or added. We have another option with the similar functionality: **--name-status**.
    - **--diff-filter**: specify the type of change a file. It has some values such as Added - **A**, Coppied - **C**, Modified - **M**, Renamed - **R**.

4. Search information of a file that was added

    ```bash
    git log --diff-filter=A --name-status | grep -C 10 <pattern>
    ```

5. Find information of user that has the last change for a line of a file

    ```bash
    git blame <file-path>
    ```

6. Search commits that removed or added a sequence of characters

    Using **git log -S<string>** or **git log -G<regex>**.

    ```bash
    git log -Sgoogle --diff-filter=M --patch
    ```

<br>

## Other operations

1. Restore a file that is moved to the staging area.

    ```bash
    git restore --staged <file-path>
    ```

2. Remove a file from the staging area

    ```bash
    git rm --cached <file-path>
    ```

3. Remove a file from the local repository

    - First, we need to revert to the previous commit.

        ```bash
        git reset --soft HEAD^1
        ```

        So, our files that are in the staging area.

    - Second, we will remove them from the staging area.

        ```bash
        git rm --cached <file-path>
        ```

        Now, our files appear in the untracking files section. Then, we will remove directly that file.

    - Finally, commit the remaining files.

        ```bash
        git commit -m "message"
        ```

<br>

## Wrapping up





<br>

Refer:

[https://www.tutorialspoint.com/git/git_move_operation.htm](https://www.tutorialspoint.com/git/git_move_operation.htm)

[https://www.tutorialspoint.com/git/git_rename_operation.htm](https://www.tutorialspoint.com/git/git_rename_operation.htm)

[https://www.tutorialspoint.com/git/git_update_operation.htm](https://www.tutorialspoint.com/git/git_update_operation.htm)

[https://dodangquan.blogspot.com/2017/11/tim-kiem-voi-git.html](https://dodangquan.blogspot.com/2017/11/tim-kiem-voi-git.html)