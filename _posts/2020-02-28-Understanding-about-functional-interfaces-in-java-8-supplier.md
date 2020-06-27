---
layout: post
title: Understanding about Functional Interfaces in Java 8 - Supplier
bigimg: /img/path.jpg
tags: [Functional Programming]
---



<br>

## Table of contents
- [Introduction to Supplier functional interface](#introduction-to-supplier-functional-interface)
- [When to use](#when-to-use)
- [Some specializations of Suppliers interface](#some-specializations-of-suppliers-interface)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Supplier functional interface

Supplier is a functional interface that is used to generate data.

Below is its definition on Java docs.

```java
@FunctionalInterface
public interface Supplier<T> {
    T get();
}
```

For example:

```java
Supplier<Integer> intRand = () -> {
    Random rand = new Random();
    return rand.nextInt(140);
};
```


<br>

## When to use

- When our methods or functions do not need input, but it expected output.


<br>

## Some specializations of Suppliers interface

Belows are some specializations of Supplier:

```java
@FunctionalInterface
public interface BooleanSupplier<T> {
    boolean getAsBoolean();
}

@FunctionalInterface
public interface IntSupplier<T> {
    int getAsInt();
}

@FunctionalInterface
public interface LongSupplier<T> {
    long getAsLong();
}

@FunctionalInterface
public interface DoubleSupplier<T> {
    double getAsDouble();
}
```

<br>

## Wrapping up



<br>

Refer:

[Functional Interfaces in Java ebook]()