---
layout: post
title: Some useful commands with repository in Git
bigimg: /img/image-header/unsplash.jpeg
tags: [Git]
---



<br>

## Table of Contents
- [Create a new repository](#create-a-new-repository)
- [Remove the remote repository](#remove-the-remote-repository)
- [Add the new remote repository](#add-the-new-remote-repository)
- [Wrapping up](#wrapping-up)


<br>

## Create a new repository

Belows are steps that we will create a new repository.
1. Create a new folder that contains our project

2. In this folder, typing **git init** command

    ```bash
    # create an empty repository with .git folder to manage everything in this folder
    git init
    ```

3. Create our new things and push them to the local repository

    ```bash
    git add .

    git commit -m "message"
    ```

    If we don't want to track some files, create **.gitignore** file.

4. Finally, we will connect the local repository with our Gitlab or Github

    - In the Gitlab or Github, create our new repository.

    - Then, in our working space, we will add the remote repository's url in the loal configuration

        ```bash
        git remote add origin <remote-repository-url>

        git push -u origin master
        ```

<br>

## Remove the remote repository

```bash
# syntax
git remote rm <repository-name>

# for example
git remote rm sample-repo
```

<br>

## Add the new remote repository

```bash
git remote add <name_of_repository> url
```

url: means the path that points to repo, the tail of url is **.git**.

To check this remote whether it makes or not, use the syntax:

```bash
git remote
git remote -v
```

When to use:
- when we want to merge a repository's branches to the other repository's branches.

<br>

## Wrapping up

- Understanding what we will intend to do with Git.
