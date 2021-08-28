---
layout: post
title: How to use BufferedReader/BufferedWriter correctly in Java
bigimg: /img/image-header/home-office-1.jpg
tags: [Java]
---




<br>

## Table of contents





<br>

## Given problem 





<br>

## Solution of BufferWriter/BufferReader



    ```java
    BufferedReader br = new BufferedReader(new InputStreamReader(System.in));   // speedup
    // Note: String splitting and/or input parsing is needed afterwards

    PrintWriter pr = new PrintWriter(new BufferedWriter(new OutputStreamWriter(System.out)));   // speedup
    // PrintWriter allows us to use the pr.printf() method
    // do not forget to call pr.close() before exitting our Java program
    ```


<br>

## 





<br>

## Wrapping up




<br>

Refer:

[https://www.boraji.com/java-linenumberreader-example](https://www.boraji.com/java-linenumberreader-example)

[https://www.guru99.com/buffered-reader-in-java.html](https://www.guru99.com/buffered-reader-in-java.html)

[https://www.javatpoint.com/how-to-read-file-line-by-line-in-java](https://www.javatpoint.com/how-to-read-file-line-by-line-in-java)

[https://www.codejava.net/java-se/file-io/how-to-read-and-write-text-file-in-java](https://www.codejava.net/java-se/file-io/how-to-read-and-write-text-file-in-java)

[https://www.journaldev.com/20601/java-bufferedwriter](https://www.journaldev.com/20601/java-bufferedwriter)

[https://stackoverflow.com/questions/14462705/how-does-bufferedwriter-work-in-java](https://stackoverflow.com/questions/14462705/how-does-bufferedwriter-work-in-java)

[https://medium.com/@isaacjumba/why-use-bufferedreader-and-bufferedwriter-classses-in-java-39074ee1a966](https://medium.com/@isaacjumba/why-use-bufferedreader-and-bufferedwriter-classses-in-java-39074ee1a966)

[http://tutorials.jenkov.com/java-io/bufferedwriter.html](http://tutorials.jenkov.com/java-io/bufferedwriter.html)

