---
layout: post
title: Waiting threads to finish completely in Java
bigimg: /img/path.jpg
tags: [Java, Multithreading]
---

In this article, we will learn how to wait our threads to finish completely. Let's get started.

<br>

## Table of contents
- [Using join() method of Thread class](#using-join()-method-of-Thread-class)
- [Using CountDownLatch](#using-countdownlatch)
- [Using shutdown(), isTerminated() methods of Executors](#using-shutdown()-isTerminated()-methods-of-executors)
- [Using invokeAll() method of ExecutorService](#using-invokeAll()-method-of-executorservice)
- [Using invokeAll() method of ExecutorCompletionService](#using-invokeAll()-method-of-executorcompletionservice)
- [Wrapping up](#wrapping-up)


<br>

## Using join() method of Thread class

The easiest way to deal with our problem is to use **join()** method of Thread class.

```java

```

<br>

## Using CountDownLatch





<br>

## Using shutdown(), isTerminated() methods of Executors



<br>

## Using invokeAll() method of ExecutorService





<br>

## Using invokeAll() method of ExecutorCompletionService





<br>

## Wrapping up
- Whenever we want to block a thread until another unit of work completes, we should never block infinitely.

    The **await()** method, like the **Future.get()** method, is overloaded to take either no parameters, or a pair of parameters to determine how long to wait. If we use the option of waiting for a specific time, an InterruptedException will be thrown if no response has come in the specific time.

    If we use the option with no parameters, the **await()** method will block forever. So if the operation we are waiting on has crashed, and will never return, our application will never progress.

    Whenever we are waiting on a parallel operation to complete, whether that is in another thread, or, for instance, on a web service to return us some data, we should consider how to react if that operation never return.


<br>

Refer:

[https://www.baeldung.com/java-executor-wait-for-threads](https://www.baeldung.com/java-executor-wait-for-threads)

[https://howtodoinjava.com/java/multi-threading/executorservice-invokeall/](https://howtodoinjava.com/java/multi-threading/executorservice-invokeall/)

[https://howtodoinjava.com/security/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/](https://howtodoinjava.com/security/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/)