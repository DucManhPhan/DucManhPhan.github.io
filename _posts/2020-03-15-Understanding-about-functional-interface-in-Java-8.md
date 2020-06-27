---
layout: post
title: Understanding about functional interface in Java 8
bigimg: /img/path.jpg
tags: [Functional Programming]
---

In this article, we will learn how to use functional interface. Let's get started.

<br>

## Table of contents
- [Given problem](#given-problem)
- [Introduction to Functional Interface](#introduction-to-functional-interface)
- [How to implement functional interface](#how-to-implement-functional-interface)
- [Generic Functional Interface](#generic-functional-interface)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

When we are working in our project, usually, we want to write a small functionality for a weird case. Then we need to encapsulate it in a class, create an instance for this class. Calling it to do action.

It's really confused, annoyed us when we do not need to write boiler-plate code. And when we create a class to wrap this functionality, we are working with misconcept of class. So, we have to define an interface to deal with it. But we have to create another class to implement that interface. OOps! We are making an loop.

How to overcome this problem?

Solution for this problem is that to use functional interface and lambda.

<br>

## Introduction to Functional Interface

A functional interface is an interface with a single abstract method, called its functional method. The **@FunctionalInterface** annotation instructs the compiler to verify that the interface has only one abstract method.

For example:

```java
@FunctionalInterface
public interface IDoSomething {
    void display(String str);

    // since Java 9
    private void displayOther() {
        System.out.println("We can define private method since Java 9.");
    }

    default void displayOther_default() {
        System.out.println("We can define default method since Java 8.");
    }

    static void displayOther_static() {
        System.out.println("We can define static method since Java 8.");
    }

    // since Java 9
    private static void displayOther_private_static() {
        System.out.println("We can define private static method since Java 8.");
    }
}
```

<br>

## How to implement functional interface
1. Use normal way

    We can define another class that implement a functional interface.

    ```java
    public class DoSomething implements IDoSomething {
        @Override
        public void display(String str) {
            System.out.println("The content of it is: " + str);
        }
    }

    IDoSomething doSomething = new DoSomething();
    doSomething.display("How to work with Functional Interface");
    ```

2. Use anonymous class

    A functional interface can also be implemented by an anonymous class that provides the functional method.

    ```java
    IDoSomething doSomething = new IDoSomething() {
        @Override
        public void display(String str) {
            System.out.println("Its content is: " + str);
        }
    };
    ```

<br>

## Generic Functional Interface

We can define generic functional interface with one or more types. For example,

```java
@FunctionalInterface
public interface TwoArgsProcessor<X> {
    X process(X arg1, X arg2);
}
```

If the generic functional interface of a particular type is used frequently, it is convenient to specialize it for that type. Specialization is accomplished by extending or implementing the generic functional interface of one type.

For example:

```java
@FunctionalInterface
public interface TwoIntsProcessor extends TwoArgsProcessor<Integer> {
}
```

Generic functional interfaces can be restricted to certain types.

For example:

```java
public class Person {
    // do something
}

public class Employee extends Person {
    // do something
}

public class Director extends Person {
    // do something
}

@FunctionalInterface
public interface calculateTax<X extends Person> {
    void calculate(X person);
}
```

<br>

## Benefits and Drawbacks
1. Benefits

    - We can use functional interface with lambda expression. It helps us in writing smaller and cleaner code by removing a lot of boiler-plate code.

2. Drawbacks




## Wrapping up
- Understanding about functional interface, how to use generic with it.

- **@FunctionalInterface** annotation is useful for compilation time checking of your code. We cannot have more than one method besides **static**, **default** and abstract methods that override methods in Object in your **@FunctionalInterface** or any other interface used as a functional interface.

    But we can use lambdas without this annotation as well as we can override methods without **@Override** annotation.

- When working with functional interface in java, we can find that it has something that is as same as Function Pointer or Functor in C++.

<br>

Refer:

[Functional Interfaces in Java ebook]()

[https://www.ntu.edu.sg/home/ehchua/programming/java/JDK8_NewFeatures.html#zz-1.](https://www.ntu.edu.sg/home/ehchua/programming/java/JDK8_NewFeatures.html#zz-1.)

[https://stackoverflow.com/questions/36881826/what-are-functional-interfaces-used-for-in-java-8](https://stackoverflow.com/questions/36881826/what-are-functional-interfaces-used-for-in-java-8)