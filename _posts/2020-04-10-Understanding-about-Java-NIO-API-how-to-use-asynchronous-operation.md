---
layout: post
title: Understanding about Java NIO API - How to use asynchronous operations
bigimg: /img/image-header/yourself.jpeg
tags: [Java]
---

In this article, we will learn how to setup asynchronous operations with Selection in Java NIO. Let's get started.


<br>

## Table of contents
- [Introduction to asynchronous operations](#introduction-to-asynchronous-operations)
- [Understanding asynchronous operations using Selectors](#)
- [Setting up the Selector to accept an incoming connection]()
- [Read the content sent through the socket using the Selector]()
- [Wrapping up](#wrapping-up)


<br>

## Introduction to asynchronous operations

1. Synchronous operation

    When we call the read() method, whether it is on a Reader from Java I/O or on a channel from Java NIO, this is said to be a synchronous operation. It means that the method returns, the read() call return when the data is read, either from the Reader or from the Channel to the ByteBuffer. This method is a synchronous call, meaning that it blocks until the data has been read and is there.

2. Asynchronous operation

    Asynchronous is said to be non-blocking behaves differently. In fact, what we do is that we trigger a read operation, then, we can continue working on something else. And when data is there, when the data is ready to be read in the buffer, then we are called back by the system, that is, by the API.

    So, in the meantime, we can do something else. We do not have to wait for the read call to return.

Suppose our application needs to read data from many resources. Take a web server, for instance, which has many incoming requests on many sockets from many clients.
- With a synchronous read, each read operation is conducted in its own thread, and will block this thread until the data is available.

    Remember that network operations, especially, are slow compared to CPU and in-memory operations.

- With asynchronous reads, a single thread can handle many read operations. So this is the main difference, and this is what is supposed to bring performance, especially to web servers.

From an operating system perspective, a thread is a system resource. So it can be expensive to setup, especially in 2002, when Java NIO was developed. It might not be the case today or at least threads are much less expensive to setup today than it was 15 years ago.

And when operating system has lots of threads to handle, it can be expensive for a CPU to switch from one thread to another thread. This is called context switching. And context switching has a cost. It is not free operation. So back in 2002, this asynchronous system has been added to the JDK to enable the development of web servers, of Java web servers in a more performant way. And indeed, web servers like Tomcat at this time leveraged this technical possibility offered by the JDK to speed up their operations.

<br>

## Understanding asynchronous operations using Selectors

The **Selector** is the entry object to set an asynchronous system.
- First, we need to create a **Channel**. And a **Channel** can be created on a disk, network, ...
- Then, configure this channel to be non-blocking.
- And we register this channel with this selector. Then the asynchronous stuff will be handled by this selector object.
- This operation returns a registration key. From this key, we can access the channel and various information about the state of the channel directly. We can do that with as many channels as we need. This is a single selector can handle several channels. In fact, it can handle many channels at the same time.

    Then the channel will fire events to the selector. There are 4 events defined in the **Channel** class.
    - **READ**, **WRITE**: the channel is ready for reading or writing.

    - In the case of socket channel:

        - **CONNECT**: a connection was established on this socket.
        - **ACCEPT**: a connection was accepted.

    The registration is configured to listen to certain events. Those events are passed as parameters during the registration process. But we can also modify those listen events directly through the key. So once the system is properly setup:
    - we need to call the **select()** method on the selector. This will be a blocking call until some other channels registered to this selector have events to be consumed.
    - From the Selector, we can get the list of the keys associated to those channels that have events to be processed.

For example:

```java
// First, create a ServerSocketChannel and configure this channel to be non-blocking
ServerSocketChannel severSocketChannel = ServerSocketChannel.open();
ServerSocketChannel.configureBlocking(false);

// Then, create a ServerSocket from this channel and bind it to a port
ServerSocket serverSocket = severSocketChannel.socket();
serverSocket.bind(new InetSocketAddress(12345));

// creat a Selector
Selector selector = Selector.open();

// The returned key can be stored somewhere for future use such as unregistering, check for validity, or changing the events we are listening to.
SelectionKey key = serverSocketChannel.register(selector, SelectionKey.OP_ACCEPT);

// The select() call is blocking until events are available, n is the number of keys with available events.
int n = selector.select();

Set<SelectionKey> selectedKeys = selector.selectedKeys();
for (SelectionKey key : selectedKeys) {
    // do something
}
```


<br>

## Setting up the Selector to accept an incoming connection

Assuming that an incoming request has been received on our socket channel. Belows are some steps that we need to do.
- We need to make sure that the key corresponds to a connection request.
- Then, we need to setup a connection with a socket and listen to the events on this socket.

For example:

```java
// Checking if the selection key indeed received an accept event is done
if ((key.readyOps() & SelectionKey.OP_ACCEPT) == SelectionKey.OP_ACCEPT) {
    // Based on SelectionKey instance, we can get the corresponding channel.
    ServerSocketChannel channel = (ServerSocketChannel)key.channel();

    SocketChannel socketChannel = channel.accept();
    socketChannel.configureBlocking(false);

    socketChannel.register(selector, SelectionKey.OP_READ);
}
```

<br>

## Read the content sent through the socket using the Selector

At this point, our selector is registered with two channels, and will get the events from both channels.
- The first channel listens to incoming requests. In the meantime, we may have other incoming requests generating other channels.
- The second channel has been created to handle the communication with a given client.

So we need to add the handling of the READ event for this second channel in our code.
- First, get the corresponding channel, then copy the content of this channel to a ByteBuffer that we created somewhere else, read it from a ByteBuffer.

    The accept() method will return immediately. Because the data from the this socket channel is available. If the data is not available, then we would not be running in this callback. That is invoked only if the data is available.

- Then do something with this ByteBuffer.

    Once the data is in the ByteBuffer, then we can do something with it, whatever we need, analyze the content, get the content, and act accordingly. This is where our application code will be returned.


```java
else if ((key.readyOps() & SelectionKey.OP_READ) == SelectionKey.OP_READ) {
    SocketChannel channel = (SocketChannel)key.channel();
    channel.accept(byteBuffer);

    // do something with the buffer
    byteBuffer.clear();
    selectedKeys.remove(key);
    key.cancel();
    channel.close();
}
```


<br>

## Wrapping up




<br>

Refer:

[Java Fundamentals: NIO and NIO2]()