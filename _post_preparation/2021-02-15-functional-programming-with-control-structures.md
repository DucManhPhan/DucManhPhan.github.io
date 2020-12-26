---
layout: post
title: Functional programming with Control Structures
bigimg: /img/image-header/yourself.jpeg
tags: [Functional Programming]
---




<br>

## Table of contents
- [Abstracting conditional structure](#abstracting-conditional-structure)
- [Abstracting loop structure](#abstracting-loop-structure)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Abstracting conditional structure



 


<br>

## Abstracting loop structure

1. Using recursion




    Drawbacks of recursion:
    - 
    - 
    - 

2. Tail recursion



3. Tail call optimization with Trampolines



4. Fold operation



    Foling operation with Mappng, Reducing


5. Memoization




<br>

## Benefits and Drawbacks





<br>

## Wrapping up

- For simple use cases, we can use the Stream API instead of imperative control structures.

    For more advanced use cases, we must implement our own types.

    For example, we can get inspiration from the Optional type to code conditional branches in a declarative style.

- We can replace loops with recursive functions. Be careful with stack overflow exceptions. For this reason, we should write tail-recursive functions, where the recursive call is the last line of the function.

    Tail-recursive functions use an accumulator to carry intermediate state.
    
    Non tail-recursive functions use the stack to keep intermediate state.

    Some compilers can do Tail call optimization automatically, which means that the compiler converts a tail-recursive function into a traditional loop. Java doesn't do this, so if we want to implement this optimization, we have to do it ourselves. An easy way is by using thunks and trampolines.

- Fold operations means the tail-recursive function for performing operations over collections in functional programming.

<br>

Refer:

[Applying Functional Programming Techniques in Java by Esteban Herrera](https://app.pluralsight.com/library/courses/applying-functional-programming-techniques-java/table-of-contents)