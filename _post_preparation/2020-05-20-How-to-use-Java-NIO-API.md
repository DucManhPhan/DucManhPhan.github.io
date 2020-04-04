---
layout: post
title: How to use Java NIO API
bigimg: /img/image-header/yourself.jpeg
tags: [Java]
---




<br>

## Table of contents
- [How Java NIO works](#how-java-nio-works)
- [Accessing Files and Directories using Java NIO Path](#accessing-files-and-directories-using-java-nio-path)
- []()
- [The difference between Java IO and Java NIO](#the-difference-between-java-io-and-java-nio)
- [Wrapping up](#wrapping-up)


<br>

## How Java NIO works




<br>

## Accessing Files and Directories using Java NIO Path

1. Introduction to Path class

    In the JDK 1.0, 1995 - 1996, we have a old File object. And now we have a second object that is used to interact with files and directories called as **Path** object.

    Path is an interface which is introduced in Java NIO file package during Java version 7, and is the representation of location in particular file system.

2. The difference between Files and Paths

    - File is a class from Java 1.0 that models files, whereas Path is an interface from Java 7.

        It means that for each file system, for each type of file system that exists, we can have different implementation of the Path interface. The implementation for the Windows file system is not the same as Linux file system.

        For instance, since a **File** object is created on a String. It's just a wrapper on the String that represent the path of the file system. It's independent on any file system, and indeed, a file does not know about anything the file system.

        But Java 7 introduces a **FileSystem** class with file system objects. And path is necessarily to linked to an explicit file system. If we do not tell the system, which file system we're going to use when we create a path, this system will give us a path and linked to our default file system, which is most of the time the case.

3. Accessing Files with Path objects

    Basically, we can do the same kind of thing as with the **File** object. We can access file in roughly the same way, but we can get more information, especially specific attributes dependent on our FileSystem objects.

    The Path is just used to access file or directory on the given file system. A Path gives information on a path:
    - different elements directory that we are going to go through to access this file.
    - We can check if this element contains a symbolic link or not.
    - Through different factory methods from Files class, we can have more information on the file or directory represented by this path. Basically, the read/write property, can be executed in this file or directories exist or not.

4. Creating Path object

    Due to Path is an interface, to get an instances of Path, we have to use factory method. Now, we have two pattern to create those Path instances.
    - from the **Paths** factory class.

        From the **Paths factory class**, there are two **get()** methods
        - takes a path as a String, or a vararg of paths.

            For example:

            ```java
            Path path1 = Paths.get("C:/tmp/debug.log");
            Path path2 = Paths.get("C:", "tmp", "debug.log");
            ```

        - a URI as a String

            For example:

            ```java
            URI uri = URI.create("file://C:/tmp/debug.log");
            Path path3 = Paths.get(uri);
            ```

    - from the **Path.of()** factory methods.

        Starting with Java 11, we have factory methods directly on this **Path** interface. Why don't we have this Path factory methods directly on the interface right from the beginning?

        Just because Java 7, it wasn't possible to create factory method on interfaces. This became possible starting with Java 8. So it has been introduced later on.

        For example:

        ```java
        Path path3 = Path.of("C:/tmp/debug.log");
        ```

5. Getting information on Files from a Path

    The Files factory class has methods that take the Path as a parameter to give us the information that we need.
    - Check if it exists or not.
    - Check if it is hidden.
    - Check if the path is a file or a directory.
    - Check if it is readable or writeable.
    - Check if it is executable.

    All those functionalities are implemented using corresponding method. For instance, we have exists() method that takes a path as a parameter.

    ```java
    Path path = Paths.get("C:/tmp/debug.log");
    boolean exists = Files.exists(path);
    boolean exists = Files.exists(path, LinkOption.NOFOLLOW_LINKS);
    ```

    These methods may take a further argument which is a constant called as ```NOFOLLOW_LINKS```. It means that the API can check if a path contains symbolic links.

    And we can check if two path actually locate the same file. Those two path may be very different in the structure. But, in fact, pointing to the same element on the disk, and this is what this method is used to in this case.

    ```java
    boolean sameFile = Files.isSameFile(path1, path2);
    ```

<br>

## Reading and Writing Text files using Java NIO API

1. Introducing the possible errors when dealing with text files

    The difference between Binary file and Text file
    - Binary files are about storing bytes. For instance, if our bytes have to be grouped four by four to create integer, this is our interpretation, our application's specific interpretation of the binary content of a given file. 

    - Text files are about storing characters. The character is also a set of bytes in a text file, but in can be interpreted as this or that character using a Charset.
        
        There are many Charset such as ASCII, ISO 8859, UTF-8, Unicode, ... The charset we should all be using is probably utf-8, but this is not the only one that is living around. So the API provide support for that.

    Java provides classes to read and write both types of files.
    - The classes are provided to read and write text file such as Reader, Writer, and the further extended classes ...

    - The classes for binary files are InputStream, OutputStream, ...

2. Reading text files

    We can use a simple pattern:
    - get a **BufferedReader** - is extension of Reader class.
    - then, through this **BufferedReader**, we are going to read file line by line.

    Belows are some steps to use the above pattern:
    - create a Path object.
    - get a **BufferedReader** on the corresponding file.
    - read a line (return null if there is none)

    ```java
    Path path = Paths.get("C:/tmp/sometext.txt");
    BufferedReader reader = Files.newBufferedReader(path);
    String line = reader.readLine();
    ```

    Some problems can happens in the above case:
    - the file may not be there.
    - the file many not have the right encoding.

    Then, it can throw an exception like this:

    ```java
    Exception in thread "main" java.nio.charset.MalformedInputException: Input length = 1
    ```

    When we see this exception, we can find that the charset we need is not a default charset, we need to pass charset as a parameter.

    ```java
    BufferedReader reader = Files.newBufferedReader(path, StandardCharsets.ISO_8859_1);
    ```

3. Writing to a text file

    Similarly, we also have a simple pattern:
    - get a BufferedWriter.
    - use it to write to our file.

    For example:

    ```java
    Path path = Paths.get("C:/tmp/sometext.txt");
    BufferedWriter writer = Files.newBufferedWriter(path);
    writer.write("Hello, world!");
    ```

    Some problems for the above code:
    - the file may already be there.
    - flush the buffer before closing it.

    We need to call close() method of BufferedWriter instance manually or use try-with-resources to automatically close this file. Because the close() method is calling a flush() method itself. And the flush() method will transfer what has been returned to the disk.

    In order to use multiple writer correctly, we need to put writers into try statement like the below code.

    ```java
    Path path = Path.of("...");
    try (BufferedWriter writer1 = Files.newBufferedWriter(path);
        BufferedWriter writer2 = Files.newBufferedWriter(writer1);
        PrintWriter pw = new PrintWriter(writer2);) {
        writer1.write("Hello, world!!!");
        pw.printf("\n");
    } catch (IOException ex) {
        System.out.println("Exception: " + ex);
    }
    ```

<br>

## 





<br>

## The difference between Java IO and Java NIO



<br>

## Wrapping up




<br>

Refer:

