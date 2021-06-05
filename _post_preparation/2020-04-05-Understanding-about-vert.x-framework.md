---
layout: post
title: Understanding about Vert.x framework
bigimg: /img/image-header/yourself.jpeg
tags: [Vert.x, Java]
---




<br>

## Table of contents
- [Introduction to Vert.x framework](#introduction-to-vert.x-framework)
- [The architecture of Vert.x framework](#the-architecture-of-vert.x-framework)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Vert.x framework






<br>

## The architecture of Vert.x framework

![](../img/Vert.x/simple-architecture-of-vertx.png)

![](../img/Vert.x/vert.x-architecture.png)


0. Vertx


    To initialize our vertx instance, we can do like this.

    ```java
    Vertx vertx = Vertx.vertx();

    // or
    Vertx vertx = Vertx.vertx(new VertxOptions().setWorkerPoolSize(40));
    ```

    Even though a Vertx instance maintains multiple event loops, any particular handler will never be executed concurrently, and in most cases will always be called using the exact same event loop.


1. Verticle instance

    Verticles are chunks of code that get deployed and run by Vert.x. An application typically be composed of many verticle instances running in the same Vert.x instance at the same time. It's an execution unit of Vert.x.

    Verticles can be run independently of each other. Verticles communicate with each other by sending messages on the event bus. Default verticles are executed on the Vert.x **event loop** and must never block. Vert.x ensures that each verticle is always executed by the same thread (never concurrently, hence avoiding synchronization constructs).

    If we have multiple verticle instances, how to run or manage them. Simple answer for this problem is that we will use the main verticle to start running all verticle instances.

    ```java
    public class MainVerticle extends AbstractVerticle {

        @Override
        public void start(Future<Void> future) {
            this.vertx.deployVerticle(new HttpServerVerticle());
            this.vertx.deployVerticle(new ProxyVerticle());
            this.vertx.deployVerticle(new WebsocketVerticle());
        }
    }
    ```

2. Http Server and Net Server



3. Vert.x Thread pool




4. HazelCast



5. Event Bus

    All communication between verticles happens through the event bus. It is the central nervous system of Vert.x. 
    
    Verticles can talk to other verticles by publishing events on addresses of the event bus, and listen to what other verticles have to say by registering event handlers that listen to events on addresses of the event bus. When publishing an event, a verticle does not know who, if anyone, is going to receive it. When receiving an event, a verticle does not know from where it is coming.

    Each event has an associated data payload, such as JSON object, a string, a number, or a raw byte buffer. JSON is the payload type recommended for most cases.

    The event bus pattern is neither a new invention, nor is it exclusive to Vert.x. Buses have been used to decouple system components for a long time, from hardware buses, such as PCI, to data buses in many object-oriented system and Enterprise service buses in large software system.

    The Vert.x event bus provides three fundamental communication patterns:
    - Publish/subscribe: When an event is published, all handlers listening on the address will receive it.

    - Point-to-Point: When an event is published, at most one handler listening on the address will receive it. If there are multiple handlers, incoming events are distributed among them in a round robin fashion.

        ```java
        // Sender verticle
        vertx.setPeriodic(1000, v -> vertx.eventBus().send("address", "our message"));

        EventBus eb = vertx.eventBus();
        MessageConsumer<String> consumer = eb.consumer("address");

        // 1st way
        eb.consumer("address", message -> System.out.println("Received: " + message.body()));

        // 2nd way
        consumer.handler(message -> System.out.println("Received: " + message.body()));
        ```

    - Request-reply: An extension of point-to-point, where the sender can attach a response handler, which the receiver can call to respond to the original sender.

        ```java
        // Sender verticle
        vertx.setPeriodic(1000, v -> vertx.eventBus().send("address", "our message"),
                        reply -> {
                            if (reply.succeeded()) {
                                System.out.println("Response: " + reply.result().body())
                            } else {
                                System.out.println("No reply")
                            }
                        });

        vertx.eventBus().consumer("address", message -> System.out.println("Received: " + message.body()));
        ```

    - Delivery options

        When sending or publishing a message on the event bus, you can pass delivery options to configure:
        - The send timeout (if the receiver does not reply to the message, the reply handler receives a failed result).
        - The message headers than can be used to pass metadata about the message content to the consumers. For example,
        you can pass the sending time or an identifier using a header.
        - The codec name to serialize the message on the event bus (only required for non supported types).

        ```java
        DeliveryOptions options = new DeliveryOptions();
        options.addHeader("some-header", "some-value");
        eventBus.send("address", "message", options);
        ```

<br>

## Source code




<br>

## Benefits and Drawbacks
1. Benefits

    - Handle multiple requests at the same time, because it has the number of Event Loop is equal to the number of CPU cores.

    - Multiple languages can use Vert.x framework. So, it is very suitable for Microservice architecture because each service can be use the different language to develop based on Vert.x framework.

2. Drawbacks

    - It's difficult to touch for the Vert.x's newbies.

    - If we use the wrong way with Vert.x such as blocking the main thread, it will makes our application slow down.

<br>

## Wrapping up

- Spring Boot serves hundreds of requests just fine.



<br>

Refer:

[https://wiki.eclipse.org/images/3/31/DemocampZurich_VertxIntro.pdf](https://wiki.eclipse.org/images/3/31/DemocampZurich_VertxIntro.pdf)

[http://tutorials.jenkov.com/vert.x/your-first-vertx-application.html](http://tutorials.jenkov.com/vert.x/your-first-vertx-application.html)

[https://medium.com/@hakdogan/working-with-multiple-verticles-and-communication-between-them-in-vert-x-2ed07e8e6425](https://medium.com/@hakdogan/working-with-multiple-verticles-and-communication-between-them-in-vert-x-2ed07e8e6425)

[http://gotocon.com/dl/goto-berlin-2014/slides/TimFox_WritingHighlyConcurrentPolyglotApplicationsWithVertX.pdf](http://gotocon.com/dl/goto-berlin-2014/slides/TimFox_WritingHighlyConcurrentPolyglotApplicationsWithVertX.pdf)

[https://design.jboss.org/redhatdeveloper/marketing/vertx_cheatsheet/cheat_sheet/images/vertx_cheatsheet_r2v1.pdf](https://design.jboss.org/redhatdeveloper/marketing/vertx_cheatsheet/cheat_sheet/images/vertx_cheatsheet_r2v1.pdf)

[Vert.x in Action](https://livebook.manning.com/book/vertx-in-action/chapter-1/v-7/)

[https://freecontent.manning.com/verticles-the-basic-processing-units-of-vert-x/](https://freecontent.manning.com/verticles-the-basic-processing-units-of-vert-x/)

[Real-time Web Application Development using Vert.x 2.0](http://file.allitebooks.com/20160304/Real-time%20Web%20Application%20Development%20using%20Vert.x%202.0.pdf)

[A gentle guide to asynchronous programming with Eclipse Vert.x for Java developers](https://vertx.io/docs/guide-for-java-devs/guide-for-java-devs.pdf)

[https://www.freecodecamp.org/news/an-introduction-to-vert-x-the-fastest-java-framework-today-27d8661ceb14/](https://www.freecodecamp.org/news/an-introduction-to-vert-x-the-fastest-java-framework-today-27d8661ceb14/)

[https://www.javacodegeeks.com/2012/07/osgi-case-study-modular-vertx.html](https://www.javacodegeeks.com/2012/07/osgi-case-study-modular-vertx.html)

[https://www.baeldung.com/vertx](https://www.baeldung.com/vertx)

[https://vertx.io/docs/guide-for-java-devs/](https://vertx.io/docs/guide-for-java-devs/)

[https://vertx.io/docs/](https://vertx.io/docs/)

[https://www.javaworld.com/article/2078838/open-source-java-projects-vert-x.html](https://www.javaworld.com/article/2078838/open-source-java-projects-vert-x.html)

[https://dzone.com/articles/introduce-to-eclicpse-vertx](https://dzone.com/articles/introduce-to-eclicpse-vertx)

[https://medium.com/javarevisited/vert-x-understanding-core-concepts-1529917658b3](https://medium.com/javarevisited/vert-x-understanding-core-concepts-1529917658b3)

[https://blog.invivoo.com/what-is-vert-x/](https://blog.invivoo.com/what-is-vert-x/)

[https://mvnrepository.com/artifact/io.vertx](https://mvnrepository.com/artifact/io.vertx)

<br>

**Examples about Vert.x**

[https://github.com/hakdogan/IntroduceToEclicpseVert.x](https://github.com/hakdogan/IntroduceToEclicpseVert.x)

[https://github.com/vert-x3/vertx-examples](https://github.com/vert-x3/vertx-examples)

[https://github.com/ltamrazov/vertx-starter-guide/tree/part-1](https://github.com/ltamrazov/vertx-starter-guide/tree/part-1) -- Should read this post

[https://github.com/jponge/vertx-in-action?files=1](https://github.com/jponge/vertx-in-action?files=1)

<br>

**Architecture of Vert.x**

[https://www.cubrid.org/blog/understanding-vertx-architecture-part-2](https://www.cubrid.org/blog/understanding-vertx-architecture-part-2)

[https://www.cubrid.org/blog/inside-vertx-comparison-with-nodejs/](https://www.cubrid.org/blog/inside-vertx-comparison-with-nodejs/)

[https://www.mednikov.net/vertx-app-strategies/](https://www.mednikov.net/vertx-app-strategies/)

[https://medium.com/@hakdogan/introduce-to-eclicpse-vert-x-1d24c97643c7](https://medium.com/@hakdogan/introduce-to-eclicpse-vert-x-1d24c97643c7)

[https://medium.com/@alexey.soshin/understanding-vert-x-event-loop-46373115fb3e](https://medium.com/@alexey.soshin/understanding-vert-x-event-loop-46373115fb3e)

[https://medium.com/@charith.code/vert-x-for-high-volume-architectures-7b1956a9bbd](https://medium.com/@charith.code/vert-x-for-high-volume-architectures-7b1956a9bbd)

[https://github.com/vietj/advanced-vertx-guide/blob/master/src/main/asciidoc/Demystifying_the_event_loop.adoc](https://github.com/vietj/advanced-vertx-guide/blob/master/src/main/asciidoc/Demystifying_the_event_loop.adoc)

[https://piotrminkowski.com/2017/08/24/asynchronous-microservices-with-vert-x/](https://piotrminkowski.com/2017/08/24/asynchronous-microservices-with-vert-x/)

<br>

**Integrate Vert.x and Spring**

[https://www.baeldung.com/spring-vertx](https://www.baeldung.com/spring-vertx)

[https://github.com/eugenp/tutorials/tree/master/spring-vertx](https://github.com/eugenp/tutorials/tree/master/spring-vertx)

[https://medium.com/@hakdogan/how-to-share-data-between-threads-in-vert-x-afdf26dcc684](https://medium.com/@hakdogan/how-to-share-data-between-threads-in-vert-x-afdf26dcc684)

[https://medium.com/@hakdogan/how-to-run-a-vert-x-cluster-with-broadcasting-messaging-fc79ff113c9c](https://medium.com/@hakdogan/how-to-run-a-vert-x-cluster-with-broadcasting-messaging-fc79ff113c9c)

[https://medium.com/@hakdogan/working-with-multiple-verticles-and-communication-between-them-in-vert-x-2ed07e8e6425](https://medium.com/@hakdogan/working-with-multiple-verticles-and-communication-between-them-in-vert-x-2ed07e8e6425)

[https://medium.com/pharos-production/vert-x-restful-services-on-java-6a4ed8a30489](https://medium.com/pharos-production/vert-x-restful-services-on-java-6a4ed8a30489)

[https://vertx.io/docs/vertx-hazelcast/java/](https://vertx.io/docs/vertx-hazelcast/java/)

[https://medium.com/halofina-techology/high-performance-vert-x-cluster-c205a809e231](https://medium.com/halofina-techology/high-performance-vert-x-cluster-c205a809e231)