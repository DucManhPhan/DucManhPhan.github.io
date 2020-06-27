---
layout: post
title: Understanding about Functional Interfaces in Java 8 - Predicate
bigimg: /img/image-header/factory.jpg
tags: [Functional Programming]
---

In this article, we will learn how to use Predicate functional interface in Java 8. Let's get started.

<br>

## Table of contents
- [Introduction to utility functional interfaces](#introduction-to-utility-functional-interfaces)
- [Predicate functional interface](#predicate-functional-interface)
- [Chaining expression with Predicate](#chaining-expression-with-predicate)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to utility functional interfaces

In Java 8, all utility functional interfaces are included in **java.util.function** package. It is useful for us to work with functional programming. Belows are functional interfaces that we will use in the next articles.

|      Model     |        Has argument        |       Returns a value        |                 Description                |
| -------------- | -------------------------- | ---------------------------- | ------------------------------------------ |
| Predicate      | yes                        | boolean                      | Test argument and return true of false     |
| Function       | yes                        | yes                          | Maps one type to another                   |
| Consumer       | yes                        | no                           | Consumes input (returns nothing)           |
| Supplier       | no                         | yes                          | Generate output (using no input)           |

<br>

## Predicate functional interface

1. **Predicate** interface

    **Predicate** is a functional interface whose functional method called **test()**, evaluates a condition on an input variable for a generic type. 

    ```java
    @FunctionalInterface
    public interface Predicate<T> {

        // return true if the condition is true
        // and otherwise, return false
        boolean test(T t);
    }
    ```

    For example:

    ```java
    Predicate<Integer> hasSatisfyAge = age -> age > 20;
    System.out.println("Will the student's age satisfy condition: " + hasSatisfyAge.test(10));

    void checkAge(Predicate<Integer> p, Integer age) {
        boolean result = p.test(age);
        // do something with it
    }
    ```

2. **BiPredicate** interface

    Then, we will learn the syntax of **BiPredicate** interface that accepts two type parameters.

    ```java
    @FunctionalInterface
    public interface Bipredicate<T, U> {
        boolean test(T t, U u);
    }
    ```

    For example:

    ```java
    BiPredicate<Integer, String> condition = (age, name) -> age > 20 && name.startWith("John Wick");
    condition.test(60, "Bill Gate");
    ```

<br>

## Chaining expression with Predicate

Because the default method of **Prediate** that returns a new **Predicate** object, so we can utilize this property to create complex logical expressions.

- Default methods

    Belows are some default method of Predicate that we need to know:

    ```java
    // OR operation
    default Predicate<T> or(Predicate<? super T> other);

    // AND operation
    default Predicate<T> and(Predicate<? super T> other);

    // ! operation
    // negate() method changes the result of an existing predicate
    default Predicate<T> negate();
    ```

    For example:

    ```java
    // x > 7 || x < 3
    Predicate<Integer> p = x -> x > 7;
    p.or(x -> x < 3).test(10);

    // x > 7 && x % 2 == 1
    p.and(x -> x % 2 == 1).test(3);

    // use with ! operation to reverse the result of the current predicate
    p.negate().test(5);
    ```

- Static methods

    Then, we continue going with static methods:

    ```java
    // isEquals() method uses the equals() method of the Predicate object's type parameter
    // to check if the argument to the test() method is equal to a value.
    static <T> Predicate<T> isEqual(Object targetRef);

    // not() method reverses the result of the calculation performed by its predicate argument.
    // since Java 11
    static <T> Predicate<T> not(Predicate<T> target);
    ```

    For example:

    ```java
    Predicate<Integer> p = Predicate.isEqual(5);
    p.test(10);

    p.and(Predicate.not(x -> x % 2 == 1)).test(8);
    ```

- Overriding default methods

    If we want to validate our inputs before processing it with different default methods, we need to cusomize default methods by overriding.

    For example, check our string variable that starts with "a" and its length is greater than 4.

    ```java
    Predicate<String> isStartWithA = str -> str.charAt(0) == 'a';

    Predicate<String> isLengthStatify = new Predicate<String>() {
        @Override
        public boolean test(String x) {
            return x.length() > 4;
        }

        @Override
        public Predicate<String> and(Predicate<? super String> p) {
            return x -> x == null ? false : test(x) && p.test(x);
        }
    };
    ```

<br>

## Source code

In order to see how Predicate functional interface works, we can reference to [Predicate functional interface](https://github.com/DucManhPhan/J2EE/tree/master/src/Java_Core/Java%208/Functional%20Interfaces/predicate).


<br>

## When to use

- It is used in the filtering operations of Stream API.

- When we want to extract method technique for some complex conditions. Because we can use chaining expression to describe these complex conditions.

<br>

## Benefits and Drawbacks
1. Benefits

    - It makes us writing conditions readable.
    
    - In a large project, it's easy to maintain because it abides by Single Responsibility Principle.

    - It's easy to test our business logic.

2. Drawbacks



<br>

## Wrapping up

- Based on our business logic, we can create **Predicate** helper class to squeeze multiple predicate into one place.


<br>

Refer:

[Functional Interfaces in Java book]()

[https://howtodoinjava.com/java8/how-to-use-predicate-in-java-8/](https://howtodoinjava.com/java8/how-to-use-predicate-in-java-8/)

[https://www.baeldung.com/java-predicate-chain](https://www.baeldung.com/java-predicate-chain)

[https://dzone.com/articles/writing-clean-predicates-java](https://dzone.com/articles/writing-clean-predicates-java)