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

Supposed that we have a segment of code in the imperative style.

```java
List<Product> products = order.getProducts();
Double discount = 0.0;

for (Product p : products) {
    if (this.isGiftProduct(p)) {
        discount = p.getPrice();
        break;
    }
}
```

From the view of functional programming, we can find that:
- The above code has a side effect because it changes the value of **discount** variable.
- It's so long.
 
So, we will use functional programming to refactor it.

```java
List<Product> products = order.getProducts();
Double discount = products.stream()
                          .filter(this::isGiftProduct)
                          .map(Product::getPrice)
                          .findFirst()
                          .orElse(0.0);
```

Benefits of using functional programming for above code:
- Using high-order functions to avoid coding in the imperative style.
    
    In Java, we can use the filter() and map() methods from the String API or the ternary operator inside the map() method to implement if-else conditions.

    ```java
    Double discount = products.stream()
                          .filter(p -> this.isGiftProduct(p)
                                     ? p.getPrice() * 0.5
                                     : p.getPrice())
                          .average()
                          .orElse(0.0);
    ```

    The ternary operator returns a value depending on the conditional expression it receives, so it can be functional if it doesn't produce a side effect when returning the value.

    But how is it possible to completely remove control structures when implementing more complex?

    It turns out that the notion of deciding what to do next based on a condition can be also be expressed with functions.

    For example:

    ```java
    if (isGiftProduct(p)) {
        return p.getPrice() * 0.5;
    } else {
        return p.getPrice();
    }
    ```
    This if-else statement can be thought as two different functions of p. We just have to choose which one to call, depending on the value of the argument. The caller of the function doesn't have to make that choice directly. We can make that decision inside of the function, but instead of using an if statement, we can use a structure to abstract the decision process using a declarative style.

    ```java
    
    ```

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