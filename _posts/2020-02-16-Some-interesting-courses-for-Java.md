---
layout: post
title: Some interesting courses for Java
bigimg: /img/image-header/factory.jpg
tags: [Courses]
---

In this article, we will learn some courses about java. Let's get started.

<br>

## Table of contents
- [Multithreading](#multithreading)
- [Application's performance](#application's-performance)
- [Java Fundermantal](#java-fundermantal)
- [Communication between applications](#communication-between-applications)
- [Securing in Java Web](#securing-in-java-web)
- [Reactive programming](#reactive-programming)
- [Functional programming](#functional-programming)
- [Testing](#testing)
- [Resource Management](#resources-management)
- [Java Swing](#java-swing)


<br>

## Multithreading
1. Applying Concurrency and Multi-threading to Common Java Patterns by Jose Paumard

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-patterns-concurrency-multi-threading/table-of-contents)

    This course has contents with:
    - Understanding Concurrency, Threading, and Synchronization

        It covers about how CPU Time sharing using a Thread Scheduler, what is race condition, understanding about the lock object in synchronization and use it in multiple methods, and Runnable pattern.

    - Implementing the Producer/Consumer pattern using wait/notify

    - Ordering Read and Writes Operations on a Multicore CPU

        It will talk about  Organization of Caches, visibility, false sharing on Multicore CPU, the definition of Happen-Before Link.

    - Implementing a Thread Safe Singleton on a Multicore CPU

2. Advanced Java Concurrent Patterns by Jose Paumard

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-concurrent-patterns-advanced/table-of-contents)

    - Introducing the Executor Pattern, Futures and Callables

        It will cover about Runnable, Executor Service patterns, Waiting queue of Executor Service, Callable interface to Model Tasks, and Future Object to transmit objects between threads.

    - Using Locks and Semaphores for the Producer / Consumer Pattern

        Some outstanding sections talk about Interruptible Lock acquisition, Timed Lock acquisition, Fair Lock acquisition of Lock pattern, and applying this lock to Producer/Consumer pattern.

    - Controlling Concurrent Applications Using Barriers and Latches

        It talks about sharing a task among Threads and merging the results, CyclicBarrier pattern, CountDownLatch pattern.

    - Understanding Casing and Atomic Variables

        We will understand about how to use casing and how does it work, some Java Atomic API.

3. Enterprise Patterns: Concurrency in Business Applications by Neil Morrissey

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/enterprise-patterns-concurrency-business-applications/table-of-contents)

    - Understanding Concurrency in Business Applications

        We can learn some interesting sections such as Properties of Transaction, Optimistic and Perssimistic Concurrency Control, Database isolation levels, database deadlocks, ...

    - Implementing the Optimistic Offline Lock Pattern

    - Implementing the Pessimistic Offline Lock Pattern

    - Implementing the Coarse-grained Lock Pattern

    - Implementing the Implicit Lock Pattern

4. Analyzing Java Thread Dumps by Uriah Levy

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/analyzing-java-thread-dumps/table-of-contents)

    - Introduction to Thread Dumps

        This section will introduce about Thread dumps, and Thread call stacks, how to capture Thread Dumps.

    - The Structure of a Thread Dump

        It covers about the structure of Thread Dumps, how to inspect individual threads, thread states, native methods.

    - Isolating Performance Issues: A Filesystem Congestion

        It talks about Filesystem Read/Write mechanics in Java.

    - Analyzing a Connection Pool Deadlock

        It focuses on a deadlock, connection pools.

    - Correlating JVM Threads to System Resources

        It covers some section such as gathering Thread CPU and Memory Utilization, File Descriptors - Filesystem handles.

5. Java Fundamentals: Asynchronous Programming Using CompletionStage by Jose Paumard

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-fundamentals-asynchronous-programming-completionstage/table-of-contents)

6. Scaling Java Applications Through Concurrency by Josh Cummings

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/scaling-java-applications-through-concurrency/table-of-contents)

    This course talks about how to improve the performance of application by some ways such as
    - Running processes in the background
    
        We will implement the fire-and-forgot pattern by using ThreadPoolExecutor, ForkJoinPool, and Threaded Recursion.

    - Sharing resources among Parallel Workers
    
        We will implement the scatter-gather pattern by using ExecutorService; Concurrency Primitives; Atomic Integer, ConcurrentHashMap, and LongAdder; Reentrant Lock.

    - Coordinating Efforts Among Dependent Processes

        We will implement Dependency Choreography by using CountDownLatch, Continuation-Passing, CompletableFuture, and addressing Thread Connection using Thread Pools.

    - Throttling Incoming Work

        Throttling is implemented by using ThreadPoolExecutor, Semaphore, CyclicBarrier, Phaser, and we learn about Performance Metrics breakdown.

<br>

## Application's performance
1. Java Performance Tuning by Tim Ojo

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-performance-tuning/table-of-contents)

<br>

## Java Fundermantal

1. Java Fundamentals: NIO and NIO2 by Jose Paumard

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-fundamentals-nio-nio2/table-of-contents)

2. Streams, Collectors, and Optionals for Data Processing in Java 8 by Jose Paumard

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-8-data-processing-streams-collectors-optionals/table-of-contents)

