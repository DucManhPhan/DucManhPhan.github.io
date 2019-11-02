---
layout: post
title: Some necessary commands in Ubuntu
bigimg: /img/image-header/road-to-solution.jpeg
tags: [Ubuntu, Linux]
---




<br>

## Table of contents
- [Open command line interface](#open-command-line-interface)
- [Understanding about user's level in Linux](#understanding-about-user's-level-in-linux)



<br>

## Open command line interface
- First way, click Terminal icon that is at the bottom of sidebar.

- Second way, use shorcut key ```Ctrl + Alt + T```.

<br>

## Understanding about user's level in Linux
- normal user

    Normal users has limited permission such as they do not install software, ...

- ```sudo```

    The purpose of ```sudo``` is to enable us to use our user account to do things that normally only ```root``` would have been able to do.

    When we use ```sudo```, we'll be aksed for our user'password for confirmation, and then the command will execute.

- ```root```

    The ```root``` user account exists on all Linux distributions and is the most powerful user account on the planet.

    ```root``` user account can be used to do anything:
    - create files or directories.
    - install software.
    - destroy entire installation with one typo or ill-conceived command.
    - delete all files on hard disk.
    - ...

    --> There is often not so much as a confirmation prompt while executing any commands as ```root```.

    It's for these reasons that it's generally recommended that we should not use ```root``` account unless we absolute have to.

<br>

## 





<br>

## 





<br>

## Redirecting output

    It is used to take the output of one command and redirect it into the input of another command.

- Output to other commands

    ```python
    cat /var/log/syslog | grep apache2
    ```

    The above code mean that ```cat``` command is used to print the contents of the system log stored at ```/var/log/syslog```. Using the pipe symbol ```|```, we're redirecting the output of that command and feeding it into ```grep```, which is looking for the string ```apache2```.

    When used together, we're able to fetch lines from the system log that reference ```apache2```. This is useful if we're troubleshouting some sort of issue with the ```apache``` service, and we'd like to look at the log file but ignore any lines that aren't relevant to our investigation.

- Output to text file

    ```
    echo "Hello, world!" >> ~/test-file.txt
    ```

    echo command normally outputs to the Terminal, but instead telling it to direct its output to a file named ```test-file.txt```, stored in our home directory. 
    
    ```>>``` that is used in the above command means that it will continue to append this string to the file.

    If ```>``` is used in the above command, it will actually wipe out the content of ```test-file.txt```.

- Output errors into Standard Error file descriptor

    Normally, we're working with a File Descriptor called Standard Output - stdout with commands that produce output. File descriptors are numbers that refer to open files, and these numbers are integers.

    Standard output is a special file descriptor, with an integer of ```1```. It is our Terminal.

    Standard error - stderr also is file descriptor to be produce in error, with an integer of ```2```.

    ```
    find /etc -name *apache* 2>/dev/null
    ```

    It means that we're redirecting output from the find command with ```2>```, instead of ```>```, to ```/dev/null```. ```/dev/null``` is a special device that anything enters it is never seen or hear from again.

<br>

## Some useful command-line tricks
- Repeat our command that we last used.

    ```java
    !!
    ```

    As same as ```two exclamation marks```, we can press the up arrow key and press Enter to recall the previous commmand and execute it.

    In order to run previous command with sudo privilege, we can type in terminal like below:

    ```java
    sudo !!
    ```

- Search in terminal

    Use ```Ctrl + R``` shortcut key to search our previous command.

- Edit a command that we've previously typed in a text editor.

    Assume we pressed the up arrow key, we have a very long command, and we just want to edit part of it without having to execute the entire thing, perhaps a command like this:

    ```
    sudo apt update && sudo apt install apache2
    ```

    Let's assume you want to install ```nginx``` instead of ```apache2```, but the rest of the command is right. If you hold ```Ctrl``` and then press ```X``` followed by ```E```, which will open the command in a text editor. There, you can change the command. Once you're done making your changes, the command will execute once you save the file. Admittedly, this is usually only useful when you have a very long command and you need to just change part of it.

- Chain command

    We can use the double ampersand - AND operator to do this.

    ```
    sudo apt update && sudo apt install apache2
    ```

    It means that the second command will run if the first was successful.

    Another way to chain commands is to use semicolon.

    ```
    sudo apt update; sudo apt install apache2
    ```

    With using semicolon, we will execute the second command regardless of whether the fist command was successful.

- Command alias

    It allows us to create a command that is just another name for another command. This allows us to simplify commands down to just one word or a few letters.

    ```java
    alias install="sudo apt install"

    // or
    alias i="sudo apt install"

    // View the top ten CPU consuming processes
    alias cpu10='ps auxf | sort -nr -k 3 | head -10'

    // View the top ten RAM consuming processes
    alias mem10='ps auxf | sort -nr -k 4 | head -10'

    // View all amounted filesystems, and present the information in a clean tabbed layout
    alias lsmount='mount | column -t'

    // Clear the screen by simply typing c
    alias c=clear
    ```

    In the fact, when we exit Terminal window, our aliases are wiped out. In order to retain them, we need to edit our ```.bashrc``` file. This file is present in our home directory and is read every time we start a new Terminal session.

- Change our working directory back to the previous directory we were in

    ```java
    cd -
    ```

<br>

## Wrapping up




<br>

Refer: