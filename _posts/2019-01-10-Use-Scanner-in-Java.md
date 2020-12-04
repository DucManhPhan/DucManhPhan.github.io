---
layout: post
title: Use Scanner in Java correctly
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Java]
---

There are so many ways to process with standard I/O or files. But using scanner is useful for breaking down input into tokens and translating token according to their data type. 

But actually, using Scanner has many problems. It can cause your problem make action wrong, not perform following your intention. In this article, we will find the pros and cons when using scanner to avoid them.

<br>

## Table of Contents
- [Introduction about Scanner class](#introduction-about-scanner-class)
- [Problem with Scanner class](#problem-with-scanner-class)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [How Scanner works](#how-scanner-works)
- [Wrapping up](#wrapping-up)

<br>

## Introduction about Scanner class
**Scanner** is a class in **java.util** package that is used to get input from standard I/O or files with primitives types such as int, double, strings, ...

A simpler text scanner which can parse primitive types and strings **using regular expression**. A **Scanner** breaks its input into tokens using delimiter pattern, which by default matches whitespace (includes tabs, blanks, and line terminators). The resulting tokens may then be converted into values of differents types using the various **next()** methods.

To create an object of Scanner class, you can reference to **Constructors** in link [Scanner in documetation of Oracle](https://docs.oracle.com/javase/8/docs/api/java/util/Scanner.html). Normally, you can pass the object of standard I/O such as System.in or object of **File** class to read input from a file. Or you can get information from string based on the pattern (refer the below example). It means that Scanner class can accept to read input from different sources.

To read values such as byte, short, int, long, float, double, boolean, big integer, big decimal, you only can call the method **nextABC()** with ABC is one of the data types that you need. 

For example: 

```Java
int n = scanner.nextInt();
```

To check the data type of value that you have just been scanned, use **hasNextABC()** method.

To read strings, use **nextLine()**;

To read single character, use **next().charAt(0);**

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

To use a different separator, call **useDelimiter()** method, specifying a regular expression.

Even though a scanner is not a stream, you need to close it to indicate that you're done with its underlying stream. Note that: when a scanner is closed, it will close its input source if the source implements the **Closeable** interface.

Passing a null parameter into any method of a Scanner will cause a **NullPointerException** to be thrown. 

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

Solution for this problem:
- Using **next()** method to discard the newline character.
- Using the other stream I/O such as **BufferReader**, ...

    For example: 

    ```Java
    BufferedReader br = new BufferedReader(new InputStreamReader(System.in)); 
    ...
    
    int n = Integer.parseInt(br.readLine());
    String s = br.readLine();
    ```

<br>

## Benefits and Drawbacks

1. Benefits

    - Using Scanner will help us parse, convert to our desired data type without implementing ourself.
    - We can customize separator in Scanner to get what we want.

2. Drawbacks

    - Scanner has a little buffer (1KB char buffer).
    - Scanner is slower than BufferReader because Scanner does parsing of input data, and BufferReader simply reads sequence of characters.
    - A Scanner is not safe for multithreaded use without external synchronization.

<br>

## How Scanner works

1. Initialization of Scanner class's object

    Scanner class will contain only a source as character stream by using InputStreamReader, or Channels class.

    ```java
    private Scanner(Readable source, Pattern pattern) {
        // ...
    }

    public Scanner(Readable source) {
        this(Objects.requireNonNull(source, "source"), WHITESPACE_PATTERN);
    }

    public Scanner(InputStream source) {
        this(new InputStreamReader(source), WHITESPACE_PATTERN);
    }

    public Scanner(File source) {
        this((ReadableByteChannel)(new FileInputStream(source)))
    }

    private static Readable makeReadable(Path source, Charset charset) throws IOException {
        Objects.requireNonNull(charset, "charset");
        return makeReadable(Files.newInputStream(source), charset);
    }

    private static Readable makeReadable(InputStream source, Charset charset) {
        Objects.requireNonNull(charset, "charset");
        return new InputStreamReader(source, charset);
    }

    private static Readable makeReadable(ReadableByteChannel source, CharsetDecoder dec) {
        return Channels.newReader(source, dec, -1);
    }

    private static Readable makeReadable(ReadableByteChannel source,
                                         Charset charset) {
        Objects.requireNonNull(charset, "charset");
        return Channels.newReader(source, charset);
    }
    ```

2. Some patterns for identifying primitive data types

    ```java
        // A pattern for java whitespace
    private static Pattern WHITESPACE_PATTERN = Pattern.compile(
                                                "\\p{javaWhitespace}+");

    // A pattern for any token
    private static Pattern FIND_ANY_PATTERN = Pattern.compile("(?s).*");

    // A pattern for non-ASCII digits
    private static Pattern NON_ASCII_DIGIT = Pattern.compile(
        "[\\p{javaDigit}&&[^0-9]]");

    private static final String BOOLEAN_PATTERN = "true|false";

    private static final String LINE_SEPARATOR_PATTERN =
                                           "\r\n|[\n\r\u2028\u2029\u0085]";
    private static final String LINE_PATTERN = ".*("+LINE_SEPARATOR_PATTERN+")|.+$";
    ```

3. Using buffer to contain the input's data and a cache for the last few recently used Patterns

    Scanner class uses CharBuffer data type to save the input's data. And it utilizes LRU cache pattern to save the used Patterns for some primitive data types.

    ```java
    public final class Scanner implements Iterator<String>, Closeable {

        // Internal buffer used to hold input
        private CharBuffer buf;

        // Size of internal character buffer
        private static final int BUFFER_SIZE = 1024; // change to 1024;

        private PatternLRUCache patternCache = new PatternLRUCache(7);

        // Internal matcher used for finding delimiters
        private Matcher matcher;

        // ...
        
        private Scanner(Readable source, Pattern pattern) {
            // ...

            this.source = source;
            delimPattern = pattern;
            buf = CharBuffer.allocate(BUFFER_SIZE);
            buf.limit(0);

            // 
            matcher = delimPattern.matcher(buf);
            matcher.useTransparentBounds(true);
            matcher.useAnchoringBounds(false);

            // ...
        }

        public Scanner reset() {
            delimPattern = WHITESPACE_PATTERN;
            useLocale(Locale.getDefault(Locale.Category.FORMAT));
            useRadix(10);
            clearCaches();
            modCount++;
            return this;
        }

    }
    ```

    To extract data from each line, **Scanner** class uses regular expression with the buffer's data by using **Matcher** class.
    
    ```java
    Matcher matcher = delimPattern.matcher(buf);
    ```

    It means that it takes resources such as memory, CPU to process each line.

4. How **nextLine()** method implements

    - First thing, **Scanner** class use **findPatternInBuffer()** method to check whether the length of buffer is enoung or not. If not, it will set a variable needInput to **true** to read file continuously.

        ```java
        private boolean findPatternInBuffer(Pattern pattern, int horizon) {
            matchValid = false;
            matcher.usePattern(pattern);
            int bufferLimit = buf.limit();
            int horizonLimit = -1;
            int searchLimit = bufferLimit;
            if (horizon > 0) {
                horizonLimit = position + horizon;
                if (horizonLimit < bufferLimit)
                    searchLimit = horizonLimit;
            }

            // only get data from start = position, end = searchLimit
            matcher.region(position, searchLimit);
            if (matcher.find()) {
                if (matcher.hitEnd() && (!sourceClosed)) {
                    // The match may be longer if didn't hit horizon or real end
                    if (searchLimit != horizonLimit) {
                        // Hit an artificial end; try to extend the match
                        needInput = true;
                        return false;
                    }
                    // The match could go away depending on what is next
                    if ((searchLimit == horizonLimit) && matcher.requireEnd()) {
                        // Rare case: we hit the end of input and it happens
                        // that it is at the horizon and the end of input is
                        // required for the match.
                        needInput = true;
                        return false;
                    }
                }
                // Did not hit end, or hit real end, or hit horizon
                position = matcher.end();
                return true;
            }

            if (sourceClosed)
                return false;

            // If there is no specified horizon, or if we have not searched
            // to the specified horizon yet, get more input
            if ((horizon == 0) || (searchLimit != horizonLimit))
                needInput = true;
            return false;
        }
        ```

    - Sencond thing, if the content in buffer is enough, so we only need to extract data from it. Otherwise, reading data from the InputStream, then put into buffer.

        ```java
        public String findWithinHorizon(Pattern pattern, int horizon) {
            // ...

            while (true) {
                if (findPatternInBuffer(pattern, horizon)) {
                    matchValid = true;
                    return matcher.group();
                }
                if (needInput)
                    readInput();
                else
                    break; // up to end of input
            }
            return null;
        }
        ```
    
    - Final thing, after receiving result from findWithinHorizon() method, we need to subtract to the length of separator string to get the real result.

        ```java
        public String nextLine() {
            // ...

            String result = findWithinHorizon(linePattern, 0);
            if (result == null)
                throw new NoSuchElementException("No line found");
            MatchResult mr = this.match();

            // get the length of separator string
            String lineSep = mr.group(1);
            if (lineSep != null)
                // get the real result
                result = result.substring(0, result.length() - lineSep.length());
            if (result == null)
                throw new NoSuchElementException();
            else
                return result;
        }
        ```

<br>

## Wrapping up

- Understanding about how Scanner works - using regular expression for separator between tokens, and idenfifying them as our primitive data type.

- Scanner class was introduced in Java 5.0.


<br>

Refer: 

[https://docs.oracle.com/javase/8/docs/api/java/util/Scanner.html](https://docs.oracle.com/javase/8/docs/api/java/util/Scanner.html)

[https://www.geeksforgeeks.org/scanner-class-in-java/](https://www.geeksforgeeks.org/scanner-class-in-java/)

[https://www.geeksforgeeks.org/difference-between-scanner-and-bufferreader-class-in-java/](https://www.geeksforgeeks.org/difference-between-scanner-and-bufferreader-class-in-java/)

