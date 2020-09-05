---
layout: post
title: Summary about Collections in Java
bigimg: /img/image-header/california.jpg
tags: [Java]
---

In this article, we will find something out about the complexity of List, Set, Queue and Map in Java collections. It is useful because it helps us improve our program's time. 

Let's get started.

## Table of contents
- [List](#list)
- [Set](#set)
- [Queue](#queue)
- [Map](#map)

<br>

## List

|                      |    Add     |      Remove      |       Get      |       Contains       |         Data Structure         |
| -------------------- | ---------- | ---------------- | -------------- | -------------------- | ------------------------------ |
| ArrayList            | O(1)       | O(n)             | O(1)           | O(n)                 | Array                          |
| LinkedList           | O(1)       | O(1)             | O(n)           | O(n)                 | Linked List                    |
| CopyOnWriteArrayList | O(n)       | O(n)             | O(1)           | O(n)                 | Array                          |

<br>

## Set

|                      |    Add     |      Contains    |     Next       |      Data Structure      |
| -------------------- | ---------- | ---------------- | -------------- | ------------------------ |
| HashSet              | O(1)       | O(1)             | O(h/n)         | Hash Table               |
| LinkedHashSet        | O(1)       | O(1)             | O(1)           | Hash Table + Linked List |
| EnumSet              | O(1)       | O(1)             | O(1)           | Bit Vector               |
| TreeSet              | O(logn)    | O(logn)          | O(logn)        | Red-Black Tree           |
| CopyOnWriteArraySet  | O(n)       | O(n)             | O(1)           | Array                    |
| ConcurrentSkipList   | O(logn)    | O(logn)          | O(1)           | Skip List                | 

<br>

## Queue

|                           |      Offer     |       Peak       |       Poll       |       Size        |       Data Structure        |
| ------------------------- | -------------- | ---------------- | ---------------- | ----------------- | --------------------------- |
| PriorityQueue             | O(logn)        | O(1)             | O(logn)          | O(1)              | Priory Heap                 |
| LinkedList                | O(1)           | O(1)             | O(1)             | O(1)              | Array                       |
| ArrayDequeue              | O(1)           | O(1)             | O(1)             | O(1)              | Linked List                 | 
| ConcurrentLinkedQueue     | O(1)           | O(1)             | O(1)             | O(n)              | Linked List                 |
| ArrayBlockingQueue        | O(1)           | O(1)             | O(1)             | O(1)              | Array                       |
| PriorityBlockingQueue     | O(logn)        | O(1)             | O(logn)          | O(1)              | Priority Heap               |
| SynchronousQueue          | O(1)           | O(1)             | O(1)             | O(1)              | None                        |
| DelayQueue                | O(logn)        | O(1)             | O(logn)          | O(1)              | Priority Heap               |
| LinkedBlockingQueue       | O(1)           | O(1)             | O(1)             | O(1)              | Linked List                 |

<br>

## Map

|                           |      Get       |   ContainsKey    |        Next      |       Data Structure     |
| ------------------------- | -------------- | ---------------- | ---------------- | ------------------------ |
| HashMap                   | O(1)           | O(1)             | O(h/n)           | Hash Table               |
| LinkedHashMap             | O(1)           | O(1)             | O(1)             | Hash Table + Linked List |
| IdentityHashMap           | O(1)           | O(1)             | O(h/n)           | Array                    |
| WeakHashMap               | O(1)           | O(1)             | O(h/n)           | Hash Table               |
| EnumMap                   | O(1)           | O(1)             | O(1)             | Array                    |
| TreeMap                   | O(logn)        | O(logn)          | O(logn)          | Red-Black Tree           | 
| ConcurrentHashMap         | O(1)           | O(1)             | O(h/n)           | Hash Tables              |
| ConcurrentSkipListMap     | O(logn)        | O(logn)          | O(1)             | Skip List                |
