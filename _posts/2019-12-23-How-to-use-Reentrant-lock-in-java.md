---
layout: post
title: How to use ReentrantLock in Java
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading]
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

What would happen if a thread is blocked inside the block? It means that the probably wrongly blocked. That is, there is some kind of bug in the **init()** method that will prevent a thread from existing this guarded block of code. It turns out that all the other threads are also blocked. No other thread will be allowed in that block of code. All the threads waiting to enter this block of code are also blocked and there is no way in the JDK nor the JVM to release them. So when this kind of situation occurs, most of the time, the only way to solve this problem is to reboot the JVM, that is to shutdown the application, and to load yet again.

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

## Understanding about Condition object

The **Condition** object is used to park and awake threads. It is built from the **Lock** object and the primary benefits is that a **Lock** object can have any number of **Condition** object linked to it, something is not possible with Object based locking and waiting.

Condition objects are used in much the same way as the locking and waiting capability built into each Java object.

We need to be a little careful because this condition object as all the Java objects extends the Object class, so it has **wait()** and **notify()** method, ... Those methods should not to be taken for **await()** and **signal()** methods. In fact, if we try to use them, they will not work since we are not in a **synchronized** block of code.

The **await()** call is blocking, but this is the difference with the **wait()** method from the Object class, it can be interrupted. We can interrupt the thread that is blocked on this **await()** call. It was not the case on the **wait()** method from the Object class. In fact, there are five versions of **await()** method.
- await()
- await(time, timeUnit)
- awaitNanos(nanosTimeout)
- awaitUntil(date)
- awaitUninterruptibly()

    If we do not want the await() call to be interrupted, we can also call awaitUninterruptibly() method. That will prevent the interruption of a thread to interrupt this method call. So this API give us ways to prevent the blocking of waiting threads with the Condition API. It's possible to create fair Locks and a fair lock will generate fair Conditions. If several threads are calling this await() method one at a time, they will be awakened in the same order.

<br>

## How to use Read/Write Locks

1. Given problem

    In some cases, what we need is exclusive writes. That is what we want to do is to guard the block of code that is going to modify a variable or a collection, or a map, but we want to allow for parallel reads of this variable or of this collection or map. And this is not how regular locks work.
    
    If the block of code that is going to modify this variable and the block of code that is going to read it, we will have exclusive writes and also exclusive reads. This is what read/write lock does, for instance, the way using synchronized keyword for the block of code or method.

2. Solution

    With the above situation, Java provides a solution - ReadWriteLock. It is an interface with only two methods.
    - readLock() to get a read lock.
    - writeLock() to get a write lock.

    Both the read lock or write lock are instances of the Lock interface.

    Some rules with the ReadWriteLock:
    - Only one thread can hold the write lock.
    - When the write lock is held, no one can hold the read lock.
    - As many threads as needed can hold the read lock.
    
        It means that if we guard a block of code with a write lock, the execution of this block of code would be exclusive. And if we guard another block of code with the read lock, this block of code will be available for as many threads as we need.

3. Implementation of Read/Write Locks

    ```java
    ReadWriteLock readWriteLock = new ReentrantReadWriteLock();
    Lock readLock = readWriteLock.readLock();
    Lock writeLock = readWriteLock.writeLock();
    ```

    ReentrantReadWriteLock is the implementing class provided by the JDK. From the readWriteLock object, we create two locks: read lock and write lock. Then get a read and a write lock as a pair from this read/write lock.
    
    Those two locks can be used to create a thread safe cache.
    
    ```java
    Map<Long, User> cache = new HashMap<>();
    try {
        readLock.lock();
        return cache.get(key);
    } finally {
        readLock.unlock();
    }
    ```

    A cache can be implemented using a basic HashMap. Reading a cache is guarded by the read lock, the structure is as same as the structure of basic Lock object. Knowing the semantic of this read lock object, we know that any number of thread can read this cache at the same time.

    Then, it is the write lock for this cache.

    ```java
    Map<Long, User> cache = new HashMap<>();
    try {
        writeLock.lock();
        cache.put(key, value);
    } finally {
        readLock.unlock();
    }
    ```

    The write-locking protects the modification of the cache and will prevent concurrent read that could read corrupted value. It could also be achieved with a ConcurrentHashMap.

