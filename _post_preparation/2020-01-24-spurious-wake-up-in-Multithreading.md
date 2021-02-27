---
layout: post
title: Spurious wake up in Multithreading
bigimg: /img/image-header/factory.jpg
tags: [Multithreading]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution for this problem](#solution-for-this-problem)
- [Some types of monitors](#some-types-of-monitors)
- [How to overcome Spurious wake up](#how-to-overcome-Spurious-wake-up)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Before going straight into the concept of Supurious wake up problem, we will look at the below example:

```java
class Resource {

    private Object lock = new Object();

    public synchronized void doSomething1() {
        wait();

        // after switching to active status, do something else
        ...
    }

    public synchronized void doSomething2() {
        if (satisfies-condition) {
            notify();
        }

        // do something
        ...
    }
}
```

Belows are the meaning of the source code:
- Assuming that we have two thread T1, and T2, and T1 takes the intrinsic lock object that is faster than T2 thread.

- Firstly, T1 enters the **doSomething1()** method, so it calls **wait()** method.

    Some operations that will be implemented after called **wait()** method.
    - T1 will release that intrinsic lock object.
    - Then, its state is set to WAITING state. In some other references, this state is BLOCKING state.
    - Finally, it will be pushed into the waiting queue of the corresponding that monitor lock object.

- Secondly, after the intrinsic lock was released, T2 will take it and implement **doSomething2()** method.

    If our **satisfies-condition** is true, then **notify()** method can be called.
    
    Some operations that are listed after called **notify()** method.
    - Thread Scheduler will select one of threads in that lock object's the **waiting queue** to alive.
    - Moves that thread from the **waiting queue** to the **entry queue**.
    - Sets the state of the selected thread from **WAITING** or **BLOCKING** to **RUNNALBE**.

    After the **notify()** method is called, our intrinsic lock object wasn't out of control of the thread T2. When thread T2 has just gone out of the **doSomething2()** method, this lock will be released automatically. Then, thread T1 will continue working in **doSomething1()** method.

The above operations are luckly a happy case, but in the concurrency programming, there still is a chance that a thread wakes up without being notified, interrupted, or timming out. It is called as the supurious wakeup problem.

The relationship between Thread Scheduler with Spurious wake up problem:
- 
- 
- 

The drawbacks of Spurious wake up:
- This problem can cause a hidden bug that we don't find it easily.

    In a huge project, it's difficult to track, and reproduce that bug because of rarely happenning.

<br>

## Solution for spurious wakeup problem

To prevent the supurious wakeup problem, we need to use **wait()** method in a while loop that tests for the condition holding and reexecutes **wait()** method when the condition still doesn't hold.

```java
public synchronized void doSomething1() {
    while (condition) {
        wait();
    }

    // after switching to active status, do something else
    ...
}
```

<br>

## Some types of monitors

1. Mesa monitor




2. Hoare monitor




<br>

## How to overcome Spurious wake up






<br>

## Wrapping up

- 




<br>

Refer:

[https://en.wikipedia.org/wiki/Spurious_wakeup](https://en.wikipedia.org/wiki/Spurious_wakeup)

[https://errorprone.info/bugpattern/WaitNotInLoop](https://errorprone.info/bugpattern/WaitNotInLoop)

[https://pubs.opengroup.org/onlinepubs/009604599/functions/pthread_cond_timedwait.html](https://pubs.opengroup.org/onlinepubs/009604599/functions/pthread_cond_timedwait.html)

[]()