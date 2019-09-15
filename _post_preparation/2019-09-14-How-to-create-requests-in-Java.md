---
layout: post
title: How to create requests in Java
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Java]
---




<br>

## Table of contents



<br>

## Communications between client and server in Spring MVC
In Spring MVC, we have two ways to do it:
- Using ```RestTemplate```.

- Using [Apache Http Client](https://hc.apache.org/httpclient-3.x/).




<br>

## Communications between client and server in Spring Webflux
To support reactive programming between Http access between client and server, Spring webflux provides a new reactive [WebClient](https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/reactive/function/client/WebClient.html) with higher level than APIs in some Http client libraries.





<br>

## Some problems when using WebClient
- Only one connection receive subscriber allowed.

    [https://stackoverflow.com/questions/48046238/spring-webflux-only-one-connection-receive-subscriber-allowed?rq=1](https://stackoverflow.com/questions/48046238/spring-webflux-only-one-connection-receive-subscriber-allowed?rq=1)

- 


<br>

## Wrapping up




<br>

Thanks for your reading.

<br>

Refer:

[https://docs.spring.io/spring/docs/5.1.9.RELEASE/spring-framework-reference/web-reactive.html#webflux-client-builder](https://docs.spring.io/spring/docs/5.1.9.RELEASE/spring-framework-reference/web-reactive.html#webflux-client-builder)

[https://juejin.im/post/5a62f17cf265da3e51333205](https://juejin.im/post/5a62f17cf265da3e51333205)