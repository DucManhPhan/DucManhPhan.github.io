---
layout: post
title: nohup command in Linux
bigimg: /img/image-header/road-to-solution.jpeg
tags: [Linux]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with nohup command](#solution-with-nohup-command)
- [Some real problems that we encounter](#some-real-problems-that-we-encounter)
- [Output file of nohup command](#output-file-of-nohup-command)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Supposed that we does not access directly to a database, but we can jump into it from an intermediate ssh server. So we will use forward port concept to access that database. But the connection to the ssh server can be terminated some times. 

Which solution can be solve our problems?

```bash
ssh -L <local_port>:<host_db>:<port_db> <ssh_username>:<ssh_host>
```

<br>

## Solution with nohup command

1. Syntax

    ```bash
    nohup <our_command> [arg]
    nohup option
    ```

    For example:

    ```bash
    nohup ssh -L <local_port>:<host_db>:<port_db> <ssh_username>:<ssh_host>
    ```

<br>

## Some real problems that we encounter

1. Sometimes, we want to ssh into a server, and maintain this connection between them in the background. But we need to type our password when using ssh. After that, our process will be stopped. So how do we deal with it?

    ```bash
    # To maintain connection, use command yes
    nohup ssh username@host -t "yes"

    # After typing the ssh server's password, our process will be stopped
    bg
    ```

    If we does not want to use nohup command to run in the background, we can press ```Ctrl + Z``` to suspend our process. Then, using ```bg``` command to put it into the background.

    When using the above nohup command, it will always save data to nohup command, then our disk's space is no longer taken full. To solve this problem, we will redirect the output of the command somewhere else, including /dev/null.

    ```bash
    nohup ssh username@host -t "yes" > /dev/null 2>&1   # does not create nohup.out
    ```

2. Now, we want to run an above command again, but it is running in the background. Belows are some steps that satsify our needs.

    - To shutdown our running process, to be aware of its process id.

    ```bash
    # 1st way
    jobs -l

    # 2nd way
    ps -A

    # 3rd way
    pidof <name>

    # 4th way
    pgrep <name>
    ```

    - Based on its PID, use kill command to shutdown it.

    ```bash
    # 1st way
    kill -9 <PID>

    # 2nd way
    pkill <name>

    # 3rd way
    killall <name>
    ```

    Belows are a table that discribes some POSIX signals.

    |       Signal Name      |    Single value    |           Effect         |
    | SIGHUP                 | 1                  | Hangup                   |
    | SIGINT                 | 2                  | Interrupt from keyboard  |
    | SIGNKILL               | 9                  | Kill signal              |
    | SIGTERM                | 15                 | Termination signal       |
    | SIGSTOP                | 17, 19, 23         | Stop the process         | 

3. Display the process's ID when using with nohup command

    To display PID, use ampersand operator **&** at the end of **nohup** command.

    ```bash
    nohup command &
    ```

<br>

## Output file of nohup command

When a process is running in the background, then we want to check log file to know more about its state. It is a normal case, so using nohup.out file is our solution. By default, the standard output will be redirected to the nohup.out file in the current folder. The standard error will be redirected to the the standard output, it means that both of them will be write to nohup.out file.

With nohup.out file, we can normally use the other commands to analysis, search, ... such as awk, tail, head, ...

<br>

## Wrapping up

- Understanding some cases that we need to use nohup command.

- How to kill a process that run in the background.

<br>

Thanks for your reading.

<br>

Refer:

[https://stackoverflow.com/questions/17385794/how-to-get-the-process-id-to-kill-a-nohup-process](https://stackoverflow.com/questions/17385794/how-to-get-the-process-id-to-kill-a-nohup-process)

[https://linuxhint.com/how_to_use_nohup_linux/](https://linuxhint.com/how_to_use_nohup_linux/)

[https://hexadix.com/use-nohup-execute-commands-background-keep-running-exit-shell-promt/](https://hexadix.com/use-nohup-execute-commands-background-keep-running-exit-shell-promt/)
