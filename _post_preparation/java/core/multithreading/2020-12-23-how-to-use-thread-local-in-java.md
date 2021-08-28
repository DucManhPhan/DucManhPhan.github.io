---
layout: post
title: How to use ThreadLocal in Java
bigimg: /img/image-header/yourself.jpeg
tags: [Multithreading]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of ThreadLocal](#solution-of-threadlocal)
- [When to use](#when-to-use)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Suppose that in a multithreading project, we need to create a data structure that is only used in each thread. When a new thread is created, that data structure is also created to contain that thread's information.

But according to Java memory model, we knew that corresponding each thread, there is an its own stack on RAM. From our current requirement, this data structure has to bring the characteristics of global variable and local variable. Because it needs to exist in global scope in a thread, but the other threads can't access to it. And it's also a representation of local scope, only in its stack. When a thread completely finishes its job, it automatically releases from JVM or RAM.

If we define a data structure with the **static** modifier, it will be shared by the multiple threads. To avoid the race condition happens in that data structure, we will use implicit lock with synchronized key word, or explicit lock with [Reentrant lock](http://ducmanhphan.github.io/2019-12-31-Reentrant-lock-in-Java/). The drawbacks of using implicit lock or explicit lock are that the performance of an application. So, utilizing lock is not a good option.

How do we deal with this problem?

<br>

## Solution of ThreadLocal

From the above section [Given problem](#given-problem), there are some problems that we need to solve.
- prevent the access from the other threads to that data structure in a thread.
- it only exists in a duration that a thread works.

Therefore, from Java 2, it provides the ThreadLocal concept to solve this problem.

1. How ThreadLocal works

    - How ThreadLocal is created internally



    - How ThreadLocal and ThreadPool interact

        From Java 1.5, it provides the Executor framework to support Java developers to manage multiple threads, then, after finishing a thread's job, this thread will be reclaimed from Thread Pool. So the Thread Pool continues to assign other tasks to the available threads.

        In our case, due to the fact that after reclaiming a thread, it also means take the thread-local variable to the Thread Pool, the thread-local variable's data is available, not removed by anothing. Therefore, when assigning a new task for an reclaimed thread, that thread will use a stale data of the thread-local variable.

        Finally, it is a bug that we don't want to encounter. So, how do we overcome this problem?

        There are two solutions for solving the problem of utilizing the other threads's data again.
        - First, after finishing our job in a thread, should we call **remove()** method.
        - Second, if we don't need to call **ThreadLocal.remove()** method manually, we can create a new **ExecutorService** that is subclassed from **ThreadPoolExecutor** class.

            ```java
            public interface Executor {
                void execute(Runnable command);
            }

            public interface ExecutorService extends Executor {
                boolean awaitTermination(long timeout, TimeUnit unit) throws InterruptedException;
                <T> Future<T> submit(Callable<T> task);
                <T> Future<T> submit(Runnable<T> task, T result);
                Future<?> submit(Runnable task);

                <T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks);
                <T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks, long timeout, TimeUnit unit);

                <T> List<Future<T>> invokeAny(Collection<? extends Callable<T>> tasks);
                <T> List<Future<T>> invokeAny(Collection<? extends Callable<T>> tasks, long timeout, TimeUnit unit);

                boolean isTerminated();
                boolean isShutdown();
                List<Runnable> shutdownNow();
                void shutdown();
            }

            // AbstractExecutorService class implements submit(), invokeAny(), and invokeAll() methods
            // using a RunnableFuture returned by newTaskFor()
            public class AbstractExecutorService extends Object implements ExecutorService {
                protected <T> RunnableFuture<T> newTaskFor(Runnable runnable, T value);
                protected <T> RunnableFuture<T> newTaskFor(Callable runnable, T value);
            }

            public class ThreadPoolExecutor extends AbstractExecutorService {
                ...

                protected void afterExecute(Runnable r, Throwable t);

                protected void beforeExecute(Thread t, Runnable r);

                protected void terminated();
            }
            ```

            The **ThreadPoolExecutor** class offers two hook methods, contains **beforeExecute()** and **afterExecute()** methods, that are called before and after execution of each task. These can be used to manipulate the execution environment, for example, reinitializing ThreadLocals, gather statistics, or adding log entries.

            The method **terminated()** can be overriden to perform any special processing that needs to be done once the Executor has fully terminated. By default, this **terminated()** method does nothing.
            
            If our current **ThreadPoolExecutor** is subclassed from multiple parent classes, we need to call **super.terminated()**, **super.beforeExecute()**, and **super.afterExecute()** method within this method.

            If hook or callback methods throw exceptions, internal worker threads may in turn fail and abruptly terminate.
            
            ```java
            public class CommonThreadPoolExecutor extends ThreadPoolExecutor {
                
            }
            ```

2. Some methods of ThreadLocal

    Belows are method that ThreadLocal supports.

    ```java
    public class ThreadLocal<T> extends Object {
        public ThreadLocal();
        protected T initialValue();
        public T get();
        public void set(T value);

        // since java 1.5
        public void remove();

        // since java 1.8
        public static <S> ThreadLocal<S> withInitial(Supplier<? extends S> supplier)
    }
    ```

    Each thread holds an implicit reference to its copy of a thread-local variable as long as the thread is alive and the ThreadLocal instance is accessible. After a thread goes away, all of its copies of thread-local instance are subject to garbage collection (unless other references to these copies exist).

    Then, the usage of TheadLocal's methods:
    - By default, the internal value of ThreadLocal is null.

    - If the **set()** method doesn't use to construct the ThreadLocal's value or after the **remove()** method is called, calling the get() method will invoke **initialValue()** method to return its value.

    - The **get()** method will return the current thread's copy of this thread-local variable.

    - The **set()** method will set the current thread's copy of this thread-local variable to the specified value.

    - The **remove()** method will remove the current thread's value for this thread-local variable.


<br>

## When to use

- When our data is only used in a thread, not share to the other threads.

<br>

## Source code

1. Using ThreadLocal in Java project

    To use ThreadLocal correctly, its instances are typically **private static fields** in classes that wish to associate state with a thread.

    ```java

    ```

2. Alternative way for ThreadLocal in Spring project

    In Spring, we can use a request-scoped bean that looks like the below code.

    ```java
    @Component
    @Scope(value = "request", proxyMode = ScopedProxyMode.INTERFACES)
    public class SpecificComponent {
        // do something

        ...
    }
    ```

    Belows are the meaning of some options in the annotation @Scope.
    - value
    - proxyMode


<br>

## Benefits and Drawbacks

1. Benefits

    - improve the performance of an application when we don't need to use the implicit/explicit locks.
    - reduce the boilerplate code, dirty signature of methods because we move the shared data within a thread to a singleton object.

2. Drawbacks

    - If we miss to clear the ThreadLocal's data, the other threads can utilize in its business logic. So, it can produce a bug.

<br>

## Wrapping up

- 

- 


<br>

Refer:

[https://www.baeldung.com/java-threadlocal](https://www.baeldung.com/java-threadlocal)

[https://dzone.com/articles/an-alternative-approach-to-threadlocal-using-sprin-1](https://dzone.com/articles/an-alternative-approach-to-threadlocal-using-sprin-1)

[https://stackoverflow.com/questions/2218282/should-i-put-my-threadlocals-in-a-spring-injected-singleton](https://stackoverflow.com/questions/2218282/should-i-put-my-threadlocals-in-a-spring-injected-singleton)

[https://automationrhapsody.com/avoid-multithreading-problems-java-using-threadlocal/](https://automationrhapsody.com/avoid-multithreading-problems-java-using-threadlocal/)

[https://medium.com/javarevisited/async-process-using-spring-and-injecting-user-context-6f1af16e9759](https://medium.com/javarevisited/async-process-using-spring-and-injecting-user-context-6f1af16e9759)

[https://www.javaguides.net/2018/09/threadlocal-class-in-java.html](https://www.javaguides.net/2018/09/threadlocal-class-in-java.html)

[https://www.javaer101.com/en/article/1411450.html](https://www.javaer101.com/en/article/1411450.html)

[https://howtodoinjava.com/java/multi-threading/when-and-how-to-use-thread-local-variables/](https://howtodoinjava.com/java/multi-threading/when-and-how-to-use-thread-local-variables/)

[https://smartbear.com/blog/how-and-when-to-use-javas-threadlocal-object/](https://smartbear.com/blog/how-and-when-to-use-javas-threadlocal-object/)

[https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/ThreadPoolExecutor.html](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/ThreadPoolExecutor.html)

[http://veerasundar.com/blog/2010/11/java-thread-local-how-to-use-and-code-sample/](http://veerasundar.com/blog/2010/11/java-thread-local-how-to-use-and-code-sample/)

[http://javarevisited.blogspot.co.at/2013/01/threadlocal-memory-leak-in-java-web.html](http://javarevisited.blogspot.co.at/2013/01/threadlocal-memory-leak-in-java-web.html)

<br>

**Problems of ThreadLocal**

[https://plumbr.io/blog/locked-threads/how-to-shoot-yourself-in-foot-with-threadlocals](https://plumbr.io/blog/locked-threads/how-to-shoot-yourself-in-foot-with-threadlocals)

[https://medium.com/javarevisited/java-concurrency-threadlocal-c1b18ab8e488](https://medium.com/javarevisited/java-concurrency-threadlocal-c1b18ab8e488)