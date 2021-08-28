---
layout: post
title: Some problems of CompletableFuture in Java
bigimg: /img/image-header/yourself.jpeg
tags: [Java, Multithreading]
---




<br>

## Table of contents
- []()
- []()
- []()
- []()
- []()


<br>

## 

```java
public static void main(String[] args) {
    CompletableFuture.runAsync(() -> System.out.println("Running asynchronously."));
}
```

When we run an above code, we can find that it does not print something else. Because this task has been launched in a Common Fork/Join pool of threads. This Common Fork/Join pool is made of demand threads that do not prevent the JVM from exiting, and the only non-demand thread that we have is the main thread. And the problem is that once we have finished to run the **runAsync()** method call, the main thread dies and so the JVM without giving a chance for our **Runnable** to be executed.

```java
public static void main(String[] args) {
    ExecutorService executor = Executors.newSingleThreadExecutor();
    Runnable task = () -> {
        System.out.println("Running asynchronously in the thread " + Thread.getCurrentThread().getName());
    };

    CompletableFuture.runAsync(task);

    Thread.sleep(1000);
    executor.shutdown();
}
```


<br>

## 






<br>

## 





<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()

[]()