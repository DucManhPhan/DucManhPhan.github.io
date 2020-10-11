---
layout: post
title: Common problems with Git 
bigimg: /img/path.jpg
tags: [Git]
---

Git is powerful tool to manage source code in our project. But sometimes, we will cope with some problems in git such as do not pull files, conflict source code, ...

When having problems, it takes so much time to resolve them. So, in this article, we will bring common solutions for them.

<br>

## Table of contents
- [There is no tracking information for the current branch](#there-is-no-tracking-information-for-the-current-branch)
- [The following untracked working tree files would be overwritten by merge](#the-following-untracked-working-tree-files-would-be-overwritten-by-merge)
- [Updates were rejected because the tip of your current branch is behind its remote counter part](#updates-were-rejected-because-the-tip-of-your-current-branch-is-behind-its-remote-counter-part)
- [The file exceeds Github's file size limit of 100.00 MB](#the-file-exceeds-github's-file-size-limit-of-100.00-MB)
- [Run multiple git process](#run-multiple-git-processes)
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

<br>

## Updates were rejected because the tip of your current branch is behind its remote counter part
- Problem

    When we used the command ```git push origin master```, Git commandline will show the below error:

    ```
    Updates were rejected because the tip of your current branch is behind its remote counter part.
    ```

- Solution

    Use ```git pull --rebase```.


## The file exceeds Github's file size limit of 100.00 MB
- Problem:
    
    When we want to push a big file with size that is larger than 100.00 MB.

- Solution

    - First way: 

        ```
        git pull --rebase
        git push -f origin master
        ```

        If you have already made some commits, you can do the following

        ```git pull --rebase```

        This will place all your local commits on top of newly pulled changes.

        BE VERY CAREFUL WITH THIS: this will probably overwrite all your present files with the files as they are at the head of the branch in the remote repo! If this happens and you didn't want it to you can UNDO THIS CHANGE with

        ```git rebase --abort```

        ... naturally you have to do that before doing any new commits!


    - Second way:

        ```
        git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch FOLDERNAME" -- --all
        git push
        ```

        replace FOLDERNAME with the file or folder we wish to remove from the given git repository.

    - Third way:

        ```bash
        git rm --cached name_of_a_giant_file
        git rm --cached name_of_another_giant_file
        git commit --amend -CHEAD
        git push
        ```

    - Fourth way:

        Use [BFG Repo Cleaner](https://rtyley.github.io/bfg-repo-cleaner/).

<br>

## Run multiple git process

1. Given problem

    When you cope with the error which something like that:
    "Another git process seems to be running in this repository, e.g.
    an editor opened by 'git commit'. 
    Please make sure all processes
    are terminated then try again. If it still fails, a git process
    may have crashed in this repository earlier:
    remove the file manually to continue."

2. Solution

    Try deleting ```index.lock``` file in your ```.git``` directory.

    Generally such problems occurs when you execute two git commands simultaneously maybe one from command prompt and one from IDE. So deleting ```.lock``` file in your ```.git``` directory can work.

    ```bash
    rm -f ./.git/index.lock
    ```

<br>

## Wrapping up

- Understanding the problem that we want to apply our solution.

<br>

Thanks for your reading.

Refer:

[http://www.thisprogrammingthing.com/2013/fixing-the-this-exceeds-githubs-file-size-limit-of-100-mb-error/](http://www.thisprogrammingthing.com/2013/fixing-the-this-exceeds-githubs-file-size-limit-of-100-mb-error/)