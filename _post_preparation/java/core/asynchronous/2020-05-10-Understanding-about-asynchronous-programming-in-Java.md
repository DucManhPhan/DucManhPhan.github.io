---
layout: post
title: Understanding about Asynchronous programming in Java
bigimg: /img/image-header/yourself.jpeg
tags: [Java, Asynchronous Programming]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with asynchronous programming](#solution-with-asynchronous-programming)
- [When to use](#when-to-use)
- [Difference between Synchronous and Asynchronous](#difference-between-synchronous-and-asynchronous)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Belows are some problems that we want to solve:
- we want to launch a task
- get the result produced by this task
- use this result to launch another task with the input being the result of this previous task

To make our problem clearer, we will get a specific example. Suppose we have a set of IDs, think of primary keys to a database, for instance, and from those IDs, we want to read the set of users from a database. This is really our first task. It takes an input and will produce this list of users as an output, and this output, we are going to feed it to another task, which is send emails. What we want to do is send emails to those users and this second task has a parameter which is a list of users. This is exactly the case we need to solve.

![](../img/asynchronous-programming/given-problem/given-problem.png)

First, reading users from a database takes time. This time will be spent in the following:
- probably some network latency
- then some computation inside the database
- then getting the result which also implies some network latency.

And of course, we do not want to block the thread that is going to execute this task. Putting a thread in a wait state is not something we want to do. We want all our threads to be as busy as possible in our application. We need to get the list of our users and launch the sending of emails using this list of users as an input. So if while using concurrent programming, the question is, what thread is going to get the result and what thread is going to feed the other task with this result and launch this other task. If this is the main thread, it means that we will have to move data from one thread to another and this main thread will have to be notified that the reading of the user from the database is done and that result is available.

So maybe we need to take a second look at this solution coming from the concurrent programming. Is it really the right solution?

Below is the source code of implement our task in concurrent programming.

```java
ExecutorService service = Executors.newSingleThreadExecutorService();
Runnable task = () -> { ... };

Future future = service.submit(task);

// do something
// ...

... = future.get(); // block until the task is done

// call cancel() method to tell ExecutorService that we do not need the result anymore
// The cancel() method is non-blocking, but it is still launched in the main thread, the thread that created and 
// submitted the task to the ExecutorService.
... = future.cancel(); 
```

So, we can find that using concurrent programming does not offer the non-blocking behavior. Then, concurrent programming is not our right solution.

How do we overcome this problem?

<br>

## Solution with asynchronous programming






<br>

## When to use





<br>

## Difference between Synchronous and Asynchronous

1. Synchronous

    The thread that launched the task needs to wait for the task to complete to continue to work. 

2. Asynchronous

    The task is executed at some point in the future. There is no need to wait for anything for it to complete.

But we have a question: Does asynchronous mean **in another thread**?

In fact, the answer is no, and we can see a simple example of that.

```java
List<String> strings = ...;
strings.sort(Comparator.naturalOrder());
```

Belows are some question for this example:
- When does this comparator get executed?

    The answer is sometime in the future and we do not know when.

- In what thread is this comparator is going to be executed?

    It is the main thread because we do not have any ExecutorService creation of thread.

- How many times is this comparator going to be called?

    In fact, we do not know. Even if we knew exactly the number of strings there is in this list, it is not possible to tell in advance exactly how many times this comparator is going to be called. All we can say is that if there is a quick sort algorithm behind that, it will be probably O(nlogn).

So asynchronous and concurrent are different notions. We can be asynchronous without being concurrent, and being concurrent does not necessarily mean that we are asynchronous. A task can be asynchronous and still be called in the same thread.

<br>

## Wrapping up




<br>

Refer:

[Java Fundamentals: Asynchronous Programming Using CompletionStage](https://app.pluralsight.com/library/courses/java-fundamentals-asynchronous-programming-completionstage/table-of-contents)