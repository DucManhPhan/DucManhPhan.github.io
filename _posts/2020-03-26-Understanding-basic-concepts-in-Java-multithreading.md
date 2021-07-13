---
layout: post
title: Understanding basic concepts in Java's multithreading
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading]
---

In this article, we will learn about some basic concepts of multithreading, how to differenciate between them, and how to use it correctly.

Let's get started.

<br>

## Table of contents
- [Program, Thread, Process](#program-thread-process)
- [Multithreading, Concurrency, Parallel](#multithreading-concurrency-parallel)
- [Race condition](#race-condition)
- [Characteristic of thread](#characteristic-of-thread)
- [How to use correct concurrent code](#how-to-use-correct-concurrent-code)
- [Benefits and drawback for using threads](#benefits-and-drawback-for-using-threads)
- [Some consequences of multithreading when using it improperly](#some-consequences-of-multithreading-when-using-it-improperly)
- [Wrapping up](#wrapping-up)

<br>

## Program, Thread, Process
- A program is a set of instructions and associated data that resides on the disk and is loaded by the Operating System to perform some task.

- A process is a program in execution. A process is an execution environment that consists of instructions, user-data, and system-data segments, as well as lots of other resources such as CPU, memory, address space, disk and network I/0 acquired at runtime.

    A program can have several copies of it running at the same time but a process necessarily belongs to only one program.

- Thread is the smallest unit of execution in a process. A thread simply executes instructions serially. A process can have multiple threads running as part of it.

    Usually, there would be some state associated with the process that is shared among all the threads and in turn each thread would have some state private to itself. The globally shared state amongst the threads of a process is visible and accessible to all the threads, and special attention needs to be paid when any thread tries to read or write to this global shared state.

--> Processes do not share any resources among themselves whereas threads of a process can share the resources allocated to that particular process, including memory address space.

<br>

## The basic concepts of multithreading, concurrency, Parallelism

- Multithreading is the ability of an application that can handle multiple tasks at a time and to synchronize those tasks. 

    This means that multithreading allows the maximum utilization of a CPU by executing two or more tasks virtually at the same time. It means that the tasks only look like they are running simultanenously; however, essentially, they can't do that. They take advantage of CPU context switching or the time slicing feature of the OS. In other words, CPU time is shared across all running tasks, and each tasks is scheduled to run for a certain period of time.

- Concurrency is the ability of an application to handle the multiple tasks it works on. The program or application can process one task at a time (sequence processing with context switching) or process multiple tasks at the same time (concurrent processing).

- Parallelism

So, to recap about concurrency and parallelism, we have:
- Concurrency is about handling (not doing) lots of things at once; while parallelism is about doing lots of things at once.

    ![](../img/Java/Multithreading/basic-concepts/parallel-concurrent-both.jpg)

- With a single core CPU, we may achieve concurrency but not parallelism.

- An application can be splitted into some types:

    - Concurrent but not parallel

        It handles more than one task at the same time, but no two tasks are executed at the same time.

    - Parallel but not concurrent

        It executes multiple subtasks of a task in a multicore CPU at the same time.

    - Neither parallel nor concurrent

        It executes all of the tasks at a time (sequential execution).

    - Both parallel and concurrent

        It executes multiple tasks concurrently in a multicore CPU at the same time.

<br>

## Race condition

When two different threads are trying to read or write the same variable or the same field, at the same time, so this concurrent reading and writing is what is called a race condition.

Several threads can be able to read the same variable at the same time, if the value of this variable does not change, it will not raise an issue. But if they are reading and writing the same variable, then it may raise a problem.

```The same time``` does not mean the same thing on a single core and on a multi core CPU.

In order to give an example of race condition, we will go into Singleton pattern in multithreading.

```java
public class Singleton {

    private static Singeton instance;

    private Single() {}

    public static Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }

        return instance;
    }
}
```

So, we have a questions about the above code of Singleton pattern - What is happening if two threads are calling ```getInstance()```?

|            Thread T1               |                Thread T2              |
| ---------------------------------- | ------------------------------------- |
| Check if instance is null ?        | Waiting                               |
| The answer is yes                  |                                       |
| Enters the if block                |                                       |
| The thread scheduler pauses T1     |                                       |
|                                    | Check if instance is null ?           |
|                                    | The answer is yes                     |
|                                    | Enters if the block                   |
|                                    | Creates an instance of Singleton      |
|                                    | The thread scheduler pauses T2        |
| Create an instance of Singleton*   |                                       |

```*``` --> Because T1 is in the **if** block, it will not check if the instance field has been initialized one more time. So, it will create another instance of singleton, and copy it in the **private static field instance**, thus erasing the instance that has beeen created by the thread T2.

Solution:
- In order to prevent the race condition, we need to use synchronization.

<br>

## Characteristic of a thread

Belows are some characteristics of a thread.
- Need its own stack
- Have some memory overhead
- Creating and destroying takes time
- The scheduler will also need to ensure the thread's state is saved before another can execute, thus swapping one to the next takes time.

    It means that the scheduler is responsible for the CPU sharing, evenly the CPU timeline, divided into tim slices, to all the tasks that need to be run.

    There are three reasons for the scheduler to pause a thread, and to tell a thread --> now, it is the time to run another thread, so we should stop running.
    - First, the CPU resource should be share equally among the thread, and there are sometimes very sophisticated priority stuff that are taken into account to share equally the CPU as a resouce.

    - A thread might be waiting for some more data. Think about a thread that is doing some input output, reading or writing data to a disk or to a network. We know that writing or reading from a disk is a slow process. If the CPU is very fast, it might pause a thread waiting for the data to be available.

    - A thread might be waiting for another thread to do something. For instance, to release a resource.

<br>

## How to use correct concurrent code

1. Check for race conditions

    - We need to have a look at our code and especially what is happening to the fields of our classes because race conditions cannot occur on variables inside methods nor parameters.

    - If we have more than one thread trying to read or write a given field, then it means that we have a race condition on that field.

2. Check for happens-before link

    On the given field, if we want things to be correct, we need to have a happens-before link between our read operations and our write operations. It is quite easy, in fact, to check for these points. They have two questions we need to answer for that.
    - Are the read / write operations volatile?
    - Are they synchronized?

    If the field we are checking has been declared volatile, they are synchronized if they occur inside the boundary of a synchronized block, so it is very simple to check for that.

    If it is not the case we must probably have a bug.

3. Synchronized or Volatile

    - Synchronized = atomicity

        With synchronization, we need to answer the question, do we need atomicity on a certain portion of code? If we have a portion of code that should not be interrupted between threads, then we need to have a synchronized block to protect our portion of code.

    - Volatile = visibility

        If it is not the case that using synchronization, then volatility is enough. It will ensure visibility and correct concurrent code.


<br>

## Benefits and Drawbacks for using threads

1. Benefits

    - Improve performance of system when we choose the compatible number of threads.

2. Drawbacks when using too many threads

    - Creating too many threads can easily run the machine out of memory.

    - Prevent other threads getting enough time on the CPU, which is starvation.

<br>

## Some consequences of multithreading when using it improperly

Depending on the consequences, the problems caused by concurrency can be categorized into some types:
1. **race conditions**

    The program ends with an undesired output, resulting from the sequence of execution among the processes.

2. **deadlocks**

    The concurrent processes wait for some necessary resources from each other. As a result, none of them can make progress.

3. **resource starvation**

    A process is perpetually denied necessary resources to progress its works.

4. **live lock**

<br>

## Wrapping up
- Some points to note about race conditions

    - It is safe if multiple threads are trying to read a shared resource as long as they are not trying to change it.

    - Multiple threads executing inside a method is not a problem in itself, problem arises when these threads try to access the same resource.

        For instance, class variables, record in a table, a file.

    - There is no race condition between threads since no data is shared between them.

    - The race conditions can generate different results, including unexpected results, that are dependent on the execution order.

- The synchronization of a multithreaded environment is achieved by locking. Locking is used to orchestrate and limit access to a resource in a multithreaded environment.

<br>

Refer:

[https://takuti.me/note/parallel-vs-concurrent/](https://takuti.me/note/parallel-vs-concurrent/)

[https://medium.com/swift-india/concurrency-parallelism-threads-processes-async-and-sync-related-39fd951bc61d](https://medium.com/swift-india/concurrency-parallelism-threads-processes-async-and-sync-related-39fd951bc61d)

[The complete coding interview guide in Java](https://packtpub.com)