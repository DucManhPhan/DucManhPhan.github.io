---
layout: post
title: Implementation with file in Java
bigimg: /img/image-header/ravashing-beach.jpg
tags: [java]
---

Implementation with file is very crucial for programmer. Master read/write file is obligated with them. 

In C++, there are some functions that is related to the implementation with file, such as: read file with text, binary mode by ifstream (support read file), ofstream (support write file), fstream (support both read/write file). 

But in Java, it supports so many classes, methods for reading/writing file. It will make you difficult about how to use it. Today, in this article, we will find out something about it, and specify them when to use, which pros and cons of them.

## Table of Contens
- [Introduction about stream](#introduction-about-stream)
  - [The Byte stream classes](#the-byte-stream-classes)
  - [The Character stream classes](#the-character-stream-classes)
- [When to use Byte streams](#when-to-use-byte-streams)
- [When to use Character streams](#when-to-use-character-streams)
- [Important note](#important-note)

<br>

## Introduction about stream
In order to use classes, methods that perform I/O, especially reading, writing file, you must use **java.io** package. This package support many data such as primitives, object, localized characters, ...

IO streams are flows of data that you can read, write.

There are two kinds of stream in Java. 
- InputStream : used to read file
- OutputStream : used to write file

<br>

Similiarity with C++, when implementing with files, it has two mode: binary mode, text mode, Java also supports Byte stream and Character stream. But these classes can used in a larger context when comparing with C++.

- Byte streams are used to perform input and output of 8-bit bytes, like *InputStream* or *OutputStream*, but with the exception of the *DataInputStream* and *DataOutputStream* can also read and write *int, long, float* and *double* values. All other stream types are built on byte streams.

- Character streams are used to perform input and output for 16-bit Unicode. It can be called as **Reader** or **Writer**. Character stream I/O automatically translates this format to and from the local character set. In Western locales, the locale character set is usually an 8-bit superset of ASCII.

    Character streams are often "wrapper" for byte streams. The character stream uses the byte stream to perform the physical I/O, while the character stream handles translation between characters and bytes. 

    For example: 

    FileReader class uses FileInputStream

    FileWritter class uses FileOutputStream

    ```
    There are two general-purpose byte-to-character "bridge" streams: **InputStreamReader** and **OutputStreamWriter**. Use them to create streams when there are no prepackaged character stream classes that meet your needs.
    ```

<br>

Belows are the image about a hierachy of classes in Input/Output stream.

![Input/output stream classes](.../img/file-in-java.png)

### The Byte stream classes
The hierarchical layout is as follows:
- InputStream: Top level abstract class for byte-oriented input stream.
    - ByteArrayInputStream: An instance of this class contains an internal buffer to read bytes stream.
    - FilterInputStream: An instance of this class contains some other input stream as a basic source of data for further manipulation.
        - BufferInputStream: This enables a *FilterInputStream* instance to make use of a buffer for input data.
        - DataInputStream: An instance of this class enables reading primitive Java types from an underlying input stream in a machine-independent manner.
        - LineNumberInputStream: An instance of this class aids in keeping track of the current line number of the input stream.
        - PushbackInputStream: This provides the ability to push back, or "unread," a data byte after reading it.
    - FileInputStream: An instance of this class is used to obtain input bytes from a file in a file system.
    - ObjectInputStream: An instance of this class is used to deserialize an object after it has been serialized by ObjectOutputSteam.
    - PipedInputStream: An instance of this class provides a pipe or buffer for an input byte that works in the FIFO manner.
    - SequenceInputStream: An instance of this class represents a logical concatenation of two or more input streams which are read in sequence, one after another.
- OutputStream: Top-level abstract class for byte-oriented input stream.
    - ByteArrayOutputStream: An instance of this class contains an internal buffer to write a bytes stream.
    - FilterOutputStream: An instance of this class contains some other output stream as a basic source of data for further manipulation.
        - BufferedOutputStream: This enables a FilterOutputStream instance to make use of a buffer for output data.
        - DataOutputStream: An instance of this class enables writing primitive Java types to an underlying output stream in a machine-independent manner.
        - PrintStream: This empowers the OutputStream objects with the ability to print representations of various data values conveniently.
    - FileOutputStream: An instance of this class is used to output a stream for writing data to a file or to a file descriptor.
    - ObjectOutputStream: An instance of this class is used to serialize an object which can be deserialized with ObjectInputStream.
    - PipedOutputStream: An instance of this class provides a pipe or buffer for output byte that works in the FIFO manner.


### The Character stream classes
Belows are the hierachy of classes in Character streams.

- Reader: Top-level abstract class to read to character streams.
    - BufferedReader: Provides an in-between buffer for efficiency while reading text from character input stream.
        - LineNumberReader: Uses a buffered character input stream that keeps track of line numbers.
    - CharArrayReader: Implements an auto-increasing character buffer that may be used as a reader.
    - FilterReader: An instance of this class is used for reading character files.
        - PushbackReader: This enables a character to be pushed back into the stream after reading.
    - InputStreamReader: An instance of this class provides a bridge from byte streams to character streams. Bytes are decoded into characters using a specified character set.
        - FileReader: An instance of this class is used for reading character files.
    - PipedReader: Uses a pipe for character input stream.
    - StringReader: Character output stream reader from source string.
- Writer: Top-level abstract class to write to character streams.
    - BufferedWriter: Provides an in-between buffer for efficiency while writing text to a character output stream.
    - CharArrayWriter: Implements an auto-increasing character buffer that may be used as a writer.
    - FilterWriter: Abstract class for writing filtered character streams.
    - OutputStreamWriter: An instance of this class provides a bridge between character streams and byte streams. Characters are encoded into bytes using a specified character set.
        - FileWriter: An instance of this class is used for writing character files.
    - PipedWriter: Uses a pipe for character output stream.
    - PrintWriter: Prints a formatted representation of an object to a test-output stream.
    - StringWriter: Character output stream is collected in a string buffer and may be used for constructing a string.

<br>


## When to use Byte streams
- When you want to process raw data like binary files.


## When to use Character streams
- Process text files. These text files can be processed character by character. A character size is typically 16 bit.


## Important note
- Names of character streams typically end with Reader/Writer and names of byte streams end with InputStream/OutputStream.
- Should use Buffer streams with Byte streams (BufferInputStream / BufferOutputStream) and Character streams (BufferReader / BufferWriter).
- It is highly recommended to close the stream when it is no longer in use. This ensures that the streams won't be affected if any error occurs. 


Refer:

https://www.geeksforgeeks.org/different-ways-reading-text-file-java/

https://www.geeksforgeeks.org/scanner-class-in-java/

https://www.geeksforgeeks.org/java-io-bufferedreader-class-java/

https://www.geeksforgeeks.org/file-handling-java-using-filewriter-filereader/

https://www.tutorialspoint.com/java/java_files_io.htm

http://tutorials.jenkov.com/java-io/streams.html

https://www.developer.com/java/data/understanding-byte-streams-and-character-streams-in-java.html

https://docs.oracle.com/javase/tutorial/essential/io/index.html

