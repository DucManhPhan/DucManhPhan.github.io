---
layout: post
title: Understanding about stream in Java 8
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Java]
---




<br>

## Table of contents




<br>

## What is Stream in Java 8 ?
Normally, we will use Collections framework to handle data. Though this framework enables a user to handle data quite efficiently, the main complexity lies in using loops and performing repeating checks. It also does not facilitate the use of multi-core system efficiently. So, Stream will deal with this problem.

A Stream is a series of different elements that have been emitted over a time period. Streams are like an array, but not an array. They do have distinct differences. The elements of an array are sequentially arranged in memory, while the elements in a Stream are not. Every Stream has a beginning as well as an end.

In order to understand about stream, we can give an example:

Have you ever sat on the banks of a river or flowing water and put your legs in it? Most of us have at least once enjoyed this peaceful experience. The water moves around our legs and moves ahead. Have you ever observed the same flowing water passing through your legs twice? Obviously, not! It's the same when it comes to Streams.

<br>

## How is Stream implemented ?




<br>

## The differences between Streams and Collection
- Collection efficiently manage and allow access to elements, whereas Stream do not allow direct manipulation or access to elements.

- Stream do not store data. They only allow passing the elements through a computational pipeline. The sources of elements in stream are array, list and map.

- Stream is functional in nature. The function is applied on each element of the stream and produces the result but the source elements are not modified.

- Stream operations are always divided into intermediate operations and terminal operations. Intermediate operations are always lazy.

- Stream is unbounded whereas collection can have finite size. The infinite elements can be computed whitin finite using streams.

- While computation the elements of stream are visited only once during life. The elements can be revisited in another instance of stream which will be the output of computation on previous stream instance.


<br>

## Compared between normal sort method and sorted() method of stream




<br>

## The difference between map() and flatMap() methods

[https://stackoverflow.com/questions/26684562/whats-the-difference-between-map-and-flatmap-methods-in-java-8](https://stackoverflow.com/questions/26684562/whats-the-difference-between-map-and-flatmap-methods-in-java-8)



<br>

## Wrapping up
- Stream represent a sequence of objects from a source, which supports aggregate operations.



<br>

Refer:

[Reactive programming with Java 9](https://subscription.packtpub.com/book/application_development/9781787124233/1/ch01lvl1sec8/asynchronous-programming)