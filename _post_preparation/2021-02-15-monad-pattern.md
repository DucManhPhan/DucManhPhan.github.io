---
layout: post
title: Monad Pattern
bigimg: /img/image-header/yourself.jpeg
tags: [Functional Pattern]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Monad pattern](#solution-with-monad-pattern)
- [How Monads handle side effects](#how-monads-handle-side-effects)
- [How to implement IO Monad](#how-to-implement-io-monad)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Normally, in functional programming, we want our methods as the pure functions. It means that we need to abide by some rules:
- No mutation of variables such as its arguments, external variables.
- Use the external systems such as file system, database, logging, ...
- Its return value is the same when receiving the same input.
- The result of the pure functions depends only on its argurments.

So how we can remove side effects in our methods?

<br>

## Solution with Monad pattern

1. Introduction to Monad

    A simple definition of a Monad is that it is a computational context in which functions can be safely executed.

    This computational context gives us a way to put a value inside of it and a way to apply a function to that value within the context. In more formal words, a monad is:
    - parameterized type **M\<T\>**
    - it has a function called **Unit** to put a value inside of it

        ```java
        T -> M<T>
        ```

    - it has another function **bind()** to apply a function to transform the value

        ```java
        M<T> bind T -> M<U> = M<U>
        ```

    For example:
    - Optional can be considered a monad because:

        - It's a parameterized type: **Optional\<T\>**
        - Its **of()** method represents the **Unit** function
        - **flatMap()** method represents the **bind()** function

            **flatMap()** method returns the value in a container, in this case, an Optional, as the **bind()** function requires it, unlike map that returns the plain value. However, **map()** is such a useful function that in most cases, it's also included in monads.

            In any cases, **bind()**, or **flatMap()**, if we prefer, is an important function because it allows us to chain monads together, transforming the values they contain.

2. Law of Monads

    - Associativity law

        It says that the order in which different functions, let's say f and g can be composed, should not affect the outcome. This is not related to the order of execution. It is related to how the functions are grouped.

        ```java
        Monad.of(value)
             .flatMap(f)
             .flatMap(g)
             .equals(Monad.flatMap(x -> f.apply(x).flatMap(g)));
        ```

    - Left Identity law

        This law says that the value contained in a monad can be transformed within the monad. That is the same as applying a function to a value and then place it into a monad.

        ```java
        Monad.of(value)
             .flatMap(f)
             .equals(f.apply(value));
        ```

    - Right Identity law

        This law says that composing the unit function with flatMap doesn't change the value returned by the unit function.

        ```java
        Monad.of(value)
             .flatMap(x -> Monad.of(x))
             .equals(Monad.of(x));
        ```

3. Some types of Monad

    In Java, there are three types can be considered monads.
    - **Optional** to deal with the absence of values
    - **CompletableFuture** for asynchronous operations
    - **Stream** for collections

<br>

## How Monads handle side effects

We know that:
- Effect is anything that can be observed from outside the program by a user or another program.
- A side effect is anything besides the value returned by the function, that is observed from outside the function.

Pure functions does not have side effects, so the first step towards handling side effects is to make the effect the only result of the function. However, an effect can still violate referential transparency, an important principle of pure functions.

For example:

```java
String x = read();
```

The read() function will get input from the keyboard. It's an impure function because it can return a different result every time it's called, depending on what the user enters. So how do we make effects like input and output, or I/O operations functional?

The answer is we don't because there's no way to do it. However, the way functional languages handle this problem is by clearly separating the part of the program that is pure and the part of the program is impure. By using laziness and monads, we can handle the impure part as if it were pure.

Back to the above example, what if the call to this **read()** function, instead of getting a value from the keyboard, returns a lazy functions that will read from the keyboard.

```java
public interface Effect {
    void run();
}

Effect x = read();
```

This will honor the principle of referential transparency because when called with the same argument, the function will always return the same effect. And what if effect were a monad? For example, if we have two functions, one that reads from the keyboard, and one that writes something to the console, using the Effect Mondad, we could bind or combine these functins to create another monad that executes both as if it were a program. This will follow the principles of functional programming because no effect happens until the program is run.

```java
Effect program = Effect.of(() -> read())
                       .flatMap(x -> write(x));
program.run();
```

So instead of directly executing a side effect, we'll return a lazy function that when executed, will produce the side effect. This gives us purity via laziness because nothing happens, we don't have side effect. The lazy function is treated as a value, honoring referential transparency if we always return the same lazy function given the same arguments. We can use Monads to compose side effects and create a program. This will not make the lazy function pure, but it will allow us to handle side effects functionally and keep the rest of the application pure.

<br>

## How to implement IO Monad

```java
public class IO<A> {
    private final Effect<A> effect;

    private IO(Effect<A> effect) {
        this.effect = effect;
    }

    public A unsafeRun() {
        return this.effect.run();
    }

    public static <T> IO<T> apply(Effect<T> effect) {
        return new IO<>(effect);
    }

    public <B> IO<B> flatMap(Function<A, IO<B>> function) {
        return IO.apply(() -> function.apply(effect.run()).unsafeRun());
    }

    public <B> IO<B> mapToVoid(Function<A, B> function) {
        return this.flatMap(result -> IO.apply(() -> function.apply(result)));
    }

    public IO<Void> map(Consumer<A> consumer) {
        return this.flatMap(result -> IO.apply(() -> {
            consumer.accept(result);
            return null;
        }));
    }
}

public static void main() {
    IO.apply(() -> "Hello, world!")
      .mapToVoid(String::toUpperCase)
      .map(System.out::println)
      .unsafeRun();
}
```

<br>

## Source code

Supposed that we have the code in the imperative style.

```java
public static String trim(String s) {
    return s.trim();
}

public static String upperCase(String s) {
    return s.toUpperCase();
}

public static String exclamation(String s) {
    return s + "!";
}

public static String format(String s) {
    String s1 = trim(s);
    String s2 = upperCase(s1);
    String s3 = exclamation(s2);
    return s3;
}

public static String format2(String s) {
    return exclamation(upperCase(trim(s)));
}
```

1. Using Optional class

    ```java
    public static Optional<String> trim(String s) {
        return Optional.of(s.trim());
    }

    public static Optional<String> upperCase(String s) {
        return Optional.of(s.toUpperCase());
    }

    public static Optional<String> exclamation(String s) {
        return Optinal.of(s + "!");
    }

    public static Optional<String> format(String s) {
        return Optional.of(s)
                       .flatMap(n -> trim(n))
                       .flatMap(n -> upperCase(n))
                       .flatMap(n -> exclamation(n))
    }
    ```


2. Using Stream class

    ```java
    public static Stream<String> trim(String s) {
        return Stream.of(s.trim());
    }

    public static Stream<String> upperCase(String s) {
        return Stream.of(s.toUpperCase());
    }

    public static Stream<String> exclamation(String s) {
        return Stream.of(s + "!");
    }

    public static String format(String s) {
        return Stream.of(s)
                     .flatMap(n -> trim(n))
                     .flatMap(n -> upperCase(n))
                     .flatMap(n -> exclamation(n))
    }

    public static void main(String[] args) {
        format("world").forEach(System.out::println);
    }
    ```

3. Using CompletableFuture class

    ```java
    public static CompletableFuture<String> trim(String s) {
        return CompletableFuture.completedFuture(s.trim());
    }

    public static CompletableFuture<String> upperCase(String s) {
        return CompletableFuture.completedFuture(s.toUpperCase());
    }

    public static CompletableFuture<String> exclamation(String s) {
        return CompletableFuture.completedFuture(s + "!");
    }

    public static CompletableFuture<String> format(String s) {
        return CompletableFuture.completedFuture(s)
                                .thenCompose(n -> trim(n))
                                .thenCompose(n -> upperCase(n))
                                .thenCompose(n -> exclamation(n))
    }

    public static void main(String[] args) {
        format("world").thenAccept(System.out::println);
    }
    ```


<br>

## Benefits and Drawbacks

1. Benefits

    - Using Monad pattern to makes our code become referential transparency because it reduces side effects by using laziness concept.

    - concise code

2. Drawbacks

    - Java doesn't support completely Monad pattern in the part of functional programming in JDK.

<br>

## Wrapping up

- Monad allows us to capture a value in a context with the Unit() function and compose different functions with the bind() function.

- With I/O operations, Monads use laziness concept to handle these side effects.

<br>

Refer:

[https://nunoalexandre.com/2016/10/13/the-monad-pattern](https://nunoalexandre.com/2016/10/13/the-monad-pattern)

[https://medium.com/thg-tech-blog/monad-design-pattern-in-java-3391d4095b3f](https://medium.com/thg-tech-blog/monad-design-pattern-in-java-3391d4095b3f)

[https://youtu.be/MlZCiiKGbb0](https://youtu.be/MlZCiiKGbb0)

[https://youtu.be/ZhuHCtR3xq8](https://youtu.be/ZhuHCtR3xq8)

[https://github.com/siy/reactive-toolbox](https://github.com/siy/reactive-toolbox)

[https://www.youtube.com/watch?v=OSuu8zBBNAA&t=2500s](https://www.youtube.com/watch?v=OSuu8zBBNAA&t=2500s)

[https://www.youtube.com/watch?v=0if71HOyVjY&t=1722s](https://www.youtube.com/watch?v=0if71HOyVjY&t=1722s)

[https://apocalisp.wordpress.com/2011/07/01/monads-are-dominoes/](https://apocalisp.wordpress.com/2011/07/01/monads-are-dominoes/)

[https://apocalisp.wordpress.com/2011/03/20/towards-an-effect-system-in-scala-part-1/](https://apocalisp.wordpress.com/2011/03/20/towards-an-effect-system-in-scala-part-1/)

<br>

**IO Monad**

[https://medium.com/@willymyfriend/java-io-monad-reality-or-fiction-5ae9078c9b44](https://medium.com/@willymyfriend/java-io-monad-reality-or-fiction-5ae9078c9b44)

[https://apocalisp.wordpress.com/2011/12/19/towards-an-effect-system-in-scala-part-2-io-monad/](https://apocalisp.wordpress.com/2011/12/19/towards-an-effect-system-in-scala-part-2-io-monad/)

[https://sergiy-yevtushenko.medium.com/beautiful-world-of-mondas-e0801905fe02](https://sergiy-yevtushenko.medium.com/beautiful-world-of-mondas-e0801905fe02)

[Applying Functional Programming Techniques in Java by Esteban Herrera](https://app.pluralsight.com/library/courses/applying-functional-programming-techniques-java/table-of-contents)