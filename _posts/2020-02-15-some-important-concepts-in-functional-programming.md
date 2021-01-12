---
layout: post
title: Some important concepts in Functional Programming
bigimg: /img/image-header/yourself.jpeg
tags: [Functional Programming]
---




<br>

## Table of contents
- [Pure function](#pure-function)
- [Referential transparency](#referential-transparency)
- [Lazines](#laziness)
- [High-order function](#high-order-function)
- [Currying](#currying)
- [Wrapping up](#wrapping-up)


<br>

## Pure function

Pure function is the function that:
- only do one thing
- no side-effects

    It means that:
    - no mutation of variables
    - no printing to the console or to any device
    - no writing to files, databases, networks, or whatever
    - no exception handling.

- its return value is the same for the same arguments
- the result of a pure function depends on its arguments

For example:

```java
public static void square(int x) {
    return x * x;
}
```

Comparison between pure function and referential transparency:
- If a function is a pure function, then it is also referential transparency, and vice versa.

    To bear out this statement, we can refer these links about [Pure function](https://en.wikipedia.org/wiki/Pure_function) and [Referential transparency](https://en.wikipedia.org/wiki/Referential_transparency) in [wikipedia.com] website.

<br>

## Referential transparency

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

    But with functional programming, it doesn't. Because it can be right for pure function - Single Responsibility Principle, but this **receiveBonusScore()** method does not depend on only its input, it's utilizing the **score** field, and change this field. And the **receiveBonusScore()** method returns **void**, so this method still violates the way that functional programming's construction - built by composing functions that take an argument and return a value. Returning void type means that we do not take advantage of chaining between compose methods with pipeline way.

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
        - It does not have side effect, then less bug, easy to maintain and testing.
        - It does not depend on the external devices such as database, file system, or network. The only thing to take care is its arguments.
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

## Lazines

1. Introduction to Laziness concept

    Laziness is about evaluating data only when it's needed or when it's first accessed. Laziness is the opposite of strictness.

    For example, when talking about method calls, laziness means that the getString() method is called only if and when the String variable is used. Strictness means that the method is immediately called, which is what Java does because Java is mostly a strict language.

    ```java
    String s = getString();

    // ...

    String getString() {
        return "...";
    }
    ```

    However, Java is not always strict. For example, we can say that a loop is lazy if it terminates early due to some conditions.

    ```java
    for (int i = 0; ; ++i) {
        if (i > 1_000_000) break;
    }
    ```

    Sources with boolean operators can be considered lazy in some cases because they don't always evaluate both operands. Lazines is not limited to evaluating arguments, methods, or expressions. The real difference between strictness and laziness is that strictness is about doing something, while laziness is about indicating that we may do something sometime in the future.

2. Implementing Laziness

    In Java, we can implement Laziness by using functional interfaces like:
    - **Supplier** when we need to return a value sometime in the future

        ```java
        public interface Supplier<T> {
            T get();
        }
        ```

    - **Consumer** when need to execute an action taking a parameter

        ```java
        public interface Consumer<T> {
            void accept(T t);
        }
        ```

    - **Runnable** when we just need to execute an action.

        ```java
        public interface Runnable {
            void run();
        } 
        ```

    However, Runnable is for working with threads, so it is better to create an interface for Effect.

    ```java
    public interface Effect {
        void run();
    }
    ```

    For example, we can make this expression lazy by wrapping the method call into a lambda expression representing a **Supplier** of type String.

    ```java
    Supplier<String> s = () -> getString();
    ```

    When Java parses this expression, the **getString()** method is not executed. We are just indicating that the method should be called sometime in the future, when we call the method **get()** on the Supplier.

    ```java
    // 1st program
    Supplier<String> s = () -> getString();
    System.out.println(s.get());
    ```

    By the way, printing to the console is a side effect, but indicating that we should print to the console sometime in the future is not because we are returning something that will be executed later if it ever gets executed.

    ```java
    // 2nd program
    Supplier<String> s = () -> getString();
    Effect e = () -> System.out.println(s.get());
    ```

    If we execute both of these program, they won't produce the same results. The output of the second program is equivalent to the first program itself, but only if we decide to run the effect. This is the key to handle effects in functional programming.


<br>

## High-order function

To understand more about high-order function, we can refer to [How to use High-Order function technique](https://ducmanhphan.github.io/2020-07-15-how-to-use-high-order-function-technique/).

<br>

## Currying

To know more about currying, refer to [How to use currying technique](https://ducmanhphan.github.io/2020-02-10-how-to-use-currying-technique/).

<br>

## Wrapping up

- To write a functional program, we have to start by writing the various base functions we need and then combine these base functions into higher-level ones, repeating the process until we have a single function corresponding to the program that we want to build. As all these functions are referential transparent, they can then be reused to build other programs without any modifications.

<br>

Refer:

[Functional Programming in Java - How functional techniques improve ebook]()

[http://blog.higher-order.com/blog/2012/09/13/what-purity-is-and-isnt/](http://blog.higher-order.com/blog/2012/09/13/what-purity-is-and-isnt/)

[https://apocalisp.wordpress.com/2008/06/18/parallel-strategies-and-the-callable-monad/](https://apocalisp.wordpress.com/2008/06/18/parallel-strategies-and-the-callable-monad/)

[https://medium.com/@sderosiaux/why-referential-transparency-matters-7c179424dab5](https://medium.com/@sderosiaux/why-referential-transparency-matters-7c179424dab5)

[https://www.sitepoint.com/what-is-referential-transparency/](https://www.sitepoint.com/what-is-referential-transparency/)

[https://sookocheff.com/post/fp/why-functional-programming/](https://sookocheff.com/post/fp/why-functional-programming/)

<br>

**Compare between Purity and Referential transparency**

[https://stackoverflow.com/questions/4865616/purity-vs-referential-transparency](https://stackoverflow.com/questions/4865616/purity-vs-referential-transparency)

[https://levelup.gitconnected.com/pure-function-vs-referential-transparency-7192553d9d1](https://levelup.gitconnected.com/pure-function-vs-referential-transparency-7192553d9d1)