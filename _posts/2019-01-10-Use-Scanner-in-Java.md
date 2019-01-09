---
layout: post
title: Use Scanner in Java correctly
bigimg: /img/image-header/ravashing-beach.jpg
tags: [java]
---

There are so many ways to process with standard I/O or files. But using scanner is useful for breaking down input into tokens and translating token according to their data type. 

But actually, using Scanner has many problems. It can cause your problem make action wrong, not perform following your intention. In this article, we will find the pros and cons when using scanner to avoid them.

<br>

## Table of Contents
- [Introduction about Scanner class](#introduction-about-scanner-class)
- [Problem with Scanner class](#problem-with-scanner-class)
- [The disadvantage of Scanner class](#the-disadvantage-of-scanner-class)

<br>

## Introduction about Scanner class
Scanner is a class in java.util package that is used to get input from standard I/O or files with primitives types such as int, double, strings, ...

A simpler text scanner which can parse primitive types and strings **using regular expression**. A Scanner breaks its input into tokens using delimiter pattern, which by default matches whitespace (includes tabs, blanks, and line terminators). The resulting tokens may then be converted into values of differents types using the various **next()** methods.

To create an object of Scanner class, you can reference to **Constructors** in link [Scanner in documetation of Oracle](https://docs.oracle.com/javase/8/docs/api/java/util/Scanner.html). Normally, you can pass the object of standard I/O such as System.in or object of File class to read input from a file. Or you can get information from string based on the pattern (refer the below example).

To read values such as byte, short, int, long, float, double, boolean, big integer, big decimal, you only can call the method **nextABC()** with ABC is one of the data types that you need. 

For example: 

```Java
int n = scanner.nextInt();
```

To check the data type of value that you have just been scanned, use *hasNextABC()* method.

To read strings, use nextLine();

To read single character, use *next().charAt(0);*

For example: 

```java
String input = "1 fish 2 fish red fish blue fish";
Scanner s = new Scanner(input).useDelimiter("\\s*fish\\s*");
System.out.println(s.nextInt());
System.out.println(s.nextInt());
System.out.println(s.next());
System.out.println(s.next());
s.close();
```

To use a different separator, call *useDelimiter()* method, specifying a regular expression.

Even though a scanner is not a stream, you need to close it to indicate that you're done with its underlying stream. Note that: when a scanner is closed, it will close its input source if the source implements the Closeable interface.

Passing a null parameter into any method of a Scanner will cause a NullPointerException to be thrown. 

<br>

## Problem with Scanner class
When you call **nextABC()** method with ABC is int, long, ..., before calling **nextLine()** method. The result is that you can not receive a string that you have just been typed.

So What is your problem at here? 

For example:

```Java
Scanner scanner = new Scanner(System.in);
...
int n = scanner.nextInt();

String s = scanner.nextLine();
```

Because, when you type an integer and then end of typing, you will touch "\n" (Enter key). The variable n will receive that value. But enter key is still on the buffer System.in. So when you call **nextLine()** method, this method will get enter key, and out of keyboard state. So string s have no value.

Solution for this problem: you can use the other stream I/O such as BufferReader, ...

For example: 

```Java
BufferedReader br = new BufferedReader(new
        InputStreamReader(System.in)); 
...
int n = Integer.parseInt(br.readLine());

String s = br.readLine();
```

<br>

## The disadvantage of Scanner class
- Scanner has a little buffer (1KB char buffer).
- Scanner is slower than BufferReader because Scanner does parsing of input data, and BufferReader simply reads sequence of characters.
- A Scanner is not safe for multithreaded use without external synchronization.


Refer: 

https://docs.oracle.com/javase/8/docs/api/java/util/Scanner.html

https://www.geeksforgeeks.org/scanner-class-in-java/

https://www.geeksforgeeks.org/difference-between-scanner-and-bufferreader-class-in-java/

