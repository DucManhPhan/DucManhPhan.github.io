---
layout: post
title: Session in Spring webflux
bigimg: /img/path.jpg
tags: [Spring]
---



<br>

## Table of contents





<br>

## Introduction to Session in Spring webflux

In the **Servlet** world, each request/response is processed in a single thread, which enables those approaches. With **Webflux**, a given request can be processed by multiple threads.

The **WebSession** instance associated with the current request/response is actually attached to the **ServerWebExchange** through **getSession()** method.

In Spring Webflux, Websession is defined as a simplified Map of name-value pairs. It will help us to keep track values that are important to an HTTP session such as Users, principals.

<br>

## 





<br>

## 





<br>

## Configuration with Session
1. Use in-memory

We will create **@Configuration** class with **@EnableSpringWebSession**.

```java
@Configuration
@EnableSpringWebSession
public class SessionConfig {

	@Bean
	public ReactiveSessionRepository reactiveSessionRepository() {
		return new ReactiveMapSessionRepository(new ConcurrentHashMap<>());
	}
}
```


2. Use Redis

```java
@Configuration
@EnableRedisWebSession
public class RedisConfig {
  
    @Bean
    public LettuceConnectionFactory redisConnectionFactory() {
        return new LettuceConnectionFactory();
    }
}
```


<br>

## Source code

To use session, in Rest Controller, we need to pass instance of WebSession as parameter of Rest API.

```java
@GetMapping("/login")
public Mono<String> login(AuthenticationRequest request, WebSession session) {
    ...

    session.getAttributes().putIfAbsent("AUTHEN_INFO", request);

    ...
}
```

<br>

## Some problems with Session





<br>

## Wrapping up







<br>

Refer:

[https://www.baeldung.com/spring-session-reactive](https://www.baeldung.com/spring-session-reactive)

[https://www.javadevjournal.com/spring/spring-session/](https://www.javadevjournal.com/spring/spring-session/)

[https://www.javadevjournal.com/spring/spring-session-with-jdbc/](https://www.javadevjournal.com/spring/spring-session-with-jdbc/)

[https://codeboje.de/spring-session-tutorial/](https://codeboje.de/spring-session-tutorial/)

[https://docs.spring.io/spring-session/docs/current/reference/html5/#websession-redis](https://docs.spring.io/spring-session/docs/current/reference/html5/#websession-redis)

[https://dzone.com/articles/session-management-with-spring-reactive](https://dzone.com/articles/session-management-with-spring-reactive)

[https://springtutor.com/control-the-session-with-spring-security/](https://springtutor.com/control-the-session-with-spring-security/)

[http://pwp.stevecassidy.net/bottle/sessions.html](http://pwp.stevecassidy.net/bottle/sessions.html)

[https://stackoverflow.com/questions/59511622/how-to-implement-multiple-authentication-methods-in-spring-webflux-security](https://stackoverflow.com/questions/59511622/how-to-implement-multiple-authentication-methods-in-spring-webflux-security)

<br>

**Spring Session with Redis**

[https://blog.jayway.com/2015/05/31/scaling-out-with-spring-session/](https://blog.jayway.com/2015/05/31/scaling-out-with-spring-session/)