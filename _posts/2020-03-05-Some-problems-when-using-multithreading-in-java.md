---
layout: post
title: Some problems when using multithreading in Java
bigimg: /img/path.jpg
tags: [Multithreading]
---



<br>

## Table of contents
- [Do not use visibility property in multithreading](#do-not-use-visibility-property-in-multithreading)
- [Wrapping up](#wrapping-up)


<br>

## Do not use visibility property in multithreading

1. Given problem

    Below is the source code that has common bugs when we usually cope with:
    - Using double-checking singleton

        ```java
        public class Singleton {
            private static Singleton instance = null;
            
            private Singleton() {
                // nothing to do
            }

            public static Singleton getInstance() {
                if (instance == null) {
                    synchronized(Singleton.class) {
                        if (instance == null) {
                            instance = new Singleton();
                        }
                    }
                }

                return instance;
            }
        }
        ```

        At the first glance, we do not take care something about this code. But when we run this code, we find that it does not work well. So what is the mistake of this code?

        If we have multiple threads enter the **getInstance()** method, we can see that it has to check a condition ```instance == null```. But at the first time, all threads read the value of instance variable is null, so they continue going to synchronized block.

        In synchronized block, only one thread can enter it. After initialized instance variable, our instance is not null. Then, the second thread will jump into this block. It also check a condition ```instance == null```. But the second thread find that the value of instance variable is still null. Also, it initialize the instance variable. So at this point, we have two instance variable. It violates the rule of Singleton that is **single instance** and **global access**.

        Why does it happen?

        To answer this question, we will go to the next section.

    - Reading shared resource

        ```java
        public class Resource {

            private int count = 1;

            public synchronized void setCount(int count) {
                this.count = count;
            }

            public int getCount() {
                return this.count;
            }
        }
        ```

        When we have two threads T1 and T2 that using the same Resource instance, T1 update value for **count** field by using **setCount()** method with 2 value. T2 reads **count** value. T1 runs first, T2 next

        But in T1 thread, we read count value = 1;

        Why does it happen here?

2. Solution

    The mistake of an above problem is that the changes of the shared resource is not visible in the other threads.

    Belows are solution for each problem
    - Using double-checking singleton

        We need to use volatile keyword for the instance variable.

        ```java
        private static volatile Singleton instance = null;
        ```

    - Reading shared resource

        We will use **synchronized** keyword for **get()** method.

        ```java
        public synchronized void getCount() {
            return this.count;
        }
        ```

        When thread T1 executes a synchronized block, and subsequently thread T2 enters a synchronized block guarded by the same lock, the values of variables that were visible to T1 prior to releasing the lock are guaranteed to be visible to T2 upon acquiring the lock.

        It means that everything T1 did in or prior to a synchronized block is visible to T2 when it executes a synchronized block guarded by the same lock. Without synchronization, there is no guarantee.

<br>

## Wrapping up

- In order to apply the visibility property, we need to use some things:

    - Use intrinsic lock
    - Use volatile


<br>

Refer:

[Java concurrency in practice]()