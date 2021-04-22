---
layout: post
title: How to use RxJava3
bigimg: /img/image-header/yourself.jpeg
tags: [Reactive Programming]
---




<br>

## Table of contents
- [Given problem]()
- [Introduction to RxJava3]()
- []()
- []()
- []()


<br>

## Given problem






<br>

## Introduction to RxJava 3.x

1. 



2. Some common classes in RxJava 3.x

    - Observable


    - ObservableOnSubscriber


    - ObservableEmitter


    - Emitter


    - Observer


<br>

## The comparison between RxJava's versions

1. RxJava 1.x and RxJava 2.x

    RxJava 1.x wasn't supported from March 21, 2018. RxJava 2.x was maintained to fix bug until February 28, 2021.


2. RxJava 2.x and RxJava 3.x



All RxJava versions can be run on Java 1.6 or above.

<br>

## Some notes about RxJava versions

- In RxJava 1.x, the types are contained in the rx package. In RxJava 2.x, most types are contained in the io.reactivex package. In RxJava 3.x, the types are contained in the io.reactivex.rxjava3 package.

- In RxJava 1.x, **onComplete()** event is actually called **onCompleted()**. In RxJava 1.x, ensure that we use Observable.fromEmitter() instead of Observable.create(). The latter is something entirely different in RxJava 1.x and is intended to be used only by advanced RxJava users.

- In RxJava 3.x, the [Observable contract] (http://reactivex.io/documentation/contract.html) dictates that emissions must be passed sequentially and one at a time. Emissions can't be passed by an Observable concurrently or in parallel. This may seem like a limitation, but it does, in fact, simplify programs and make Rx easier to reason with.

<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()

[]()