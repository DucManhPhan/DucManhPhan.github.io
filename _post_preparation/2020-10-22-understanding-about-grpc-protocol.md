---
layout: post
title: Understanding about gRPC protocol
bigimg: /img/image-header/home-office-1.jpg
tags: [gRPC]
---





<br>

## Table of Content
- [Given problem](#given-problem)
- [Solution of gRPC protocol](#solution-of-grpc-protocol)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Some common problems when using gRPC protocol](#some-common-problems-when-using-grpc-protocol)
- [Wrapping up](#wrapping-up)


<br>

## Given problem







<br>

## Solution of gRPC protocol

1. Introduction to gRPC



2. 



3. 


<br>

## When to use







<br>

## Benefits and Drawbacks







<br>

## The comparison between RESTful and gRPC

|                 RESTful                  |                gRPC                 |
| ---------------------------------------- | ----------------------------------- |
| resource focus                           | Action focus                        |
| embrace HTTP semantics                   | embrace Programming semantics       |
| Loose coupling                           | Tighter coupling                    |
| Messaging often text based               | Messaging often binary based        |

Belows are some explanations for these comparisons.
1. Resource focus and Action focus

    RESTful is a resource focused protocol.
    
    gRPC is an action focused protocol. Instead of passing resources along with those HTTP verbs saying what we want to do with that resource, we're actually going to be passing function calls and then passing parameters and expecting results back.

2. Embrace HTTP semantics and Embrace Programming semantics

    RESTful architecture typically try and embrace HTTP semantics. This doesn't mean that every RESTful protocol runs over HTTP but HTTP is really a foundational concept and a lot of RESTful architectures are really designed to work with this protocol.

    gRPC, on the other hand, is designed to embrace programming semantics. Instead of structuring our requests like HTTP requests, we're actually going to be structuring our requests like normal function calls or normal method calls. So we're going to have a method name, we're going to pass in some arguments and we're going to expect the result of that calculation.

3. Loose coupling and Tigher coupling

    When working with a RESTful architecture, they're typically considered to be the more loosely coupled option. And the reason for that is we've got this resource focus, so the server only has to expose the resources that are being asked for. And there's a relatively small well-defined set of actions that can be done on those. If we look at an HTTP style RESTful architecture, we might expect to find get, post, put, and delete as the primary options that we have.

    gRPC, on the other hand, is considered to be a more tightly coupled protocol. And the reason for that is the client doesn't just need to know about the resources that the server has to offer, it also needs to know about the methods that can be called, the arguments that those methods need in order to function properly. And how to deal with the data that's going to be coming back from those calls.

4. Messaging often text based and Messaging often binary based

    Binary messages are typically much smaller than text based messages when sending the same data.

--> RESTful architectures work well in web-based applications. And when the domain that's being described can easily be modeled in terms of resources. On the other hand, gRPC makes it much clearer what actions a client can invoke on the server and potentially makes it a lot easier to program the clients. Because the server's going to accept those specific method calls which can be very clearly named. However, in order for the clients to be aware of what methods are going to be available, the server has to publish those in some way.

<br>

## Some common problems when using gRPC protocol







<br>

## Wrapping up







<br>

References:

[]()

[]()

[]()

[]()

[]()