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






<br>

## Solution with Docker Compose






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

    This option will be used to create container.

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

    It will exchange two folders in host and container.

10. container_name

    It points the name for our container.

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




<br>

Refer:

[https://kipalog.com/posts/Gioi-thieu-ve-Docker-Compose](https://kipalog.com/posts/Gioi-thieu-ve-Docker-Compose)

[https://viblo.asia/p/docker-compose-la-gi-kien-thuc-co-ban-ve-docker-compose-1VgZv8d75Aw](https://viblo.asia/p/docker-compose-la-gi-kien-thuc-co-ban-ve-docker-compose-1VgZv8d75Aw)

[https://viblo.asia/p/docker-chua-biet-gi-den-biet-dung-phan-1-lich-su-ByEZkWrEZQ0](https://viblo.asia/p/docker-chua-biet-gi-den-biet-dung-phan-1-lich-su-ByEZkWrEZQ0)

[https://viblo.asia/p/docker-vs-docker-compose-RnB5pXGd5PG](https://viblo.asia/p/docker-vs-docker-compose-RnB5pXGd5PG)

[https://docs.docker.com/compose/extends/](https://docs.docker.com/compose/extends/)

[https://techtalk.vn/lam-quen-voi-docker-compose.html](https://techtalk.vn/lam-quen-voi-docker-compose.html)