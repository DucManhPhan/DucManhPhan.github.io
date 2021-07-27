---
layout: post
title: How to use interface in Java 8
bigimg: /img/path.jpg
tags: [Java]
---



<br>

## Table of contents
- [Introduction to Interface](#introduction-to-interface)
- [Define fields in Interface](#define-fields-in-interface)
- [Default methods](#default-methods)
- [Static methods](#static-methods)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to Interface

Interfaces are the contracts that we want other classes to implement. With interface, we can avoid dead diamon problem in multiple inheritance that happens in C++, ...

Belows are some default properties of interface:
- All the members (methods and fields) of an interface are public.

- All the methods in an interface are public and abstract (except static and default).

- All the fields of an interface are public, static and, final by default.

In Java 8, the interfaces define additional default methods and static methods.

In Java 9, interfaces were allowed to have private methods. Private methods are useful to call from default methods.

In Java 9, interfaces can also have private static methods. Since the static method of an interface can be called without creation of an implementing object, these methods can only be called by public static methods defined in the interface.


<br>

## Define fields in Interface

In Java 8, we can define fields in interface that are ```public static final``` by default. But we can find that it is not good practice because the interface is only used to define its behaviors that will show to the outside.

To solve this problem, we need to use Enum type.

For example, we have:

```java
public interface DayOfWeek {

    int monday = 0;

    int tuesday = 1;

    // ...
}
```

How to use:
- If a constant is common to all classes which implement an interface, it should be defined as a field in the interface.

<br>

## Default methods

1. Definition of default methods

    The default methods are the methods with **default** keyword that are defined in interface with implementation. The default methods can be called as defender methods.

    A default method is an implementation provided by the interface that does not have to be overriden by an implementing class. Default methods help in the compilation of legacy code.

    ```java
    public interface IDoSomething {
        default void display(String str) {
            System.out.println("Content of it: " + str);
        }
    }
    ```

2. Why we need default methods in interface



    When we use default methods, they makes us add new methods to the interface without breaking their existing implementation.


3. Problem of default methods

    


With default methods in Interface, we have a rule for it:
- Do not use default methods until you really need to provide a default implementation for a method. Default methods are commonly useful in extending the functionality of an existing interface.

- Do not use default methods instead of ordinary instance methods because interfaces with default methods are open for dead diamond problem. If you really need to use both abstract and non-abstract instance methods use the abstract class not the interface.

<br>

## Static methods

1. Definition of static methods

    A static method has a single instance associated with the interface. A static method can be called without creation of an object.

2. Why we need static methods in interface




3. Problem of static method




With static methods in Interface, we have a rule for it:
- Do not use static methods in an interface until that method is a utility method.

<br>

## Wrapping up







<br>

Refer:

[https://docs.oracle.com/javase/tutorial/java/IandI/defaultmethods.html](https://docs.oracle.com/javase/tutorial/java/IandI/defaultmethods.html)

[https://www.javahelps.com/2015/02/introduction-to-interface-with-java-8.html](https://www.javahelps.com/2015/02/introduction-to-interface-with-java-8.html)

[https://www.journaldev.com/2752/java-8-interface-changes-static-method-default-method](https://www.journaldev.com/2752/java-8-interface-changes-static-method-default-method)

[https://dzone.com/articles/interface-default-methods-java](https://dzone.com/articles/interface-default-methods-java)