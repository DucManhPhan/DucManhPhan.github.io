---
layout: post
title: Understanding about architecture of Redis
bigimg: /img/image-header/factory.jpg
tags: [Caching]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [The architecture of Redis](#the-architecture-of-redis)
- [Some features that Redis supports](#some-features-that-redis-supports)
- [Data types in Redis](#data-types-in-redis)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Comparison between Redis and Memcached](#comparison-between-redis-and-memcached)
- [Wrapping up](#wrapping-up)


<br>

## Given problem







<br>

## The architecture of Redis





<br>

## Some features that Redis supports

1. disk persistent

    Redis supports the writing of its data to disk automatically in two different ways, and can store data in four structures in addition to plain string keys as memcached does.

2. client-side sharding to scale write performance

3. Publish/Subscribe

4. Master/slave replication

    It will be used to scale the read performance.

5. Supports scripting (store procedures)


6. Supports transactions

<br>

## Data types in Redis

- String
- List
- Set
- Hash
- Sorted set 


<br>

## When to use





<br>

## Benefits and Drawbacks

1. Benefits




2. Drawbacks




<br>

## Comparison between Redis and Memcached


|               Comparison Type            |                    Redis                 |                         Memcached                       |
| ---------------------------------------- | ---------------------------------------- | ------------------------------------------------------- |
| Type                                     | In-memory non-relational database        | In-memory key-value cache                               |
|






<br>

## Wrapping up






<br>

Refer:

[]()
