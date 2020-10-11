---
layout: post
title: Some useful commands with configuration in Git
bigimg: /img/image-header/unsplash.jpeg
tags: [Git]
---



<br>

## Table of Contents
- [List all configuration](#list-all-configuration)
- [Remove a configuration in Git](#remove-a-configuration-in-git)
- [Show URL of the remote repository](#show-url-of-the-remote-repository)
- [Fill configuration to Git](#fill-configuration-to-git)
- [Configure certification to pass proxy](#configure-certification-to-pass-proxy)

<br>

## List all configuration

```bash
# In global
git config --global --list

# In local
git config --local --list
```

<br>

## Remove a configuration in Git

```bash
# Using --unset option
git config --unset <configuration-name>
```

For example:

```bash
git config --global --unset https.proxy
git config --global --unset http.proxy

git config --unset https.proxy
git config --unset https.proxy
```


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

    ```bash
    git remote set-url origin <link_git_project>
    ```

<br>

## Configure certification to pass proxy

```bash
git config --global http.proxy <host-proxy>:<port-proxy>

git config --global http.sslCAInfo <path-certification>
```
