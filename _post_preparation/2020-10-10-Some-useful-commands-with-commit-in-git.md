---
layout: post
title: Some useful commands with commit in Git
bigimg: /img/image-header/unsplash.jpg
tags: [Git]
---



<br>

## Table of Contents
- [Given problem](#given-problem)
- [The structure of Git](#the-structure-of-git)
- [Push commits to the remote branch](#push-commits-to-the-remote-branch)
- [Take a commit from a branch to the other branch](#take-a-commit-from-a-branch-to-the-other-branch)
- [Revert commits of a branch](#revert-commits-of-a-branch)
- [Remove a commit](#remove-a-commit)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Normally, when working with Git, the local modifications will be staged or indexed. Then they will be considered as a commit with a specific version - SHA1 in the local repository. To synchronize between the local repository and the remote repository, we need to use **git push** command.

But there are some cases that we want to do with these commits such as revert or undo our actions, recommend the already commits, ...

How do we deal with it?

<br>

## The structure of Git

Before going straight forward to our problems, we will look at an image that describe the flows of Git.

![](../img/Git-guide/commit/commit-flows.png)

So, belows are actions of **git commit** command.
- Using **git add** command to index all untracked or modified files before using **git commit** command.

- Syntax

    ```bash
    git commit <options>
    ```

    The meaning of some options:
    - **-a** ot **--all**: automatically stage files that have been modified or deleted. It does not affect to the new files.

    - **-C <commit>** or **--reuse-message=<commit>**: use the message of the specific commit.

    - **-c <commit>** or **--reedit-message=<commit>**: edit the commit message by using editor.

    - **-m** or **--message=<msg>**: define a message for our commit.

    - **--allow-empty-message**: when using script files with git, we can use this option.

    - **--amend**: it will modify the last commit by adding the current changes to it.

        ```bash
        git commit --amend
        ```

<br>

## Push commits to the remote branch

1. To the remote branch that has already existed

    ```bash
    # if we are in the local branch that is correpsonding the remote branch
    git push
    ```

2. To the new branch that hasn't already existed in remote repository

    ```bash
    git push -u origin <branch-name>
    ```

    **-u** means **--set-upstream**.

<br>

## Take a commit from a branch to the other branch

In order to solve our problem, use **git cherry-pick** command. Belows are some cases that we usually encounter.

- Pick a commit from a branch to master branch

    ```bash
    git checkout master

    # 1st - get the previous commit of HEAD pointer of <branch-name>
    git cherry-pick <branch-name>~1

    # 2nd - specify the hash code of the commit that we want
    git cherry-pick <commit>
    ```

- Pick n commits from a branch to master branch

    ```bash
    git checkout master

    # specify many commits
    git cherry-pick <commit1> <commit2>

    # specify from commit 1 to commit n by using ... symbol
    # commit1 will not be included to the other branch
    git cherry-pick <commit1>...<commitn> 

    # to reduce the limitation of an above statement.
    git cherry-pick <commit1>^..<commitn>
    ```

3. Pick a commit to the two branches

    ```bash
    # assuming that we have some changes in branch 1
    git add .
    git commit -m "This is commit of branch 1"

    # switch to the branch 2 that we want to apply the latest commit of branch 1
    git checkout branch-2
    git cherry-pick branch-1
    ```

<br>

## Revert commits of a branch

1. Using git reset command



2. Using git checkout command



3. Using git revert command


    - Revert initial git commit

        ```bash
        git update-ref -d HEAD
        ```


<br>

## Remove a commit

1. Using git rm command

    ```bash
    git rm 
    ```

2. Using git reset command

    ```bash
    # revert to HEAD pointer will get rid of work in progress,
    # it will erase all the changes in our working tree and index.
    git reset --hard HEAD

    # revert to the previous commit of HEAD
    git reset --hard HEAD~1

    # or if we want to revert to the specific commit
    git reset --hard <commit>

    # finally, synchronize with the remote repository
    git push origin HEAD --force
    ```


<br>

## 





<br>

## 





<br>

## Wrapping up





<br>

Refer:

[https://kipalog.com/posts/Undo--mot-commit-trong-git-tree](https://kipalog.com/posts/Undo--mot-commit-trong-git-tree)

[https://quantrimang.com/hoat-dong-update-trong-git-157692](https://quantrimang.com/hoat-dong-update-trong-git-157692)

[https://medium.com/@nguynthanhhip/m%E1%BB%99t-s%E1%BB%91-c%C3%A2u-l%E1%BB%87nh-git-ph%E1%BB%95-bi%E1%BA%BFn-b5d5f63b7ddc](https://medium.com/@nguynthanhhip/m%E1%BB%99t-s%E1%BB%91-c%C3%A2u-l%E1%BB%87nh-git-ph%E1%BB%95-bi%E1%BA%BFn-b5d5f63b7ddc)

[https://quantrimang.com/hoat-dong-update-trong-git-157692](https://quantrimang.com/hoat-dong-update-trong-git-157692)

[https://dodangquan.blogspot.com/2019/01/revert-initial-git-commit.html](https://dodangquan.blogspot.com/2019/01/revert-initial-git-commit.html)

[https://dodangquan.blogspot.com/2018/10/git-delete-branch-by-pattern.html](https://dodangquan.blogspot.com/2018/10/git-delete-branch-by-pattern.html)

[https://www.programmersought.com/article/60051711556/](https://www.programmersought.com/article/60051711556/)

[https://viblo.asia/p/git-nang-cao-git-cherry-pick-RQqKLQ9pZ7z](https://viblo.asia/p/git-nang-cao-git-cherry-pick-RQqKLQ9pZ7z)