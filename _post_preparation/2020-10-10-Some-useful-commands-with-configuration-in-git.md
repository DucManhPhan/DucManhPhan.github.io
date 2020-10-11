---
layout: post
title: Some useful commands with repository in Git
bigimg: /img/image-header/unsplash.jpg
tags: [Git]
---



<br>

## Table of Contents





<br>

## Given problem





<br>

## 






<br>

## Show URL of the remote repository

Problem: We want to check URL of our remote repository.

```bash
# first way
git config --get remote.origin.url

# 2nd way
git remote show origin
```

<br>

## Fill configuration to Git

1. Configure user's information at the first time

    ```bash
    git config --global user.name "our-name"

    git config --global user.email "our-email"
    ```

2. Reconfigure URL of git in local repository

    Assuming that we have a case that we changed the Git's URL. So, in local repository, how do we also change this url that do not have to pull it again?

    To solve this problem, we will type the following command:

    ```
    git remote set-url origin <link_git_project>
    ```

<br>

## Remove 





<br>

Refer:

[]()

[]()

[]()
