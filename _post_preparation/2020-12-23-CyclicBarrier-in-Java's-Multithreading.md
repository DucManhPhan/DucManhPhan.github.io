---
layout: post
title: CyclicBarrier in Java's Multithreading
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading, Java]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of CyclicBarrier](#Solution-of-CyclicBarrier)
- [When to use](#when-to-use)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [The difference between CountDownLatch and CyclicBarrier](#the-difference-between-countdownlatch-and-cyclicbarrier)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Before jumping into **CyclicBarrier** - how it works, we need to read about the article [CountDownLatch in Java's Multithreading](https://ducmanhphan.github.io/2020-02-12-CountDownLatch-in-Java's-multithreading/).

The drawback of **CountDownLatch** is the reusable property. Because when the current count of **CountDownLatch** is equal to zero, the current count does not reset again.

And **CountDownLatch.await()** will be called in the main thread, to continue the main thread's tasks. It's difficult to use when we need to do the other task, not in the main thread, if the remained threads finished.

The **CountDownLatch.await()** method will block the main thread to wait for all other threads completely finishes. Sometimes we do not need this situation, we want do the other task without blocking the main thread.

So how does reduce these drawbacks?

<br>

## Solution of CyclicBarrier

To solve all above issues, Java provides CyclicBarrier. **CyclicBarrier** was introduced in Java 5 that is acompanied with CountDownLatch, Semaphore, ... 

Belows are some steps to describe how **CyclicBarrier** works.
- First, we need to construct **CyclicBarrier** with the number of threads and (optional) the barrier action will be implemented after all threads reach barrier.

    ```java
    int numThreads = 5;
    Runnable barrierAction = () -> System.out.println("Barrier action will be implemented when other threads finished.");
    CyclicBarrier barrier = new CyclicBarrier(numThreads, barrierAction);

    // ...
    ```

    From the document of CyclicBarrier on [docs.oracle.com](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CyclicBarrier.html), we have:

    ```java
    // Creates a new CyclicBarrier that will trip when the given number of parties (threads) are waiting upon it,
    // and which will execute the given barrier action when the barrier is tripped,
    // performed by the last thread entering the barrier.
    public CyclicBarrier(int parties, Runnable barrierAction);

    // Creates a new CyclicBarrier that will trip when the given number of parties (threads) are waiting upon it,
    // and does not perform a predefined action when the barrier is tripped.
    public CyclicBarrier(int parties)
    ```

- Second, pass our **CyclicBarrier**'s instance to the threads. In each thread, we need to call **CyclicBarrier.await()** method. It will wait until all parties have invoked await on this barrier.

    Below is the information of await() method we need to know:

    ```java
    public int await() throws InterruptedException, BrokenBarrierException;

    public int await(long timeout, TimeUnit unit) throws InterruptedException, BrokenBarrierException, TimeoutException;
    ```

    If the current thread is not the last thread, but it called **CyclicBarrier.await()** method, then 

<br>

## When to use





<br>

## Source code




<br>

## Benefits and Drawbacks






<br>

## The difference between CountDownLatch and CyclicBarrier





<br>

## Wrapping up




<br>

Refer:

[]()