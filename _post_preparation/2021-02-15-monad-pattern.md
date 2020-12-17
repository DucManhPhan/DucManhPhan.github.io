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
- [Source code](#source-code)
- [When to use](#when-to-use)
- [Wrapping up](#wrapping-up)

<br>

## Given problem






<br>

## Solution with Monad pattern

1. Introduction to Monad

    According to [wikipedia.com](https://en.wikipedia.org/wiki/Monad_(functional_programming)), we have the definition of Monad.

    ```
    In functional programming, a monad is an abstraction that allows structuring programming generically. Supporting languages may use monads to abstract away boilerplate code needed by the program logic. Monads achieve this by providing their own data type (a particular type for each type of monad), which represents a specific form of computation, along with one procedure to wrap values of any basic type within the monad (yielding a monadic value) and another to compose functions that output monadic values (called monadic functions).
    ```

    From the above definition, we can conclude some essential points:
    - Creating its own data type (usually called as monadic value) to wrap a value.

        For example, in Java, we can have some classes that use Monad pattern.
        - Optional class

            ```java
            String str = "hello, world!";
            Optional<String> optStr = Optional.of(str);
            ```

        - List class

            ```java
            List ints = List.of(1, 2, 3);
            ```

    - Providing a composition function to unwrap monadic value to the other monadic value.

        A composition function is a function that accepts the other functions as arguments.



2. 


3. Some types of Monad


<br>

## Source code





<br>

## When to use




<br>

## Benefits and Drawbacks

1. Benefits



2. Drawbacks



<br>

## Wrapping up




<br>

Refer:

[https://nunoalexandre.com/2016/10/13/the-monad-pattern](https://nunoalexandre.com/2016/10/13/the-monad-pattern)

[https://medium.com/thg-tech-blog/monad-design-pattern-in-java-3391d4095b3f](https://medium.com/thg-tech-blog/monad-design-pattern-in-java-3391d4095b3f)

[https://youtu.be/MlZCiiKGbb0](https://youtu.be/MlZCiiKGbb0)

[https://youtu.be/ZhuHCtR3xq8](https://youtu.be/ZhuHCtR3xq8)

[https://medium.com/@willymyfriend/java-io-monad-reality-or-fiction-5ae9078c9b44](https://medium.com/@willymyfriend/java-io-monad-reality-or-fiction-5ae9078c9b44)

[https://www.youtube.com/watch?v=OSuu8zBBNAA&t=2500s](https://www.youtube.com/watch?v=OSuu8zBBNAA&t=2500s)

[https://www.youtube.com/watch?v=0if71HOyVjY&t=1722s](https://www.youtube.com/watch?v=0if71HOyVjY&t=1722s)