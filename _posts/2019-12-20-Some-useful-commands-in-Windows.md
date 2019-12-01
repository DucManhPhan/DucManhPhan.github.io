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

2. Get all detailed information about our current network adapter connection

    ```bash
    ipconfig
    ```

    The result will have summary information:
    - Current IP Address
    - Subnet Mask
    - Default Gateway IP
    - Current domain

3. Get list of all active TCP connection

    ```bash
    netstat
    ```

    This command is used to check whether malware is running on our computer.

4. Check whether our computer can access another computer

    ```bash
    ping

    telnet
    ```

5. Get the path of packet from our computer to others

    ```bash
    tracert google.com
    ```

    It will have:
    - Number of hops (intermediate servers) before getting to the destination
    - Time it takes to get to each hop
    - The IP and sometimes the name of each hop

<br>

## Process commands
1. List all process

    ```bash
    tasklist
    ```


<br>

## Check commands
1. Check whether windows is activated or not

    ```bash
    slmgr /xpr
    ```

    If the content of dialog is ```The machine is permanently activated```, so windows is activated.

2. Check the certain file extension will be opened by which programs

    ```bash
    assoc
    ```

3. Compare two text files

    ```bash
    fc /a /b file1.txt file2.txt
    ```

    With:
    - ```/a```: used to compare in ASCII mode
    - ```/b```: used to compare in Binary mode

4. Check about configuration of power

    ```bash
    powercfg -energy
    ```

5. Check the integrity of the core system files in OS

    ```bash
    sfc /scannow
    ```

    It is used to check when we find that our OS has virus.

    The SFC command also lets you:
    - ```/VERIFYONLY```: Check the integrity but don’t repair the files.
    - ```/SCANFILE```: Scan the integrity of specific files and fix if corrupted.
    - ```/VERIFYFILE```: Verify the integrity of specific files but don’t repair them.
    - ```/OFFBOOTDIR```: Use this to do repairs on an offline boot directory.
    - ```/OFFWINDIR```: Use this to do repairs on an offline Windows directory.
    - ```/OFFLOGFILE```: Specify a path to save a log file with scan results.

6. Scan entire driver

    ```bash
    chkdsk C: /f /r /x
    ```

    This command checks for things like:
    - File fragmentation
    - Disk errors
    - Bad sectors

7. Run scheduled task

    ```bash
    SCHTASKS /Create /SC HOURLY /MO 12 /TR Example /TN c:\temp\File1.bat
    ```

    The scheduled switch ```/SC``` accepts arguments like minute, hourly, daily, and monthly. Then you specify the frequency with the ```/MO``` command.

8. Change attributes files/folders

    ```bash
    ATTRIB +R +H C:\temp\File1.bat
    ```

8. Search something inside any of ASCII files

    ```bash
    find

    findstr
    ```

<br>

## Wrapping up
- We should always use all above useful commands to improve our performance.

<br>

Refer:

[https://docs.microsoft.com/vi-vn/windows/win32/cimwin32prov/win32-physicalmemory?redirectedfrom=MSDN](https://docs.microsoft.com/vi-vn/windows/win32/cimwin32prov/win32-physicalmemory?redirectedfrom=MSDN)
