---
layout: post
title: How to use @Async annotation in Spring
bigimg: /img/path.jpg
tags: [Java, Spring]
---



<br>

## Table of contents

- [How to use @Async annotation](#how-to-use-@async-annotation)
- [Source code](#source-code)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to @Async annotation




<br>

## How to use @Async annotation
Belows are some steps to use **@Async** annotation in our project.

1. Configure package in pom.xml to use @Async annotation

    If we want to experience maven project with @Async annotation, not use Spring boot, we can use some the below packages.

    ```xml
    <properties>
        <spring.version>4.1.7.RELEASE</spring.version>
    </properties>

    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-core</artifactId>
      <version>${spring.version}</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context</artifactId>
      <version>${spring.version}</version>
    </dependency>
    ```

2. Use **@EnableAsync** annotation with our configuration class

    ```java
    @Configuration
    @EnableAsync
    public class AppConfig {
    }
    ```

    By default, **@EnableAsync** detects Spring's @Async annotation.

3. Use @Async annotation for our method

    In order to use @Async, we need to know about some crucial things:
    - @Async must be applied to public method only.
    - self-invocation - calling the async method from within the same class. It won't work

    The @Async used with public method that have void return type or return type **Future<T>**, **CompletableFuture<T>**.

    ```java
    @Async
    public void displayNumbers() {
        // ...
    }

    @Async
    public Future<String> doSomething() {
        // ...
    }

    @Async
    public CompletableFuture<String> doSomething() {
        // ...
    }
    ```

    If the return type is void, exceptions will not be propagated to the calling thread. So, we need to create asynchronous exception handler that implement **AsyncUncaughtExceptionHandler** interface. When an exception is thrown in method with void return type, the **handleUncaughtException()** method will be called.

    ```java
    public class CustomAsyncExceptionHandler implements AsyncUncaughtExceptionHandler {
        @Override
        public void handleUncaughtException(Throwable throwable, Method method, Object... obj) {
            System.out.println("Exception message - " + throwable.getMessage());
            System.out.println("Method name - " + method.getName());
            for (Object param : obj) {
                System.out.println("Parameter value - " + param);
            }
        }
    }
    ```

4. Customize our Executor

    Because each method that is marked with @Async annotation, it will be run on one thread. So, to manage all of threads, we need to have a thread pool. By default, a **SimpleAsyncTaskExecutor** is used.

    So, to customize our default thread pool, we can override it at two levels that are application level, and the individual method level.

    - In the method level

        ```java
        @Configuration
        @EnableAsync
        public class AppConfig {
            @Bean("threadPoolTaskExecutor")
            public TaskExecutor getAsyncExecutor() {
                ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
                executor.setCorePoolSize(20);
                executor.setMaxPoolSize(1000);
                executor.setWaitForTasksToCompleteOnShutdown(true);
                executor.setThreadNamePrefix("Async-");
                return executor;
            }
        }

        @Service
        public class EmailService {
            @Async("threadPoolTaskExecutor")
            public void displayThreadName() {
                System.out.println("Our thread's name - " + Thread.currentThread().getName());
            }
        }
        ```

    - In application level

        Our configuration class will implement the **AsyncConfigurer** interface.

        ```java
        @Configuration
        @EnableAsync
        public class AppConfig implements AsyncConfigurer {
            @Override
            public Executor getAsyncExecutor() {
                return new ThreadPoolTaskExecutor();
            }
        }
        ```

<br>

## Source code





<br>

## When to use




<br>

## Benefits and Drawbacks






<br>

## Wrapping up







<br>

Refer:

[https://www.baeldung.com/spring-async](https://www.baeldung.com/spring-async)

[https://howtodoinjava.com/spring-boot2/rest/enableasync-async-controller/](https://howtodoinjava.com/spring-boot2/rest/enableasync-async-controller/)