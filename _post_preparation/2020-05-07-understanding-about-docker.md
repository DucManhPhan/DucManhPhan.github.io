---
layout: post
title: Understanding about Docker
bigimg: /img/image-header/yourself.jpeg
tags: [Docker]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Introduction to Docker](#introduction-to-docker)
- [How to setup Docker](#how-to-setup-docker)
- [Some commands in Docker CLI](#some-commands-in-docker-cli)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Before Docker was born, we usually use Virtual Machine software such as VMWare, Virtual Box, ... But to use it, we need to install the Operating System that we want to simulate the webserver's environment that we want to use. 

Then, we have to install softwares that we really need in out project. Installing these softwares takes so much our time. 

Supposed that we had the environment that we want, but our softwares that has multiple versions, different environment variables to configure. They can conflict together. It is the worst thing that we do not want to touch.

How do we overcome these problems?

<br>

## Introduction to Docker

1. History of Docker



2. Some concepts in Docker




3. The architecture of Docker





<br>

## How to setup Docker

1. In Windows




2. In Ubuntu



<br>

## Some commands in Docker CLI

1. List all images that are downloaded from Docker Hub

    ```python
    # 1st way
    docker image ls

    # 2nd way
    docker images
    ```

2. List all containers that are running in Docker engine

    ```python
    # 1st way
    docker ps

    # 2nd way
    docker container ls --all

    # call help
    docker container --help

    docker container ls --help
    ```

3. Pull an image from Docker Hub and run a container

    ```python
    docker run <image_name>

    # call help
    docker run --help
    ```

    For example, below is a command that pull ngix webserver from DockerHub and run it as a container.

    ```python
    docker run --detach --publish 80:80 --name webserver ngix
    ```

    The meaning of options in an above command:
    - ```--detach``` or ```-d```

        In Docker, there are two mode:
        - the background mode or a detach mode
        - the default foreground mode

        If we use **--detach** or **-d** option, it means that we want this container run in a detached mode.

    - ```--expose```

        Using this flag is a way of documenting which ports are used, but does not actually map or open any ports. Exposing ports is optional.

    - ```--publish``` or ```-p```

        By default, when you create a container, it does not publish any of its ports to the outside world. To connect to the outside, we use ```-p``` option.

        This option means that mapping a **host port** to a running **container port**.

        For example:

        ```python
        docker run -d -p <host_port>:<container_port> --name webserver ngix
        ```

    - ```--name```

        Assign a name for this container. If we do not use a name for a container, Docker will generate a random string name for a container.

    - ```-rm```
        
        Using this option will remove our container when it exits.

    To know more about this run command, we can refer this Docker's article [https://docs.docker.com/engine/reference/commandline/run/](https://docs.docker.com/engine/reference/commandline/run/).

4. Stop a container

    ```python
    docker container stop <container_name>
    ```


5. To check version of Docker Client/Server

    ```python
    # Only check version without the detailed information
    docker --version

    # verbose information about Docker Client/Server
    docker version
    ```

6. Pull an image from Docker Hub

    ```python
    docker pull <image_name>
    ```

7. Remove an image

    ```python
    # Use image_id to specify which image to delete
    docker rmi <image_id>

    # Use the repository's name that combines with the tag
    docker rmi <repository_name>:<tag>
    ```

    For example:

    ```python
    # Use -f flat to forcely remove an image
    docker rmi -f fd484f19954f

    docker rmi test:latest
    ```

8. List all containers with some specific states

    ```python
    # all shutdowned containers
    docker ps -a

    # show all shutdowned containers with only numeric IDs
    docker -ps -a -q

    # show containers with disk usage
    docker ps --size

    # filter some containers with key=value pair
    docker ps --filter 'exited=0'
    ```

9. Run a container

    ```python
    docker start <container_name>
    ```

10. Restart a container

    ```python
    docker restart <container_name>
    ```

11. Build an image from DockerFile

    ```python
    docker build --file <dockerfile_name> .
    ```

<br>

## Wrapping up




<br>

Refer:

[https://medium.com/edumall/vi%E1%BA%BFt-dockerfile-hi%E1%BB%87u-qu%E1%BA%A3-77a6603b8f8](https://medium.com/edumall/vi%E1%BA%BFt-dockerfile-hi%E1%BB%87u-qu%E1%BA%A3-77a6603b8f8)

[https://viblo.asia/p/docker-nhung-kien-thuc-co-ban-phan-1-bJzKmM1kK9N](https://viblo.asia/p/docker-nhung-kien-thuc-co-ban-phan-1-bJzKmM1kK9N)