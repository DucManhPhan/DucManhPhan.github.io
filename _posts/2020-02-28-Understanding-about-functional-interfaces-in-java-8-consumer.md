---
layout: post
title: Understanding about Functional Interfaces in Java 8 - Consumer
bigimg: /img/path.jpg
tags: [Functional Programming]
---



<br>

## Table of contents
- [Introduction to Consumer functional interface](#introduction-to-consumer-functional-interface)
- [Chaining with Consumer interface](#chaining-with-consumer-interface)
- [Chaining with BiConsumer interface](#chaining-with-biconsumer-interface)
- [Some specializations of Consumer and BiConsumer interface](#some-specializations-of-consumer-and-biconsumer-interface)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Consumer functional interface

1. Consumer functional interface

    **Consumer** is a functional interface that is **used to process data**.

    Below is a definition of this interface.

    ```java
    @FunctionalInterface
    public interface Consumer<T> {
        /**
         * Performs this operation on the given arguments.
         *
         * @param: t - the input argument
         */
        void accept(T t);
    }
    ```

    For example:

    ```java
    Consumer<String> toPrint = value -> System.out.println(value);
    toPrint.accept("Hello, world!");
    ```

2. BiConsumer functional interface

    BiConsumer is used to process inputs of two different generic types.

    ```java
    @FunctionalInterface
    public interface BiConsumer<T, U> {
        /**
         * Performs this operation on the given arguments.
         *
         * @param: t - the first input argument
         * @param: u - the second input argument
         */
        void accept(T t, U u);
    }
    ```

<br>

## Chaining with Consumer interface

To chain many **Consumer** interface, we need to use a default method **andThen()**.

```java
default Consumer<T> andThen(Consumer<? super T> after) {
    Objects.requireNonNull(after);
    return (T t) -> {
        accept(t);
        after.accept(t);
    };
}
```

For example:

```java
int sum = 0;
Consumer<Integer> printInteger = value -> System.out.println("The input value is: " + value);
Consumer<String> calcSum = value -> sum += value;

calcSum.andThen(printInteger)
       .accept(10);
```

<br>

## Chaining with BiConsumer interface

BiConsumer also support chaining functionality by using ```andThen()``` method with two parameters.

```java
/**
 * Returns a composed BiConsumer that performs, in sequence, this operation followed by the after operation.
 * If performing either operation throws an exception, it is relayed to the caller of the composed operation.
 * If performing this operation throws an exception, the after operation will not be performed.
 * 
 * @param: after - the operation to perform after this operation
 * @return: a composed BiConsumer that performs in sequence this operation followed by the after operation
 * @throws: NullPointerException - if after is null
 */

default BiConsumer<T, U> andThen(BiConsumer<? super T, ? super U> after);
```

For example:

```java
Consumer<String, String> printConcatString = (str1, str2) -> System.out.println(str1 + str2);
printConcatString.accept("Hello, ", "What is your name?");
```

<br>

## Some specializations of Consumer and BiConsumer interface

1. Consumer interface

    Belows are some specializations of Consumer:

    ```java
    @FunctionalInterface
    public interface IntConsumer {
        void accept(int value);
    }

    @FunctionalInterface
    public interface LongConsumer {
        void accept(long value);
    }

    @FunctionalInterface
    public interface DoubleConsumer {
        void accept(double value);
    }
    ```

2. BiConsumer interface

    Belows are some specializations of **BiConsumer**:

    ```java
    @FunctionalInterface
    public interface ObjIntConsumer<T> {
        void accept(T t, int value);
    }

    @FunctionalInterface
    public interface ObjLongConsumer<T> {
        void accept(T t, long value);
    }

    @FunctionalInterface
    public interface ObjDoubleConsumer<T> {
        void accept(T t, double value);
    }
    ```

<br>

## Wrapping up

- **Consumer** or **BiConsumer** functional interface is useful to process data. It will return no value.

- Using **andThen()** method to chaining multiple actions.

<br>

Refer:

[Functional interfaces in Java ebook]()

[https://www.tutorialspoint.com/how-to-use-consumer-and-biconsumer-interfaces-in-lambda-expression-in-java](https://www.tutorialspoint.com/how-to-use-consumer-and-biconsumer-interfaces-in-lambda-expression-in-java)