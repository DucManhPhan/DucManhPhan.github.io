---
layout: post
title: How to use Apache HttpClient to communicate with other systems
bigimg: /img/path.jpg
tags: [Java]
---



<br>

## Table of contents
- [Introduction to Apache HttpClient](#introduction-to-apache-httpclient)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Apache HttpClient

Spring RestTemplate and Apache HttpClient API work at different levels of abstraction.
- Spring RestTemplate is superior to the HttpClient and take care of the tranformation from JSON or XML to Java objects.

- The Apache HttpClient takes care of all low level details of communication via Http.

But we also can use some other http client libraries such as OkHttp, Netty.

In order to use Apache HttpClient APIs, we can add depedency into pom.xml file:

```xml
<dependency>
    <groupId>org.apache.httpcomponents</groupId>
    <artifactId>httpclient</artifactId>
</dependency>
```



<br>

## Source code





<br>

## Benefits and Drawbacks



<br>

## Wrapping up







<br>

Refer:

[https://www.baeldung.com/httpclient-multipart-upload](https://www.baeldung.com/httpclient-multipart-upload)

[https://www.baeldung.com/httpclient-connection-management](https://www.baeldung.com/httpclient-connection-management)

[https://www.baeldung.com/httpclient-post-http-request](https://www.baeldung.com/httpclient-post-http-request)

[https://www.baeldung.com/httpclient-guide](https://www.baeldung.com/httpclient-guide)

[https://springframework.guru/using-resttemplate-with-apaches-httpclient/](https://springframework.guru/using-resttemplate-with-apaches-httpclient/)

[https://www.journaldev.com/7146/apache-httpclient-example-closeablehttpclient](https://www.journaldev.com/7146/apache-httpclient-example-closeablehttpclient)

[https://www.javaguides.net/2018/10/apache-httpclient-get-post-put-and-delete-methods-example.html](https://www.javaguides.net/2018/10/apache-httpclient-get-post-put-and-delete-methods-example.html)