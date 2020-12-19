---
layout: post
title: Some important concepts in Functional Programming
bigimg: /img/image-header/yourself.jpeg
tags: [Functional Programming]
---




<br>

## Table of contents





<br>

## Given problem






<br>

## Introduction to Functional Programming

In functional programming, there are a set of techniques that we need to know:
- First-class functions
- Anonymous functions
- Closures
- Currying
- Lazy evaluation
- Parametric polymorphism
- Algebraic data types




<br>

## Referential transparency concept

1. Introduction to Referential Transparency
    This concept means that when we pass an argument with multiple times to a function, we will always receive the same output.

    For example:

    ```java
    public static int increment(int val) {
        return val + 1;
    }
    ```

    From the above a method, **increment()** method will always have the output = 4 when passing an argument = 3.

    **Referential transparency** concept is as same as the **Idempotency** concept in HTTP.

2. Comparisons with Object-oriented programming

    Assuming that there is a case in OOP.

    ```java
    public class Student {
        private int score;

        /**
         * Receive reward score by taking part in activities in a university
         */
        public void receiveBonusScore(int reward) {
            this.score += reward;
        }

        public int getScore() {
            return this.score;
        }
    }
    ```

    After each time we call the **bonusScore()** method with the same input, then calling **getScore()** method will display the different results. It satisfied some properties of OOP such as encapsulation, abstraction.

    But with functional programming, it doesn't. Because it can be right for pure function - Single Responsibility Principle, but this **receiveBonusScore()** method does not depend on only its input, it's utilizing the **score** field, and change this field. And the **receiveBonusScore()** method returns void, so this method still violates the way that functional programming's construction - built by composing functions that take an argument and return a value. Returning void type means that we do not take advantage of chaining between compose methods with pipeline way.

    Continuously, the **receiveBonusScore()** method is still illegal with referential transparency because each the same input, our **score** field's value will increment, it doesn't return the same output. To make this method works with referential transparency, use **immutable object pattern**.

    To refactor the above code into functional programming, we have:

    ```java
    /**
     * Use lombok library
     */
    public class Student {
        @Getter
        private int score;

        public Student(int score) {
            this.score = score;
        }
    } 

    public class CalculationStudent {
        public static Student receiveBonusScore(Student student, int reward) {
            return new Student(student.getScore() + reward);
        }
    }
    ```

3. Benefits and drawbacks:

    - Benefits

        - Using referential transparency concept makes our code highly deterministic because it doesn't change the output implicitly.
        - Based on referential transparency, a language optimizer would do well to simply cache the result, rather than perform the calculation, to save time.
        - It does not have side effect, then less bug, easy to maintain and testign.
        - It allows the programmer and the compiler to reason about program behavior. This can help in proving correctness, simplifying an algorithm, assisting in modifying code without breaking it, or optimizing code by means of memoization, common subexpression elimination, lazy evaluation, or parallelization.

    - Drawbacks

        - It can always make a new instance, so it takes so much memory if we don't use it suitable.

4. Some types of side effect without referential transparency

    - I/O side effect

        - Input

            Supposed that when we have a question to ask a user such as *What's your name?* in multiple times. Normally, we can receive multiple answers depends on user. It means that it produces a different result with each call is a side effect.

        - Output

            When a function makes a query to the user by outputing text to the console, it has changed the state of the system. The state is permanently changed because returning the system to its previous state is not possible. Even removing the characters would mean making a subsequent change.

        And to implement I/O functionality, many languages provide I/O in the separated threads to improve the throughput of the system. The act of creating a thread changes the system state. So, it is another type of side effect. Using the thread need us to take care about the system's incapability to support the thread or knowing whether any other problems arose with the thread, and the communication between threads.

    - Unintetional side effect

        For example:

        ```java
        public int add(int a, int b) {
            return a + b;
        }
        ```

        Take the first glance at the above code, we don't see something strange. But it can be caused overflow when the sum of a and b is greater than the value of the integer's maximum.

        So, it will change the state of the system, then it is unintentional side effect.

    - Intentional side effect

        For example:

        ```java
        public void divide(int a, int b) {
            return a/b;
        }
        ```

        With the division between two integers, we need to take care about the divided integer, it can have value is equal to zero. So, an exception will be thrown.

        It is intentional side effect.

<br>

## Substitution model concept




<br>

## Wrapping up




<br>

Refer:

[Functional Programming fro Dummies ebook]()

[http://blog.higher-order.com/blog/2012/09/13/what-purity-is-and-isnt/](http://blog.higher-order.com/blog/2012/09/13/what-purity-is-and-isnt/)

[https://apocalisp.wordpress.com/2008/06/18/parallel-strategies-and-the-callable-monad/](https://apocalisp.wordpress.com/2008/06/18/parallel-strategies-and-the-callable-monad/)

[https://medium.com/@sderosiaux/why-referential-transparency-matters-7c179424dab5](https://medium.com/@sderosiaux/why-referential-transparency-matters-7c179424dab5)

[https://www.sitepoint.com/what-is-referential-transparency/](https://www.sitepoint.com/what-is-referential-transparency/)

[https://sookocheff.com/post/fp/why-functional-programming/](https://sookocheff.com/post/fp/why-functional-programming/)