---
layout: post
title: How to use HttpURLConnection to communicate with other systems
bigimg: /img/path.jpg
tags: [Java]
---





<br>

## Table of contents
- [Introduction to HttpURLConnection](#introduction-to-httpurlconnection)
- [Some steps to work with HttpURLConnection]()
- [Source code]()
- [Some problem when using HttpURLConnection]()
- [Preparing parameter headers for HttpURLConnection](#preparing-parameter-headers-for-httpurlconnection)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to HttpURLConnection





<br>

## Some steps to work with HttpURLConnection



<br>

## Source code




<br>

## Some problem when using HttpURLConnection
1. Using PUT request with JSON data but it does not work.

    ```java
    url = new URL("...");
    HttpURLConnection hurl = (HttpURLConnection) url.openConnection();
    hurl.setRequestMethod("PUT");
    hurl.setDoOutput(true);
    hurl.setRequestProperty("Content-Type", "application/json");
    hurl.setRequestProperty("Accept", "application/json");

    String payload = "{'pos':{'left':45,'top':45}}";

    OutputStreamWriter osw = new OutputStreamWriter(hurl.getOutputStream());
    osw.write(payload);
    osw.flush();
    osw.close();
    ```

    Solution:
    - With an above problem, we can find that we only open connection, then set parameters for request. Finally, we do not send it to our server.

        To send our content, we need to call:

        ```java
        int responseCode = hurl.getResponseCode();
        ```

        Because the Oracle implementation of **HttpURLConnection** caches our post's content unless we tell it to be in streaming mode. The content will be sent if we start interaction with **getResponseCode()** method of **HttpURLConnection**'s instance.

    - According to RFC 4627, we can not use single quotes in our JSON (although some implementations seem to not care). So, we need to change our json string with the below format:

        ```java
        String payload = "{\"pos\":{\"left\":45,\"top\":45}}";
        ```

<br>

## Benefits and Drawbacks
1. Benefits



2. Drawbacks

    - It's just a very old API.
    
        The first version of Java was released more than 20 years ago in 1996. HttpURLConnection was added to Java in JDK 1.1, which was released in 1997. It's designed around the HTTP/1.1 timeframe. Things weren't clear-cut as they are now in terms of modeling HTTP requests and responses and typical interaction patterns.

        And it doesn't include generics, enums, and lambdas, so it feels really clunky to use in modern Java. Even though, HttpURLConnection is being replaced with HttpClient in Java 11.

    - In HttpURLConnection's code, we can find some weird things that we need to know

        ```java
        try {
            URL url = new URL("http://google.com");
            HttpURLConnection conn = (HttpURLConnection) conn.openConnection();     // (1)
            conn.setRequestMethod("GET");   // (2)
            conn.setRequestProperty("User-Agent", "...");
            if (conn.getResponseCode() == 200) {
                System.out.println(readInputStream(conn.getInputStream()));     // (3)
            } else {
                System.out.println("Something wrong there");
            }
        } catch(IOException ex) {
            System.out.println("Something wrong there");
        }
        ```

        At (1) line, when we call **openConnection()** method on the URL, we get back a URL connection. However, we know the URL points to an HTTP server, so we want to configure it as such. Therefore, we need to first cast it to HttpURLConnection.
        
        At (2) line, when configuring the HTTP **RequestMethod** pass in a string because there were no enums when this API was designed. However, we could easily pass in a malformed string.

        At (3) line, it's difficult to realize that it's the actual handling of the response body. There we see that we can ask the connection for the input stream. But that's a raw input stream. Therefore, we need to write a helper method, in this case, readInputStream() to take that raw input stream and turn it into something useful. That's pretty low-level code that we have to write there with lots of possibilities.for subtle errors.

    - The Http method **PATCH** does not support.

    - An exception is thrown directly when encountering errors such as 400 Bad Request, 404 Not Found. So, we need to use exception handling try/cathch to handle our exceptions.

<br>

## Wrapping up
- If our project do not use JDK 11, to communicate with other systems, we can use other third-party libraries such as the Apache HttpComponents project, which also offers an HttpClient API, and OkHttp from Square, which is another opensource HttpClient for Java, and there's also even higher-level libraries like the JAX-RS Rest client. This REST client doesn't only perform HTTP requests, but it also knows about REST principles, and can, for example, automatically map JSON responses to Java objects. 


<br>

Refer:

**Drawbacks of HttpURLConnection**

[[https://docs.oracle.com/javase/1.5.0/docs/guide/net/http-keepalive.html](https://docs.oracle.com/javase/1.5.0/docs/guide/net/http-keepalive.html)

[https://www.javacodegeeks.com/2014/09/caveats-of-httpurlconnection.html](https://www.javacodegeeks.com/2014/09/caveats-of-httpurlconnection.html)

[https://www.baeldung.com/httpurlconnection-post](https://www.baeldung.com/httpurlconnection-post)

[https://www.baeldung.com/java-http-request](https://www.baeldung.com/java-http-request)

[https://www.programming-books.io/essential/android/use-httpurlconnection-for-multipartform-data-1448a66f16754d7d925f8a4804526afe](https://www.programming-books.io/essential/android/use-httpurlconnection-for-multipartform-data-1448a66f16754d7d925f8a4804526afe)

[https://www.codejava.net/java-se/networking/use-httpurlconnection-to-download-file-from-an-http-url](https://www.codejava.net/java-se/networking/use-httpurlconnection-to-download-file-from-an-http-url)

[https://www.codejava.net/java-se/networking/upload-files-by-sending-multipart-request-programmatically](https://www.codejava.net/java-se/networking/upload-files-by-sending-multipart-request-programmatically)

<br>

**Download file with URL**

[https://www.baeldung.com/java-download-file](https://www.baeldung.com/java-download-file)