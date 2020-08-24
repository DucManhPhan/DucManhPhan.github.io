---
layout: post
title: Common commands in git
bigimg: /img/image-header/home-office-1.jpg
tags: [Git]
---

Assumed that we have a Football repository with three branches, it includes master, Ronaldo and Messi branches. So, in this article, we will learn how to implement with Football repository; master, Ronaldo and Messi branches.

<br>

## Table of Contents
- [Get Football repository for firt time](#get-football-repository-for-first-time)
- [Push data to master branch](#push-data-to-master-branch)
- [Clone repository from other branch directly](#clone-repository-from-other-branch-directly)
- [Pull code from other branch](#pull-code-from-other-branch)
- [Push code to other branch](#push-code-to-other-branch)
- [Delete file/folder](#delete-file/folder)
- [Configure user's information at the first time](#configure-user's-information-at-the-first-time)
- [Solution for common error](#solution-for-common-error)
- [Revert to previous state](#revert-to-previous-state)
- [Remove remote repository](#remove-remote-repository)
- [Add remote repository](#add-remote-repository)

<br>

## Understanding structure of GIT

The following image describe the working of Git command

![GIT command](../img/Git-guide/structure-of-git-command.png)

<br>

## Get Football repository for firt time
In order to get this repository, we will use command:

```
git clone https://github.com/manhpd/Football.git
```

So, when the above command is completely finished, we have a directory with name - Football.

Now, we have to clone this repository from gitlab. Therefore, we will must insert username and password into your git link.

```
git clone https://username:password@github.com:1080/manhpd/Football.git
```

<br>

## Push data to master branch
Before pushing data, we have to identify all modified files in our local repository, and added files/folders.

```
git status
```

Next, we will choose some files/directory that we need to push to master branch, or choose all files/folders.

```
git add name_file_Or_name_folder

Or

git add *
```

Then, we will push our data to repository at local.

```
git commit -m "comment for this operations"
```

Finally, we will push data to master branch.

```
git push origin master
```

<br>

## Clone repository from other branch directly

```
git clone -b Ronaldo --single-branch https://github.com/manhpd/Football.git

Or

git clone -b Ronaldo --single-branch https://username:password@github.com:1080/manhpd/Football.git

```

With Git 1.7.10 and later, add --single-branch to prevent fetching of all branches.

--> We should clone master branch because all other branches is created from master branch. So, we will easily switch to the other branches to work on them.

<br>

## Pull code from other branch
If we want to pull code from Ronaldo branch, so we can implement to follow some steps:
- jump into a branch that we want.

    ```
    git checkout -b Ronaldo
    ```

- pull code

    ```
    git pull origin Ronaldo
    ```

<br>

## Push code to other branch
- Go to Ronaldo branch.

  - git checkout -b Ronaldo

- Push code

  - git status
  - git add *
  - git commit -m "comments"
  - git push --set-upstream origin Ronaldo

We can replace ```--set-upstream``` with ```-u```.

<br>

## Delete file/folder
In Footbal repository at local, we have a ```sample``` folder. Now, we want to delete this folder.

```
git rm -rf sample
git commit -m "remove duplicate folder"
git push origin master/Ronaldo/Messi
```

Of if we want to delete folder in git but no local

```
git rm -r --cached sample
```

```-r``` means ```recursive```, git will be recursive the sample folder to delete all files or folders in sample folder.
```-f``` means ```force```.

<br>

## Configure user's information at the first time

```
git config --global user.name "Your_Name"
git config --global user.email "Your_email"
```

<br>

## Solution for common error
When you cope with the error which something like that:
"Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. 
Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue."

Solution: 

try deleting ```index.lock``` file in your .git directory.

Generally such problems occurs when you execute two git commands simultaneously maybe one from command prompt and one from IDE.

Or 

Other solution: Try with this:

```
rm -f ./.git/index.lock
```

Note: Such problems may occur when you execute two git commands simultaneously maybe one from command prompt and one from IDE. So deleting ```.lock``` file in your ```.git``` directory can work.

Or 

Other solution: Use the below command in the root directory of the application. 

This will delete the index.lock file and release the active lock.

```
rm .git/index.lock
```

<br>

## Revert to previous state
When you do something wrong in files or folders in the "Local directory".
You can revert the previous state by using the following way:

Syntax:

```git checkout -- the_name_of_folder_or_file```

--> This statement will replace the changes in the working "tree" with the newest data in HEAD (Remote machine).

If you want to take off the changes and the local commit in "Local Directory", 
and get the latest history from remote machine, point to the local master branch. 

Syntax: 

```
git fetch origin
git reset --hard origin/master
```

<br>

## Remove remote repository
We have to be in this repository by git.

Syntax:

```
git remote rm repository_name
```

Ex: Delete "Data structure" repository.

```
git remote rm Data-structure
```

<br>

## Add remote repository

```
git remote add name_of_repository url
```

url: means the path that points to repo, the tail of url is ".git"

Ex: git remote add Website https://github.com/manhpd/Data-Structure.git

To check this remote whether it makes or not, use the syntax:

    git remote

or 

    git remote -v

<br>

## Merge parent branch into child branch




<br>

## Rewrite the previous commit message
When we want to rewrite the message in the previous commit, we can do something like that:

```
git commit -v --amend
```

<br>

## Update braches in local repository when any branches were deleted in the remote repository

1. Given problem

    Gitlab has a functionality that it will remove a branch when this branch is merged to the other branches.

    But when we check branches in local repository by typing:

    ```
    git branch -a
    ```

    It will list all branches that we interact that include some branches that is deleted in the remote repository.

2. Solution

    To remove remote tracking branches for deleted branches, we need to issue:

    ```
    git remote prune origin
    ```

    If we just want to list such stale branches (and not remove them), use this:

    ```
    git remote prune origin --dry-run
    ```

<br>

Thanks for your reading.

Refer:

[https://github.com/git-tips/tips#list-all-the-conflicted-files](https://github.com/git-tips/tips#list-all-the-conflicted-files)