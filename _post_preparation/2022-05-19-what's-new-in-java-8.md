---
layout: post
title: What's new in Java 8
bigimg: /img/image-header/yourself.jpeg
tags: [Java]
---




<br>

## Table of contents
- [Some new features in Java 8]()
- []()
- []()
- [Benefits and Drawbacks]()
- [Wrapping up]()


<br>

## Some new features in Java 8

Java 8 was release in March 18, 2014, two years seven months after the previous release.

Belows are some new characteristics in Java 8.
1. Functional interfaces
2. Virtual methods
3. Class and method references
4. New Date and Time API
5. Nashorn Javascript engine

    Nashorn replaces Rhino as the default Javascript engine for the Oracle JVM. Nashorn is faster since it uses the invoke dynamic feature of the JVM and had better support for ECMA script.

6. Remove the Permanent Generation from the Hotspot virtual machine 
7. Stream API
8. Optional
9. Improvements in concurrency library

    - improved concurrent hash map
    - CompletableFuture
    - thread safe accumulators
    - an improved read write lock that is called a StampedLock
    - an implementation of a work stealing thread pool

10. Adding default, static methods to interfaces
11. The integration with JRocket makes JVM run faster 

    The JVM dropped the idea of perm gen, instead of using native OS memory for class metadata. This is a huge deal and provides better memory utilization.

    The JRocket integration also brought Mission control (jmc) to the JDK as standard. It compliments JConsole and VisualVM with similar functionality but adds very inexpensive profiling.

12. Improvements to Base64 encoding supports
13. And anything else


<br>

## 






<br>

## Benefits and Drawbacks





<br>

## Wrapping up




<br>

Refer:

[]()

[]()

[]()

[]()

[]()