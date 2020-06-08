---
layout: post
title: Understanding about Functional Interfaces in Java 8 - Operators
bigimg: /img/path.jpg
tags: [Functional Programming, Java]
---



<br>

## Table of contents
- [Introduction to Operators](#introduction-to-operators)
- []()
- []()
- []()


<br>

## Introduction to Operators





<br>

## UnaryOperator interface

1. Introduction

    **UnaryOperator<T>** is a functional interface that is inherited from **Function<T, R>** interface.

    ```java
    @FunctionalInterface
    public interface UnaryOperator<T> extends Function<T,T> {

        default <V> Function<T,V> andThen(Function<? super R,? extends V> after);

        R apply(T t);

        default <V> Function<V,R> compose(Function<? super V,? extends T> before)

        /**
         * Returns a unary operator that always returns its input argument.
         */
        static <T> UnaryOperator<T> identity();
    }
    ```

    From an above source code, we can find that we have functional method is apply() method, two default method: andThen() and compose() methods.


2. Some specializations of UnaryOperator

    Belows are its specializations.

    ```java
    @FunctionalInterface
    public interface IntUnaryOperator {
        int applyAsInt(int operand);
    }

    @FunctionalInterface
    public interface LongUnaryOperator {
        int applyAsLong(long operand);
    }

    @FunctionalInterface
    public interface DoubleUnaryOperator {
        int applyAsDouble(double operand);
    }
    ```


<br>

## BinaryOperator interface

1. Introduction




2. Some specializations of BinaryOperator
 




<br>

## Wrapping up







<br>

Refer:

[]()