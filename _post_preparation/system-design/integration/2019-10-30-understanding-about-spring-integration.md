---
layout: post
title: Understanding about Spring Integration
bigimg: /img/image-header/california.jpg
tags: [Spring]
---



<br>

## Table of Contents
- [Given problem](#given-problem)
- [Solution of Spring Integration](#solution-of-spring-integration)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Supposed that we have a large application that contains multiple systems, each system will have one responsibility. And we need to divide our application to lots of systems because if an application need to scale, it have to be able to split.

So business processes span multiple systems that are constructed using a variety of technologies. We may see different languages and products, and all of these technologies need to talk to each other in order to satisfy business requirements. We'll often see these systems interacting and sharing information. Sometimes what peers to be a simple transaction within one system may actually be an orchestrated set of operations that occur behind the scenes in many other systems. This is where we see enterprise integration in action.

For example, think of e-commerce system and now let's think about all of the different systems that need to interact. We may visit the web interface of some company and order an item but really there are a multitude of systems behind the scenes working in tandem in order to complete that business process.

We may have the inventory system checking to see that our items available, the billing systems are actually performing the financial transactions and then we're also going to see interaction with a shipping partner such as FedEx or UPS in order to see the status of our items as it is sent to us and then also there is a notification system involved. We're often notified when we hit different milestones in the purchase such as when our item has been shipped when it many be arriving. We get all these different notifications. That's not just one system. It's a bunch of systems working together to provide us that service or that capability. And that's where the real complexity arises. Getting these systems that may not share a common architecture or platform to work together to exchange information in a reliable and efficient manner in order to fulfill the business process. In addition the interoperability of these systems is often rigid and that creates problems when we need to change our process in some way. It creates a lot of work and it requires a lot of effort. And these are the problems that enterprise integration looks to solve.

<br>

## Solution of Spring Integration

1. Introduction to Spring Integration

    Spring integration is a project that extends the Spring framework to support a set of enterprise integration patterns found in the EIPs book by Hope and Wolf. These patterns provide us with better approaches to exchanging data between systems. The project was first introduced by Mark Fischer in 2007. The framework uses the features found within the Spring Core to implement EIPs. This allows developers familiar with Spring to leverage their existing knowledge to quickly build Spring Integration applications. In addition developers will find that Spring Integration opens the door to interfacing with systems that use a variety of technologies such as Web services, JMS underlying file systems and JDBC.

    Spring Integration is an implementation of the Enterprise Integration Patterns based on the Spring framework. It contains many ready to use implementations of the concepts of the Enterprise Integration patterns in the form of interfaces and classes that are designed with the main principles of the Spring framework in mind.

    ![](../img/Architecture-pattern/EIP/spring-integration/classes-interfaces-spring-integration.png)

    It has interfaces and classes of messages, different kinds of message channels, many different kinds of endpoints, and transformers and Routers.

    We can use these components with the standard Spring framework programming techniques such as dependency injection, which helps us to maintain separation of concerns between business logic and integration logic.

    Some ways to configure in Spring Integration:
    - Using XML configuration
    - Using annotation configuration
    - Using Domain Specific Config Language configuration

        Using these Domain-Specific Language, we can configure Spring Integration components in a readable way.

    Some approaches of enterprise integration 
    - Promotes the exchange of data between systems.

        The way it is promoted is really be abstracting the problems that we encounter when we attempt to integrate our systems. We want to eliminate rigid data exchanges or rigid interoperability problems and to do that we need to use a more robust approach. And this is where the different enterprise integration patterns come into play.

        There's more robust ways that we can structure the communication between systems to do things like guarantee delivery we can handle a significant load better. We can also increase the availability of the system, so that is all accomplished through abstractions and through patterns and we get these common solutions to these problems that we normally face.

        One of the major hurdles when working with enterprise integration is that the integration need is not always within our enterprise, so we may need to reach out to a third-party and connect to one of their systems or they may use a different technology than we do.

        So there's all these complexities and one of the ways we can overcome that is by leveraging adapters. So we'll see that most enterprise integration solutions have a variety of adatpers that allow us to communicate with different technologies that may be found within our organization or within a third-parties organization.

    - Abstracts system connectivity

    - Provides common solutions to integration challenges

    - Leverages adapters to communicate between internal and external applications

    Some goals of enterprise integration
    - Unlock synergies through innovative use of existing systems.
    - Reduce the costs and effort required to exchange consistent data.
    - Produce flexible enterprise architectures.
    - Stabilize connectivity between systems.

    Enterprise integration eliminates the barriers that keep our systems from exchanging data or working together. And what this allows is new capabilities and synergies to be recognized by the system owners. Information and capabilities once contained in siloed systems can be unlocked to support new organizational processes. It encourages system interaction by solving problems faced by developer when integrating systems. Legacy approaches were often brittle, they were quite much oversight and the effort to maintain the connectivity between the systems was very high.

    So we want to chnage our applications to support our business processes and the way we do that is by leveraging this integration approach that really reduce coupling between our systems using flexible architectures that are constructed using enterprise integration patterns that were popularized in the book EIPs. We can build better systems that exchange information and create these new synergies between the different systems.

2. The architecture of Spring Integration

    - Lightweight message-driven architecture
    - Passes messages using **pipes and filters**

        This is similar to Unix construct where the output of a filter is often routed to the next filter for manipulation. The routing is performed by the pipe while the operations are performed by the filter. In our scenario, channels do the routing instead of the pipes and endpoints performs the operations. We can link numerous filters together to build the processes.
        
    - No direct tie in to an enterprise service bus
        
    - Leverages task schedulers and task executers

    - Adapters facilitate communication between systems

        A key feature of the framework is the set of provided adapters which ease integration with various third-party technologies such as messaging systems, file systems, database and FTP servers.

        Belows are a few of these apdaters that Spring Integration provides.
        - Data stores (JDBC, MongoDB, JPA)
        - File stores (File System, FTP, SFTP)
        - HTTP
        - Mail (SMTP)
        - Messaging (AMQP, JMS)
        - Twitter
        - Web services (SOAP, REST, JSON)

        Spring Integration provides us with a bunch of tools to integrate systems together to exchange data. When we use these tools, we have lower development costs and lower maintainance costs because these tools follow strict enterprise integration patterns.


3. How to configure Spring Integration with Maven




<br>

## When to use





<br>

## 





<br>

## Benefits and Drawbacks

1. Benefits

    - Reducing the complexity of exchanging information between systems.
    - Spring Integration will make our applications more robust, flexible and consistent.

        Consistency is very important because it prevents applications that leverage various integration techniques with a rigid implementation.

    - Spring Integration abstracts the integration technique behind its messaging system allowing for the exchange of information between systems to easily transition to a better format.


2. Drawbacks



<br>


## Wrapping up





<br>

Refer:

[The Ultimate Spring Integration course on Udemy](https://udemy.com/course/ultimate-spring-integration/learn/lecture/17376986#overview)

[Spring Integration: Getting Started By Jesper De Jong](https://app.pluralsight.com/library/courses/spring-integration-getting-started/table-of-contents)

[https://spring.io/projects/spring-integration](https://spring.io/projects/spring-integration)