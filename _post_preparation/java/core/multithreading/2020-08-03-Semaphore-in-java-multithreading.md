---
layout: post
title: Semaphore in Java's Multithreading
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading, Java]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Semaphore](#solution-of-semaphore)
- [When to use](#when-to-use)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution of Semaphore

A Semaphore is a well-known concept in concurrent programming. It does not come from Java. It comes from the very early days of the unique operating systems. It looks like a lock, but allows several threads in the same block of code. In fact, semaphore is built and a number of permits, this number of permits is the number of threads in this block of code.

Below is the source code of Semaphore in Java.

```java
Semaphore semaphore = new Semaphore(5);
try {
    semaphore.acquire();
    // guarded block of code
} finally {
    semaphore.release();
}
```

When we create a semaphore in Java, we have to fix the number of permits on which the semaphore is built. Then there is an **acquire()** method to acquire a permit and be allowed in a guarded block of code and a **release()** method to release this permit.

A semaphore built in the normal way, and the default way, is non-fair. It means that if there are threads waiting for permits, they will be accepted randomly in the guarded block of code. This **acquire()** method, is blocking until a permit is available. So, in our example, at most 5 threads can execute the guarded block of code at the same time.

A Semaphore can be made fair. If we pass the **true** Boolean as the second parameter of the construction of this object, each will create a fair semaphore. The **acquire()** method can ask for more than one permit at a time. Then the **release()** method must release them all.

```java
Semaphore semaphore = new Semaphore(5, true);      // fair
try {
    semaphore.acquire(2);
    // guarded block of code
} finally {
    semaphore.release(2);
}
```

In an above example, **acquire()** method will ask for 2 permits, and if there is only 1 available, the thread executing this code will have to wait for a second 1 to be released. If we ask for 2 permits, we should also release two permits.

<br>

## When to use

- 



<br>

## Source code

1. Using interruptibly

    ```java
    Semaphore semaphore = new Semaphore(5);
    try {
        semaphore.acquireUninterruptibly();
        // guarded block of code
    } finally {
        semaphore.release();
    }
    ```

    If we call the **interrupt()** method on a thread that is blocked on an **acquire()** method, this thread will throw an **InterruptedException** at once. If we do not want this behavior, then we can call the **acquireUninterruptibly()** method on this semaphore object, and in this case, this thread cannot be interrupted. The only way to free aim is by calling its **release()** method.

    If we interrupt that thread, it will not do anything at the moment of the method call. But if a permit becomes available, this thread will not be allowed in the guarded block of code. It will instead throw InterruptedException.

2. Using acquisition

    ```java
    Semaphore semaphore = new Semaphore(5);
    try {
        if (semaphore.tryAcquire()) {
            // guarded block of code
        } else {
            // could not enter the guarded code
        }
    } finally {
        semaphore.release();
    }
    ```

    **tryAcquire()** method will see if a permit is available, and if it is not the case, it will fail, written false, and we will be able to execute some other code than the guarded block of code. 

    We can also pass the timeout to this **tryAcquire()** method.

    ```java
    Semaphore semaphore = new Semaphore(5);
    try {
        if (semaphore.tryAcquire(1, TimeUnit.SECONDS)) {
            // guarded block of code
        } else {
            // could not enter the guarded code
        }
    } finally {
        semaphore.release();
    }
    ```

<br>

## Some methods need to know




<br>

## Benefits and Drawbacks

1. Benefits



2. Drawbacks




<br>

## Wrapping up

- Semaphore that has some specific methods that do not exist on a classical Lock object. Those methods make a semaphore more than just a lock with more than one permit. In fact, we have methods to handle both the permits and the waiting threads.

    First we can reduce the number of permits after the Semaphore has been created. It is not possible to increase this number of permits.

    We also have methods to check if there are waiting threads on this semaphore, which is not possible on the Lock object.
    - Are there any waiting threads?
    - How many threads are waiting?
    - Get the collection of the waiting threads

- The difference between Semaphore and a Lock object is that Lock has only one permit and a Semaphore has more than one. And it is possible to query a semaphore for the number of waiting threads.

<br>

Refer:

[Advanced Java Concurrent Patterns by Jose Paumard](https://app.pluralsight.com/library/courses/java-concurrent-patterns-advanced/table-of-contents)