---
layout: post
title: Using wait, notify in synchronized method/block of Multithreading Java
bigimg: /img/image-header/factory.jpg
tags: [Multithreading, Java]
---



<br>

## Table of contents
- [Understanding about synchronized keyword](#understanding-about-synchronized-keyword)
- [Understanding wait(), notify() and notifyAll() methods](#understanding-wait()-notify()-and-notifyAll()-methods)
- [What is Object monitor?](#what-is-object-monitor?)
- [Wrapping up](#wrapping-up)


<br>

## Understanding about synchronized keyword




<br>

## Understanding wait(), notify() and notifyAll() methods
1. ```wait()``` method

    The ```wait()``` method is exposed on each Java object. Each java object can act as a condition variable.

    ```java

    ```

    Note:
    - ```wait()``` method must occur in synchronization.
    - should occur in loop on the wait condition

        ```java
        synchronized(lock) {
            while (!conditional) {
                lock.wait();
            }
        }
        ```


2. ```notify()``` method

    ```java

    ```

    Note:
    - Nothing happends to the current thread that calls notify() method, it continues to run until it's natural end.

        The ```wait()``` and ```notify()``` methods must be called within a synchronized context. As soon as the synchronized block that contains the ```notify()``` call finishes, the lock is then available and the block containing the ```wait()``` call in another thread can then continue.

        Calling notify simply moves the waiting thread back into the runnable thread pool. That thread can then continue as soon as the lock is available.



3. ```notifyAll()``` method





<br>

## What is Object monitor?





<br>

## Producer/Consumer pattern using wait/notify




<br>

## Producer/Consumer pattern using BlockingQueue






<br>

## Wrapping up




<br>

Refer:

[https://javarevisited.blogspot.com/2015/07/how-to-use-wait-notify-and-notifyall-in.html](https://javarevisited.blogspot.com/2015/07/how-to-use-wait-notify-and-notifyall-in.html)