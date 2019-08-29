---
layout: post
title: Understanding about Log4j 2.x framework
bigimg: /img/image-header/home-office-1.jpg
tags: [java]
---




<br>

## Table of contents



<br>

## The structure of Log4j 2.x





<br>

## 

```
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter</artifactId>
   <exclusions>
      <exclusion>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-logging</artifactId>
      </exclusion>
   </exclusions>
</dependency>
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter-log4j2</artifactId>
</dependency>

```


```
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter</artifactId>
   <exclusions>
      <exclusion>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-logging</artifactId>
      </exclusion>
   </exclusions>
</dependency>
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter-log4j2</artifactId>
</dependency>
```


<br>


## Wrapping up





<br>

Refer:

[https://dzone.com/articles/log4j-2-configuration-using-properties-file](https://dzone.com/articles/log4j-2-configuration-using-properties-file)

[https://www.journaldev.com/7128/log4j2-example-tutorial-configuration-levels-appenders](https://www.journaldev.com/7128/log4j2-example-tutorial-configuration-levels-appenders)

[https://www.programering.com/a/MTO0MjMwATc.html](https://www.programering.com/a/MTO0MjMwATc.html)

[https://howtodoinjava.com/log4j2/log4j2-properties-example/](https://howtodoinjava.com/log4j2/log4j2-properties-example/)

[https://stackify.com/log4j2-java/](https://stackify.com/log4j2-java/)

[https://logging.apache.org/log4j/log4j-2.1/manual/appenders.html#FileAppender](https://logging.apache.org/log4j/log4j-2.1/manual/appenders.html#FileAppender)