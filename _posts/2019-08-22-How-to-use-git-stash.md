---
layout: post
title: How to use git stash
bigimg: /img/image-header/unsplash.jpg
tags: [Git]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with git stash](#solution-with-git-stash)
- [List all stashes](#list-all-stashes)
- [Check the changes before applied a stash](#check-the-changes-before-applied-a-stash)
- [Insert a stash](#insert-a-stash)
- [Remove a stash or all stashes](#remove-a-stash-or-all-stashes)
- [Apply a stash into a branch](#apply-a-stash-into-a-branch)
- [Move a stash into a new branch](#move-a-stash-into-a-new-branch)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Assuming that we are working with some changes in a specific feature branch, but we do not complete this task. Suddenly, there is a critical bug that we need to fix immediately. If we use ```git checkout``` command to switch to a hot-fix branch, these changes will take to that branch. It is not good way to deal with it. Because we have to remember these changed files to take that feature branch again.

So, how do we overcome it?

<br>

## Solution with git stash

1. How git stash works

    Git stash is used to save our changes in one place. The data structure for this way is stack. The top of stack is alway the latest changes that we have just pushed to the stack.

    To access the element of the stack, we can use syntax: ```stash@{n}```.

    This command will revert our workspace to match the ```HEAD``` commit.

2. Some useful operations of git stash

    Below are some operations of git stash that we need to know.
    - list all stash that we save

    - remove an item from the stack

    - insert these changes as a single stash

    - check the changes before applied a stash

    - apply a stash into a branch

<br>

## List all stashes

1. Syntax

    ```bash
    git stash list
    ```

    Some options:
    - **-p** or **--patch**

        list the changed contents of all stashes.

<br>

## Check the changes before applied a stash

1. Syntax

    ```bash
    git stash show <options> <stash-index>
    ```

    For example:

    ```bash
    git stash show stash@{1}
    ```


2. When to use

    - show the differences between the changes and the current branch.

<br>

## Insert a stash

1. Syntax

    ```bash
    # use push
    git stash push 

    # use save
    git stash save <our-messages>
    ```

    In reality, using **git stash push** is the same as **git stash**. We need to use **git stash push** because **git stash save** has been deprecated.

    Some important options for these commands:
    - **-u** or **--include-tracked**
    
        All untracked files are stashed and then cleaned up with **git clean**.

    - **-a** or **--all**
    
        All ignored and untracked files are also stashed and then cleaned up with **git clean**.

    ![](../img/Git-guide/stash/un-tracked-file-stash.svg)

2. When to use

    - When we want to save the local modifications to a new stash and turn the current branch into **HEAD** commit.

<br>

## Remove a stash or all stashes

1. Syntax

    ```bash
    # remove a stash, then apply it into the current branch
    git stash pop <stash-index>

    # only remove a stash
    git stash drop <stash-index>

    # remove all stash
    git stash clear
    ```

    For example:

    ```bash
    git stash drop stash@{1}

    git stash pop stash@{0}
    ```

    If we do not specify the stash, the **git stash drop** command will remove the last stash, and **git stash pop** command will remove the latest stash.

2. When to use

    - Using **git stash pop** command when we do not want this stash in stack, and it will apply into the current branch.

    - Using **git stash clear** command when deleting all stashes.

<br>

## Apply a stash into a branch

1. Syntax

    ```bash
    git stash apply <stash-index>
    ```

    For example:

    ```bash
    git stash apply stash@{1}
    ```

2. When to use

    - When we only want to apply a stash into our current branch but do not remove it from a stack.

<br>

## Move a stash into a new branch

1. Syntax

    ```bash
    git stash branch <new-branch-name> <stash-index>
    ```

    For example:

    ```bash
    git stash branch new-feature-branch stash@{1}
    ```

2. When to use

    - When we apply a stash into a branch, we find that there are some conflicts. To do not make influence that branch, we create and switch to a new branch, and merge that stash into this new branch.

<br>

## Wrapping up

- Understanding how and when to use stash.

<br>

Refer:

[https://git-scm.com/docs/git-stash](https://git-scm.com/docs/git-stash)

[https://www.freecodecamp.org/news/useful-tricks-you-might-not-know-about-git-stash-e8a9490f0a1a/](https://www.freecodecamp.org/news/useful-tricks-you-might-not-know-about-git-stash-e8a9490f0a1a/)

[https://www.atlassian.com/git/tutorials/saving-changes/git-stash](https://www.atlassian.com/git/tutorials/saving-changes/git-stash)