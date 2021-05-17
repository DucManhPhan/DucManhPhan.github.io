---
layout: post
title: Scatter and Gather pattern
bigimg: /img/path.jpg
tags: [Concurrency Pattern]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Scatter-Gather pattern](#solution-with-scatter-gather-pattern)
- [Scatter-Gather using Futures](#scatter-gather-using-futures)
- [Scatter-Gather using ExecutorService](#scatter-gather-using-executorservice)
- [The importance of making aggregations Thread-safe](#the-importance-of-making-aggregations-thread-safe)
- [Gathering using concurrency primitives](#gathering-using-concurrency-primitives)
- [Gathering using AtomicInteger, ConcurrentHashMap, and LongAdder](#gathering-using-atomicinteger-concurrenthashmap,-and-longadder)
- [Gathering using ReentrantLock](#gathering-using-reentrantlock)
- [Wrapping up](#wrapping-up)


<br>

## Given problem





<br>

## Solution with Scatter-Gather pattern

This pattern shows up often in applications where a form of voting or biding is taking place between independent agents.

For example, when evaluating access to a request, or when collecting quotes or prices for a proposed job. It comes up when one task is split into smaller tasks for the purpose of the smaller portions being run on separate agents, and then aggregated into a single result. It even appears in circumstances when specific instructions are duplicated to various agents for the purpose of increasing redundancy or lowering latency.

And while it may be tempting to take naturally splittable work and process it serially, choosing to parallelize the work may afford greater scalability in the same way that having more than one cashier at the supermarket may accelerate the checkout process.

![](../img/concurrency/java/scatter-and-gather-pattern/scatter-and-gather-pattern.png)

<br>

## Scatter-Gather using Futures

Belows are some features of Future class.
- Future is an Object that represents the result that the submitted task will eventually return once that task is completed.

- By calling get() method, the current thread chooses to block and wait for the result. This can be called by any thread that has the reference, even multiple threads. Because eventual result is encapsulated in a Future, we have flexibility to pass the Future around to different layers of the application, that is a better candidate for performing the blocking.

<br>

## Scatter-Gather using ExecutorService




- **ExecutorService** and **ExecutorCompletionService** performance



<br>

## The importance of making aggregations Thread-safe




<br>

## Gathering using concurrency primitives




<br>

## Gathering using AtomicInteger, ConcurrentHashMap, and LongAdder




<br>

## Gathering using ReentrantLock



- Max Search using tryLock()


<br>

## Wrapping up





<br>

Refer:

[Scaling Java Applications Through Concurrency](https://app.pluralsight.com/library/courses/scaling-java-applications-through-concurrency/table-of-contents)