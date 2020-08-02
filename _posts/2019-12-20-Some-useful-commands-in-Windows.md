---
layout: post
title: Some useful commands in Windows
bigimg: /img/image-header/factory.jpg
tags: [Windows]
---

In this article, we will list all interesting, common commands that we use in Windows. It makes us do operations on Windows fastly.

Let's get started.

<br>

## Table of contents
- [Search commands](#search-commands)
- [List commands](#list-commands)
- [Network Commands](#network-commands)
- [Process commands](#process-commands)
- [Computer commands](#computer-commands)
- [Check commands](#check-commands)
- [Looping statement](#looping-statement)
- [Conditional statements](#conditional-statements)
- [Operators](#operators)
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
    - ```/O```: sort or order the way it displays the output.

        - ```N```: name
        - ```S```: size
        - ```E```: extension
        - ```D```: date/time
        - ```G```: group directories first

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
    netstat -a -b
    ```

    This command is used to check whether malware is running on our computer.

    With:
    - ```-a```: display all connections and listening ports
    - ```-b```: display all the executable involved in creating each connection or listening port.
    - ```-n```: display addresses and port numbers in numerical form.
    - ```-o```: display the owning process ID associated with each connection.

    For example:

    ```bash
    netstat -aon | find /i "listening"

    netstat -aon | find "8080"

    netstat -aon | findstr 8080
    ```

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

    Syntax:

    ```bash
    tasklist [/S system [/U username [/P [password]]]] [/M [module] | /SVC | /V] [/FI filter] [/FO format] [/NH]
    ```

    |               Field           |                      Description                   |
    | ----------------------------- | -------------------------------------------------- |
    | ```/S <system>```             | Specifies the remote system to connect to          |
    | ```/U <username>```           | Specifies the user context under which the command should execute. |
    | ```/P <password>```           | Specifies the password for the given user context. Prompts for input if omitted. |
    | ```/M <module>```             | Lists all tasks currently using the given exe/dll name. If the module name is not specified all loaded modules are displayed. |
    | ```/SVC```                    | Displays services hosted in each process.          |
    | ```/V```                      | Displays verbose task information.                 |
    | ```/FI filter```              | Displays a set of tasks that match given criteria specified by the filter. |
    | ```/FO format```              | Specifies the output format. Valid values: "TABLE," "LIST," and "CSV." |
    | ```/NH```                     | Specifies that the "Column Header" should not show in the output. Valid only for "TABLE" and "CSV" formats. |

    ```bash
    # display on command line
    tasklist

    # save to file
    tasklist > output.txt
    ```

2. Filter processes for specific intention

    |               Field           |      Valid operators      |                      Valid values                   |
    | ----------------------------- | ------------------------- | --------------------------------------------------- |
    | STATUS                        | eq, ne                    | RUNNING | NOT RESPONDING | UNKNOWN                  |
    | IMAGENAME	                    | eq, ne	                | Image name                                          | 
    | PID	                        | eq, ne, gt, lt, ge, le	| PID value                                           |
    | SESSION	                    | eq, ne, gt, lt, ge, le	| Session number                                      |
    | SESSIONNAME	                | eq, ne	                | Session name                                        |
    | CPUTIME	                    | eq, ne, gt, lt, ge, le	| CPU time in the format of hh:mm:ss, and hh - hours, mm - minutes, ss - seconds |
    | MEMUSAGE	                    | eq, ne, gt, lt, ge, le	| Memory usage in KB                                  |
    | USERNAME	                    | eq, ne	                | Username in [domain\]user format                    |
    | SERVICES	                    | eq, ne	                | Service name                                        |
    | WINDOWTITLE	                | eq, ne	                | Window title                                        |
    | MODULES	                    | eq, ne	                | DLL name                                            |

    ```bash
    tasklist /fi "<conditions>"
    ```

3. Remove processes

    |               Field           |                      Description                   |
    | ----------------------------- | -------------------------------------------------- |
    | ```/PID <processID>```        | Specifies the PID of the process to be terminated. Use tasklist to get the PID. |
    | ```/IM ImageName```           | Specifies the image name of the process to be terminated. Wildcard '*' can be used to specify all tasks or image names. |
    | ```/T```                      | Terminates the specified process and any child processes which were started by it. |
    | ```/F```                      | Specifies to forcefully terminate the process(es). |

    ```bash
    taskkill [/S system [/U username [/P [password]]]]          { [/FI filter] [/PID processid | /IM imagename] } [/T] [/F]
    ```

    For example:

    ```bash
    taskkill /pid 2500

    taskkill /f /im chrome.exe
    ```

<br>

## Computer commands
1. Shutdown computer

    ```bash
    shutdown
    ```

    The shutdown command is used to shutdown, logoff or reboot the specified machines both locally and remotely.

    With:
    - ```-a```: abort the machine from shutting down.
    - ```-s```: shutdown the machine.
    - ```-r```: reboot the machine.
    - ```-l```: log off the currently logged user.
    - ```-t```: specify the time to wait in seconds.
    - ```-c```: display comments in the output window.
    - ```-I```: open up the "remote shutdown dialog" box, where we can add either the hostnames or the IP addresses of the machines.
    - ```-f```: forcefully terminate all the application that are currently running on the specified computer, and then will perform the specified operation such as Log off, Reboot, Shutdown.

    For example:

    ```bash
    # shutdown OS in 60 seconds
    shutdown -s -t 60

    # sleep OS
    powercfg /h on
    shutdown /h
    ```

2. Operations with PATH environment

    - List all paths

        ```bash
        # display on command line
        set

        ## save to a file
        set > output.txt
        ```

    - Get an specific application's path

        ```bash
        set env_name_variable
        ```

        For example:

        ```bash
        set JAVA_HOME
        ```

    -  Add application's path to PATH environment

        ```bash
        set PATH=%PATH%;<our-path-name>
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

## Looping statement
1. For /D - For Directories

    ```bash
    for /d %%parameter in (folder_set) do command
    ```

    It is used to loop through serveral directories. If set contains wildcards, then specifies to match against directory names instead of file names.

    For example:

    ```bash
    # List all directories in C:\
    for /d %x in (C:\*) do echo "%x"

    for /d %v in (*.*) do dir /x "%v"
    ```

2. For /R - For files rooted at Path

    ```bash
    for /r [[driver:]path] %%parameter in (set) do command
    ```

    It is used to recursive directories and sub-directories. It walks the directory tree rooted at ```[driver:]path```, executing the FOR statement in each directory of the tree.

    If no directory specification is specified after /R, then the current directory is assumed. If ```set``` is just a single period (.) character, then it will just enumerate the directory tree.

    For example:

    ```bash
    # list all pdf file in C:\Program Files into listpdf.txt
    for /r "C:\Program Files" %x in (*.pdf) do (echo %x >> C:\listpdf.txt)

    for /r C:\Windows\Prefetch %v in (*.pf) do del %v
    ```

3. For /L - For list of numbers

    ```bash
    for /l %%parameter in (start, step, end) do command
    ```

    It is used to loop through a range of specified numbers.

    For example:

    ```bash
    for /l %v in (1, 1, 20) do telnet %l  %v

    for /l %g in (20, -2, 0) do echo %g
    ```

4. For /F - For file's content

    ```bash
    for /f ["options"] %%parameter in (filename_set) do command

    for /f ["options"] %%parameter in ("text string to process") do command

    for /f ["options"] %%parameter in ("command to process") do command
    ```

    It is used to loop through a wide variety of files, commands and strings. So, it is used to analyze the output of a command or commands and to take further action based on what the initial output was.

    When we execute all above commands in batch file, we should use ```%%``` perceding the variable name.

    For example:

    ```bash
    for /d %%v in (*.*) do dir /s "%%v"
    ```

    With some values of ```options```:
    - ```eol=c```: specifies an end of line comment character (just one).
    - ```skip=n```: specifies the number of lines to skip at the beginning of the file.
    - ```delims=xxx```: specifies a delimeter set. This replaces the default delimeter set of space and tab.
    - ```tokens=x,y,m-n```: specifies which tokens from each line are to be passed to the for body for each iteration. This will cause additional variable names to be allocated.

        - The m-n form is a range, specifying the mth through the nth tokens. If the last character in the tokens= string is an asterisk, then an additional variable is allocated and receives the remaining text on the line after the last token parsed.

    - ```usebackq```: specifies that the new semantics are in force, where a back quoted string is executed as a command and a single quoted string is a literal string command and allows the use of double quote file names in filename_set.


    For example:

    ```bash
    # list all directories and files available inside the C:\Program Files directory
    for /f "tokens=*" %v in ('dir /b "c:\program files"') do echo %v

    # display all the processes running in the background
    for /f "delims==" %v in ('tasklist') do @echo %v
    ```

<br>

## Conditional statements
1. Use if statement

    ```bash
    # Check exist of folder
    @echo off
    if exist C:\Windows (
        echo Found
    ) else (
        echo Not found
    )

    Pause
    ```

    With tasklist command, it returns the error level as '0' for successful execution, returns '1' for failure.

    ```bash
    @echo off
    tasklist
    cls
    if errorlevel 1 (
        echo success
    ) else (
        echo failure
    )

    Pause
    ```

## Operators

|               Operators            |                Meaning                 |
| ---------------------------------- | -------------------------------------- |
| EQU                                | EQUAL                                  |
| NEQ                                | NOT EQUAL                              |
| LSS                                | LESS THAN                              |
| LEQ                                | LESS THAN OR EQUAL                     |
| GTR                                | GREATER THAN                           |
| GEQ                                | GREATER THAN OR EQUAL                  |


<br>

## Wrapping up
- We should always use all above useful commands to improve our performance.

<br>

Refer:

[https://docs.microsoft.com/vi-vn/windows/win32/cimwin32prov/win32-physicalmemory?redirectedfrom=MSDN](https://docs.microsoft.com/vi-vn/windows/win32/cimwin32prov/win32-physicalmemory?redirectedfrom=MSDN)
