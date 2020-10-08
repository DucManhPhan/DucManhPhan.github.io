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

```bash
# first way: use git checkout
git checkout -b new_branch_name     // --> create new branch and switch to it

# second way: use git branch
git checkout master // --> create new branch from master branch
git branch new_branch_name  // --> we are in master branch
git checkout new_branch_name
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

    Problem: We have created a new branch feature from master branch, but master branch was pretty far behind origin/master. Now that master branch is in sync with origin/master, we wish commits on feature were starting now, instead of being so far behind.

    ```bash
    git checkout feature
    git rebase master
    ```

    **git rebase master** does a couple of things:
    - First it locates the common ancestor between your currently-checked-out branch and master.
    - Then it resets the currently-checked-out branch to that ancestor, holding all later commits in a temporary holding area.
    - Then it advances the currently-checked-out-branch to the end of master and replays the commits from the holding area after master�s last commit.

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

<br>

Refer:

[]()

[]()

[]()
