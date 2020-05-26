---
layout: post
title: CountDownLatch in Java's Multithreading
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading, Java]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of CountDownLatch](#solution-of-countdownlatch)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Source code](#source-code)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Normally, when we want multiple threads work together, we usually utilize some common keyword and methods such as **synchronized**, **wait()**, **notify()**, **join()**. Our problem is that we need to run multiple threads before the main thread. But using them to solve this problem has some drawbacks:

- **wait()**, **notify()** method only work on the segment code of **synchronized** keyword.

    The problem of using **wait()** method is the spurious wake up. Spurious wake up is a phenomena where a waiting thread is awaken without a notify signal. This can be happened due to OS. So in some cases, if code is not written properly, it ended up with an error or deadlock.

- Using **join()** method makes our code duplicated, difficult to maintain. Because we have to call **join()** method of multiple threads.

- Using **wait()**, **notify()**, **join()** method and synchronized keyword is difficult to use when we manullay orchestrate among threads.

So, how to deal with the above drawbacks?

<br>

## Solution of CountDownLatch

**CountDownLatch** is defined in the package **java.util.concurrent**. It was introduced in Java 5. To solve the above problems when using synchronized keyword, wait(), notify(), and join() methods, CountDownLatch provides some functionalities:
- CountDownLatch handles spurious wake up.

- CountDownLatch takes responsibility to orchestrate among threads.

Belows are some steps to describe how **CountDownLatch** works.
- **CountDownLatch**'s instance is constructed with the **count** variable that is corresponding to the number of threads we want to work together.

- Pass that **CountDownLatch**'s instance into our threads. Then, each our threads works successfully, we need to call **countDown()** method to decrease the **count** variable, if the count is greater than zero. Then the new count is zero, all waiting threads are re-enabled for thread scheduling purposes.

    If the current count variable equals to zero, nothing happens.

- Finally, in the other thread, we need to call **await()** method of CountDownLatch's instance.

    In this **await()** method, it can happen some cases of the **count** variable.
    - If the current **count** is zero, then this method returns immediately.

    - If the current **count** is greater than zero, the current thread becomes disabled for thread scheduling purposes and lies dormant until one of two things happen:

        - The **count** reaches zero due to invocations of the **countDown()** method.
        - Some other thread interrupts the current thread.

    - If the current thread:

        - has its interrupted status set on entry to this method.
        - is interrupted while waiting.

        then **InterruptedException** is thrown and the current thread's interrupted status is cleared.

<br>

## When to use

- Use **CountDownLatch** when one or many threads require to wait for one or more threads to complete, before it can continue processing.


<br>

## Benefits and Drawbacks

1. Benefits

    - We do not need to know about reference of Thread class's instances

2. Drawbacks

    - Once the counter of **CountDownLatch** is equal to 0, it can not be set again or we cannot use CountDownLatch any more. To reset it, we need to use **CyclicBarrier**.

        It means that the CountDownLatch's not reusable.

<br>

## Source code

```java
ExecutorService service = Executors.newFixedThreadPool(5);
final CountDownLatch latch = new CountDownLatch(5);

IntStream.range(0, 5).forEach(item -> {
    service.submit(() -> {
            // do something
            // ...

            latch.countDown();
        });
});

latch.await();
```


<br>

## Wrapping up

- Memory consistency effects: Until the count reach zeros, actions in a thread prior to calling **countDown()** happen-before actions following a successful return from a corresponding **await()** in another thread.


<br>

Refer:

[https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CountDownLatch.html#countDown--](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CountDownLatch.html#countDown--)