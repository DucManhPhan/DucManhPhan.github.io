---
layout: post
title: How to use Spring RestTemplate to communicate with other systems
bigimg: /img/path.jpg
tags: [Spring, Http Client]
---

In this article, we will learn how to use Spring RestTemplate. Let's get started.

<br>

## Table of contents
- [Introduction to Spring RestTemplate](#introduction-to-spring-resttemplate)
- [Some useful methods that RestTemplate supports](#some-useful-methods-that-RestTemplate-supports)
- [Some steps use for utilizing Spring RestTemplate](#some-steps-use-for-utilizing-spring-resttemplate)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Understanding about some useful classes for utilizing RestTemplate](#understanding-about-some-useful-classes-for-utilizing-resttemplate)
- [Some problems when using Spring RestTemplate](#some-problems-when-using-spring-resttemplate)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Spring RestTemplate

Spring RestTemplate is a part of **spring-web** module that was introduced in Spring 3. We have some interesting information that we have to jot down:
- It is a blocking and synchronous HttpClient that exposes a simple, template method API over underlying HTTP Client libraries such as JDK **HttpURLConnection**, **Apache HttpComponents**, ...

    Spring RestTemplate is an above layer of the Http client, it will tackle the problem of the transformation from JSON or XML to Java objects.

    The Http client takes care of all low-level details of communication via HTTP.

- It supports Restful webservices with only Http protocol, not Https protocol.

- It will be deprecated in the future since we have **WebClient** that support reactive programming, non-blocking HttpClient in Spring boot 2 or Spring 5 or later.

RestTemplate simplifies communication with HTTP services, and program code can provide it with URLs and extract results. It uses JDK's **HttpURLConnection** by default to communicate, but we can switch to different HTTP sources through **RestTemplate.setRequestFactory()**: **Apache HttpComponents**, **Netty**, **OkHttp**, and so on.

<br>

## Some useful methods that RestTemplate supports

- **getForObject()** : It retrieves an entity using HTTP GET method on the given URL.

- **exchange()** : Executes the HTTP method for the given URI. It returns ResponseEntity. It can communicate using any HTTP method.

- **headForHeaders()** : Retrieves all headers. It uses HTTP HEAD method.

- **getForEntity()** : It retrieves an entity by using HTTP GET method for the given URL. It returns ResponseEntity.

- **delete()** : Deletes the resources at the given URL. It uses HTTP DELETE method.

- **put()**: It creates new resource or update for the given URL using HTTP PUT method.

- **postForObject()**: It creates new resource using HTTP POST method and returns an entity.

- **postForLocation()**: It creates new resource using HTTP POST method and returns the location of created new resource.

- **postForEntity()**: It creates news resource using HTTP POST method to the given URI template. It returns ResponseEntity.


<br>

## Some steps use for utilizing Spring RestTemplate
1. We use HttpHeaders class to fill some key-values into our http header.

    ```java
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_JSON);
    headers.set("Authorization", "Bearer ...");
    // include the other parameters of header.
    ```

2. Normally, we will use **HttpEntity** to wrap all request body and all parameters of http header.

    ```java
    HttpEntity <String> entity = new HttpEntity<String>(headers);

    // or
    String bodyData = "";
    HttpEntity<String> httpEntity = new HttpEntity<String>(bodyData, headers);
    ```

3. Send request.

    - The common way to send request is to use **exchange()** method and use **HttpMethod** class that define all request methods we need.

    - With get request, we can use **getForEntity()** method or getForObject() method.

    - With post request, use **postForObject()**, **postForEntity()**, **postForLocation()** methods.

    - With put request, use **put()** method.

    - With delete request, use **delete()** method.

    - To get all headers information, use **headForHeaders()** method.

<br>

## Source code

In order to understand how to implement code by using Spring RestTemplate, we can check out source code in [Spring RestTemplate Utils](https://github.com/DucManhPhan/J2EE/tree/master/src/Utils/spring-resttemplate-utils).

<br>

## Benefits and Drawbacks
1. Benefits

    - Spring RestTemplate provides many functionality for interact with Rest client. It deals with JSON/XML transformation of entities, ...

    - Spring RestTemplate is a higher-level abstraction than Apache HttpClient. By default, Spring RestTemplate uses Apache HttpClient internally. We can use other implementation with configuring ClientHttpRequestFactory class.

    - RestTemplate is thread-safe once constructed, and that we can use callbacks to customize its operations.

2. Drawbacks

    - It takes so much time when we have multiple user access.
    
        Under the hood, RestTemplate uses the Java Servlet API, which is based on the thread-per-request model. The thread will block until the web client receives the response.
        
        When we have multiple user, our application will create multiple threads, which will exhaust the thread pool or occupy all the available memory.

    - Degrade our application's performance.

<br>

## Understanding about some useful classes for utilizing RestTemplate

1. RequestCallback class

    ```java
    @FunctionalInterface
    public interface RequestCallback {
        void doWithRequest(ClientHttpRequest var1) throws IOException;
    }
    ```

2. ResponseExtractor class

    According to the [ResponseExtractor's document](https://docs.spring.io/spring/docs/3.0.x/javadoc-api/org/springframework/web/client/ResponseExtractor.html) we have its definition:

    ```java
    @FunctionalInterface
    public interface ResponseExtractor<T> {
        @Nullable
        T extractData(ClientHttpResponse var1) throws IOException;
    }
    ```

    The **extractData()** method is used to extract data from the given **ClientHttpResponse** and return it.

    Take a closer look at **ClientHttpResponse** class, we can find that:

    ```java
    public interface ClientHttpResponse extends HttpInputMessage, Closeable {
        HttpStatus getStatusCode() throws IOException;

        int getRawStatusCode() throws IOException;

        String getStatusText() throws IOException;

        void close();
    }

    public interface HttpInputMessage extends HttpMessage {
        InputStream getBody() throws IOException;
    }
    ```

    It means that its method will be called each time we receive stream data that probably assuming that it has BUFFER_SIZE = 4096 or like that. Then, to get data under **InputStream**, we only need to call **var1.getBody()**. Finally, we will read data from **InputStream**, then convert it to our format.

    But the **getForObject()** and **getForEntity()** methods of **RestTemplate** load the entire response in memory. This is not suitable for downloading large files since it can cause out of memory exceptions. So, to deal with this problem, we can use **ResponseExtractor** class as argument of **execute()** method of **RestTemplate**.

    ```java
    RequestCallback requestCallback = request -> request.getHeaders()
        .setAccept(Arrays.asList(MediaType.APPLICATION_OCTET_STREAM, MediaType.ALL));

    ResponseExtractor<Void> responseExtractor = response -> {
        Path path = Paths.get("some/path");
        Files.copy(response.getBody(), path);
        return null;
    };

    restTemplate.execute(URI.create("www.something.com"), HttpMethod.GET, requestCallback, responseExtractor);
    ```

<br>

## Some problems when using Spring RestTemplate
1. Error while extracting response for type [class java.lang.String] and content type [application/json]

    The main problem here is content type [text/html;charset=iso-8859-1] received from the service, however the real content type should be application/json;charset=iso-8859-1

    In order to overcome this you can introduce custom message converter. and register it for all kind of responses (i.e. ignore the response content type header). Just like this:

    ```java
    List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();        
    //Add the Jackson Message converter
    MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();

    // Note: here we are making this converter to process any kind of response, 
    // not only application/*json, which is the default behaviour
    converter.setSupportedMediaTypes(Collections.singletonList(MediaType.ALL));        
    messageConverters.add(converter);  
    restTemplate.setMessageConverters(messageConverters); 
    ```

<br>

## Wrapping up
- Spring RestTemplate that uses **MessageConverter** internally. So we need to set this property in the RestTemplate bean.

- Spring supports multiple http client libraries through its [ClientHttpRequestFactory](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/http/client/ClientHttpRequestFactory.html) abstraction:

    - Apache HttpComponents HttpClient
    - Netty4
    - OkHttp
    - OkHttp3
    - Standard JDK calls

<br>

Refer:

[https://www.baeldung.com/spring-webclient-resttemplate](https://www.baeldung.com/spring-webclient-resttemplate)

[https://github.com/spring-framework-guru/sfg-blog-posts/tree/master/resttemplate](https://github.com/spring-framework-guru/sfg-blog-posts/tree/master/resttemplate)

[https://springframework.guru/using-resttemplate-with-apaches-httpclient/](https://springframework.guru/using-resttemplate-with-apaches-httpclient/)

[https://www.journaldev.com/17096/spring-resttemplate-example](https://www.journaldev.com/17096/spring-resttemplate-example)

[https://programmer.ink/think/are-you-familiar-with-the-use-and-principles-of-resttemplate-enjoy-spring-mvc.html](https://programmer.ink/think/are-you-familiar-with-the-use-and-principles-of-resttemplate-enjoy-spring-mvc.html)

[https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/client/RestTemplate.html](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/client/RestTemplate.html)

[https://springframework.guru/using-resttemplate-in-spring/](https://springframework.guru/using-resttemplate-in-spring/)

[https://stackoverflow.com/questions/44176335/restclientexception-could-not-extract-response-no-suitable-httpmessageconverte](https://stackoverflow.com/questions/44176335/restclientexception-could-not-extract-response-no-suitable-httpmessageconverte)

<br>

**Error Handling in RestTemplate**

[https://www.baeldung.com/spring-rest-template-error-handling](https://www.baeldung.com/spring-rest-template-error-handling)

<br>

**Some ways to download file in Spring boot**

[https://memorynotfound.com/spring-mvc-download-file-examples/](https://memorynotfound.com/spring-mvc-download-file-examples/)

[https://memorynotfound.com/spring-mvc-file-upload-example-validator/](https://memorynotfound.com/spring-mvc-file-upload-example-validator/)

[https://www.devglan.com/spring-boot/spring-boot-file-upload-download](https://www.devglan.com/spring-boot/spring-boot-file-upload-download)

[https://javausecase.com/2017/07/20/asyncresttemplate-rest-call-with-responseextractor-asyncrequestcallback/](https://javausecase.com/2017/07/20/asyncresttemplate-rest-call-with-responseextractor-asyncrequestcallback/)

[https://www.baeldung.com/spring-resttemplate-download-large-file](https://www.baeldung.com/spring-resttemplate-download-large-file)

[https://o7planning.org/en/11765/spring-boot-file-download-example](https://o7planning.org/en/11765/spring-boot-file-download-example) - Useful link about how to download file when using InputStreamResource, ByteArrayResource, or set properties on HttpServletResponse
