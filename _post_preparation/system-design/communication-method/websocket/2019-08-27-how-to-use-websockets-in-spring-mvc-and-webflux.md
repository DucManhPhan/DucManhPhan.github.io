---
layout: post
title: How to use websocket in Spring MVC and Spring webflux
bigimg: /img/image-header/yourself.jpg
tags: [java]
---




<br>

## Table of contents
- [What is websocket and how it works?](#what-is-websocket-and-how-it-works?)
- [Benefits and drawbacks](#benefits-and-drawbacks)
- [Common information about websocket in Spring MVC and Spring Webflux](#common-information-about-websocket-in-spring-mvc-and-spring-webflux)
- [How to use websocket in Spring MVC](#how-to-use-websocket-in-spring-mvc)
- [How to use websocket in Spring Webflux](#how-to-use-websocket-in-spring-webflux)
- [How to use STOMP in Spring MVC](#how-to-use-stomp-in-spring-mvc)
- [Wrapping up](#wrapping-up)

<br>

## What is websocket and how it works?
1. Definition
    According to [wikipedia.com](), we have:
    
    ```

    ```

2. How websocket works





<br>

## Benefits and drawbacks

1. Benefits




2. Drawbacks




<br>

## Common information about websocket in Spring MVC and Spring Webflux
According to [spring.io](https://docs.spring.io/spring-boot/docs/2.1.0.BUILD-SNAPSHOT/reference/html/boot-features-websockets.html), we have:

```
Spring Boot provides Websockets auto-configuration for embedded Tomcat, Jetty, and Undertow. If you deploy a war file to a standalone container, Spring Boot assumes that the container is responsible for the configuration of its Websocket support.

Spring framework provides rich Websocket support for MVC web applications that can be easily accessed through the spring-boot-starter-websocket module.

Websocket support is also available for reactive web applications and requires to include the Websocket API alongside spring-boot-starter-webflux.

<dependency>
    <groupId>javax.websocket</groupId>
    <artifactId>javax.websocket-api</artifactId>
</dependency>
```

So, to use websocket in spring MVC, we can use package ```spring-boot-starter-websocket```.

Then, with spring webflux, there are two way to do it:
1. ```javax.websocket```

    Using ```javax.websocket``` Websocket API, we can read this following article [Spring Boot WebFlux WebSocket Example](https://howtodoinjava.com/spring-webflux/reactive-websockets/).

2. ```spring-boot-starter-webflux-websocket```

    We can have some links to work with it:
    - [How to broadcast messages in Spring Reactive Websocket API](https://stackoverflow.com/questions/54962814/how-to-broadcast-messages-in-spring-reactive-websocket-api).
    - [A Simple Chat App using WebFlux](https://github.com/monkey-codes/java-reactive-chat)

In order to know more information about utilizing websocket, we can refer to this [link](https://github.com/spring-projects/spring-boot/issues/14810).

<br>

## How to use websocket in Spring MVC




<br>

## How to use websocket in Spring Webflux
1. Architecture of websocket in Webflux



2. Understanding about the steps of websocket in Webflux

    - Configure Webflux to handle Websockets


    - Connecting Websocket sessions



    [https://fossies.org/linux/spring-framework/src/docs/asciidoc/web/webflux-websocket.adoc](https://fossies.org/linux/spring-framework/src/docs/asciidoc/web/webflux-websocket.adoc)

3. Source code


[https://stackoverflow.com/questions/26211248/websockets-is-it-possible-to-add-multiple-endpoints-using-sockjs](https://stackoverflow.com/questions/26211248/websockets-is-it-possible-to-add-multiple-endpoints-using-sockjs)


[https://developer.okta.com/blog/2018/09/24/reactive-apis-with-spring-webflux](https://developer.okta.com/blog/2018/09/24/reactive-apis-with-spring-webflux)

[http://kojotdev.com/2019/08/spring-webflux-websocket-with-vue-js/](http://kojotdev.com/2019/08/spring-webflux-websocket-with-vue-js/)


[http://kojotdev.com/2019/08/spring-webflux-websocket-with-vue-js/](http://kojotdev.com/2019/08/spring-webflux-websocket-with-vue-js/)



<br>

## How to use STOMP in Spring MVC

[https://spring.io/guides/gs/messaging-stomp-websocket/](https://spring.io/guides/gs/messaging-stomp-websocket/)

[https://docs.spring.io/spring-framework/docs/5.0.0.BUILD-SNAPSHOT/spring-framework-reference/html/websocket.html](https://docs.spring.io/spring-framework/docs/5.0.0.BUILD-SNAPSHOT/spring-framework-reference/html/websocket.html)

[https://www.concretepage.com/spring-4/spring-4-websocket-sockjs-stomp-tomcat-example](https://www.concretepage.com/spring-4/spring-4-websocket-sockjs-stomp-tomcat-example)

[https://allandequeiroz.com/a-very-small-taste-of-websockets-with-webflux-reactive-mongodb-data-on-spring-5-2/](https://allandequeiroz.com/a-very-small-taste-of-websockets-with-webflux-reactive-mongodb-data-on-spring-5-2/)

<br>

## When to use websocket




<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer:

**Information about Spring-boot-starter-websockets compatible with Spring MVC, not Spring WebFlux (use javax-websocket-api dependency)**

[https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/web.html#websocket](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/web.html#websocket)

[https://docs.spring.io/spring-boot/docs/2.1.0.BUILD-SNAPSHOT/reference/html/boot-features-websockets.html](https://docs.spring.io/spring-boot/docs/2.1.0.BUILD-SNAPSHOT/reference/html/boot-features-websockets.html)

<br>

**Some reasons that Spring boot starter websocket is not compatible with Spring webflux**

[https://github.com/spring-projects/spring-boot/issues/14810](https://github.com/spring-projects/spring-boot/issues/14810)

[https://howtodoinjava.com/spring-webflux/reactive-websockets/](https://howtodoinjava.com/spring-webflux/reactive-websockets/)

[https://stackoverflow.com/questions/48414750/spring-boot-2-reactive-web-websocket-conflict-with-datarest](https://stackoverflow.com/questions/48414750/spring-boot-2-reactive-web-websocket-conflict-with-datarest)

[https://blog.openshift.com/how-to-build-java-websocket-applications-using-the-jsr-356-api/](https://blog.openshift.com/how-to-build-java-websocket-applications-using-the-jsr-356-api/)

[https://www.baeldung.com/spring-websockets-send-message-to-user](https://www.baeldung.com/spring-websockets-send-message-to-user)

[https://www.baeldung.com/rest-vs-websockets](https://www.baeldung.com/rest-vs-websockets)

[https://tyrus-project.github.io/documentation/1.13.1/index/websocket-api.html](https://tyrus-project.github.io/
documentation/1.13.1/index/websocket-api.html)

[https://idodevjobs.wordpress.com/2019/02/07/spring-websocket-client-without-stomp-example/](https://idodevjobs.wordpress.com/2019/02/07/spring-websocket-client-without-stomp-example/)

<br>

**STOMP - Message Broker**

[https://o7planning.org/vi/10719/tao-ung-dung-chat-don-gian-voi-spring-boot-va-websocket](https://o7planning.org/vi/10719/tao-ung-dung-chat-don-gian-voi-spring-boot-va-websocket)

[https://blog.joshmlwood.com/websockets-with-spring-boot/](https://blog.joshmlwood.com/websockets-with-spring-boot/)