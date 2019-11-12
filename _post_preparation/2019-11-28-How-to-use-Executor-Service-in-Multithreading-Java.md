---
layout: post
title: How to use ExecutorService framework in Multithreading Java
bigimg: /img/image-header/home-office-1.jpg
tags: [java, Multithreading]
---



<br>

## Table of contents
- [Some ways to create ExecutorService](#some-ways-to-create-executorservice)
- [Use shutdown() or shutdownNow() methods to terminate thread](#use-shutdown()-or-shutdownNow()-methods-to-terminate-thread)
- [Use back-off strategy for running thread forever](#use-back-off-strategy-for-running-thread-forever)
- [Wrapping up](#wrapping-up)

<br>

## Some ways to create ExecutorService
1. Use ```newCachedThreadPool()``` method

    ```java

    ```


2. Use ```newFixedThreadPool()``` method



3. Use ```newSingleThreadExecutor()``` method




4. use ```newScheduledThreadPool()``` method

    - Run task at once time

        ```java
        <V> ScheduledFuture<V> schedule(Callable<V> callable, long delay, TimeUnit unit);

        ScheduledFuture<?> schedule(Runnable command, long delay, TimeUnit unit);
        ```

        For example:

        ```java
        Runnable taskAtOnce = () -> {
            System.out.println("Running this task at once time.");
        };

        ScheduledExecutorService scheduleService = Executors.newScheduledThreadPool(1);
        scheduleService.schedule(taskAtOnce, 5, TimeUnit.SECONDS);
        System.out.println("Running immediately.");

        scheduleService.shutdown();
        ```

    - Run task repeatedly after the given delay time

        ```java
        ScheduledFuture<?> scheduleAtFixedRate(Runnable command, long initialDelay, long period, TimeUnit unit);

        ScheduledFuture<?> scheduleWithFixedDelay(Runnable command, long initialDelay, long delay, TimeUnit unit);
        ```

        For example:

        ```java
        
        ```
<br>

## Use shutdown() or shutdownNow() methods to terminate thread





<br>

## Use back-off strategy for running thread forever




<br>

## Wrapping up





<br>

Refer: 

[https://stackoverflow.com/questions/2104676/java-executor-best-practices-for-tasks-that-should-run-forever](https://stackoverflow.com/questions/2104676/java-executor-best-practices-for-tasks-that-should-run-forever)

[]()

