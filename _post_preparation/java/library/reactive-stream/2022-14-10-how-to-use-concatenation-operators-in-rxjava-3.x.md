---
layout: post
title: How to use concatenation operators in RxJava 3.x
bigimg: /img/image-header/yourself.jpeg
tags: [Reactive Programming]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Concatenation operators](#solution-with-concatenation-operators)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution with Concatenation operators

Concatenation operators will emit items of each provided Observable sequentially and in the order specified. It doesn't move on to the next Observable until the current one calls onComplete(). This makes it greate to ensure that the merged Observable starts emitting in a guaranteed order.

However, it is often a poor choice for infinite Observable, as it will indefinitely hold up the queue and forever leave the Observable that is next in line waiting.

Belows are some concatenation operators that we need to know.
1. Observable.concat() factory method

    The Observable.concat() factory is the concatenation equivalent to Observable.merge(). It will combine the emitted values of multiple observables, but will fire each one sequentially and only move to the next after onComplete() is called.

    If we use Observable.concat() with infinite observables, it will forever emit from the first one it encounters and prevent any following Observable from firing. If we ever want to put an infinite Observable anywhere in a concatenation operation, it should be listed last. This ensures that it does not hold up any Observable following it because there are none. We can also use take() operators to make an infinite Observable finite.

    There are concatenation counterparts for arrays and Iterable<Observable<T>> inputs as well, just like there are in the case of merging. The Observable.concatArray() factory fires off each Observable sequentially in an Observable[] array. The Observable.concat() factory also accepts an Iterable<Observable<T>> and fires off each Observable<T> in the same manner.

    Note that there are a few variants of concatMap(). Use concatMapIterable() when you want to map each emission to an Iterable<T> instead of an Observable<T>. It emits all T values for each Iterable<T>, saving you the step and overhead of turning each one into an Observable<T>. There is also a concatMapEager() operator that eagerly subscribes to all Observable sources it receives and caches the emissions until it is their turn to emit.

2. concatWith() operator

    Using concatWith() operator also creates a same effect when using Observable.concat() factory method.

3. concatMap() operator

    Just as there is flatMap(), which dynamically merges observables, there is a concatenation counterpart called concatMap(). Use this operator if you care about ordering and want each Observable being mapped from each emission before starting the next one.

    More specifically, concatMap() merges each mapped Observable sequentially and fires them one at a time. It moves to the next Observable when the current one calls onComplete(). If source emissions produce observables faster than concatMap() can emit from them, those observables are queued.

<br>

## When to use





<br>

## Wrapping up




<br>

Refer:

[Learning RxJava 3.x ebook]()

[]()

[]()

[]()

[]()