---
layout: post
title: How to use volatile keyword in Java
bigimg: /img/image-header/factory.jpg
tags: [Multithreading, Java]
---



<br>

## Table of contents
- [Introduction to volatile keyword](#introduction-to-volatile)
- [When to use](#when-to-use)
- [Benefits and drawbacks](benefits-and-drawbacks)
- [Common questions about volatile](#common-questions-about-volatile)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to volatile keyword






<br>

## Intrinsic Locking

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

## When to use

- ```volatile``` keyword is used in creating thread-safe ```Singleton``` by double-checking the singleton instance.

    [http://www.cs.umd.edu/~pugh/java/memoryModel/DoubleCheckedLocking.html](http://www.cs.umd.edu/~pugh/java/memoryModel/DoubleCheckedLocking.html)



<br>

## Benefits and drawbacks
1. Benefits




2. Drawbacks
- 


<br>

## Common questions about volatile





<br>

## Wrapping up




<br>

[https://www.geeksforgeeks.org/volatile-keyword-in-java/](https://www.geeksforgeeks.org/volatile-keyword-in-java/)

[http://tutorials.jenkov.com/java-concurrency/volatile.html](http://tutorials.jenkov.com/java-concurrency/volatile.html)

[https://www.ibm.com/developerworks/library/j-jtp03304/#2.0](https://www.ibm.com/developerworks/library/j-jtp03304/#2.0)

[https://stackoverflow.com/questions/106591/what-is-the-volatile-keyword-useful-for](https://stackoverflow.com/questions/106591/what-is-the-volatile-keyword-useful-for)

[https://javarevisited.blogspot.com/2011/06/volatile-keyword-java-example-tutorial.html](https://javarevisited.blogspot.com/2011/06/volatile-keyword-java-example-tutorial.html)

[https://www.javatpoint.com/volatile-keyword-in-java](https://www.javatpoint.com/volatile-keyword-in-java)

[https://www.baeldung.com/java-volatile](https://www.baeldung.com/java-volatile)

[https://www.java67.com/2012/08/what-is-volatile-variable-in-java-when.html](https://www.java67.com/2012/08/what-is-volatile-variable-in-java-when.html)

[https://www.javacodegeeks.com/2018/03/volatile-java-works-example-volatile-keyword-java.html](https://www.javacodegeeks.com/2018/03/volatile-java-works-example-volatile-keyword-java.html)

[https://stackoverflow.com/questions/8698285/when-to-use-volatile-vs-synchronization-in-multithreading-in-java](https://stackoverflow.com/questions/8698285/when-to-use-volatile-vs-synchronization-in-multithreading-in-java)

