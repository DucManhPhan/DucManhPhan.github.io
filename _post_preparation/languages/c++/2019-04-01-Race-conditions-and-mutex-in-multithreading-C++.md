---
layout: post
title: Race conditions and mutex in multithreading C++
bigimg: /img/image-header/california.jpg
tags: [C++, Multithreading]
---



<br>

## Table of contents
- [Race condition](#race-condition)
- [Mutex](#mutex)
- [Wrapping up](#wrapping-up)

<br>

## Race condition
- Problem's context

    Assuming that you and your friend live together in a department. Your department has one bathroom, one kitchen, ... In a morning, you're cooking a dish, but your buddy is hurry, so, he also wants to cook with you. But there is only one kitchen and one place to cook.

    If he mixes his food into your dish, it's so bad. You can not eat your dish and everything will be complicated.

    The other thing will be as same as using bathroom.

    This problem will be called **race condition**.

- Race condition

    In concurrency, a race condition is anything where the outcome depends on the relative ordering of execution of operations on two or more threads; the threads race to perform their respective operations. Most of the time, this is quite benign because all possible outcomes are acceptable, even though they may change with different relative orderings.

    Race conditions can often be hard to find and hard to duplicate because the window of opportunity is small. Because race conditions are generally timing sensitive, they can often disappear entirely when the application is run under the debugger, because the debugger affects the timing of the program, even if only slightly.

- Solution

    - Option 1: to wrap data structure with a protection mechanism, to ensure that only the thread actually performing a modification can see the intermediate states where the invariants are broken.

    - Option 2: to modify the design of data structure and its invariants so that modifications are doneas a series of indivisible changes, each of which preserves the invariants. This is generally referred to as ```lock-free programming```.

    - Option 3: to handle the updates to the data structure as a transaction, just as updates to a database are done within a ```transaction```. The required series of data modifications and reads is stored in a transaction log and then committed in a single step. If the commit can not proceed because the data structure has been modified by another thread, the transaction is restarted. It's ```software transactional memory``` - STM. C++ does not directly support STM.

<br>

## Mutex




<br>

## Wrapping up





<br>


Refer:

[https://thispointer.com/c11-multithreading-part-4-data-sharing-and-race-conditions/](https://thispointer.com/c11-multithreading-part-4-data-sharing-and-race-conditions/)

[https://thispointer.com/c11-multithreading-part-5-using-mutex-to-fix-race-conditions/](https://thispointer.com/c11-multithreading-part-5-using-mutex-to-fix-race-conditions/)

[http://jakascorner.com/blog/2016/01/deadlock.html](http://jakascorner.com/blog/2016/01/deadlock.html)

[http://jakascorner.com/blog/2016/01/data-races.html](http://jakascorner.com/blog/2016/01/data-races.html)