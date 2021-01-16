---
layout: post
title: How to use currying technique
bigimg: /img/image-header/yourself.jpeg
tags: [Functional Programming]
---


<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Currying](#solution-with-currying)
- [Source code](#source-code)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

In this article, we will learn how functional programming handles functions of multiple arguments. Let's start by talking about closures.

A closure is the ability of a method to reference a variable or another method in its enclosing context.

For example:

```java
Integer a = 2;
Function<Integer, Integer> f = new Function<Integer, Integer>() {
    @Override
    public Integer apply(Integer x) {
        return x * a;
    }
}
```

We can find that the anonymous class forms a closure when it accesses variable a, which is defined outside its scope. The anonymous class closes over the value of the variable at the time the code is run. In Java, this is valid only if the variable of the enclosing block is final or effective final. Effective final means that a variable is not explicitly marked as final, but its initial value is never changed.

Or we can use with lambda expression.

```java
Integer a = 2;
Function<Integer, Integer> f = x -> x * a;

// equivalent to f(x) = x * 2
```

We can wonder that the f Function can be equivalent to the function f(x) = x * 2, but that is not entirely correct because 2 is not a constant, it's a closure. Just it cannot be modified after it is initialized, but we can initialize the variable with a different value every time it's run.

```java
Integer a = Integer.parseInt(args[0]);
Function<Integer, Integer> f = x -> x * a;
```

In other words, this function does not only depends on **x** but also on **a**. So the correct way to express this function is:

```java
f(x, a) = x * a
```

As we know, the result of a pure function should only depend upon its arguments, but using closures can break this rule. Also, reusing the function somewhere else is harder now because it depends on the context and not only on its argument. Used this way, closures should be avoided as much as possible in functional programming.

So, should we turn the closure to an explict of the function? We can do that, but we could face another problem. Making the closure depends on an argument of the function means that the function should take two arguments. However, the applied method of the Function interface only takes one.

```java
@FunctionalInterface
public interface Function<T, R> {
    R apply(T t);
}
```

We can use the BiFunction interface, which represents a function of two arguments, or BinaryOperator, which corresponds to a function of two arguments of the same type.

```java
@FunctionalInterface
public interface BiFunction<T, U, R> {
    R apply(T t, U u);
}

@FunctionalInterface
public interface BinaryOperator<T> extends BiFunction<T, T, T> {
}
```

It will work fine for our example, but what if we need three arguments or more. How do we deal with this problem?

<br>

## Solution with Currying

1. History of Currying

    According to the [wikipedia.com](https://en.wikipedia.org/wiki/Currying), we have:

    This concept was introduced by Gottlob Frege, developed by Moses Schönfinkel, and further developed by Hashkell Curry, his name is used to name the programming language, Haskell.

2. Introduction to Currying

    Currying is about converting a function of multiple arguments to a function of one argument each step at a time.

    So, instead of creating a function that takes two parameters, we can create a one-parameter function that returns another one-parameter function. The first function receives the first argument of the original function, and the second function receives the second argument.

    ```java
    f(a, b) = a + b
    f(a)(b) = g(b) = a + b
    ```

    This makes f as a proper mathematical function of one argument, but in this case, the range of f consists of functions.

    Applying the value 1 produces a single-argument function which adds 1 to its argument. Applying the value 2 produces to this function produces not another function but the final result.

    ```java
    f(1) = g(2) = 1 + 2
    ```

    As we can see, upon being called with an argument, each function produces the next one in the sequence, the last one does the actual operation. This is different from a function that takes multiple arguments, especially in a language like Java, where all the arguments are evaluated at the same time before the function is called.

    With currying, the arguments of a function are evaluated at different times, and it's not until the function receives all of its arguments that the operation is executed.

3. Partial Application

    There's a concept related to currying that is called partial application. While currying is about converting a function with many arguments into a series of one-argument functions, partial application is about supplying fewer arguments than the ones required by the function to produce new functions by fixing some of their arguments.

    For example:

    ```java
    // normal function
    add(1, 2, 3, 4, 5, 6)

    // partial function
    add3(3, 4, 5)

    add6(4, 5)
    ```

    In terms of partial application, currying consists of replacing a function that takes multiple arguments with functions that we can partially apply one argument after the other. But we are not required to completely curry the function.

    ```java
    add(1, 2, 3, 4, 5)
    add1(2, 3, 4, 5)
    add3(3, 4, 5)
    ```

    This function of five arguments can be curried just into a function that takes four arguments as add1() function.

    So all currying is partial application, but all partial application is currying.

4. The order of currying function

    In curried functions, the order does matter. Because applying the function to the first argument gives us a new function, not the final result.

    For example, we will design a curried function to apply a reward in which customers can convert their points into money to pay for their order. The arguments of this function are the monetary value of a point, the number of points the customer wants to exchange, and the total of the order.

    ```java
    // arguments: pointValue, numberOfPoints, total
    Function<Double,
            Function<Integer,
                    Function<Double, Double>>> applyReward = 
            pointValue -> numberOfPoints -> total -> total - (pointValue * numberOfPoints);

    Function<Integer, Function<Double, Double>> applyNormalReward = applyReward.apply(1.00);
    Function<Integer, Function<Double, Double>> applyVIPReward = applyReward.apply(2.00);

    System.out.println(applyNormalReward.apply(5).apply(10.0));
    System.out.println(applyVIPReward.apply(5).apply(10.0));
    ```

    By ordering the arguments of the curried function in a particular way from the most specific to the least specific, we improve its resuability.

<br>

## Source code

To use currying for the above problem, we have:

```java
// use lambda expression
Function<Integer, Function<Integer, Integer>> add = a -> b -> a + b;

// use anonymous class
Function<Integer, Function<Integer, Integer>> add = 
    new Function<Integer, Function<Integer, Integer>>() {
        return new Function<Integer, Integer> apply(Integer a) {
            @Override
            public Integer apply(Integer b) {
                return a + b;
            }
        }
    }

// result
Integer result = add.apply(1).apply(2); // 3
```

If we find that the type of Function is too long, we can use inheritance to reduce it.

```java
Function<Short, Function<Integer, Function<Long, Long>>> f = s -> i -> l -> s + i + l;

// reduced version
CurriedFunction f = s -> i -> l -> s + i + l;
interface CurriedFunction extends Function<Short, Function<Integer, Function<Long, Long>>> {}
```


<br>

## Wrapping up

- In normal function, we have:

    ```java
    (A, B, C) -> D
    ```

    With curried function, having:

    ```
    A -> B -> C -> D

    Function<A, Function<B, Function<C, Integer>>>
    ```

- When a curried function is applied to only some of its arguments, it's partially applied.

<br>

Refer:

[Applying Functional Programming Techniques in Java by Esteban Herrera](https://app.pluralsight.com/library/courses/applying-functional-programming-techniques-java/table-of-contents)