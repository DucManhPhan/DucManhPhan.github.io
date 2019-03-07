---
layout: post
title: The architecture of Restful API
bigimg: /img/path.jpg
tags: [java]
---




## Table of contents
- [Introduction to REST](#introduction-to-rest)
- []()
- [Wrapping up](#wrapping-up)


<br>

## Introduction to REST
REST is an acronym of **Representational State Transfer**, and is a software architecture approach for creating scalable web services. The term **REST** was coined by **Roy Fielding** in his PhD dissertation, and revolves around a number of principles. These principles underpin the architecture of RESTful web services.

At the core of REST are resources, and resources are identified using **Uniform Resource Identifier - URIs**. Conceptually, resources are separate from their representation (that is, the format in which they are provided to clients). REST does not mandate any specific format, but typically includes XML and JSON.

Another distinctive property of REST is that clients interact entirely through hypermedia, which is dynamically provided by the application servers. Apart from endpoints, clients need no prior knowledge of how to interact with a RESTful service. This constraint is referred to as **Hypermedia as the Engine of Application State (HATEOAS)**.

REST advocates statelessness. No client state is stored on the server. All the information needed to perform operations is contained in the requests (as part of the URL, request body, or as HTTP header).

RESTful web services must provide caching capabilities. Servers can indicate how and for how long to cache repsonses. Clients can use cached responses instead of contacting the server.

<br>

## The endpoint
We have:

```java
@RestController
@RequestMapping("/rooms")
public class RoomsResource {
    ...

    @RequestMapping(value = "/{roomId}", method = RequestMethod.GET)
    public RoomDTO getRoom(@PathVariable("roomId") String roomId) {
        RoomDTO room = ... 

        // do something

        return room;
    }
}
```

```@org.springframework.web.bind.annotation.RestController``` instruct Spring that ```RoomsResource``` is a controller.

The above code, we can note that: Traditionally, one could expect this controller class to be called ```RoomController```. However, in the RESTful architecture style, the core concept revolves around resources. Therefore, using the ```Resource``` suffix embodies the REST principles more appropriately.

Besides path parameter, we can get request parameter by using ```@org.springframework.web.bind.annotation.RequestParam``` parameter that provides the means to map an HTTP query parameter to a Java method attribute. 

```java
@RequestMapping(method = RequestMethod.GET)
public List<RoomDTO> getRoomsInCategory(@RequestParam("categoryId") long categoryId) {
    ...
}
```

Service designers could also declare this endpoint without using a parameter. For example, the URL pattern could be ```/rooms/categories/{categoryId}```. This approach has the added benefit of improving caching, since not all browsers and proxies cache query parameters.

<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

[https://restfulapi.net/rest-architectural-constraints/](https://restfulapi.net/rest-architectural-constraints/)

[https://www.oreilly.com/learning/how-to-design-a-restful-api-architecture-from-a-human-language-spec](https://www.oreilly.com/learning/how-to-design-a-restful-api-architecture-from-a-human-language-spec)

[https://en.wikipedia.org/wiki/Representational_state_transfer](https://en.wikipedia.org/wiki/Representational_state_transfer)

[https://blog.cloud-elements.com/restful-architecture-101](https://blog.cloud-elements.com/restful-architecture-101)