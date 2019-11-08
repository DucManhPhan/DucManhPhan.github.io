---
layout: post
title: Understanding basic concepts in Java's multithreading
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading, Java]
---



<br>

## Table of contents
- [Program, Thread, Process](#program-thread-process)
- [Multithreading, Concurrency, Parallel](#multithreading-concurrency-parallel)
- [Characteristic of thread](#characteristic-of-thread)
- [Benefits and drawback for using threads](#benefits-and-drawback-for-using-threads)


<br>

## Program, Thread, Process
- A program is a set of instructions and associated data that resides on the disk and is loaded by the Operating System to perform some task.

- A process is a program in execution. A process is an execution environment that consists of instructions, user-data, and system-data segments, as well as lots of other resources such as CPU, memory, address space, disk and network I/0 acquired at runtime.

    A program can have several copies of it running at the same time but a process necessarily belongs to only one program.

- Thread is the smallest unit of execution in a process. A thread simply executes instructions serially. A process can have multiple threads running as part of it.

    Usually, there would be some state associated with the process that is shared among all the threads and in turn each thread would have some state private to itself. The globally shared state amongst the threads of a process is visible and accessible to all the threads, and special attention needs to be paid when any thread tries to read or write to this global shared state.

--> Processes do not share any resources amongst themselves whereas threads of a process can share the resources allocated to that particular process, including memory address space.

<br>

## Multithreading, Concurrency, Parallel
- Multithreading is the ability to run several threads of computation at the same time in the same process.

- Concurrency means when a task is broken down into smaller pieces and run simultaneously.

- Parallel 

<br>

## Characteristic of thread
- Need its own stack
- Have some memory overhead
- Creating and destroying takes time
- The scheduler will also need to ensure the thread's state is saved before another can execute, thus swapping one to the next takes time

<br>

## Benefits and drawback for using threads
1. Benefits



2. Drawbacks when using too many threads
- Creating too many threads can easily run the machine out of memory.
- Prevent other threads getting enough time on the CPU, which is starvation.

<br>

## Wrapping up





<br>

Refer:

[]()

[]()