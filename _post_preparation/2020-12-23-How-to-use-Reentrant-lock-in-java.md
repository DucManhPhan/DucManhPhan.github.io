---
layout: post
title: How to use ReentrantLock in Java
bigimg: /img/image-header/yourself.jpeg
tags: [Java, Multithreading]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of ReentrantLock](#solution-of-ReentrantLock)
- [When to use](#when-to-use)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Below is a disadvantage of intrinsic lock that we need to know when using ReentrantLock.

Normally, we have two ways of synchronization in Java, the **synchronized** keyword that can be used in several ways and the **volatile** keyword that we can use on failed declarations. Those two keywords are related to what is called **intrinsic locking**.

Now we will dig into some problems of intrinsic locking.

If we want to synchronize a method, for instance, the below init() method of the Person class. The best way to do that is to create a key object, which can be whatever object, and to place a synchronized block inside this method.

```java
public class Person {
    private final Object key = new Object();

    public String init() {
        synchronized(key) {
            // do something
        }
    }
}
```

This code synchronized of key prevents more than one thread to execute the guarded block of code at the same time. This is called the synchronized pattern in Java.

Now what happens if several threads are trying to execute the init() block? One of them will be allowed in the block, the others will have to wait for their turn to execute the same block of code. This is the basic synchronization pattern in Java.

What would happen if a thread is blocked inside the block? It means that the probably wrongly blocked. That is, there is some kind of bug in the init() method that will prevent a thread from existing this guarded block of code. It turns out that all the other threads are also blocked. No other thread will be allowed in that block of code. All the threads waiting to enter this block of code are also blocked and there is no way in the JDK nor the JVM to release them. So when this kind of situation occurs, most of the time, the only way to solve this problem is to reboot the JVM, that is to shutdown the application, and to load yet again.

<br>

## Solution of ReentrantLock

Normally, when we want to use synchronization in our method, we can write the below code:

```java
Object key = new Object();

synchronized(key) {
    // do something
}
```

Instead of writing the above code, that is creating a key object and passing this key object to a synchronized block of code, we are going to use ReentrantLock to replace the above code.

```java
Lock lock = new ReentrantLock();
try {
    lock.lock();

    // do something
} finally {
    lock.unlock();
}
```

We create an instance of the Lock interface, the JDK provides an implementing class which is called ReentrantLock, and inside the try...finally block of code, we call the lock() method of this Lock object and in the finally part, call the unlock() method, thus guaranteeing that this unlock() method will be called when exitting this block of code whatever happens after the lock() call.

Lock is an interface, implemented by ReentrantLock. It is part of the java.util.concurrent package introduced in Java 5 in 2004. It offers the same guarantees, that is exclusion explicitly, read & write ordering, that is visibility, happens-before link between operation as the synchronize pattern.


<br>

## When to use




<br>

## Source code

1. Using Interruptible Lock Acquisition

    

2. Using Time Lock Acquisition




3. Using Fair Lock Acquisition




<br>

## Benefits and Drawbacks




<br>

## Wrapping up




<br>

Refer:

[]()