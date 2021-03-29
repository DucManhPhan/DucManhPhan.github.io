---
layout: post
title: How to use ThreadFactory in Java
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading]
---


<br>

## Table of Contents
- [Given problem](#given-problem)
- [Solution with ThreadFactory](#solution-with-threadfactory)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>


## Given problem

Normally, when we are working with multithreading in Java project, we will use a class that implements **Runnable** interface, or extends **Thread** class. But it has some disadvantages that we need to take care.

- Do not setup thread priority.
- Do not provide the thread's name.

<br>

## Solution with ThreadFactory

1. Syntax of **ThreadFactory**

    ```java
    public interface ThreadFactory {
        Thread newThread(Runnable r);
    }
    ```

<br>

## Source code

1. Defines our custom class that implements **ThreadFactory** interface

    ```java
    public class MpThreadFactory implements ThreadFactory {

        private String name;

        public MpThreadFactory(String name) {
            this.name = name;
        }

        @Override
        public Thread newThread(Runnable r) {
            Thread t = new Thread(r, this.name);
        }
    }
    ```

2. Using **ThreadFactoryBuilder** in Guava concurrent library.


    ```java
    ThreadFactory threadFactory = new ThreadFactoryBuilder()
                                        .setNameFormat("Worker-%d")
                                        .setDaemon(true)
                                        .build();
    ```


3. Using **VerboseThread** class in **JCabi Log** library.

    To use JCabi Log library, insert the below dependency.

    ```xml
    <dependency>
        <groupId>com.jcabi</groupId>
        <artifactId>jcabi-log</artifactId>
        <version>0.18.1</version>
    </dependency>
    ```

    The **VerboseThread** class will log all runtime exceptions through SLF4J. **VerboseThreads** factory should be used together with executor services from **java.util.concurrent** package.

    ```java
    ThreadFactory factory = new VerboseThreads();
    Executors.newScheduledThreadPool(2, factory).scheduleAtFixedRate(
        new Runnable() {
            @Override
            public void run() {
            // the same sensitive operation that may throw
            // a runtime exception
            }
        }, 1L, 1L, TimeUnit.SECONDS
    );
    ```

<br>

## Benefits and Drawbacks

1. Benefits

    - Enable application to use special thread subclasses.

    - Adding the priority for each thread.

    - Support to fill the thread's name.

        It's really helpful when we cope with the bug in our program, we can see the thread's name.

    - We can use factory pattern with ThreadFactory, and then use statistic for our threads.

2. Drawbacks

<br>

## Wrapping up

- Understanding about why we should use ThreadFactory over Runnable interface or Thread class.

<br>

Refer:

[https://www.jcabi.com/jcabi-log/apidocs-0.7.5/com/jcabi/log/VerboseThreads.html](https://www.jcabi.com/jcabi-log/apidocs-0.7.5/com/jcabi/log/VerboseThreads.html)

[https://log.jcabi.com/threads-VerboseProcess.html](https://log.jcabi.com/threads-VerboseProcess.html)
