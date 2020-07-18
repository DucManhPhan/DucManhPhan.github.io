---
layout: post
title: How to build an image from DockerFile
bigimg: /img/image-header/yourself.jpeg
tags: [Docker]
---



<br>

## Table of contents
- [Introduction to DockerFile](#introduction-to-dockerfile)
- [Common commands in DockerFile](#common-commands-in-dockerfile)
- [Create an easy DockerFile](#create-an-easy-dockerfile)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to DockerFile






<br>

## Common commands in DockerFile

1. **FROM** command

    This command is used in the head line of DockerFile. It is used to setup a base image to make an environment for our current image.

    FROM command can be utilized multiple times to create multiple images.

    Syntax:

    ```python
    # 1st version
    FROM <image>

    # 2nd version
    FROM <image>:<tag>

    # 3rd version
    FROM <image>@<digest>
    ```

    We can do not specify the tag, Docker will download the latest version of this image.

    For example:

    ```python
    # use ubuntu as os to setup our image
    # parent image
    FROM ubuntu:18.04

    # base image
    FROM scratch
    ```

    Most DockerFiles start from a parent image. If we want to completely control the contents of our image, we might need to create a base image instead.

2. **MAINTAINER** command

    This command will set the author's name for building this image.

    Syntax:

    ```python
    MAINTAINER <name>
    ```

    For example:

    ```python
    MAINTAINER manhpd
    ```

3. **RUN** command

    This command will be run within the container at build time.

    Syntax:

    ```python
    # 1st version
    RUN <command>

    # 2nd version
    RUN ["<executable>", "<param1>", "<param2>"]
    ```


4. **ADD** command

    This command will copy new files, directories in **host machine**, or remote file URLs from **<src>** and adds them to the filesystem of the **image** at the path **<dest>**.

    Syntax:

    ```python
    # 1st version
    ADD <src> [<src> ...] <dest>

    # 2nd version
    ADD ["<src>", ... "<dest>"]
    ```

    The **<dest>** value is the absolute path. If we defined **WORKDIR** value, **<dest>** can be use the relative path with **WORKDIR** value.

5. **COPY** command

    It can copy a file (in the same directory as the DockerFile) to the container.

    Syntax:

    ```python
    COPY <src> [<src> ...] <dest>
    COPY ["<src>", ... "<dest>"]
    ```

    Conditions for **<dest>** is as same as **ADD** command.

6. **ENTRYPOINT** command

    If the **ENTRYPOINT** isn't specified, Docker will use **/bin/sh -c** as the default. However, if we want to override some of the system defaults, we can specify our own entrypoint and therefore manipulate the environment.


7. **ENV** command

    It will define some environment variables.

    Syntax:

    ```python
    ENV <key> <value>
    ENV <key>=<value> [<key>=<value> ...]
    ```

    For example:

    ```python
    ENV JAVA_HOME <path>
    ```

8. **WORKDIR** command

    It is used to set the working directory for **RUN**, **CMD**, **ENTRYPOINT**, **COPY** and **AND** need to follow.

    Syntax:

    ```python
    WORKDIR </path/to/workdir>
    ```

9. **EXPOSE** command

    This command has the functionality that is as same as the **--expose** option in **docker run** command.

    It is used to documented a port for this container.

    Syntax:

    ```python
    EXPOSE <port> [<port> ...]
    ```


10. **USER** command

    It sets the user name or UID to use when running the image and for any RUN, CMD and ENTRYPOINT instructions that follow it in the Dockerfile.

    Syntax:

    ```python
    USER <username | UID>
    ```

11. **VOLUMNE** command

    It is used to enable access from the container to a directory on the host machine.

    Syntax:

    ```python
    VOLUME ["<path>", ...]
    VOLUME <path> [<path> ...]
    ```

12. **ARG** command

    Syntax:

    ```python

    ```

13. **LABEL** command

    This command will add information to an image.

    Syntax:

    ```python
    LABEL <key>=<value> [<key>=<value> ...]
    ```

14. **CMD** command



    Syntax:

    ```python
    # 1st version - prefered version
    CMD ["<executable>","<param1>","<param2>"]

    # 2nd version
    CMD ["<param1>","<param2>"] #  (as default parameters to ENTRYPOINT)

    # 3rd version
    CMD <command> <param1> <param2> # (shell form)
    ```


<br>

## Create an easy DockerFile





<br>

## Why we need to use base image

https://www.youtube.com/watch?v=FaR1rwX4YfU


<br>

## Wrapping up




<br>

Refer:

[https://docs.docker.com/develop/develop-images/dockerfile_best-practices/](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

[https://medium.com/@phamducquan/docker-l%C3%A0-g%C3%AC-ki%E1%BA%BFn-th%E1%BB%A9c-c%C6%A1-b%E1%BA%A3n-v%E1%BB%81-docker-13c6efc4aefe](https://medium.com/@phamducquan/docker-l%C3%A0-g%C3%AC-ki%E1%BA%BFn-th%E1%BB%A9c-c%C6%A1-b%E1%BA%A3n-v%E1%BB%81-docker-13c6efc4aefe)

[https://kipalog.com/posts/Hieu-hon-ve-Dockerfile](https://kipalog.com/posts/Hieu-hon-ve-Dockerfile)

[https://thenewstack.io/docker-basics-how-to-use-dockerfiles/](https://thenewstack.io/docker-basics-how-to-use-dockerfiles/)

[https://kapeli.com/cheat_sheets/Dockerfile.docset/Contents/Resources/Documents/index](https://kapeli.com/cheat_sheets/Dockerfile.docset/Contents/Resources/Documents/index)

[https://viblo.asia/p/docker-nhung-kien-thuc-co-ban-phan-1-bJzKmM1kK9N](https://viblo.asia/p/docker-nhung-kien-thuc-co-ban-phan-1-bJzKmM1kK9N)

[https://phoenixnap.com/kb/docker-cmd-vs-entrypoint](https://phoenixnap.com/kb/docker-cmd-vs-entrypoint)