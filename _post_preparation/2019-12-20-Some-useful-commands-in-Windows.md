---
layout: post
title: Some useful commands in Windows
bigimg: /img/image-header/factory.jpg
tags: [Windows, commands]
---

In this article, we will list all interesting, common commands that we use in Windows. It makes us do operations on Windows fastly.

Let's get started.

<br>

## Table of contents
- [Search commands](#search-commands)
- [List commands](#list-commands)
- [Network Commands](#network-commands)
- [Process commands](#process-commands)
- [Wrapping up](#wrapping-up)


<br>

## Search commands
1. Search folder

    ```bash
    dir <folder_name> /AD /s
    ```

    With:
    - ```/A```: display files with specified attributes.
        - ```D```: may the attribute be Directories.
        - ```H```: Hidden files
        - ```A```: Files ready for archiving
        - ```S```: System files
        - ```I```: Not content indexed files
        - ```L```: Reparse Points

    - ```/s```: display files in specified directory and sub directories.

2. Search file

    ```bash
    dir /S /P <file_name>
    ```

    With:
    - ```/S```: searches recursively
    - ```/b```: removes the additional directory metadata from the search results, so you get a nice clean list of files
    - ```/P```: pauses after each screenful of information

    For example:

    ```bash
    # save result in text file
    dir /S <filename> > c:\results.txt
    ```

<br>

## List commands
1. List all logical driver in OS

    ```bash
    wmic logicaldisk get name
    ```

2. List all files, directories

    ```bash
    dir
    ``` 

3. List information about CPU

    ```bash
    # 1st way
    wmic cpu get caption, deviceid, name, numberofcores, maxclockspeed, status

    # 2nd way
    msinfo32
    ```

4. List information of RAM

    ```bash
    # Total RAM 
    # banklabel - which slots the RAM chips are installed in
    # capacity - how much large each module is expressed in bytes
    # devicelocator - another entity to tell which slots the RAM chips are installed in.
    # memorytype - the type of our phical memory. Ex: 21 means DDR2, 24 means DDR3
    # typedetail - Ex. 128 means synchronous
    wmic memorychip get banklablel, devicelocator, memorytype, typedetail, capacity, speed

    # get complete details about the memory modules
    wmic memorychip list full

    # use systeminfo command
    systeminfo | findstr /C:"Total Physical Memory"

    systeminfo | findstr /C:"Available Physical Memory"
    ```

<br>

## Network Commands
1. List all computers in the same network

    ```bash
    net view

    arp -a
    ```

<br>

## Process commands
1. List all process

    ```bash
    tasklist
    ```



<br>

## Wrapping up
- We should always use all above useful commands to improve our performance.

<br>

Refer:

[https://docs.microsoft.com/vi-vn/windows/win32/cimwin32prov/win32-physicalmemory?redirectedfrom=MSDN](https://docs.microsoft.com/vi-vn/windows/win32/cimwin32prov/win32-physicalmemory?redirectedfrom=MSDN)
