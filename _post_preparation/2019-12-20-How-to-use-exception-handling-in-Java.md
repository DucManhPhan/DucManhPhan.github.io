---
layout: post
title: How to use exception handling in Java
bigimg: /img/image-header/factory.jpg
tags: [Java, Exception handling]
---



<br>

## Table of contents





<br>

## 






<br>

## When to use






<br>

## try-catch block




<br>

## finally block

```finally``` block will be called after the execution of the ```try``` or ```catch``` code blocks.

The only times ```finally``` won't be called are:
- If you invoke ```System.exit()```.

- If you invoke ```Runtime.getRuntime().halt(exitStatus)```.

- If the JVM crashes first.

- If the JVM reaches an infinite loop (or some other non-interruptable, non-terminating statement) in the ```try``` or ```catch``` block.

- If the OS forcibly terminates the JVM process; e.g., ```kill -9 <pid>``` on UNIX.

- If the host system dies; e.g., power failure, hardware error, OS panic, et cetera.

- If the ``finally`` block is going to be executed by a daemon thread and all other non-daemon threads exit before ```finally``` is called.


<br>

## Wrapping up




<br>

Refer:

[https://stackoverflow.com/questions/2190161/difference-between-java-lang-runtimeexception-and-java-lang-exception](https://stackoverflow.com/questions/2190161/difference-between-java-lang-runtimeexception-and-java-lang-exception)

[https://www.mkyong.com/java/java-custom-exception-examples/?utm_source=mkyong.com&utm_medium=Referral&utm_campaign=afterpost-related&utm_content=link9](https://www.mkyong.com/java/java-custom-exception-examples/?utm_source=mkyong.com&utm_medium=Referral&utm_campaign=afterpost-related&utm_content=link9)

