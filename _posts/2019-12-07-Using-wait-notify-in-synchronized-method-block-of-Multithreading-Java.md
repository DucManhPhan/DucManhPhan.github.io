---
layout: post
title: Using wait, notify in synchronized method/block of Multithreading Java
bigimg: /img/image-header/factory.jpg
tags: [Multithreading, Java]
---

In this article, we will find something about synchronization such as what is synchronization, how to use wait, notify inside a synchronized block code.

Let's get started.

<br>

## Table of contents
- [Understanding about synchronization](#understanding-about-synchronization)
- [Synchrozing more than one method](#synchronizing-more-than-one-method)
- [Understanding wait(), notify() and notifyAll() methods](#understanding-wait()-notify()-and-notifyAll()-methods)
- [Wrapping up](#wrapping-up)


<br>

## Understanding about synchronization
Synchronization is used to prevent a block of code to be executed by more than one thread at the same time. From a technical point of view, it prevents the thread scheduler to give the hand to a thread that wants to execute the synchronized portion of code that has already been executed by another thread.

In [Understanding basic concepts in Java's multithreading](http://ducmanhphan.github.io/2019-11-26-Understanding-basic-concepts-in-Java-multithreading), we talked about race condition and the solution for it. So, in this section, we will use synchronization do deal with it.

```java
public class Singleton {

    private static Singleton instance;

    private Singleton() {}

    public static synchronized Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }

        return instance;
    }
}
```

So, to move on about synchronization, we need to answer a question - How does synchronization work under the hood?

Our Singleton class is a class with a ```getInstance()``` method that we want to synchronize. If it is not, any thread can run this method freely. Synchronizing means protecting this method by a fence, declared with the synchronized keyword.

Under the hood, the Java machine uses a special object, called a lock object, that has a key. In fact, every object in the Java language, has this key, that is used for synchronization. So, what does it change our code?

When a thread - T1 want to enter this protected method - ```getInstance()``` method, this protected method or block of code, it will make a request on this lock object, give me your key. If the lock object has the key available, it will give it to this thread, and this thread will be able to run the ```getInstance()``` method freely. If another thread - T2 wants to enter this synchronized block of code, it will make the same request on the lock object, but this time, the lock object has no key available for him. Why? Just because the lock object gave its key to the T1 thread. The lock object has only one single key. So the T2 thread has to wait for the key to be available.

At some point, the T1 thread will finish to run the ```getInstance()``` method, it will give back the key to the lock object, so this lock object will be able to give the key to the T2 thread and the T2 thread will be allowed to run a ```getInstance()``` method. When it has finished running this method, it will give back the key to the lock object. This mechanism is very simple, and will prevent more than one thread to execute the ```getInstance()``` method at the same time.

So, for synchronization to work, we need a special, technical object that will hold the key.

In fact, every Java object can play this role. This key is defined internally in the objet class, thus making it available for all the Java objects we define in our applications. It is worth noting that sometimes this key is also called a monitor in books and articles.

How do we know which object has been chosen to hold this key?
- A synchronized static method uses the class as a synchronization object.

    ```java
    public static synchronized Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }

        return instance;
    }
    ```

- A synchronized non-static method uses the instance as a synchronization object.

    ```java
    public synchronized String getName() {
        return this.name;
    }
    ```

- A third posibility is to use a dedicated object to synchronize

    It is a good idea to hide an object used for synchronization whether we are in a static context or not.

    ```java
    public class Person {
        private final Object key = new Object();

        public String init() {
            synchronized(key) {
                // do some stuff
            }
        }
    }
    ```

    So, instead of synchronizing the init() method, we can create the synchronized block inside this method, and pass this key object as a parameter of this synchronized keyword. 



<br>

## Synchrozing more than one method
Suppose we have a Person class with two methods in this class, getName() and getAge(). And we added synchronized keyword on the declaration of those methods. The lock object used by the JVM is the object itself, it means that it is an instance of the class we are in.

So, what is going to happen if a T1 thread wants to execute ```getName()```. It will take the key from the lock object, thus preventing a T2 thread from executing ```getAge()``` at the same time. Why? because since we did not declare any explicit object on the synchronization of our methods, the same key is used to synchronized both methods. This might not be what we need. If we need to synchronize ```getName()``` independently of ```getAge()```, then we need to create two lock objects in the Person class, and synchronize the block of codes inside the methods on those two different objects.

But now suppose that we have two instances of our Person class like the below:

|            Mary instance              |               John instance             |
| ------------------------------------- | --------------------------------------- |
| public synchronized String getName(); | public synchronized String getName();   |
| public synchronized int getAge();     | public synchronized int getAge();       |

Once again, the ```getName()``` and ```getAge()``` methods are synchronized using the ```synchronized``` keyword on the method declaration. It means that the instances Mary and John are used to synchronize those methods. So we have two lock objects with two key. The thread executing the ```getName()``` of the Mary instance object, does not prevent a thread from executing the ```getAge()``` from the John instance object. And it will not prevent another thread to execute this same ```getName()``` method on another object. We really need to keep in mind that, to understand how synchronization works, we need to identify which object is used as a lock and what are the keys used in our application.

Remember that using the synchronized keyword on a method declaration, uses an implicit lock object, which is the class object in the case of a static method, or the instance object itself in the case of a non-static method.

If we really want to prevent two threads to execute the ```getName()``` method at the same time, in all the instances of the Person class, then we need our lock object to be bound not to each instance of our class, but to the class itself. So, it has to be the static field of the Person class.

```Java
public class Person {

    private static Object monitor = new Object();

    private String name;

    private int age;

    public String getName() {
        synchronized(Person.monitor) {
            return this.name;
        }
    }

    public int getAge() {
        synchronized(Person.monitor) {
            return this.age;
        }
    }
}
```

<br>

## Understanding wait(), notify() and notifyAll() methods
1. ```wait()``` method

    The ```wait()``` method is exposed on each Java object. Each java object can act as a condition variable.

    When a thread executes the ```wait()``` method, it releases the monitor for the object and is placed in the wait queue.

    Note:
    - ```wait()``` method must occur insdie a synchronized block of code, if not, an IllegalMonitor exception is raised.
    - should occur in loop on the wait condition.

        ```java
        synchronized(lock) {
            while (!conditional) {
                lock.wait();
            }
        }
        ```


2. ```notify()``` method

    Like the ```wait()``` method, ```notify()``` method can only be called by the thread which owns the monitor for the object on which ```notify()``` is being called else an illegal monitor exception is thrown.

    The ```notify()``` method will awaken one of the threads in the associated wait queue.

    However, this thread will not be scheduled for execution immediately and will compete with other active threads that are trying to synchronize on the same object. The thread which executed notify will also need to give up the object's monitor, before any one of the competing threads can acquire the monitor and proceed forward.

    It means that the released thread is chosen randomly among those threads.

    Note:
    - Nothing happends to the current thread that calls ```notify()``` method, it continues to run until it's natural end.

        The ```wait()``` and ```notify()``` methods must be called within a synchronized context. As soon as the synchronized block that contains the ```notify()``` call finishes, the lock is then available and the block containing the ```wait()``` call in another thread can then continue.

        Calling ```notify()``` method simply moves the waiting thread back into the runnable thread pool. That thread can then continue as soon as the lock is available.



3. ```notifyAll()``` method

    This method will wake up all the threads that are waiting on the object's monitor.

<br>

## Wrapping up
- Understanding how does synchronization work under the hood.
- Some types of lock object in synchronization.

<br>

Refer:

[https://javarevisited.blogspot.com/2015/07/how-to-use-wait-notify-and-notifyall-in.html](https://javarevisited.blogspot.com/2015/07/how-to-use-wait-notify-and-notifyall-in.html)

Appying Concurrency and Multithreading to Common Java patterns in [pluralsight.com](pluralsight.com)

[https://javashareclub.online/2016/06/05/bai-hoc-ve-notify-va-notifyall/](https://javashareclub.online/2016/06/05/bai-hoc-ve-notify-va-notifyall/)

[https://blog.overops.com/5-things-you-didnt-know-about-synchronization-in-java-and-scala/](https://blog.overops.com/5-things-you-didnt-know-about-synchronization-in-java-and-scala/)

[https://javarevisited.blogspot.com/2015/06/java-lock-and-condition-example-producer-consumer.html#axzz66cRUo3Xi](https://javarevisited.blogspot.com/2015/06/java-lock-and-condition-example-producer-consumer.html#axzz66cRUo3Xi)

[https://docs.oracle.com/javase/tutorial/essential/concurrency/locksync.html](https://docs.oracle.com/javase/tutorial/essential/concurrency/locksync.html)

[https://javarevisited.blogspot.com/2012/10/difference-between-notify-and-notifyall-java-example.html](https://javarevisited.blogspot.com/2012/10/difference-between-notify-and-notifyall-java-example.html)

[https://peterwadid.files.wordpress.com/2013/02/packtpub-java-7-concurrency-cookbook-oct-2012.pdf](https://peterwadid.files.wordpress.com/2013/02/packtpub-java-7-concurrency-cookbook-oct-2012.pdf)