3. Java Fundamentals: The Java Reflection API Method Handles by Jose Paumard

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-fundamentals-reflection-api-method-handles/table-of-contents)

4. Java Fundamentals: Exception Handling by Esteban Herrera

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-fundamentals-exception-handling/table-of-contents)

5. Java Fundamentals: Collections by Richard Warburton

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-fundamentals-collections/table-of-contents)

6. Working with Files in Java Using the Java NIO API by Jose Paumard

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/files-java-nio-api/table-of-contents)


<br>

## Communication between applications

1. Enhancing Application Communication with gRPC by Mike Van Sickle

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/grpc-enhancing-application-communication/table-of-contents)



## Securing in Java Web

1. Securing Java Web Applications by Josh Cummings

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-web-application-security-vulnerabilities/table-of-contents)

    It will covers some interesting sections about preventing Cross-site Scripting attacks, preventing CSRF, Response Splitting, and Open Redirect, preventing Directory Traversal and Malicious File Upload, and preventing SQL and NoSQL Injection

2. Securing Java Web Applications Through Authentication by Josh Cummings

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/java-securing-web-applications-aaa/table-of-contents)

    The table of content of this course:
    - Identifying and Mitigating Enumeration Vulnerabilities

    - Identifying and Mitigating Brute Force Vulnerabilities

    - Identifying and Mitigating Plaintext Vulnerabilities in Transit

    - Identifying and Mitigating Plaintext Vulnerabilities at Rest

    - Creating an **Audit Trail** for Security Events

<br>

## Reactive programming

1. Reactive Programming in Java 12 with RxJava 2 by Russell Elledge

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/reactive-programming-java-12-rxjava-2/table-of-contents)

2. Reactive Programming in Java 8 With RxJava by Russell Elledge

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/reactive-programming-java-8-rxjava/table-of-contents)

<br>

## Functional programming

1. Applying Functional Programming Techniques in Java by Esteban Herrera

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/applying-functional-programming-techniques-java/table-of-contents)

<br>

## Testing

1. Automated Web Testing with Selenium and WebDriver Using Java by Bryan Hansen

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/automated-web-testing-selenium-webdriver-java/table-of-contents)

2. Java Unit Testing path by Nicolae Caprarescu

    To learn this course, we can refer this [link](https://app.pluralsight.com/paths/skills/unit-testing-in-java)

<br>

## Resource Management

1. Gradle Fundamentals by Kevin Jones

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/gradle-fundamentals/table-of-contents)

2. Maven Fundamentals by Bryan Hansen

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/maven-fundamentals/table-of-contents)

<br>

## Java Swing

1. Mastering Java Swing - Part 1 by John Purcell

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/mastering-java-swing-part1/table-of-contents)

2. Mastering Java Swing - Part 2 by John Purcell

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/mastering-java-swing-part2/table-of-contents)

3. Mastering Java Swing - Part 3 by John Purcell

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/mastering-java-swing-part3/table-of-contents)

4. Mastering Java Swing - Part 4 by John Purcell

    To learn this course, we can refer this [link](https://app.pluralsight.com/library/courses/mastering-java-swing-part4/table-of-contents)


