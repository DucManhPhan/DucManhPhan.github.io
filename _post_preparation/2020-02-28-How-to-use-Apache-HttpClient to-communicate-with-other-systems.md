---
layout: post
title: How to use Apache HttpClient to communicate with other systems
bigimg: /img/path.jpg
tags: [Java]
---



<br>

## Table of contents
- [Introduction to Apache HttpClient](#introduction-to-apache-httpclient)
- []()



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

## 





<br>

## Implementing with Get request






<br>

## Implementing with Post request





<br>

## Implementing with Put request




<br>

## Implementing with Patch request



<br>

## Implementing with Delete request




<br>

## Implementing with upload file




<br>

## Implementing with download file

## Wrapping up







<br>

Refer:

[https://www.baeldung.com/httpclient-multipart-upload](https://www.baeldung.com/httpclient-multipart-upload)

[https://www.baeldung.com/httpclient-guide](https://www.baeldung.com/httpclient-guide)

[https://springframework.guru/using-resttemplate-with-apaches-httpclient/](https://springframework.guru/using-resttemplate-with-apaches-httpclient/)

