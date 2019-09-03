---
layout: post
title: Understanding about the basic of Reactive programming
bigimg: /img/image-header/unsplash.jpg
tags: [java]
---



<br>

## Table of contents
- [Reactive architecture](#reactive-architecture)
- [ReactiveX](#reactivex)
- [Reactive stream](#reactive-stream)


<br>

## Reactive architecture




<br>

## ReactiveX




<br>

## Reactive stream
- Publisher

    According to [http://www.reactive-streams.org](http://www.reactive-streams.org/reactive-streams-1.0.0-javadoc/org/reactivestreams/Publisher.html) about Publisher, we have:
    - A Publisher is a provider of a potentially unbounded number of sequenced elements, publishing them according to the demand received from its Subscribers.
    - A Publisher can serve multiple Subscribers subscribed 

    ```Java
    public interface Publisher<T> {
        // request Publisher to start streaming data
        // This is a factory method, and can be called multiple times, each time starting a new Subscription.
        // Each Subscription will work for only a single Subscriber.
        void subscribe(Subscriber<? super T> s);
    }
    ```

- Subscriber

    According to [http://www.reactive-streams.org](http://www.reactive-streams.org/reactive-streams-1.0.0-javadoc/org/reactivestreams/Subscriber.html) about Subscriber, we have:
    -  Will receive call to ```onSubscribe(Subscription)``` once after passing an instance of Subscriber to ```Publisher.subscribe(Subscriber)```.
    - No further notifications will be received until ```Subscription.request(long)``` is called.

    ```Java
    public interface Subscriber<T> {
        // successful terminal state
        void onComplete();

        // failed terminal state
        void onError(Throwable t);

        // data notification sent by the Publisher in response to requests to Subscription.request(long)
        void onNext(T t);

        // invoked after calling Publisher.subscribe(Subscriber)
        void onSubscribe(Subscription s);
    }
    ```

- Subscription

    According to [http://www.reactive-streams.org](http://www.reactive-streams.org/reactive-streams-1.0.0-javadoc/org/reactivestreams/Subscription.html#request-long-), we have:
    - A Subscription represents a one-to-one lifecycle of a Subscriber subscribing to a Publisher.
    - It can only be used once by a single Subscriber.
    - It is used to both signal desire for data and cancel demand (and allow resource cleanup).


    ```Java
    public interface Subscription {
        // request the Publisher to stop sending data and clean up resources
        void cancel();

        // no events will be sent by a Publisher until demand is signaled via this method
        void request(long n);
    }
    ```



<br>

## Wrapping up
- Before Java 8, asynchronous non-blocking behavior was not obvious to implement for at least two reasons.

    - Callback based API required verbose anonymous classes and are not easy to chain.
    - ```Future``` type is asynchronous but blocks the current thread until the computation completes when we try to get the result with the ```get()``` method.

- Netty server

    - Monolithic: 200-300 requests/sec/host
    - Reactive: 10-20k requests/sec/host

<br>

Thanks for your reading.

<br>

Refer:

[https://www.javaworld.com/article/3288219/mastering-spring-framework-5-part-2-spring-webflux.html](https://www.javaworld.com/article/3288219/mastering-spring-framework-5-part-2-spring-webflux.html)