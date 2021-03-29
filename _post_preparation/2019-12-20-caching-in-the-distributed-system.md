---
layout: post
title: Caching in the Distributed System
bigimg: /img/image-header/factory.jpg
tags: [Caching]
---



<br>

## Table of contents





<br>

## Given problem

Assuming that we have our distributed system can be looked like the below image:

![](../img/distributed-system/caching/problem-caching.png)

From the above image, we can find that we have:
- When a User1 want to retrieve information from our Server, User1 sends that request to Server, then Server will take so much time to calculate, and access to Database to find records that satisfy User1's conditions.

- Then, a User2 also want to get the same information, our Server also need to process again, and access to Database.

Belows are some drawbacks of the above system design:
- If there are many users that require the same information that is calculated for a long time, it makes us recomputation.
- Otherwise, we also need to access the other external system, so it will increases network calls and the database load.

Therefore, how do we deal with it?

<br>

## Solution of using Caching





<br>

## Some cache policy that we need to know

1. LRU - Least Recently Used



2. LFU - Least Frequently Used


    For example:
    - Used in caffeine

3. 

<br>

## Thrashing concept of Caching






<br>

## Consistency in Caching

1. Write-through cache

    A write-through cache means that when we need to make an update to the data that we have, now, our data is put on both cache and database. In this case, the first, we will update that data on Cache, but it causes the data inconsistency between Cache and Database. Then, we also push that update to the Database. 

    So, it means that we update the Cache before updating the Database.


    Some trade-off characteristics of Write-through cache:
    1. Benefits


    2. Drawbacks




2. Write-back cache

    A write-back cache means that to hit the database directly and once we hit the database, make sure to make an entry in the cache, so either database can tell the cache that this entry is no longer valid or we hit the cache, we find that entry is evicted. Then, if there will be a query on the cache, that entry won't exist, so it's going to pull from the database, and send back to the client.

    Some trade-off characteristics of Write-back cache:
    1. Benefits



    2. Drawbacks


3. Write-around cache


<br>

## When to use





<br>

## Benefits and Drawbacks






<br>

## Wrapping up






<br>

Refer:

[What is Distributed Caching? Explained with Redis!](https://www.youtube.com/watch?v=U3RkDLtS7uY)

[Understanding write-through, write-around and write-back caching (with Python)](https://shahriar.svbtle.com/Understanding-writethrough-writearound-and-writeback-caching-with-python)