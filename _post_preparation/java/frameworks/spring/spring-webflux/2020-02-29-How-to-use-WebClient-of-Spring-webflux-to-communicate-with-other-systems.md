---
layout: post
title: How to use WebClient of Spring Webflux to communicate with other systems
bigimg: /img/path.jpg
tags: [Java, Reactive programming, Spring]
---





<br>

## Table of contents
- [Introduction to WebClient](#introduction-to-webclient)
- [Some steps for utilizing WebClient](#some-steps-for-utilizing-webclient)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [The comparison of WebClient with RestTemplate](#the-comparison-of-webclient-with-resttemplate)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to WebClient





<br>

## Some steps for utilizing WebClient






<br>

## Source code





<br>

## Benefits and Drawbacks
1. Benefits




2. Drawbacks




<br>

## Some tips to use WebClient efficiently

https://piotrminkowski.com/2020/03/30/a-deep-dive-into-spring-webflux-threading-model/



<br>

## The comparison of WebClient with RestTemplate

- non-blocking, reactive, and supports higher concurrency with less hardware resources.
- provides a functional API that takes advantage of Java 8 lambdas.
- supports both synchronous and asynchronous scenarios.
- supports streaming up or down from a server.


<br>

## Some problems when using WebClient
- Only one connection receive subscriber allowed.

    [https://stackoverflow.com/questions/48046238/spring-webflux-only-one-connection-receive-subscriber-allowed?rq=1](https://stackoverflow.com/questions/48046238/spring-webflux-only-one-connection-receive-subscriber-allowed?rq=1)

- block()/blockFirst()/blockLast() are blocking, which is not supported in thread reactor-http-nio-3

    https://stackoverflow.com/questions/51449889/block-blockfirst-blocklast-are-blocking-error-when-calling-bodytomono-afte


<br>

## Wrapping up








<br>

Refer:

[https://o7planning.org/en/10303/customize-java-compiler-processing-your-annotation-annotation-processing-tool](https://o7planning.org/en/10303/customize-java-compiler-processing-your-annotation-annotation-processing-tool)

[https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/reactive/function/client/WebClient.html](https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/reactive/function/client/WebClient.html)

[https://stackoverflow.com/questions/53778890/how-to-upload-multiple-files-using-webflux](https://stackoverflow.com/questions/53778890/how-to-upload-multiple-files-using-webflux)

[https://ddcode.net/2019/06/21/spring-webflux-file-upload-and-download/](https://ddcode.net/2019/06/21/spring-webflux-file-upload-and-download/)

[https://juejin.im/post/5a62f17cf265da3e51333205](https://juejin.im/post/5a62f17cf265da3e51333205)

[https://github.com/spring-projects/spring-framework/issues/22919](https://github.com/spring-projects/spring-framework/issues/22919)

[https://java-focus.com/pass-header-to-reactive-webclient-spring-webflux/](https://java-focus.com/pass-header-to-reactive-webclient-spring-webflux/)

[https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/reactive/function/client/WebClient.RequestHeadersSpec.html#headers-java.util.function.Consumer-](https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/reactive/function/client/WebClient.RequestHeadersSpec.html#headers-java.util.function.Consumer-)

[https://app.pluralsight.com/library/courses/java-fundamentals-httpclient/table-of-contents](https://app.pluralsight.com/library/courses/java-fundamentals-httpclient/table-of-contents)