---
layout: post
title: Common problems with GIT
bigimg: /img/path.jpg
tags: [git]
---

Git is powerful tool to manage source code in our project. But sometimes, we will cope with some problems in git such as do not pull files, conflict source code, ...

When having problems, it takes so much time to resolve them. So, in this article, we will bring common solutions for them.

<br>

## Table of contents
- [There is no tracking information for the current branch](#there-is-no-tracking-information-for-the-current-branch)
- [The following untracked working tree files would be overwritten by merge](#the-following-untracked-working-tree-files-would-be-overwritten-by-merge)
- [Wrapping up](#wrapping-up)


<br>

## There is no tracking information for the current branch
- Problem: 

    ```
    There is no tracking information for the current branch.
        Please specify which branch you want to merge with.
        See git-pull(1) for details

        git pull <remote> <branch>

    If you wish to set tracking information for this branch you can do so with:

        git branch --set-upstream develop origin/<branch>
    ```

    This problem happens when we want to pull files from remote repository. But in our workspace, there are some files that is not indexed. 

- Solution:

    We could specify what branch we want to pull:

    ```
    git pull origin master
    ```

    Or we could set it up so that our local master branch tracks github master branch as an upstream:

    ```
    git branch --set-upstream-to=origin/<master-branch> <our-current-branch>
    git pull
    ```

    This branch tracking is set up for us automatically when we clone a repository (for the default branch only), but if we add a remote to an existing repository we have to set up the tracking ourself.

<br>

## The following untracked working tree files would be overwritten by merge
- Problem: 

    ```
    The following untracked working tree files would be overwritten by merge.
    ```

    When we use command ```git pull``` to update our workspace folder, but there are some files that is still untracking information.

- Solution: 

    The problem is that we are not tracking the files locally but identical files are tracked remotely.
    
    So in order to ```pull``` our system would be forced to overwrite the local files which are not version controlled.

    ```
    git add *
    git stash
    git pull
    ```

## The file exceeds Github's file size limit of 100.00 MB
- Problem:
    
    When we want to push a big file with size that is larger than 100.00 MB.

- Solution

    ```
    git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch pi/data/node-login.0'

    git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch pi/data/node-login.1'

    git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch pi/data/local.0'
    ```


<br>

## Wrapping up


<br>

Thanks for your reading.