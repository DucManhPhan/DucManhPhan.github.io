---
layout: post
title: Some useful commands in Redis
bigimg: /img/image-header/factory.jpg
tags: [Caching]
---

Redis is important component when we want to design scalable system. It is used as cache for our system. So, in this article, we will learn how to use some commands in Redis.

Let's get started.

<br>

## Table of contents
- [How to install redis-cli](#how-to-install-redis-cli)
- [Connect with local/remote redis server](#connect-with-local/remote-redis-server)
- [Get/set commands](#get/set-commands)
- [Check commands](#check-commands)
- [Query commands](#query-commands)
- [Modification commands](#modification-commands)
- [Wrapping up](#wrapping-up)


<br>

## How to install redis-cli

1. Install redis-cli on Windows

    To install it on Windows, we can visit some webpages to download a redis executable file.
    - [tporadowski/redis](https://github.com/tporadowski/redis/releases)
    - [microsoftarchive/redis](https://github.com/MicrosoftArchive/redis/releases)

2. Install redis-cli on Ubuntu

    Belows are some steps to install redis-cli in Ubuntu.
    1. Update the apt package

        ```bash
        sudo apt update
        ```

    2. Install redis-tools

        ```bash
        sudo apt install -y redis-tools 
        ```
<br>

## Connect with local/remote redis server

By default, Redis runs without username and password, the default port is: 6379.

```bash
# Go to the folder of Redis
# 1st - Run Redis client in local host
redis-cli

# 2nd - Connect to the remote server
redis-cli -h <ip_addr> -p <port_number> -a <password>
```

<br>

## Get/set commands
1. Create / Update data

    ```bash
    set key value

    # set if not exist value in key
    setnx key value
    ```

    For example:

    ```bash
    set phone_type Iphone
    ```

2. Get data

    ```bash
    get key
    ```

    For example:

    ```bash
    get phone_type
    ```

3. Modify key's name

    ```bash
    renamenx <key_name> <new_key_name>
    ```

    For example:

    ```bash
    renamenx phone_type phonetype
    ```

<br>

## Check commands
1. Check whether key is existed or not

    ```bash
    exists key
    ```

    For example:

    ```bash
    exists phone_type
    ```

<br>

## Query commands
1. Find all keys with patterns

    ```bash
    keys pattern
    ```

    For example:

    ```bash
    keys *type
    ```

    Especially, if we want to list all keys in Redis.

    ```bash
    keys *
    ```

    Note:
    - Time complexity: O(N) with N being the number of keys in the database, under the assumption that the key names in the database and the given pattern have limited length.
    - All redis commands are single thread and will block the server. The only difference is that ```keys``` has the potential of blocking server for longer when querying a large data set.

        So, with version 2.8 or later, use ```scan``` is a superior alternative to ```keys``` because it does not block the server nor does it consume significant resources.

        ```bash
        redis-cli --scan --pattern '*'
        ```

2. Get random key from Redis

    ```bash
    randomkey
    ```

3. Get the data type of the value stored in the key

    ```bash
    type key
    ```

    For example:

    ```bash
    type phone_type
    ```

4. Get the value of a key depends on its type

    ```bash
    # string data type
    get <key>

    # hash data type
    hgetall <key>

    # list data type
    lrange <key> 0 -1

    # set data type
    smembers <key>

    # zset data type
    zrange <key> 0 -1 withscores
    ```

<br>

## Modification commands
1. Increment value in key

    ```bash
    incr key
    ```

    For example:

    ```bash
    set num 2
    incr num
    ```

2. Increment the integer value of a key by the given amount

    ```bash
    incrby key increment
    ```

    For example:

    ```bash
    incrby num 5
    ```

3. Increment the float value of a key by the given amount
    
    ```bash
    INCRBYFLOAT key increment
    ```

4. Decrement the integer value of key by one
    
    ```bash
    decr key
    ```

    For example:

    ```bash
    decr num
    ```

5. Decrement the integer value of a key by the given number

    ```bash
    decrby key decrement
    ```

    For example:

    ```bash
    decrby num 4
    ```

6. Delete key

    ```bash
    DEL key
    ```

7. Set expiration time for key

    ```bash
    expire key <expiration_time_ms>
    ```

8. Returns the number of seconds until a key is deleted
    
    ```bash
    ttl key
    ```

9. Clear expired time of key

    ```bash
    persist key
    ```


<br>

## Wrapping up
- Understanding about the commands of Redis.


<br>

Refer:

[https://gist.github.com/LeCoupa/1596b8f359ad8812c7271b5322c30946](https://gist.github.com/LeCoupa/1596b8f359ad8812c7271b5322c30946)
