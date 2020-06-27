---
layout: post
title: How to use HttpURLConnection to communicate with other systems
bigimg: /img/path.jpg
tags: [Http Client]
---

In this article, we will learn how to use HttpURLConnection to communicate with other system based on HTTP protocol.

Let's get started.

<br>

## Table of contents
- [Introduction to HttpURLConnection](#introduction-to-httpurlconnection)
- [Some steps to work with HttpURLConnection](#some-steps-to-work-with-httpurlconnection)
- [Source code](#source-code)
- [Some problems when using HttpURLConnection](#some-problems-when-using-httpurlconnection)
- [Preparing parameter headers for HttpURLConnection](#preparing-parameter-headers-for-httpurlconnection)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to HttpURLConnection

**HttpURLConnection** was introduced to Java in JDK 1.1. **HttpURLConnection** class is http specific URLConnection. **HttpURLConnection** is a subclass of **URLConnection** which provides support for HTTP connections. **HttpsURLConnection** is another class which is used for the more secured HTTPS protocol.

<br>

## Some steps to work with HttpURLConnection
1. Create an instance of URL class.

    ```java
    URL url = new URL("...");
    ```

2. Call **openConnection()** method or URL class to get an instance of **HttpURLConnection** class.

    ```java
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    ```

3. Set the request method for an instance of **HttpURLConnection** based on **setRequestMethod()** method. By default, use GET method.

    ```java
    conn.setRequestMethod("GET");       // "POST", "PUT", "DELETE"
    ```

4. Set information for request headers such as "Content-Type", "Accept", "Authorization", ... based on **setRequestProperty()** method.

    ```java
    conn.setRequestProperty("Content-Type", "application/json");
    conn.setRequestProperty("Authorization", "BASIC ...");
    ```    

5. If in our request method, we need to pass request body. Then we should call **setDoOutput()** method.

    ```java
    conn.setDoOutput(true);
    ```

6. When we have request body, we will pass it based on **OutputStream** instance of **HttpURLConnection**'s field.

    ```java
    String bodyData = "...";
    OutputStream os = conn.getOutputStream();
    os.write(bodyData.getBytes());
    os.flush();
    os.close();
    ```

7. Receive response based on InputStream instance of HttpURLConnection's field. To make the reading response effectively, we need to use **BufferedReader** class.

    ```java
    int responseCode = conn.getResponseCode();
    System.out.println("Response code is: " + responseCode);
    if (responseCode == HttpURLConnection.HTTP_OK) {
        this.toResponseResult(conn);
    } else {
        this.toErrorResult(conn);
        System.out.println("Receive error " + responseCode + " when sending request");
    }

    public String toResponseResult(HttpURLConnection conn) throws IOException {
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        return this.getResponseDataFromStream(in);
    }

    public String toErrorResult(HttpURLConnection conn) throws IOException {
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        return this.getResponseDataFromStream(in);
    }

    private String getResponseDataFromStream(BufferedReader in) throws IOException {
        String inputLine = "";
        StringBuffer response = new StringBuffer();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }

        in.close();
        System.out.println("The content of response is: " + response);

        return response.toString();
    }
    ```

<br>

## Source code

In order to get some examples of utilizing HttpURLConnection, we can check out [HttpUrlConnectionUtils](https://github.com/DucManhPhan/J2EE/tree/master/src/Utils/httpurlconnection-utils).


<br>

## Some problems when using HttpURLConnection
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

    - It is a lightweight HTTP client, used to access network resources, and hence, suitable for mobile applications.

    - It's available in Java standard.

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

- The **java.net** package includes classes and interfaces that help manage cookies and can be used to create a stateful (as opposed to stateless) HTTP session. The classes are **CookieHandler**, **CookieManager**, and **HttpCookie**.

- Each **HttpURLConnection** instance is used to make a single request but the underlying network connection to the HTTP server may be transparently shared by other instances.

    Calling the **close()** methods on the **InputStream** or **OutputStream** of an **HttpURLConnection** after a request may free network resources associated with this instance but has no effect on any shared persistent connection.
    
    Calling the **disconnect()** method may close the underlying socket if a persistent connection is otherwise idle at that time.

<br>

Refer:



[https://www.rapidvaluesolutions.com/tech_blog/introduction-to-httpurlconnection-http-client-for-performing-efficient-network-operations/](https://www.rapidvaluesolutions.com/tech_blog/introduction-to-httpurlconnection-http-client-for-performing-efficient-network-operations/)

**Drawbacks of HttpURLConnection**

[[https://docs.oracle.com/javase/1.5.0/docs/guide/net/http-keepalive.html](https://docs.oracle.com/javase/1.5.0/docs/guide/net/http-keepalive.html)

[https://www.javacodegeeks.com/2014/09/caveats-of-httpurlconnection.html](https://www.javacodegeeks.com/2014/09/caveats-of-httpurlconnection.html)

[https://www.baeldung.com/httpurlconnection-post](https://www.baeldung.com/httpurlconnection-post)

[https://www.baeldung.com/java-http-request](https://www.baeldung.com/java-http-request)

[https://www.programming-books.io/essential/android/use-httpurlconnection-for-multipartform-data-1448a66f16754d7d925f8a4804526afe](https://www.programming-books.io/essential/android/use-httpurlconnection-for-multipartform-data-1448a66f16754d7d925f8a4804526afe)

[https://www.codejava.net/java-se/networking/use-httpurlconnection-to-download-file-from-an-http-url](https://www.codejava.net/java-se/networking/use-httpurlconnection-to-download-file-from-an-http-url)

[https://www.codejava.net/java-se/networking/upload-files-by-sending-multipart-request-programmatically](https://www.codejava.net/java-se/networking/upload-files-by-sending-multipart-request-programmatically)

[https://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html](https://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html)

<br>

**Download file with URL**

[https://www.baeldung.com/java-download-file](https://www.baeldung.com/java-download-file)

<br>

**HttpURLConnection with SOAP**

[https://www.blackbaud.com/files/support/infinitydevguidemobile/Advanced/Subsystems/inwebapi-developer-help/Content/Java/coCreateAConnectionWithURLConnection.htm](https://www.blackbaud.com/files/support/infinitydevguidemobile/Advanced/Subsystems/inwebapi-developer-help/Content/Java/coCreateAConnectionWithURLConnection.htm)