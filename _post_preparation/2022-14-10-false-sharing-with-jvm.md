---
layout: post
title: False sharing with JVM
bigimg: /img/image-header/yourself.jpeg
tags: [Memory management]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Cache line](#cache-line)
- [False sharing](#false-sharing)
- [Solution for false sharing problem](#solution-for-false-sharing-problem)
- [Wrapping up](#wrapping-up)

<br>

## Given problem






<br>

## Cache line






<br>

## False sharing





<br>

## Solution for false sharing problem

1. Padding for our data fields



2. Using annotation **@Contended**



<br>

## Wrapping up




<br>

Refer:

[https://medium.com/@rukavitsya/what-is-false-sharing-and-how-jvm-prevents-it-82a4ed27da84](https://medium.com/@rukavitsya/what-is-false-sharing-and-how-jvm-prevents-it-82a4ed27da84)

[https://medium.com/@genchilu/false-sharing-%E4%BB%A5%E5%8F%8A%E5%85%B6%E8%A7%A3%E6%B3%95-%E4%BB%A5-golang-%E7%82%BA%E4%BE%8B-d2a87c414640](https://medium.com/@genchilu/false-sharing-%E4%BB%A5%E5%8F%8A%E5%85%B6%E8%A7%A3%E6%B3%95-%E4%BB%A5-golang-%E7%82%BA%E4%BE%8B-d2a87c414640)

[https://medium.com/distributed-knowledge/optimizations-for-c-multi-threaded-programs-33284dee5e9c](https://medium.com/distributed-knowledge/optimizations-for-c-multi-threaded-programs-33284dee5e9c)