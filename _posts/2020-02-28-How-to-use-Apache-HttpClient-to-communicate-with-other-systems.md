---
layout: post
title: How to use Apache HttpClient to communicate with other systems
bigimg: /img/path.jpg
tags: [Http Client]
---

In this article, we learn how to use Apache HttpClient. Let's get started.

<br>

## Table of contents
- [Introduction to Apache HttpClient](#introduction-to-apache-httpclient)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Apache HttpClient

The first version of Apache HttpClient is 4.0-alpha1, it was released at Jul 18, 2007. And nowadays, this library is still supported by Apache with the newest version - 4.5.11.

Apache HttpClient has the same functionality with HttpURLConnection is to communicate with other system based on HTTP protocol.

Spring RestTemplate and Apache HttpClient API work at different levels of abstraction.
- **Spring RestTemplate** is superior to the HttpClient and take care of the tranformation from JSON or XML to Java objects.

- The **Apache HttpClient** takes care of all low level details of communication via Http.

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

In order to understand how to implement code by using Apache HttpClient, we can check out source code in [Apache HttpClient Utils](https://github.com/DucManhPhan/J2EE/tree/master/src/Utils/apache-httpclient-utils).


<br>

## Benefits and Drawbacks
1. Benefits

    - Large and extensive APIs

    - Supports cookie handling, authentication and connection management

    - More suitable for web browser and other web applications, because of its large size


2. Drawbacks

    - When using in Android app, Google blog lists few bugs, we can reference to [this link](https://www.rapidvaluesolutions.com/tech_blog/introduction-to-httpurlconnection-http-client-for-performing-efficient-network-operations/).

    - Does not support **HttpResponseCache** mechanism, hence leading to increased network usage and battery consumption

<br>

## Wrapping up




<br>

Refer:

[https://hc.apache.org/httpcomponents-client-4.5.x/examples.html](https://hc.apache.org/httpcomponents-client-4.5.x/examples.html)

[https://www.baeldung.com/httpclient-multipart-upload](https://www.baeldung.com/httpclient-multipart-upload)

[https://www.baeldung.com/httpclient-connection-management](https://www.baeldung.com/httpclient-connection-management)

[https://www.baeldung.com/httpclient-post-http-request](https://www.baeldung.com/httpclient-post-http-request)

[https://www.baeldung.com/httpclient-guide](https://www.baeldung.com/httpclient-guide)

[https://springframework.guru/using-resttemplate-with-apaches-httpclient/](https://springframework.guru/using-resttemplate-with-apaches-httpclient/)

[https://www.journaldev.com/7146/apache-httpclient-example-closeablehttpclient](https://www.journaldev.com/7146/apache-httpclient-example-closeablehttpclient)

[https://www.javaguides.net/2018/10/apache-httpclient-get-post-put-and-delete-methods-example.html](https://www.javaguides.net/2018/10/apache-httpclient-get-post-put-and-delete-methods-example.html)