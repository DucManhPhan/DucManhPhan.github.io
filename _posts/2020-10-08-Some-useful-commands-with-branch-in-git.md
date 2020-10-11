---
layout: post
title: Some useful commands with branch in Git
bigimg: /img/image-header/unsplash.jpeg
tags: [Git]
---



<br>

## Table of Contents
- [Understanding about branch in git](#understanding-about-branch-in-git)
- [Create a new brach](#create-a-new-branch)
- [Clone single branch](#clone-single-branch)
- [Pull/Update data from branches](#pull/update-data-from-branches)
- [Rename a branch's name](#rename-a-branch's-name)
- [Delete a branch](#delete-a-branch)
- [Merge branches](#merge-branches)
- [Find all changes in a branch](#find-all-changes-in-a-branch)

<br>

## Understanding about branch in git

Belows are some concepts that we want to take care:
- **origin** is a remote.
- **master** is a local branch.
- **origin/master** is a remote branch (which is a local copy of the branch named **master** on the remote named **origin**).


<br>

## Create a new brach

1. In the same repository

    ```bash
    # first way: use git checkout
    git checkout -b <new-branch-name>     // --> create new branch and switch to it

    # second way: use git branch
    git checkout master // --> create new branch from master branch
    git branch <new_branch_name>  // --> we are in master branch
    git checkout <new-branch-name>

    git push -u origin <new-branch-name>
    ```

2. Push a branch of a repository to the other repository

    - Given problem

        Sometimes, we need to change our current repository to the new repository. Then, we need to move all branches in the old repository to the new repository.

    - Solution

        Belows are some steps that we need to follow:
        - Add the new repository

            ```bash
            git remote add <new-repository-name> <link-new-repository>

            # example
            git remote add new-repository http://gitlab.com/new-project.git
            ```

        - Update local with new repository

            ```bash
            git fetch <new-repository-name>
            ```
        
        - Check all current branches

            ```bash
            git branch -a
            ```

        - To push a branch into the new repository, we need to switch to that branch.

            ```bash
            git checkout <repository-name>/<branch-name>
            ```

        - Then, in order to push the current branch to the new repository, we do some following commands.

            ```bash
            git push -u <new-repository-name> <new-branch-name>
            ```

<br>

## Clone single branch

```bash
git clone -b <branch-name> --single-branch <>

# OR

git clone -b R<branch-name> --single-branch <>
```


<br>

## Pull/Update data from branches

1. Update all branches in the local repository from the remote repository

    ```bash
    git fetch orgin
    ```

2. Update origin/master branch with our branch that is separated from local/master branch

    This section will refer from [How to undo (almost) anything with Git](https://github.blog/2015-06-08-how-to-undo-almost-anything-with-git/).

    Problem: We have created a new branch **feature** from **master** branch, but **master** branch was pretty far behind **origin/master**. Now that **master** branch is in sync with **origin/master**, we wish commits on **feature** were starting now, instead of being so far behind.

    ```bash
    git checkout feature
    git rebase master
    ```

3. Update braches in local repository when any branches were deleted in the remote repository

    - Problem

        Sometimes, in our project, we create a new merge request. Git always has an option that it will delete our feature branch after successfully merging. The problem is that in the remote repository, these branches removed but in the local repository, the corresponding branches does not.

    - Solution

        ```bash
        # list all branches in the local repository
        git branch -a

        # To remove remote tracking branches for deleted branches, we need to issue:
        git remote prune origin

        # If we just want to list such stale branches (and not remove them), use this:
        git remote prune origin --dry-run

        # But using the above commands, we only delete the remote braches that has tracked in local repository, we do not delete the branches that used in the local repository.
        # To delete these branches, we can use the following commands:
        git branch --merged >/tmp/merged-branches && \
        vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches
        ```

        But the above command will delete both master branch in the local repository. If we do not want to do that, we have two solutions for this case:
        - Use **git branch -d** for specific branches.
        - Just use grep to exclude master:

            ```bash
            git branch --merged | grep -v "master" >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches 
            ```

<br>

## Rename a branch's name

Sometimes, we have some mistake about the rule when naming a branch. Then, we need to change the branch's name by creating a new branch. It takes our effort and time.

Below is a command that we need in this situation.

```bash
# change the name of branch in local repository
git branch -m <new-name>

# push this change to the remote repository
git push <remote-name> :<old-name> <new-name>
```

<br>

## Delete a branch

1. In a local repository

    ```bash
    git branch -d <branch-name>
    ```

2. In the remote repository

    ```bash
    git push origin --delete remote-branch-name
    ```

3. Using pattern

    ```bash
    git branch --list 'pattern*' | sed 's/^* //' | xargs -r git branch -D
    ```

4. Rebuild a branch that has just been deleted

    ```bash
    git reflog

    # select commit-id that we want
    # syntax: git branch <branch-name> <commit-id>
    git branch feature HEAD@{2}
    ```

<br>

## Merge branches

1. Using git merge command

    To update the **feature** branch from the **master** branch, we will use **git merge** command.

    ```bash
    # switch to the feature branch
    git checkout <feature-branch>

    # merge master into feature-branch
    git merge master
    ```

    How git merge works:
    - Firstly, git merge will find the common base commit between commits.
    - Then, it will create a new **merge commit** that combines multiple sequences of commits of the feature branch into one unify history.

    The drawbacks of git merge command:
    - Supposed that we have a git flow like the below:

        ```bash
        # the starting git flow
        a --- b --- c --- d --- e (master branch refer to the commit e)
        |
        x
         \
          y --- z (HEAD refers commit z of the feature branch)
        
        git checkout master

        # use git merge command
        git merge feature

        # result
                                   (HEAD refers to the new commit f of the feature branch)
                                     |
                                     v
        a --- b --- c --- d --- e -- f (master branch refer to the new commit f)
        |                          /    
        x                         /
         \                       /
          y --- z --------------  
        ```

        From the above images, we can find that:
        - When creating a merge commit, Git will attempt to auto magically merge the seperate histories.

    To refer the detail of git merge command, read the article [https://www.atlassian.com/git/tutorials/using-branches/git-merge](https://www.atlassian.com/git/tutorials/using-branches/git-merge).


2. When merging branches, there are multiple conflicts

    To search all conflicts, we can use the below commands:

    ```bash
    grep -H -r "<<<"
    grep -H -r ">>>"
    grep -H -r '^=======$' *
    ```

<br>

## Find all changes in a branch

```bash
# Check the all changes in a file, between current state and a branch
git diff branch_name path-to-file

# See differences between two commit 
git diff COMMIT_ID_1 COMMIT_ID_2

# See the files that changed between two commit
git diff --name-only COMMIT_ID_1 COMMIT_ID_2

# See the files changed in a specific commit
git diff-tree --no-commit-id --name-only -r COMMIT_ID

# or 

git show --pretty="format:" --name-only COMMIT_ID

# See diff with only the changed lines (no context)
git diff --unified=0

# See details (log message, text diff) of a commit
git show COMMIT_ID

# Count the number of commits
git rev-list HEAD --count
git rev-list COMMIT_ID --count
```
