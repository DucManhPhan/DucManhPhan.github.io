---
layout: post
title: How to use Java API for websocket
bigimg: /img/image-header/factory.jpg
tags: [Java, Websocket]
---



<br>

## Table of contents





<br>

## Introduction to Websockets

Websockets allow for duplex communication between browser and server. What that means is that as well as the browser sending to the server data, the server can also send the browser data.

Unlike the traditional HTTP, where the browser sends a request to the server to grab the data, the server is no way in that scenario to send data directly to the browser.

Websockets are supported in modern servers, and in modern browsers, so IE 10, Chrome, Firefox, IIS8 and above, Apache, all support Websockets.

![](../img/Websocket/connection-websockets.png)

The way it works is that we have a client and a server, and the client and server perform a Websocket handshake. Once the handshake has been performed, and both sides are happy that they can communicate over Websockets, we can then send data two ways. So the client can send data to the server, and the server can send data to the client. At some point, one side or other can decide that they want to end the communication. What that happens, one side closes the communication, and the other side of the connection receives an event which tells them the connection's been closed, and they can then tidy up behind themselves.

<br>

## Introduction to the Java API for Websockets

The Java API for Websockets, this is part of Java EE since version 7. This is an API that lets us create a Websocket server, so we can run code inside, for example, Tomcat, or Jetty, or any sort of standard Java EE server. It allows us to create what's called an endpoint, and we can create that endpoint one of two ways.
- We can create endpoint programmatically means that We can use an API to create the endpoint.

- We can use Java annotations to create the endpoint.

The API allows us to send both text, and binary data. It also allows us to use Java types in the server, and convert those Java types into JSON that we can send the client, and then any JSON we receive back from the client, we can convert back to Java types within the server, and that makes writing code for the API for Websockets very easy.

We simply use the built-in Java types. It also supports something called URI templates, which allow us to configure the URI the server can receive, and then change the root of those request depending on the incoming URI. So to see how to use Websockets, we'll build a demo application.


<br>

## When to use






<br>

## 



<br>

## Wrapping up








<br>

Refer:
