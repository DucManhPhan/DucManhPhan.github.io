---
layout: post
title: The different between Web server, Web container and Application server
bigimg: /img/path.jpg
tags: [Java]
---

In this article, we will learn how to differentiate between web server, web container, and application server. Based on these differences, we can choose our compatible server to deploy our applications.

Let's get started.

<br>

## Table of content
- [Web server](#web-server)
- [Web container or Servlet container](#web-container-or-servlet-container)
- [Application server](#application-server)
- [Some questions about web container and application server](#some-questions-about-web-container-and-application-server)
- [Wrapping up](#wrapping-up)

<br>

## Web server

1. Definition

    According to [wikipedia.com](https://en.wikipedia.org/wiki/Web_server), we have the functionality of web server is to store, process and deliver web pages to clients. The communication between client and server takes place using HTTP protocol. Pages delivered are most frequently HTML documents, which may include images, style sheets and scripts in addition to the text document.

    While the major function is to seve content, a full implementation of HTTP also includes ways of receiving content from clients. This feature is used for submitting web forms, including uploading of files.

2. How web server works

    When we type the address of website, for example: **http://www.example.com/path/file.html**. The browser will search IP address corresponding to **http://www.example.com** in cache file of computer. If not finding, the browser will send **http://www.example.com** to DNS system to get its IP address.

    After get its IP address, the client's user agent will translate it into a connection to www.example.com with the following HTTP/2 request.

    ```python
    GET /path/file.html HTTP/2
    Host: www.example.com
    Content-Type: text/html;charset=utf-8
    ...
    ```

    Before sending our real packet into host, three handshake will be implemented. It will check connection between our computer and host that is connected.

    Then we have the content of packet, TCP protocol will works. It will split the big package into smaller packet, then sending it to our host - wwww.example.com.

    In the host - www.example.com, due to use the HTTP protocol, by default, the port is 80, always there is a process that is listening to get its package.

    After receiving all packets, the web server on **www.example.com** will append the given path to the path of its root directory. On an Apache server, this is commonly **/home/www** (on Unix machines, usually **/var/www**). The result is the local file system resource:

    ```yaml
    /home/www/path/file.html
    ```

    The web server then reads the file, if it exists, and sends a response to the client's web browser. The response will describe the content of the file and contain the file itself or an error message will return saying that the file does not exist or is unavailable.

3. Common web servers

    - Apache HTTP Server - is used everywhere including Java world.
    - Nginx
    - Internet Information Services (IIS) - more popular in Microsoft ASP.NET world.
    - LiteSpeed Web server
    - GWS

<br>

## Web container or Servlet container

1. Definition

    Web container or Servlet container is a web server that can serve dynamic content based on JSP - Java Server Pages, and Servlet. A web container is responsible for managing the lifecycle of servlets, mapping a URL to a particular servlet and ensuring that the URL requester has the correct access rights throught xml configurations or annotation configurations.

    Servlets are java classes executed on the server and are used to generate dynamic web pages. We can use print statements within servlet to print html tags and html data to the browser. Java Server Page (JSP) is a server side technology based on java that help us to create dynamically generated web pages based on HTML, XML etc. easily. While servlets can be considered as java classes with html, JSPs can be considered html pages with java. JSPs are eventually converted into servlets by the server before execution.

2. Common Web containers

    - Apache Tomcat (formerly Jakarta Tomcat), Apache Tomcat 6 and above are operable as general application container (prior versions were web containers only).
    - Jetty from the Eclipse Foundation. Also support SPDY and Websocket protocols.

    - Resin Pro, from Caucho Technology.

<br>

## Application server

1. Definition

    In order to define application server correctly, it needs to satisfy some requirements of Java EE specifications.

    |                 Specification                 |           Java EE 6        |         Java EE 7        |       Java EE 8        |
    | --------------------------------------------- | -------------------------- | ------------------------ | ---------------------- |
    | Servlet                                       | 3.0                        | 3.1                      | 4.0                    |
    | JavaServer Pages (JSP)                        | 2.2                        | 2.3                      | 2.3                    |
    | Unified Expression Language (EL)              | 2.2                        | 3.0                      | 3.0                    |
    | Debugging Support for Other Languages (JSR-45)| 1.0                        | 1.0                      | 1.0                    |
    | JavaServer Pages Standard Tag Library (JSTL)  | 1.2                        | 1.2                      | 1.2                    |
    | JavaServer Faces (JSF)                        | 2.0                        | 2.2                      | 2.3                    |
    | Java API for RESTful Web Services (JAX-RS)    | 1.1                        | 2.0                      | 2.1                    |
    | Java API for WebSocket (WebSocket)            | n/a                        | 1.0                      | 1.1                    |
    | Java API for JSON Processing (JSON-P)         | n/a                        | 1.0                      | 1.1                    |
    | Common Annotations for the Java Platform (JSR-250 | 1.1                    | 1.2                      | 1.3                    |   
    | Enterprise JavaBeans (EJB)                    | 3.1 Lite                   | 3.2 Lite                 | 3.2                    |
    | Java Transaction API (JTA)                    | 1.1                        | 1.2                      | 1.2                    |
    | Java Persistence API (JPA)                    | 2.0                        | 2.1                      | 2.2                    |
    | Bean Validation                               | 1.0                        | 1.1                      | 2.0                    |
    | Managed Beans                                 | 1.0                        | 1.0                      | 1.0                    |
    | Interceptors                                  | 1.1                        | 1.2                      | 1.2                    |
    | Contexts and Dependency Injection for the Java EE Platform | 1.0           | 1.1                      | 2.0                    |
    | Dependency Injection for Java                 | 1.0                        | 1.0                      | 1.0                    |

    So, an application server has a full functionality of a web container, but it provides the amount of additional functionality such as EJB, JTA, CDI, JAX-RS, JAX-WS, ...

2. Common Application servers

    - IBM Websphere
    - Oracle Web Logic
    - Glassfish from Oracle, includes a whole Tomcat as web container.
    - Wildfly (formerly Redhat JBoss application server).
    - Apache Geronimo is a full Java EE 6 implementation by Apache Software Foundation.

<br>

## Some questions about web container and application server

1. Tomcat and Wildfly - which one do we choose?

    - We choose Tomcat, if we want to deploy our application with only servlet and jsp file, without any other features such as EJB, JTA, JPA, JAX-RS, JAX-WS, ... But Tomcat is an open source, lightweigt, and easy to use.

        In order to use fully functionality of Java EE in Tomcat, we can use Spring framework, deploy our project to **.war** extension. Then, deploy on Tomcat. Tomcat will help us to operate multiple the projects's deployment.

    - We choose Wildfly when we have to use Java EE functionalities in our project. Wildfy has two versions, free and commercial, it can be called as JBoss Enterprise Application Platform. And we can easy to migrate to JBoss EAP to receive support from Redhat.

<br>

## Wrapping up
- Understand the concept of web server, web container, and application server.

- When to choose the specific type server in our project.

<br>

Refer:

**Web server**

[https://en.wikipedia.org/wiki/Web_server](https://en.wikipedia.org/wiki/Web_server)

<br>

**Application server**

[https://blog.idrsolutions.com/2015/04/top-10-open-source-java-and-javaee-application-servers/](https://blog.idrsolutions.com/2015/04/top-10-open-source-java-and-javaee-application-servers/)

[https://en.wikipedia.org/wiki/Java_Platform,_Enterprise_Edition](https://en.wikipedia.org/wiki/Java_Platform,_Enterprise_Edition)

<br>

[https://javajee.com/web-server-web-container-and-application-server](https://javajee.com/web-server-web-container-and-application-server)

[https://www.mulesoft.com/tcat/tomcat-6](https://www.mulesoft.com/tcat/tomcat-6)

[https://www.mulesoft.com/tcat/understanding-apache-tomcat](https://www.mulesoft.com/tcat/understanding-apache-tomcat)

[https://www.oracle.com/technetwork/java/javaee/servlet/index.html](https://www.oracle.com/technetwork/java/javaee/servlet/index.html)

[https://examples.javacodegeeks.com/enterprise-java/tomcat/tomcat-connection-pool-configuration-example/](https://examples.javacodegeeks.com/enterprise-java/tomcat/tomcat-connection-pool-configuration-example/)

[https://examples.javacodegeeks.com/enterprise-java/tomcat/tomcat-server-xml-configuration-example/](https://examples.javacodegeeks.com/enterprise-java/tomcat/tomcat-server-xml-configuration-example/)

[https://stackoverflow.com/questions/11911182/why-does-tomcat-skip-the-scanning-jars-specified-in-defaultjarscanner-jarstoskip](https://stackoverflow.com/questions/11911182/why-does-tomcat-skip-the-scanning-jars-specified-in-defaultjarscanner-jarstoskip)

<br>

**Comparing Tomcat with Websphere**

[https://www.mulesoft.com/tcat/tomcat-websphere](https://www.mulesoft.com/tcat/tomcat-websphere)

[https://dzone.com/articles/wildfly-8-vs-glassfish-4-which?fromrel=true](https://dzone.com/articles/wildfly-8-vs-glassfish-4-which?fromrel=true)

<br>

**War, Jar, Ear files**

[https://stackoverflow.com/questions/1594667/war-vs-ear-file/1594818#1594818](https://stackoverflow.com/questions/1594667/war-vs-ear-file/1594818#1594818)

