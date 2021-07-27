---
layout: post
title: Problems about Date type between Java and Javascript
bigimg: /img/image-header/california.jpg
tags: [Java]
---



<br>

## Table of contents



<br>

## 
- This is hard and inconsistent, yes. The JavaScript Date object was based on the one in Java 1.0, which is so bad that Java redesigned a whole new package. JavaScript is not so lucky.



<br>

## Solution
- Convert Date data type from Java to long data type

    ```java
    Date date = new Date();
    long msec = date.getTime();
    ```

- Convert Date data type in Java to String data type

    ```java
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
    ...

    String strDate = formatter.format(date)
    ```

<br>

## Wrapping up



<br>

Refer:

[https://stackoverflow.com/questions/41340836/why-does-date-accept-negative-values](https://stackoverflow.com/questions/41340836/why-does-date-accept-negative-values)

[https://javascript.info/date](https://javascript.info/date)

[http://codecoding.com/how-different-browsers-implement-date-function/](http://codecoding.com/how-different-browsers-implement-date-function/)