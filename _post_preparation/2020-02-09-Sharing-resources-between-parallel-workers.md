---
layout: post
title: Sharing resources between parallel workers
bigimg: /img/path.jpg
tags: [Multithreading, Java]
---



<br>

## Table of contents





<br>

## The Scatter-Gather pattern

This pattern shows up often in applications where a form of voting or biding is taking place between independent agents. For example, when evaluating access to a request, or when collecting quotes or prices for a proposed job. It comes up when one task is split into smaller tasks for the purpose of the smaller portions being run on separate agents, and then aggregated into a single result. It even appears in circumstances when specific instructions are duplicated to various agents for the purpose of increasing redundancy or lowering latency.

And while it may be tempting to take naturally splittable work and process it serially, choosing to parallelize the work may afford greater scalability in the same way that having more than one cashier at the supermarket may accelerate the checkout process.

![](../img/concurrency/java/scatter-and-gather-pattern/scatter-and-gather-pattern.png)

<br>

## Scatter-Gather using Futures





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