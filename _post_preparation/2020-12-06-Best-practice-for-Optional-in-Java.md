---
layout: post
title: Best practice for Optional in Java
bigimg: /img/image-header/home-office-2.jpg
tags: [Java]
---



<br>

## Table of Contents





<br>

## Using ifPresent() method

1. Problem

    Normally, when we have an Optional variable, we need to check whether it is empty by using isPresent() method. If it has value, we will use get() method to get the real value. All operations will be described in the below code:

    ```java
    Optional<String> optName = Optional.ofNullable(null);
    if (optName.isPresent()) {
        doSomething(optName.get());
    }
    ```

2. Solution

    If we are using Optional like the above code, we can find that it is as same as when checking null value of Object variable.

    So, to reduce the boilerplate code, we can do like that.

    ```java
    optName.ifPresent(realValue -> doSomething(realValue));
    ```

<br>

## Using ofNullable() method

1. Problem

    When we want to wrap the variable, we can use of() static method to convert it to Optional variable.

    If our variable has null value, then of() static method will throw NullPointerException.

2. Solution

    To avoid that exception, we can use ofNullable() static method like the below source code.

    ```java
    String probablyNullValue = null;
    Optional<String> optString = Optional.ofNullable(probablyNullValue);
    ```

<br>

## Using orElse() method

1. Problem

    When we want to get the real value of Optional variable, we usually call get() method. But if the real value has null value, then it throw NoSuchElementException.

2. Solution

    To solve it, we need to use orElse() method. Because orElse() method will check the real value, if it is null, then it returns the default value that we pass as an argument of orElse() method.

    ```java
    public T orElse(T other) {
        return value != null ? value : other;
    }
    ```

<br>

## Wrapping up



<br>

Refer:

[https://topdev.vn/blog/mot-so-tips-de-tang-hieu-nang-truy-van-trong-mongodb-phan-1/](https://topdev.vn/blog/mot-so-tips-de-tang-hieu-nang-truy-van-trong-mongodb-phan-1/)