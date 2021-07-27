---
layout: post
title: Interesting information about string in C++
bigimg: /img/image-header/california.jpg
tags: [Dynamic Programming]
---



<br>

## Table of contents
- [Use += operator or append method](#use-+=-operator-or-append-method)



<br>

## Use += operator or append method
Normally, we use ```+= operator``` to concat a string to another string, but ```+= operator``` is slightly slower than ```append()``` method, simply because each time ```+``` is called, a new string (creation of a new buffer) is made which is returned that is a bit overload in case of many append operation.

<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

[https://www.bfilipek.com/2018/12/fromchars.html?m=1](https://www.bfilipek.com/2018/12/fromchars.html?m=1)

[http://kayari.org/cxx/antipatterns.html](http://kayari.org/cxx/antipatterns.html)