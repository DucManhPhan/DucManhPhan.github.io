---
layout: post
title: How to use Generics in Java
bigimg: /img/image-header/factory.jpg
tags: [Java]
---



<br>

## Table of contents





<br>

## Given problem




<br>

## Definition of Generics

- Declarations

    - Constructors

        In a generic class, type parameters appear in the header that declares the class, but not in the constructor.

        ```Java
        class Pair<T, U> {
            private final T first;
            private final U second;

            public Pair(T first, U second) { 
                this.first = first; 
                this.second = second;    
            }

            public T getFirst() {
                return this.first;
            }

            public T getSecond() {
                return this.second;
            }
        }
        ```

        So, when invoking the constructor, we should use type parameters accompany with it. If we do not use it, it produces a warning because Pair is treated as a raw type, conversion from a raw type to the corresponding parameterized type generates an unchecked warning --> use ```-XLint:unchecked``` flag.

        ```Java
        Pair<String, Integer> pair = new Pair<String, Integer>("book", 10);
        ```

    - Static members

        The consequence is that static members of a generic class are shared across all instantiations of that class, including instantiations at different types.

        So, static members of a class can not refer to the type parameter of a generic class, and when accessing a static member the class name should not be parameterized.

<br>

## How to use subtype in Generics
- Subtyping

    - In Java, one type is a subtype of another if they are related by an ```extends``` or ```implements``` clause.
    - If one type is a subtype of another type, we can say that the second is a supertype of the first.

        Every reference type is a subtype of ```Object```, and ```Object``` is a supertype of every reference type.

    - Substitution principle

        A variable of a given type may be assigned a value of any subtype of that type, and a method with a parameter of a given type may be invoked with an argument of any subtype of that type.

        For example:

        ```Java
        List<Integer> ints = new ArrayList<Integer>();
        ints.add(1);
        ints.add(2);

        // compile-time error because List<Integer> is not a subtype of List<Number>
        // but List<Integer> is a subtype of Collection<Integer>
        // Arrays behave quite differently, Integer[] is a subtype of Number[].
        List<Number> nums = ints;       
        ```

- To solve an above problem: ```List<Integer>``` is not a subtype of ```List<Number>```, we can use ```Wildcards``` with ```extends``` keyword.

    We have method ```addAll()``` of ```Collection``` interface, 

    ```Java
    interface Collection<E> {

    }
    ```


<br>

## When to use






<br>

## The difference between generics of Java and template of C++






<br>

## 




<br>

## Wrapping up
- Generics are compiled by erasure, at run time the classes **List<Integer>**, **List<String>**, and **List<List<String>>** are implemented by a single class, namely List.
    
    So, we can check by the following code:

    ```java
    List<Integer> ints = Arrays.asList(1, 2, 3);
    List<String> strings = Arrays.asList("one", "two");
    assert ints.getClass() == strings.getClass();
    ```


<br>

Refer:

