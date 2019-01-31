---
layout: post
title: Common commands in git
bigimg: /img/image-header/home-office-1.jpg
tags: [git]
---

Assumed that we have a Football repository with three branches, it includes master, Ronaldo and Messi branches. So, in this article, we will learn how to implement with Football repository; master, Ronaldo and Messi branches.

## Table of Contents
- [Get Football repository for firt time](#get-football-repository-for-first-time)
- [Push data to master branch](#push-data-to-master-branch)
- [Clone repository from other branch directly](#clone-repository-from-other-branch-directly)
- [Pull code from other branch](#pull-code-from-other-branch)
- [Push code to other branch](#push-code-to-other-branch)
- [Delete file/folder](#delete-file/folder)


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

