---
layout: post
title: How to apply Producer/Consumer pattern in Java's multithreading
bigimg: /img/image-header/factory.jpg
tags: [Multithreading, Java, Concurrency Pattern]
---



<br>

## Table of contents
- [Understanding about Producer/Consumer pattern](#understanding-about-producer/consumer-pattern)
- [When to use](#when-to-use)
- [Producer/Consumer pattern using wait/notify](#producer/consumer-pattern-using-wait/notify)
- [Producer/Consumer pattern using Lock framework](#producer/consumer-pattern-using-lock-framework)
- [Producer/Consumer pattern using BlockingQueue](#producer/consumer-pattern-using-blockingqueue)
- [Producer/Consumer pattern with Semaphore](#producer/consumer-pattern-with-semaphore)
- [Common questions with Producer/Consumer](#common-questions-with-producer/consumer)
- [Wrapping up](#wrapping-up)


<br>

## Understanding about Producer/Consumer pattern






<br>

## When to use




<br>

## Producer/Consumer pattern using wait/notify
1. Runnable pattern

    This is the first pattern used to launch threads in Java. It is introduced in Java 1.0. Other patterns have been introduced in Java 5.

    In Java 1, the model of a task is the **Runnable** interface. It's very simple interface called Runnable. Since this method has only one method, in Java 8, it became a functional interface with **@FunctionalInterface** annotation added to it. It does not change anything in Java 7. It does not introduce any kind of backward incompatibility. It is just leveraging a new feature of the Java 8 compiler.

    ```java
    @FunctionalInterface
    public interface Runnable {
        void run();
    }
    ```

    This **Runnable** interface can be implemented using a lambda expression.

    ```java
    Runnable task = () -> System.out.println("Hello, world!");
    ```

    - How to stop a thread

        There is a method in the Thread class called **stop()**. But we should not use this method to stop a thread because if we check the documentation on this method, we will have the exact reasons that this method has in fact been introduced in the first version of the Thread class before the people who write it realized that it was a wrong idea to create such a method. The problem is once this method was published, it was not possible to remove it on the Thread class without introducing a backward incompatibility. It is there for legacy, backward compatibility reasons. It will not be removed in future versions but the only thing we want to know with this method is that we should stay away from it.

        The right pattern to stop a thread is to use the **interrupt()** method. The tricky is the **interrupt()** method will not stop a thread, but merely send a signal to the task the thread is running, telling it that it is time for this task to stop itself.

        ```java
        Runnable task = () -> {
            while (!Thread.currentThread().isInterrupted()) {
                // the task itself.
            }
        }
        ```

        If the thread is blocked, or waiting, then the corresponding method will throw an **InterruptedException**.

        The methods **wait()**, **notify()**, **join()** throw **InterruptedException**.

2. Using Producer/Consumer with wait/notify

    A producer produces values in a buffer. A consumer consumes the values from this buffer. Be careful, the buffer can be empty, or full.

    Producers and consumers are run in their own thread.

    - If we do not use wait/notify pattern, then we have:

        ```java
        public static Object lock = new Object();

        public class Consumer {
            public void consume() {
                synchronized(lock) {
                    while (isEmpty(buffer)) {}
                    buffer[--count] = 0;
                }
            }
        }

        public class Producer {
            public void produce() {
                synchronized(lock) {
                    while (isFull(buffer)) {}
                    buffer[++count] = 1;
                }
            }
        }
        ```

        Our prolem happens when buffer is empty. Well, the thread executing this consumer will be running the **isEmpty()** method inside this infinite while loop forever. So this thread will be blocked inside the **consume()** method, inside the synchronized block, while holding the key of the lock object.

        So what is going happen in the producer?

        The thread running the producer will be waiting for the key held this lock object and since this key is not available because it is held by the consumer thread, it will not be able to execute its synchronized block. So it will have no chance to add any object to buffer. In fact, this way of writing things, this way of naively synchronizing our two methods is not the right way to do it, it will lead to a deadlock.

    - Use **wait()**/**notify()**

        Calling the **wait()** method releases the key held by this thread. So this key is available to the other thread. And it puts the current thread in a particular state called the WAIT state. The WAIT state is not the same as the state in which a thread is when it is waiting at the entrance of a synchronized block. It is a special thread state. The only way to release a thread from a WAIT state is to notify it.

        Calling the **notify()** method released a thread that is in the **WAIT** state, so a thread that has called a **wait()** method and puts it in **RUNNABLE** state. And this is the only way to release a waiting thread. So if we never call the **notify()** method in our code, at some point, the new application will most probably not work properly. If there are more than one thread in the **WAIT** state, and this is the case most of the time, the released thread by the **notify()** method is chosen randomly among these threads. We also have a **notifyAll()** method that will awake all the threads in the **WAIT** state.

        ```java
        public class Producer {
            public void produce() {
                synchronized(lock) {
                    while (isFull(buffer)) {
                        lock.wait();
                    }

                    buffer[count++] = 1;
                    lock.notifyAll();
                }
            }
        }

        public class Consumer {
            public void consume() {
                synchronized(lock) {
                    while (isEmpty(buffer)) {
                        lock.wait();
                    }

                    buffer[--count] = 0;
                    lock.notifyAll();
                }
            }
        }
        ```

<br>

## Producer/Consumer pattern using Lock framework





<br>

## Producer/Consumer pattern using BlockingQueue






<br>

## Producer/Consumer pattern with Semaphore






<br>

## Common questions with Producer/Consumer
1. How to resolve the producer/consumer problem so that my CPU cycle can be used to 100%. For example, if producer is producing less and consumer is consuming fast then your CPU cycle is getting wasted which is associated with cost. So what would be strategy to resolve this.





<br>

## Wrapping up




<br>

Refer:

[]()