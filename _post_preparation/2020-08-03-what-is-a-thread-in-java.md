---
layout: post
title: What is a thread in Java
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with using threads](#solution-with-using-threads)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Comparison between Thread and Process](#comparison-between-thread-and-process)
- [Wrapping up](#wrapping-up)

<br>

## Given problem






<br>

## Solution with using threads





1. Threads that are managed by JVM




    Priority of a thread:
    - The priorities of threads in Java starts from 1 - the lowest priority to 10 - the highest priority.
    - At the construction time of a thread, by default, its priority is 5.
    - When setting for a thread's priority, we can use some enumerations such as Thread.MIN_PRIORITY, Thread.MAX_PRIORITY, Thread.MEDIUM_PRIORITY. 

2. Threads that are managed by Kernel

    Below is the structure of TCB - Thread Control Block.

    ![]()


<br>

## When to use





<br>

## Benefits and Drawbacks

1. Benefits

    - Reduced memory utilization. The memory overhead of creatign another thread is limited to the stack plus some bookkeeping memory needed by the thread manager. 
    - No advanced techniques required to access server global-data. If the data could possibly be modified by another concurrently running thread, all that threads to be done is to protect the relevant section with a mutual exclusion lock or mutex. In the absence of such a possibility, the global data is accessed as if there were no threads to worry about.
    - Creating a thread takes much less time than creating a process because there is no need to copy the heap segment, which could be very large.
    - The kernel spends less time in the scheduler on context switches between threads than between processes. This leaves more CPU time for the heavily loaded server to do its job.

2. Drawbacks

    - 
    - 
    - 

<br>

## Comparison between Thread and Process





<br>

## Wrapping up




<br>

Refer:

[Lecture 4: Threads and Scheduling](http://www.cs.cornell.edu/courses/cs4410/2015su/lectures/lec04-scheduling.html)

[Threads]https://www.cs.uic.edu/~jbell/CourseNotes/OperatingSystems/4_Threads.html)

[Thread (computing)](https://en.wikipedia.org/wiki/Thread_(computing))

[Understanding MySQL internals - Discovering and Improving a great database]()