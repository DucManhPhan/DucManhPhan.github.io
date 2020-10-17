---
layout: post
title: Some estimation parameters to use in Distributed System
bigimg: /img/image-header/yourself.jpeg
tags: [Distributed system]
---




<br>

## Table of contents
- [About Database](#about-database)
- [About calling webservice](#about-calling-webservice)
- [About caching](#about-caching)
- [About Messaging system](#about-messaging-system)
- [Wrapping up](#wrapping-up)


<br>

## About Database

1. In RDBMS

    - Select query

        |      Condition      |          Duration          |
        | ------------------- | -------------------------- |
        | best                | 10 ms --> 20 ms            |
        | worst               | max = 100 ms               |

        When working with database, we should set the timeout for querying statement that is 60 s.

2. In NoSQL

    - MongoDB


    - Cassandra


<br>

## About calling webservice

1. Using Restful API

    |      Condition      |          Duration          |
    | ------------------- | -------------------------- |
    | best                | 100 ms --> 200 ms          |
    | worst               | 30 s --> 60 s              |

    Nowadays, the systems communicate through restful api, then, we need to set timeout for this calling.

2. Using WebSocket



3. Using TCP socket



4. Using gRPC




<br>

## About caching

1. Using Redis

    - Redis Cluster


2. Using Memcache



<br>

## About Messaging system

1. Using Kafka



2. Using Rabbit MQ



3. Using Active MQ



<br>

## Wrapping up

- Always use the above parameters to check our system to satisfy our non-functional requirements.

