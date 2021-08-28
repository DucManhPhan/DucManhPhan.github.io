---
layout: post
title: How to use Java 11's HttpClient to communicate with other systems
bigimg: /img/path.jpg
tags: [Java]
---



<br>

## Table of contents
- [Introduction to Java 11's HttpClient](#introduction-to-java-11's-httpclient)
- []()
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Java 11's HttpClient

The HttpClient API is introduced in Java 11, which was released in September 2018. However, it was already available as a preview feature the year before that in Java 9. This way the API had some time to mature in the real world before it was finalized in Java 11.

As of Java 11, the HttpClient API is part of the Java standard library. That means we do not need to add any external dependencies to our application to use this APIs. The HttpClient API replaces the HttpURLConnection API that was already available in Java for a long time. And like HttpURLConnection, this new HttpClient API supports HTTP/2, and Websocket communication. And it alsow supports earlier versions of HTTP. Another important feature of the HttpClient API is that it provides both synchronous, blocking, and asynchronous, non-blocking methods to perform Http requests.

The design goal of the HttpClient API was to be easy to use in common cases and to be powerful enough for complex use cases.

The HttpClient API has the three most important types that live in **java.net.http package**. 
- First, the HttpClient class that has two most important methods are send() and sendAsync() methods.

    The send() method performs a synchronous and blocking call to a server, whereas the sendAsync() method performs an asynchronous non-blocking call. We cannot directly instantiate the HttpClient class. Instead, there's a **newBuilder()** method that provides us with a builder class.

- Second, it's the HttpRequest.

    One of the parameters to the send() method is an **HttpRequest**. An **HttpRequest** contains all the information that we would expect like the **URI** that the request is targeted at, possibly **HTTP headers** that need to be sent along with the request, and an **HTTP method** indicating whether it's a GET, PUT, POST, or another HTTP method that should be sent in the request to the server.
    
    Same as with the HttpClient, we cannot construct an HttpRequest directly. But we can do so through a builder. The builders always return immutable object. So once created, an HttpRequest or an HttpClient cannot be changed.

- Third, we have HttpResponse type. In addition to the URI, headers, and the statusCode, typically the most important part of the HttpResponse is the body. That is the payload that's returned by the HTTP server.

For example:

```java
HttpClient client = HttpClient.newHttpClient();
HttpRequest request = HttpRequest.newBuilder(URI.create("http://google.com"))
                                 .build();

HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
```

By default, the HttpRequest builder will construct a GET request to the server.

<br>

## 





<br>

## Wrapping up







<br>

Refer:

[Java Fundamentals: HttpClient](https://app.pluralsight.com/library/courses/java-fundamentals-httpclient/table-of-contents)

[https://www.baeldung.com/java-9-http-clients](https://www.baeldung.com/java-9-http-client)

[https://openjdk.java.net/groups/net/httpclient/intro.html](https://openjdk.java.net/groups/net/httpclient/intro.html)

[https://blog.codefx.org/java/http-2-api-tutorial/](https://blog.codefx.org/java/http-2-api-tutorial/)

[https://blog.codefx.org/java/switch-expressions/](https://blog.codefx.org/java/switch-expressions/)