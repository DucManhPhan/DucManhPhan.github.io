---
layout: post
title: Fork-Join framework in Java
bigimg: /img/image-header/factory.jpg
tags: [Multithreading, Java]
---



<br>

## Table of contents
- [Introduction to Fork/Join framework](#introduction-to-fork/join-framework)
- [How to use](#how-to-use)
- [Source code](#source-code)
- [When to use](#when-to-use)
- [Comparison between Fork-Join and Executors framework](#comparison-between-fork-join-and-executors-framework)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to Fork/Join framework

According to [the document of oracle](https://docs.oracle.com/javase/tutorial/essential/concurrency/forkjoin.html), we have:

```
The fork/join framework is an implementation of the ExecutorService interface that helps you take advantage of multiple processors. It is designed for work that can be broken into smaller pieces recursively. The goal is to use all the available processing power to enhance the performance of your application.
```

As with any ```ExecutorService``` implementation, the fork/join framework distributes tasks to worker threads in a thread pool. The fork/join framework is distinct because it uses a **work-stealing** algorithm. Worker threads that run out of things to do can steal tasks from other threads that are still busy.

The center of the fork/join framework is the **ForkJoinPool** class, an extension of the **AbstractExecutorService** class. **ForkJoinPool** implements the core **work-stealing** algorithm and can execute **ForkJoinTask** processes.


<br>

## How to use

If we want to use the Fork/Join framework, we need to identify our problems that can be divided into multiple subproblems. We repeat the process in a recursive way until the problems we have to solve are small enough to be solved directly. We can find our code looks like the below code.

```java
if ( problem.size() > DEFAULT_SIZE) {
    divideTasks();
    executeTask();
    taskResults=joinTasksResult();
    return taskResults;
} else {
    taskResults=solveBasicProblem();
    return taskResults;
}
```

Then we will wrap the above code in a **ForkJoinTask** subclass, typically using one of its more specialized types, either **RecursiveTask** that can return a result, or **RecursiveAction**.

After our **ForkJoinTask** subclass is ready, create the object that represents all the work to be done and pass it to the **invoke()** method of a **ForkJoinPool** instance.




<br>

## Source code




<br>

## When to use






<br>

## Benefits and Drawbacks
1. Benefits




2. Drawbacks

    - The basic problems that we're not going to subdivide have to be not very large, but not very small. According to the Java API documentation, it should have between 100 and 10,000 basic computational steps.

    - We should not use blocking I/O operations like reading user input or data from a network socket waiting until the data is available. Such operations will cause your CPU cores to become idle, reducing the parallelism level, so we will not achieve the full performance.

    - We can't throw checked exceptions inside a task. We have to include the code to handle them (for example, wrapping into unchecked RuntimeException). Unchecked exceptions have a special treatment.


<br>

## Comparison between Fork-Join and Executors framework

[https://stackoverflow.com/questions/9276807/whats-the-advantage-of-a-java-5-threadpoolexecutor-over-a-java-7-forkjoinpool](https://stackoverflow.com/questions/9276807/whats-the-advantage-of-a-java-5-threadpoolexecutor-over-a-java-7-forkjoinpool)



<br>

## Wrapping up
- The Fork/Join framework has another critical part: the work-stealing algorithm, which determines which tasks to be executed. 
    
    When a task is waiting for the finalization of a child task using the join() method, the thread that is executing that task takes another task from the pool of tasks that are waiting and starts its execution.

    In this way, the threads of Fork/Join framework are always executing a task by improving the performance of the application.



<br>

Refer: 

[https://www.javaworld.com/article/2078440/java-tip-when-to-use-forkjoinpool-vs-executorservice.html](https://www.javaworld.com/article/2078440/java-tip-when-to-use-forkjoinpool-vs-executorservice.html)

[https://www.pluralsight.com/guides/introduction-to-the-fork-join-framework](https://www.pluralsight.com/guides/introduction-to-the-fork-join-framework)

[https://docs.oracle.com/javase/tutorial/displayCode.html?code=https://docs.oracle.com/javase/tutorial/essential/concurrency/examples/ForkBlur.java](https://docs.oracle.com/javase/tutorial/displayCode.html?code=https://docs.oracle.com/javase/tutorial/essential/concurrency/examples/ForkBlur.java)