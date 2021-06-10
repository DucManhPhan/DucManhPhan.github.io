---
layout: post
title: Some interesting things about HTTP protocol
bigimg: /img/image-header/yourself.jpeg
tags: [Network]
---




<br>

## Table of contents
- [About GET method](#about-get-method)
- [About POST method](#about-post-method)
- []()
- [Comparing between HTTP 1.0 and HTTP 1.1](#comparing-between-http-1.0-and-http-1.1)
- [Wrapping up](#wrapping-up`)


<br>

## About GET method

1. Do not use GET method to send sensitive data to server

	The GET method's parameters are passed via URL. It means that parameters are stored in server logs, and browser history.

	Solution:
	- Using HTTPS protocol and don't expose sensitive data in the URL.

2. Size of path in GET method

	- Microsoft Internet Explorer

		The path of GET method will limit to a maximum of 2048 characters, minus the number of characters in the actual path.

		But the POST method is not limited by the size of the URL for submitting name/value pairs. These pairs are transferred in the header and not in the URL.

	- Chrome

		It can support the length of URL more than 100,000 characters, but after 64,000 characters, the remained characters will be hidden.

	- Firefox

		The maximum length of URL is 65,536 characters.

<br>

## About POST method

1. 



2. 




<br>

## Comparing between HTTP 1.0 and HTTP 1.1

1. Persistent connections

	- HTTP 1.0 opens a new connection for each request/response pair. It means that after receiving the response from a server, it will terminate the connection.

		Drawbacks of HTTP 1.0:
		- Time-consuming for the connection creation, so a system encounters high latency and low throughput.

	- HTTP 1.1 provides multiple requests/responses on the same connection. It is called as a persistent connection.


2. Caching

	- HTTP 1.0 uses a header **If-Modified-Since** to support caching.

	- HTTP 1.1 provides multiple improvements over HTTP 1.0 by using other headers such as **If-Unmodified-Since**, **If-None-Match**, **Cache-Control**, and using entity tags to mark the same resources.


<br>

## Wrapping up




<br>

Refer:

[https://en.wikipedia.org/wiki/TCP_congestion_control#Slow_start](https://en.wikipedia.org/wiki/TCP_congestion_control#Slow_start)

[Should sensitive data ever be passed in the query string?](https://security.stackexchange.com/questions/29598/should-sensitive-data-ever-be-passed-in-the-query-string)

[]()