---
layout: post
title: Waiting threads to finish completely in Java
bigimg: /img/path.jpg
tags: [Multithreading]
---

In this article, we will learn how to wait our threads to finish completely. Let's get started.

<br>

## Table of contents
- [Using join() method of Thread class](#using-join()-method-of-Thread-class)
- [Using CountDownLatch](#using-countdownlatch)
- [Using shutdown(), isTerminated() methods of Executors](#using-shutdown()-isTerminated()-methods-of-executors)
- [Using invokeAll() method of ExecutorService](#using-invokeAll()-method-of-executorservice)
- [Using invokeAll() method of ExecutorCompletionService](#using-invokeAll()-method-of-executorcompletionservice)
- [Wrapping up](#wrapping-up)


<br>

## Using join() method of Thread class

The easiest way to deal with our problem is to use **join()** method of Thread class.

```java
public static void main(String[] args) throws InterruptedException {
    System.out.println("Start main thread.");

    Thread firstThread = new Thread(() -> {
        System.out.println("First thread is running.");
    });

    Thread secondThread = new Thread(() -> {
        System.out.println("Second thread is running.");
    });

    secondThread.start();;
    firstThread.start();

    secondThread.join();
    firstThread.join();

    System.out.println("End main thread.");
}
```

The drawbacks of this way:
- It creates the duplicated code, difficult to maintains, and read.

- This way is too basic.


<br>

## Using CountDownLatch

Below is the source code of using CountDownLatch and ExecutorService to manage multiple threads efficiently.

```java
public class ActionService implements Runnable {

    private CountDownLatch latch;

    public ActionService(CountDownLatch latch) {
        this.latch = latch;
    }

    public void run() {
        System.out.println("Start Action Service");

        try {
            Thread.sleep(5000);
        } catch(InterruptedException ex) {
            System.out.println(ex);
        }

        this.latch.countDown();
    }
}

public static void main(String[] args) {
    CountDownLatch latch = new CountDownLatch(3);
    ExecutorService executor = Executors.newFixedThreadPool(3);
    IntStream.range(0, 3).forEach(item -> xecutor.execute(new ActionService(latch)));
    executor.shutdown();

    try {
        latch.await();
    } catch(InterruptedException ex) {
        System.out.println(ex);
    }

    System.out.println("End of Action Services");
}
```

The drawbacks of this way:
- We need to know about the specific number of threads to construct CountDownLatch instance.

<br>

## Using shutdown(), isTerminated() methods of Executors

From the document of [oracle](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/ExecutorService.html), we have the definition of **isTerminated()** method:

```java
// Returns true if all tasks have completed following shut down.
boolean isTerminated();
```

```java
ExecutorService executor = Executors.newSingleThreadExecutor();
IntStream.range(0, 3).forEach(item -> executor.execute(() -> System.out.println("Thread " + item + "th")));

while (!executor.isTerminated()) {
    // infinite loop
}
```

<br>

## Using awaitTermination() method after shutdown() method of Executors

From the document of [oracle](https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/ExecutorService.html), we have the definition of **awaitTermination()** method:

```java
// Blocks until all tasks have completed execution after a shutdown request, or the timeout occurs, or the current thread is interrupted, whichever happens first.
boolean awaitTermination(long timeout, TimeUnit unit);
```

Below is the source code that using awaitTermination() method and shutdown() method.

```java
ExecutorService executor = Executors.newSingleThreadExecutor();
IntStream.range(0, 3).forEach(item -> executor.execute(() -> System.out.println("Thread " + item + "th")));

executor.shutdown();

try {
    if (!executor.awaitTermination(50, TimeUnit.SECONDS)) {
        executor.shutdownNow();
    }
} catch (InterruptedException ex) {
    System.out.println(ex);
}
```

<br>

## Using invokeAll() method of ExecutorService

**invokeAll()** method returns a list of **Future** objects after all tasks finish or the timeout expires.

```java
ExecutorService executor = Executors.newFixedThreadPool(3);
Collection<Callable<Void>> tasks = new ArrayList<>();   // our task do not need a returned value

for (/* iteratare something */) {
    Callable<Void> task = () -> {
        // do something
        // ...

        return null;
    }

    tasks.add(task);
}

try {
    executor.invokeAll(tasks);
} catch(InterruptedException ex) {
    System.out.println(ex);
}
```

The benefits of this way:
- We do not specify how many tasks that we need to run.


<br>

## Using invokeAll() method of ExecutorCompletionService

**ExecutorCompletionService** uses a queue to store the results in the order they are finished, and **invokeAll()** method will return a list having the same sequential order as produced by the iterator for the given task list.

```java
public class SleepingCallable implements Callable<String> {

  final String name;
  final long period;

  SleepingCallable(final String name, final long period) {
    this.name = name;
    this.period = period;
  }

  public String call() {
    try {
      Thread.sleep(period);
    } catch (InterruptedException ex) {
        System.out.println(ex);
    }

    return name;
  }
}

final ExecutorService pool = Executors.newFixedThreadPool(2);
final CompletionService<String> service = new ExecutorCompletionService<String>(pool);
final List<? extends Callable<String>> callables = Arrays.asList(
    new SleepingCallable("slow", 5000),
    new SleepingCallable("quick", 500)
);

for (final Callable<String> callable : callables) {
  service.submit(callable);
}

pool.shutdown();

try {
  while (!pool.isTerminated()) {
    final Future<String> future = service.take();
    System.out.println(future.get());
  }
} catch (ExecutionException | InterruptedException ex) {
    System.out.println(ex);
}
```

<br>

## Wrapping up
- Whenever we want to block a thread until another unit of work completes, we should never block infinitely.

    The **await()** method, like the **Future.get()** method, is overloaded to take either no parameters, or a pair of parameters to determine how long to wait. If we use the option of waiting for a specific time, an **InterruptedException** will be thrown if no response has come in the specific time.

    If we use the option with no parameters, the **await()** method will block forever. So if the operation we are waiting on has crashed, and will never return, our application will never progress.

    Whenever we are waiting on a parallel operation to complete, whether that is in another thread, or, for instance, on a web service to return us some data, we should consider how to react if that operation never return.


<br>

Refer:

[https://www.baeldung.com/java-executor-wait-for-threads](https://www.baeldung.com/java-executor-wait-for-threads)

[https://howtodoinjava.com/java/multi-threading/executorservice-invokeall/](https://howtodoinjava.com/java/multi-threading/executorservice-invokeall/)

[https://howtodoinjava.com/security/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/](https://howtodoinjava.com/security/how-to-generate-secure-password-hash-md5-sha-pbkdf2-bcrypt-examples/)