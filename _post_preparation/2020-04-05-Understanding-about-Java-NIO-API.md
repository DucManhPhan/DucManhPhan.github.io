---
layout: post
title: Understanding about Java NIO API
bigimg: /img/image-header/yourself.jpeg
tags: [Java]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Introduction to Java NIO](#introduction-to-java-nio)
- [Creating Channels with NIO](#creating-channels-with-nio)
- [Use asynchronous operations with Java NIO](#use-asynchronous-operations-with-Java-nio)

<br>

## Given problem
Before diving into Java NIO, NIO2, we should understand some drawbacks of Java I/O, why Java NIO, NIO2 added to the Java 4 and Java 7.

Java I/O was released in the Java 1.0 - 1996. It offers the **File** class of **java.io** package to access file systems. This File object represents a file/directory and did allow you to perform some operations such as checking if a file/directory exists, get properties and delete it.

Belows are some disadvantages of Java I/O that we need to know.
- The File class lacked some important functionality, such as a **copy()** method.
- It also defined many methods that returned **boolean**. As one can imagine, in case of an error, false was returned, rather than throwing an exception. The developer had, indeed, no way of knowing why it failed.
- Did not provide good handling on support of symbolic links.
- A limited set of file attributes was provided.
- But below is the major points that Java NIO, NIO added to the JDK.

    - We know that Java I/O is added to the JDK in 1995/1996 and Java NIO in 2002, that is 7 years later. In fact, during those 7 years, people realized that Java I/O was technically speaking a good API, no problem on that, but it was lacking several features, especially for performance reasons.

        For instances, Java I/O writes or reads one byte or character at a time and cannot conduct bulk reads or bulk write operations.

        Readers are for reading only. This is the case of reader class and the input stream class. And Writers are for writing only.

        Then buffering is made for use of buffered reader or buffered writer for the character stream and buffered input stream, buffered output stream where the raw bytestreams are. It occurs in the JVM called heap memory that is in a nutshell, an essential memory of the JVM and held by the garbage collector. This is not well adapted to very large files, very large read and write operations.

        Then the handling of charsets is not great. Basically, a text file written in Latin-1 across it, for instance, that is a charset not suppported by default by the JDK which default UTF-8, would have to read using the binary operation and then converted character by character to the right charset. This is not transparent to the user.

        The Java I/O API does not offer any solution for that. And at last, all the operations on the Java I/O API are synchronous operations. All these is not bad in 1996 but in 2002, 7 years later, people had the feeling that those functionalities were missing from Java I/O and decided to create a new Java I/O API to handle all these.

<br>

## Introduction to Java NIO

1. Some functionalities that Java NIO provide

    In the JDK, to access files and network, there are three APIs to deal with it.
    - The first one is Java I/O that is introduced in 1996 in the very first version of the JDK.
    - The second, Java NIO has been added to the JDK in 2002, Java 4.
    - The last one to date, in 2011, in Java 7, Java NIO2 was introduced.

    NIO stands for Non-blocking IO. It deals with buffers and channels. It also supports asynchronous operations.

    When NIO was released, there was a statement about that NI0 was more efficient, better performance than pure Java I/O. This might have changed. This might not be the case anymore. It really depends on our application and our use cases.

    The Java NIO provides:
    - bulk access to raw bytes and only raw bytes, so we can leverage the functionalities of file systems and operating system to speed up read and write operations.
    - bidirectional channels with a single channel, that is with single Java object, we can both read and write data to and from the disk or to and from the network.
    - off-heap buffering. It means that it can create buffer outside of the central memory of the JVM, in portions of memory not handled by the garbage collector. So, we can create very large buffers. Think of multi-gigabytes or even multi-terabytes of size without any impact on the performance of the garbage collector.
    - Proper support for charsets directly inside the JDK. So the JDK defines standard charsets objects. Objects for the standard, well-known and most widely used charsets around and those charsets provide encode and decode methods to convert a stream of characters expressed in a given charset to another charset.
    - support for asynchronous operations.

2. Understanding new concepts of Java NIO

    Java NIO introduces three new concepts:
    - Buffer

        A buffer can be seen as a space in memory. It can reside in the main memory of the JVM, the heap or off-heap, which is very useful for very large buffers.

    - Channel

        The channel is where the data comes from. The channel object is an object that connect to a file or to a socket, for instance. A channel can write the buffer to the medium or can read data from that medium to a buffer.
        
        A channel only knows bytes buffers, so it can only read and write bytes from files or for socket, for instance. Afterwards, we have to convert the content of this buffer to characters if this is a character buffer or to data or object if it is raw data or raw objects.

    - Selector

        A selector has been introduced to handle asynchronous operations. 

    A write operation takes data from a buffer and writes it to a channel.

    A read operation reads data from a channel and writes it into a buffer.

    Once the data is in the buffer, we can read it and interpret it as raw bytes, data types, objects, or characters as we need it.

<br>

## Creating Channels with NIO

1. Understanding channels and in-memory file channels

    - Channel

        The channel is an interface and is implemented by several classes.
        - The first one is **FileChannel** to access files.

            It has a cursor. It allows for multiple reads and writes. It is thread safe.

        - The second is **DatagramChannel** to access to socket.

            It supports multicast since it is UDP and it supports multiple, non-concurrent reads and writes.

        - The third one is the **SocketChannel** and **ServerSocketChannel** to access to a TCP socket.

            It supports asynchronous operations and also supports multiple, non-concurrent reads and writes.

        **FileChannel**, **SocketChannel**, and **ServerSocketChannel** are in fact, abstract classes extended by concrete classes in the JDK. But these implementations are hidden and should not be used directly.

        To create an instances of Channels, we are going to use factory methods.

    - In-memory files channels

        A **FileChannel** can be mapped to a memory array for direct access. This allows for much faster operation than accessing to the disk directly. It is built on native features provides by the different operating system and this is the reason why the concrete implementation of **FileChannel** are hidden just because they are different depending on the machine we are working on.

        It should be used with caution because a single write in this kind of array can trigger a modification of the file that will be send to the disk directly.

        There are 3 modes of this mapping:
        - **READ_ONLY**: the mapped file cannot be modified.

            The file is just loaded in memory and is read from this array.

        - **READ_WRITE**: the file can be modified with the previous warning.

        - **PRIVATE**: modifications are local to this channel and will not be propagated to the disk.

2. Understanding buffers and their main properties

    Buffer is an abstract class, extended by typed buffers.
    - The first type buffer and the most important is ByteBuffer since this is the only type of buffer, a channel can write in or read from.

        So, if we need to write characters to a ByteBuffer, we need to decorate it with a CharBuffer precisely and to write character using the method of this CharBuffer. As same as IntBuffer that allows for reading and writing integer into a ByteBuffer.

    - CharBuffer

    And then those ByteBuffer, CharBuffer, ... are extended by concrete implementations. Those concrete implementations are hidden. We do not have direct access to them. We can only create buffer using factory methods. This is the right pattern to use.

    A buffer is an in-memory structure backed by an array of bytes. It is usually stored in the central memory of the JVM, handled by the garbage collector. But it can also be stored in the off-heap space of the JVM, thus not impacting the garbage collector. This is very useful for very large buffers. The size of buffer is an Int since it is backed by an array. So the size of a buffer can be as large as two gigabytes which could have an impact on the performance of the garbage collector if stored in the central memory space of the JVM.

    A buffer object has 3 properties:
    - a capacity = the size of the backing array.
    - a current position that can be seen as cursor. All the read and the write operations are made to or from the current position.
    - a limit which is the last position in memory seen by this buffer.

    So with those two indexes, cursor and limit, we can create views on buffers which can be seen as a kind of a sub buffer inside a buffer. And a buffer always keeps track of the available space, so we know exactly what amount of data, we can write in a buffer.
    
    A buffer can hold a single mark. Marking a buffer does two things:
    - It sets the mark to the current position. The position we are reading from or writing to in the buffer.
    - It returns this to be able to chain calls on this buffer.
    - A buffer supports 4 operations:

        - rewind: clears the mark and sets the current position to 0.
        - reset: sets the current position to the previously set mark. This is the companion method of the mark method.
        - flip: sets the limit to the current position and rewinds the buffer.
        - clear: clears the buffer.

        These operations return this and can be chained for better patterns.

3. Some operations

    - Writing content to a file using Buffers and Channels

        Suppose we need to write integers to a file. First, we need a buffer to write those integers in and then, a channel which will be a FileChannel to write the contents of this buffer to the right file. A channel can only write or read from a ByteBuffer.

        - Create a ByteBuffer.
        - use the putXXX() method to write data.
        - have our FileChannel to write the ByteBuffer to a file.

        Note that in this way, we can write characters or arrays of characters but we cannot write directly strings of characters.

        To write strings of characters, we can use the following pattern.
        - convert the ByteBuffer to a CharBuffer.
        - use the put(String) method that is available of CharBuffer.
        
            For example:

            ```java
            // use off-heap memory
            ByteBuffer byteBuffer = ByteBuffer.allocate(1024);
            byteBuffer.putInt(10);
            FileChannel fileChannel = FileChannel.open(Paths.get("files/ints.bin"), CREATE, WRITE);
            fileChannel.write(byteBuffer);

            // should not forget to close manually the FileChannel if we are not choosing the try-with-resource in Java 7.
            fileChannel.close();
            ```

    - Reading content from a file using a flip operation

        In order to properly read a file, we need to understand how buffer works. Remember that in Java

<br>

## Use asynchronous operations with Java NIO





<br>

## Introduction to Java NIO2

Then NIO2 brought some more functionalities to both Java I/O and Java NIO.
- First, native access to file systems and events, specially directory events track file creation and deletion.
- Directory structure exploration API.



<br>

## Using FileSystems in Java NIO2




<br>

## Visiting Directory Trees in NIO2





<br>

## Listening Directory Events in NIO2




<br>

## Wrapping up




<br>

Refer:

[https://stackoverflow.com/questions/25537675/java-what-exactly-is-the-difference-between-nio-and-nio-2](https://stackoverflow.com/questions/25537675/java-what-exactly-is-the-difference-between-nio-and-nio-2)