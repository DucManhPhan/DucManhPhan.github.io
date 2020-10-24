---
layout: post
title: Some useful commands with files and folders in Git
bigimg: /img/image-header/unsplash.jpg
tags: [Git]
---



<br>

## Table of Contents
- [Delete operation](#delete-operation)
- [Rename operation](#rename-operation)
- [Move operation](#move-operation)
- [Search operation](#search-operation)
- [Undo operations](#undo-operations)
- [Wrapping up](#wrapping-up)

<br>

## Delete operation

1. Stop tracking a file from the staging area

    ```bash
    # with a file
    git rm --cached <file-path>

    # with a folder
    # -r option means recursive
    git rm -r --cached <folder-path>
    ```

2. Remove a file from the local repository

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

    - Finally, commit the remaining files and push them to the remote repository.

        ```bash
        git commit -m "message"

        git push origin <branch-name>
        ```

3. Remove files that are not tracked by the staging area

    ```bash
    git clean -f

    # delete folder
    git clean -f -d

    # watch files before deleting
    git clean -n -f -d
    ```

4. Delete local's all removed files in repository

    ```bash
    git rm $(git ls-files --deleted)
    ```

5. Remove a folder in the remote repository

    ```bash
    git rm -rf <folder-name>

    git commit -m "message"

    git push -f origin <branch-name>
    ```

<br>

## Rename operation

```bash
# rename a file
git mv <file-name> <new-file-name>
```


<br>

## Move operation

```bash
git mv <file-path> <folder-path>
```


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

7. Search for commits by a particular author

    ```bash
    git log --author="<pattern>"
    ```

8. Search for commits with a commit message that matches \<pattern\>

    ```bash
    git log --grep="<pattern>"
    ```

9. Display commits that have the specified file

    ```bash
    git log -- <file-path>
    ```

<br>

## Undo operation

1. Restore a file that does not add to the staging area

    ```bash
    # 1st way - use git checkout
    git checkout -- <file-path>

    # 2nd way - use git reset
    git reset 
    ```

2. Restore a file that is added to the staging area.

    ```bash
    # 1st way - using git restore
    git restore --staged <file-path>

    # 2nd way - using git reset in mixed mode
    # the local respority and the staging area will be reset, but the changes in working space are still remained
    git reset -- <file-path>
    ```

3. Restore a file that is pushed to the local/remote repository

    Sometimes we push the changes of a files as the 2 commits to the local/remote repository. But now we want to revert this file to the previous state of the 2 commits.

    ```bash
    # commits of a file in the master of the local/remote repository
               HEAD (refers to branch 'master')
                |
                v
    a --- b --- c  branch 'master' (refers to commit 'c')
    ```

    ```bash
    # switch to the master branch
    git checkout master

    # reverts to two revision back
    git checkout master~2

    # delete file in the workspace
    rm -f <file-name>

    # restore <file-name> from the staging area
    git checkout <file-name>

    # push to the remote repository
    git push -f origin master
    ```

    OR we can use the below way:

    ```bash
    git checkout master

    # In git, -- before the file tells git that all the next arguments should be interpreted as filenames,
    # not as branch-names or anything else.
    git checkout <commit-id> -- <file-name>
    ```

<br>

## Wrapping up

- To use above commands effectively, we need to think about what object that we cope with, and then action for it.

<br>

Refer:

[https://dodangquan.blogspot.com/2017/11/tim-kiem-voi-git.html](https://dodangquan.blogspot.com/2017/11/tim-kiem-voi-git.html)