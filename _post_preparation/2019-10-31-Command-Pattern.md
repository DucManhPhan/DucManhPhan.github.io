---
layout: post
title: Command pattern
bigimg: /img/image-header/yourself.jpeg
tags: [Behavirol pattern, design pattern]
---

 


<br>

# Table of Contents
- [Given Problem](#given-problem)
- [Solution with Command Pattern](#solution-with-command-pattern)
- [When to use](#when-to-use)
- [Code C++/Javascript](#code-C++/Javascript)
- [Relations with other patterns](#relations-with-other-patterns)
- [Application & Examples](#application-&-examples)
- [Wrapping up](#wrapping-up)

<br>

# Given Problem 





<br>

# Solution with Command Pattern



According to Gang of Four's definition, we have:

```
Encapsulate a request as an object, thereby letting you parameterize clients with different requests,
queue or log requests, and support undoable operations.

```

Below is the class diagram of Command pattern:

![](../img/design-pattern/command-pattner/command-pattern.png)

Command pattern has primarily four components:
- Command

    It will store all information that is required for executing an action, including the method to call, the method arguments, and the object (consider as Receiver) that implements the method.

- Receiver

    This is actual object which do perform request when the command's ```execute()``` method is called.

- Invoker

    It stores all commands and call ```execute()``` method of Command object when necessary.

    It knows how to execute a given command but does not know how the command has been implemented. It only knows about the command's interface.

- Client

    It has functionalities such as encapsulating each request into Command object, controls the command execution process by specifying what commands to execute and at what stages of the process to execute them.

<br>

# When to use
- A history of requests is needed.
- We need callback functionality.
- Requests need to be handled at variant times or in variant orders.
- The invoker should be decoupled from the object handling the invocation.

<br>

# Benefits & Drawback






<br>

# Code C++/Javascript





<br>

## Relations with other patterns






<br>

# Application & Examples





<br>

## Wrapping up




<br>

Thanks for your reading.

<br>

Refer:

[https://dzone.com/articles/design-patterns-command](https://dzone.com/articles/design-patterns-command)

[https://www.baeldung.com/java-command-pattern](https://www.baeldung.com/java-command-pattern)

