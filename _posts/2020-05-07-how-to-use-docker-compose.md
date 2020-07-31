---
layout: post
title: How to use Docker Compose
bigimg: /img/image-header/yourself.jpeg
tags: [Docker]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Docker Compose](#solution-with-docker-compose)
- [How to create docker-compose.yaml file](#how-to-create-docker-compose.yaml-file)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Before going to this article, we can read up on the article [Understanding about Docker](https://ducmanhphan.github.io/2020-05-07-understanding-about-docker/). In that article, we can learn about how to run an image an a container.

But if in our project, we have multiple softwares or multiple images, then when we deploy our application, we need to deploy sequentially each container. It takes so much our time and effort. To reduce the hard working time, we can use docker-compose.

So, how docker-compose work?

<br>

## Solution with Docker Compose

To manage all containers that we want to run through Docker, we will define docker-compose.yaml file. It will contains definition of all images that we want to use such as image name, container name when it run, ports, ...

After defining docker-compose.yaml file completely, we will use docker-compose tool to read that file and deploy them.

1. Setup docker compose tool

    - In Windows OS, by default, when we install Docker, docker compose tool will also be installed.

    - In Ubuntu OS, Docker and Docker compose will be installed seperately.

        Belows are some steps that install docker compose tool.
        - Check the current version of docker-compose: 
            
            ```java
            sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o / usr / local / bin / docker-compose
            ```
        
        - Set the permissions: 
            
            ```java
            sudo chmod + x / usr / local / bin / docker-compose
            ```

        - Verify whether docker compose is installed successfully: 

            ```java
            docker-compose --version
            ```

2. How Docker Compose tool works

    - First, this tool will build an image from the source code or pull an image from Docker Hub.
    - Then, run them as containers with ports, environment variables, ... that are configured in docker-compose.yaml file.

<br>

## How to create docker-compose.yaml file

Before creating **docker-compose.yaml** file, we need to understand some parameters that will be used in it.
1. verison

    The current version of docker-compose that we are using.

2. services

    All the containers that we want to utilize.

3. image

    Images will be used when creating containers.

4. build

    This option will be used to build an image from the source code by reading its DockerFile, then run as a container.

5. ports

    It is used to define the port of host and port of container.

    For example:

    ```yaml
    ports:
        - 3306:3306
    ```

6. restart

    When a container was turned off, immediately it will be started.

7. environment

    This parameter will define multiple environment variables for our container.

8. depends_on

    It points to the dependence between services. For example, before a service can be run, it need other services to run.

9. volumnes

    They are physical areas of disk space shared between the host and a container, or even between containers. So, volumne is a shared directory in the host visible from some or all containers.

    It will exchange two folders in host and container.

10. container_name

    It points the name for our container.

11. networks

    It defines the communication rules between containers, and between a container and a host. Common network zones will make containers' services discoverable by each other, while private zones will segregate them in virtual sandboxes.

    It means that we only need to define the name for networks that will be used to communicate between multiple containers, or define the private network for one container.

    ```yaml
    version: '3.0'

    services:
        service_a:
            image: image_service_a
            networks:
                - shared_networks

        service_b:
            image: image_service_b
            networks:
                - shared_networks

        service_c:
            image: image_service_c
            networks:
                - private_networks

    networks:
        shared_networks: {}
        private_networks: {}
    ```

12. expose

    It will document the host port.

So, to run docker-compose.yaml file, we can run a below command line.

```python
# running docker-compose file
docker-compose up

# running containers in detach mode or background
docker-compose up -d

# stop containers
docker-compose stop

# list all enviroment variables in a specific container
docker-compose run <container_name> env

# remove all containers in docker
docker-compose down --volumes
```

<br>

## Wrapping up

- Understanding about the intention of docker-compose tool and some commands that we can use to deploy our application.


<br>

Refer:

[https://www.baeldung.com/docker-compose](https://www.baeldung.com/docker-compose)

[https://kipalog.com/posts/Gioi-thieu-ve-Docker-Compose](https://kipalog.com/posts/Gioi-thieu-ve-Docker-Compose)

[https://viblo.asia/p/docker-compose-la-gi-kien-thuc-co-ban-ve-docker-compose-1VgZv8d75Aw](https://viblo.asia/p/docker-compose-la-gi-kien-thuc-co-ban-ve-docker-compose-1VgZv8d75Aw)

[https://viblo.asia/p/docker-chua-biet-gi-den-biet-dung-phan-1-lich-su-ByEZkWrEZQ0](https://viblo.asia/p/docker-chua-biet-gi-den-biet-dung-phan-1-lich-su-ByEZkWrEZQ0)

[https://viblo.asia/p/docker-vs-docker-compose-RnB5pXGd5PG](https://viblo.asia/p/docker-vs-docker-compose-RnB5pXGd5PG)

[https://docs.docker.com/compose/extends/](https://docs.docker.com/compose/extends/)

[https://techtalk.vn/lam-quen-voi-docker-compose.html](https://techtalk.vn/lam-quen-voi-docker-compose.html)