---
layout: post
title: Understanding about the Distributed System
bigimg: /img/image-header/yourself.jpeg
tags: [Distributed system]
---




<br>

## Table of contents





<br>

## 






<br>

## 






<br>

## 





<br>

## Fallacies of Distributed Computing
1. The network is reliable.

    Many of the technologies will hide the fact that we're using a network at all to send requests to different machines. For example, if we're every used WCF then we've seen how it can quickly turn a web service call into a method call on an object.
    
    Methods call are completely reliable. When we make one call, we know for certain that the object that we're calling will receive its parameters and it will execute the method. And when that method call returns, we know beyond a shadow of a doubt that the caller will receive the return value, and then the caller will continue executing at the next line. If the method throws an exeception, then we can be absolutely sure that the caller will catch the exeception and will take the appropriate action. But the same can not be said about web service calls or indeed any communication over a network.

    When we make a web service call there's no guarantee that the service will receive the request, and when it returns a value, we can't be sure that the caller will actually get the result. And when an exeception is thrown, it can sometimes be hard to tell whether it was the result of a problem in the web service itself or simply some kind of a network failure.

    So when coding for network communication, we have to understand that the call might fail in ways that simply are not possible in regular object-oriented in memory programming. We have to code for failures at every point in the communication. The request may fail on its way to the server or worse yet the response may fail on its way back to the client. If a failure happens, then the client generally can't tell which side failed. They can't tell whether the message failed on its way to the service or the response back to the client, so that leaves the system in an indeterminate state. These kinds of states don't occur in regular object-oriented coding, so we typically don't think about them, but when the network is unreliable then we have to.

2. Latency is zero.

    In most object-oriented code, time isn't an issue. The code just tends to be procedural just moving from one statement to the next as quickly as the machine will allow, so we don't even think about the dimension of time.
    
    But when we're sending our requests to a remote machine, we have to be aware of the passage of time. Until that response comes, we're in a state of limbo where we don't know whether the request got through or not, and we have to timeouts for these requests. If the timeout elapses, then we don't know whether the request would have actually succeed had we just waited a little bit longer.
    
    We have two different machines, each keeping tracking of its own state separated by the time and space, and somehow we need to choreograph a dance between these two machines, even though neither one really knows the state of the other. A lot of systems that we've built work fine on localhost, but then they don't work when deployed to real networks, and it's because we've fallen victim to one of these two fallacies.

3. Bandwidth is infinite.

    When we pass parameter to a method, the entire parameter makes it to the other side. Even if the parameter is a long list or a big XML document, the parameter that's actually passed is really just a pointer to some shared memory, and the method can access that shared memory just as easily as the caller could.

    But in a distributed system, there is no shared memory, so we just have to send the contents of that long list or that big XML document, and a common mistake that developers will make is to simply copy the whole thing into a single request. Unfortunately, the bigger the request is the more likely that it is to fail.

    In a distributed system, messages need to be broken down into chunks, but we have to be aware when we're doing this that each chunk is going to be individually subject to latency, and so these latencies are going to add up. So, it's kind of a balancing act between latency and bandwidth, and we have to choose the right balance in order make our system the most reliable.

4. The network is secure.

    Our distributed application will be attacked in ways that an object-oriented system just never would. There are many more attack vetors available to a hacker when a message is on the wire. An application developer has to get every detail right, but an attacker only has to find one thing wrong.
    
    A lot of enterprise applications are built with the assumption that parts of it, if not all of it, are running on an internal secure network. But that internal network is not secure, most of the attacks actually occur from the inside.

5. Topology doesn't change.

    It's pretty easy to build assumptions about topology into our code. Topology includes things like the platforms and the tools upon which our code is built, as well as which machines have access to which other machines. But rather than build those assumptions into the code, it's much better to construct the system in pieces that can be reconfigured to match the topology into which it's deployed.

6. There is one administrator.

    When we're building a distributed application, the developer are the administrator, but once it's out into production then that's going to be somebody else. In fact, it probably won't be just one person. We will probably have to give up the reins to somebody that runs the network, somebody else runs the machines, and then somebody else that runs the applications. And furthermore, with cloud hosting becoming more prevalent, the administrator of the box is probably not even aware of what the applications are that are running on it, so we have to build our applications so that each different type of administrator can manage just the part of the system that they need.

7. Transport cost is zero.

    In object-oriented coding, creating a new object is free. All it costs is a little bit of memory, and memory is cheap, but in a distributed system, sending a message costs real money. There's first of all the cost of keeping the network running so that's paying for people, electricity, and space, but then there's also the cost per message, so that's the actual bandwidth cost. It can be easy to forget while we're working in a test environment that each of these messages that we're sending is going to translate into real dollars.

8. The network is homogeneous.

    There are actually two fallacies in this one statement.
    
    The first is about the stacks that the applications are written on. So if all components are written on one stacks, then we've got a homogeneous network. And this may be under our control for a small distributed system, but large ones, especially those that integrate across company boundaries, are going to be written by different teams, and so we have to write each component with the knowledge that we're going to be using different vendors for different pieces of the system. But the not the worst of the assumptions.

    The second one is that all of the components will be on the same version. When we roll out a distributed system, this is probably going to be true, and this is going to lure us into a false sense of security, but when we reach version 2, we'll find ourselves, if only temporarily, in a heterogeneous network. We'll still have version 1 components running, but then we'll also want to deploy version 2 on top of them.

    Now, we might solve this problem in the beginning by just simply taking down the whole system, upgrading it all, and then bringing it back up. That's only going to work for a short period, and maybe not even ever. As more and more versions are deployed and more and more components are added, the window of time during which we can have multiple versions is going to grow. And once we have two or more project team or two or more companies involved, then that window is basically going to stay open forever. We will never again have all the components on the same version, and it will be impossible to bring down the whole system to do an upgrade. So, we have to build our systems with the assumption that we're going to have a heterogeneous system. We're going to have some older versions of components interoperating with newer versions of components, and we have to build our systems to be resilient and tolerant of this.

    The most dangerous part of this fallacy is the fact that only chance to combat it has already come and gone before we're deployed the first version. Once we have version 1 in production, then we have already sealed our fate. If we didn't build the system with the ability to be heterogeneous from the outset, then it's very rare that we'll ever get it back.

<br>

## Wrapping up




<br>

Refer:

[]()