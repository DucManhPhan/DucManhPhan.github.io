---
layout: post
title: How Spring Websockets works
bigimg: /img/image-header/unsplash.jpg
tags: [java]
---




<br>

## Table of contents
- [What is Websockets](#what-is-websockets)
- [STOMP](#stomp)
- [How Spring Websockets works](#how-spring-websockets-works)
- [Advantages and disadvantages](#advantages-and-disadvantages)
- [Wrapping up](#wrapping-up)

<br>

## What is Websockets




<br>

## STOMP
STOMP is an acronym of ```Simple (or Streaming) Text Oriented Messaging Protocol``` that is similar to the HTTP convention of an uppercase command such as CONNECT, followed by a list of header key/value pairs, and then optional content, which in the case of STOMP is null-terminated. It is also possible and highly recommended too pass content-length as a parameter to any commands, and the server will use that value instead as the length of passed content.

STOMP is a simple interoperable protocol designed for asynchronous message passing between clients via mediating servers. It defines a text based wire-format for messages passed between these clients and servers.

STOMP is a frame based protocol, with frames modelled on HTTP. A frame consists of a command, a set of optional headers and an optional body. STOMP is text based but also allows for the transmission of binary messages. The default encoding for STOMP is UTF-8, but it supports the specification of alternative encodings for message bodies.



<br>

## SockJS and StompJS in client



<br>

## How Spring Websockets works



<br>

## Advantages and disadvantages



<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

[https://stomp.github.io/stomp-specification-1.2.html#Abstract](https://stomp.github.io/stomp-specification-1.2.html#Abstract)

[https://github.com/netgloo/spring-boot-samples/tree/master/spring-boot-web-socket-user-notifications](https://github.com/netgloo/spring-boot-samples/tree/master/spring-boot-web-socket-user-notifications)