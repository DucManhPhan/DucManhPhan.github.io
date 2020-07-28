---
layout: post
title: How to convert between String and new DateTime in Java 8
bigimg: /img/image-header/yourself.jpeg
tags: [Java]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Introduction to new DateTime API in Java 8](#introduction-to-new-datetime-api-in-java-8)
- [Convert String to DateTime](#convert-string-to-datetime)
- [Convert DateTime to String](#convert-datetime-to-string)
- [Convert DateTime to DateTime for different formats](#convert-datetime-to-datetime-for-different-formats)
- [Some problems when using new DateTime](#some-problems-when-using-new-datetime)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Introduction to new DateTime API in Java 8






<br>

## Convert String to DateTime

1. From String to LocalDate



2. From String to LocalDateTime


<br>

## Convert DateTime to String




<br>

## Convert DateTime to DateTime for different formats




<br>

## Some problems when using new DateTime

1. Text '24/07/2020 02:30 PM' could not be parsed: Conflict found: Field AmPmOfDay 0 differs from AmPmOfDay 1 derived from 02:30

    - Given problem

        Our current date time is in the format.

        ```java
        public static final String DATE_TIME_FORMAT = "dd/MM/yyyy HH:mm a";

        public static final String DATE_FORMAT = "dd/MM/yyyy";
        ```

        So, when we run code with above formats, we encounter the problem **Field AmPmOfDay 0 differs from AmPmOfDay 1 derived from 02:30**.

        Because using H means hour-of-day (0 - 23). But we defined **AM/PM** in above format, so hour format is in **1 - 12**. It means that we need to use h:clock-hour-of-am-pm(1 -12).


    - Solution

        ```java
        public static final String DATE_TIME_FORMAT = "dd/MM/yyyy hh:mm a";

        public static final String DATE_FORMAT = "dd/MM/yyyy";
        ```


<br>

## Wrapping up




<br>

Refer:

[https://mkyong.com/java8/java-8-how-to-convert-string-to-localdate/](https://mkyong.com/java8/java-8-how-to-convert-string-to-localdate/)

[https://mkyong.com/java8/java-8-how-to-format-localdatetime/](https://mkyong.com/java8/java-8-how-to-format-localdatetime/)