<br>

## When to use

- use it when we actually need something it provides that ```synchronized``` doesn't, like timed lock waits, interruptible lock waits, non-block-structured locks, multiple condition variables, or lock polling.

- ```ReentrantLock``` also has scalability benefits, and we should use it if we actually have a situation that exhibits high contention, but remember that the vast majority of synchronized blocks hardly ever exhibit any contention, let alone high contention. We would advise developing with synchronization until synchronization has proven to be inadequate, rather than simply assuming **the performance will be better** if we use ```ReentrantLock```.


<br>

## Source code

1. Using Interruptible Lock Acquisition

    ```java
    Lock lock = new ReentrantLock();
    try {
        lock.lockInterruptibly();
        // do something
    } finally {
        lock.unlock();
    }
    ```

    This is the interruptible pattern. We call the **lockInterruptibly()** method which will have the same kind of semantic as the **lock()** method call, that is the thread will wait until it can enter the guarded block of code. Now if another thread has a reference on it, that another thread can interrupt it by calling its **interrupt()** method.
    
    This was not possible with the synchronized pattern. This can be costly. It can be hard to achieve from a pure implementation prospective, but it is possible.

2. Using Time Lock Acquisition

    ```java
    Lock lock = new ReentrantLock();
    if (lock.tryLock()) {
        try {
            // guarded block of code
        } finally {
            lock.unlock();
        }
    } else {
        // do something
    }
    ```

    This is a timed lock acquisition. It means that instead of calling the **lock()** method, can call the **tryLock()** method and this time if a thread is already executing the guarded block of code, the **tryLock()** called will return **false** immediately. So instead of being lock, our thread will not enter the guarded block of code and will be able to do something else immediately.
    
    Note that we can also pass a timeout to this **tryLock()** method, for example, our thread will wait for 1 second. If the guarded block of code is still not available after this timeout, it will execute the **else block of code**.


3. Using Fair Lock Acquisition

    Suppose we have several threads waiting for a given lock. Whether it is an intrinsic or explicit lock, the first one to enter the guarded block of code is chosen randomly. This is the default behavior of both the synchronized keyword and the Lock object. Fairness means that the first to enter the wait line is the first to enter the block of code.

    ```java
    Lock lock = new ReentrantLock();    // non-fair mode
    try {
        lock.lock();
        // guarded block of code
    } finally {
        lock.unlock();
    }
    ```

    By default, a ReentrantLock built in the normal way is non-fair, meaning that if two threads are waiting to acquire this lock, we do not know in advance which one is going to execute the guarded block of code first. Now if we pass the true Boolean when building this Lock object, this Lock object becomes a fair ReentrantLock or a fair lock.
    
    ```java
    Lock lock = new ReentrantLock(true);    // fair mode
    ```

    It means that if two threads are waiting to acquire, the first one to the guarded block of code will be the first that enter the wait list.

    A fair lock is costly, so using fairness is not activated by default and we should really use that only if we need it absolutely.

<br>

## Benefits and Drawbacks

1. Benefits

    - ```Reentrant Lock``` provides explicit locking that is much more granular and powerful than ```synchronized``` keyword.

        For example:
        - The scope of lock can range from one method to another but scope of ```synchronized``` keyword can not go beyond one method.

    - Lock framework also supply ```Condition variables``` that are instances of ```Condition``` class, which provides inter thread communication methods similar to ```wait()```, ```notify()``` and ```notifyAll()``` such as ```await()```, ```signal()``` and ```signalAll()```.

        So, if one thread is waiting on a condition by calling ```condition.await()```, then once that condition changes, second thread can call ```condition.signal()``` or ```condition.signalAll()``` method to notify that its time to wake up, condition has been changed.

2. Drawbacks

    - Difficult to use, understand for the novice programmers.

<br>

## Wrapping up

- In Read/Write locks, the pair of read and write locks must be created from the same ReadWriteLock object.

- In Read/Write locks, write operations are exclusive of other writes and reads. But read operations can be made in parallel. It thus allows for superior throughput, especially when we have reads and few writes, which is usually the assumption made when we create caches.


<br>

Refer:

[Advanced Java Concurrent Patterns by Jose Paumard](https://app.pluralsight.com/library/courses/java-concurrent-patterns-advanced/table-of-contents)