---
layout: post
title: Best practice for Optional in Java
bigimg: /img/image-header/home-office-2.jpg
tags: [Functional Programming]
---



<br>

## Table of Contents
- [Using ifPresent() or ifPresentOrElse() methods](#using-ifpresent()-or-ifPresentOrElse()-methods)
- [Using ofNullable() method](#using-ofnullable()-method)
- [Using orElse() method](#using-orelse()-method)
- [Using orElseThrow() method](#using-orElseThrow()-method)
- [Using map() method](#using-map()-method)
- [Wrapping up](#wrapping-up)


<br>

## Using ifPresent() or ifPresentOrElse() methods

1. Problem

    Normally, when we have an **Optional** variable, we need to check whether it is empty by using **isPresent()** method. If it has value, we will use **get()** method to get the real value. All operations will be described in the below code:

    ```java
    Optional<String> optName = Optional.ofNullable(null);
    if (optName.isPresent()) {
        doSomething(optName.get());
    }
    ```

2. Solution

    If we are using Optional like the above code, we can find that it is as same as when checking null value of Object variable.

    So, to reduce the boilerplate code, we can do like that.

    ```java
    optName.ifPresent(realValue -> doSomething(realValue));
    ```

    But in some cases, we can have an another action for some unsatisfied conditions, then we can use ifPresentOrElse() method. Below is a source code of ifPresentOrElse() method.

    ```java
    // since Java 9
    public void ifPresentOrElse(Consumer<? super T> action, Runnable emptyAction) {
        if (value != null) {
            action.accept(value);
        } else {
            emptyAction.run();
        }
    }
    ```

    Another sample for this case:

    ```java
    Optional<String> req = options.requires.stream()
                                           .filter(mn -> !modules.containsKey(mn))
                                           .findFirst();
    if (req.isPresent()) {
        throw new BadArgs("err.module.not.found", req.get());
    }

    // Use ifPresent() way
    options.requires.stream()
                    .filter(mn -> !modules.containsKey(mn))
                    .findFirst()
                    .ifPresent(s -> throw new BadArgs("err.module.not.found", s));
    ```

    Note about some methods that returns an **Optional**:
    - **reduce()** method

        **Stream.reduce()** is general-purpose method for generating our custom reduction operations.

        ```java
        Optional<T> reduce(BinaryOperator<T> accumlator);

        /**
         * @param: identity - the initial value of the reduction and the default result if there are no elements in the stream
         * @param : accumulator - it takes two parameters: a partial result of the reduction and the next element of the stream. It returns a new partial result.
         * 
         * @return: the result of the reduction.
         */
        T reduce(T identity, BinaryOperator<T> accumlator);
        ```

        For example:

        ```java
        // If subList() returns empty list, then reduce() method can return an empty Optional
        // So, get() method would throw a NoSuchElementException.
        String hist = replayableHistory.subList(first + 1, replayableHistory.size())
                                       .stream()
                                       .reduce((a, b) -> a + RECORD_SEPARATOR + b)
                                       .get();

        // using String.join()
        String hist = String.join(RECORD_SEPARATOR, replayableHistory.subList(first + 1, replayableHistory.size()));
        ```

<br>

## Using ofNullable() method

1. Problem

    When we want to wrap the variable, we can use of() static method to convert it to Optional variable.

    If our variable has null value, then of() static method will throw NullPointerException.

2. Solution

    To avoid that exception, we can use ofNullable() static method like the below source code.

    ```java
    String probablyNullValue = null;
    Optional<String> optString = Optional.ofNullable(probablyNullValue);
    ```

<br>

## Using orElse() method

1. Problem

    When we want to get the real value of Optional variable, we usually call **get()** method. But if the real value has null value, then it throw **NoSuchElementException**.

2. Solution

    To solve it, we need to use orElse() method. Because orElse() method will check the real value, if it is null, then it returns the default value that we pass as an argument of orElse() method.

    ```java
    public T orElse(T other) {
        return value != null ? value : other;
    }
    ```

<br>

## Using orElseThrow() method

1. Problem

    Sometimes, we encounter the problem that is to check whether the value of variable is satisfied, if no, throw an exception.

    ```java
    Optional<Configuration> oparent = cf.parent();
    if (!oparent.isPresent() || oparent.get() != this.configuration()) {
        throw new IllegalArgumentException("Parent of configuration != configuration of this layer");
    }
    ```

2.  Solution

    With an above example, we need to use isPresent() and get() method of Optional class, it has too many conditions. It makes our code difficult to read.

    ```java
    cf.parent().filter(cfg -> cfg == this.configuration()) 
               .orElseThrow(() -> new IllegalArgumentException("..."));
    ```

<br>

## Using map() method

1. Problem

    When we use Optional variable, we need to check whether it is present or not. If it exists, we convert it to other format, otherwise, we get the default value.

    ```java
    Optional<BigInteger> prime = findPrime();
    if (prime.isPresent()) {
        System.out.println("Prime is " + prime.get());
    } else {
        System.out.println("Prime not found");
    }

    // OR
    String title = "";
    Book book = service.findBookById(id);
    if (book != null) {
        title = book.getTitle();
    }
    ```

2. Solution

    Because we need to convert the real value of Optional to other value, so we can think about **Function** functional interfaces that are arguments of **map()** and **flatMap()** method of Optional like that:

    ```java
    public <U> Optional<U> map(Function<? super T, ? extends U> mapper) {
        Objects.requireNonNull(mapper);
        if (!isPresent()) {
            return empty();
        } else {
            return Optional.ofNullable(mapper.apply(value));
        }
    }

    public <U> Optional<U> flatMap(Function<? super T, ? extends Optional<? extends U>> mapper) {
        Objects.requireNonNull(mapper);
        if (!isPresent()) {
            return empty();
        } else {
            @SuppressWarnings("unchecked")
            Optional<U> r = (Optional<U>) mapper.apply(value);
            return Objects.requireNonNull(r);
        }
    }
    ```

    Below is a solution for our above problem.

    ```java
    System.out.println(
        findPrime()
            .map(p -> "Prime is " + p)
            .orElse("Prime not found");
    );

    // OR
    String title = service.findBookById(id)
                          .map(book -> book.getTitle())
                          .orElse("");

    // If getTitle() returns an Optional, use flatMap() method
    String title = service.findBookById(id)
                          .flatMap(book -> book.getTitle())
                          .orElse("");
    ```
    
    So we have conclusions:
    - If the function returns a plain object, use map() method.
    - If the function returns an Optional, use flatMap() method.

<br>

## Using filter() method

Below is the declaration of filter() method in Optional class.

```java
Optional<T> filter(Predicate<? super T> predicate);
```

1. Problem

    ```java
    Book book = service.findBookById(id);
    if (book != null && book.getNumberOfPages() > 500) {
        System.out.println("It is a long book");
    }
    ```

2. Solution

    When we cope with some conditions for our object, we can use filter to do it.

    ```java
    service.findBookById(id)
           .filter(book -> book.getNumberOfPages() > 500)
           .ifPresent(
               book -> System.out.println("It is a long book");
           );
    ```

<br>

## Wrapping up

- We need to use Optional to reduce the check null operations. It makes our code concise, easy to read.

- Always start from an Optional.

- Apply a chain of **filter()**, **map()**, or **flatMap()** method.

- Use **orElse()**, or **orElseGet()** methods to get unwrap the value.

- Never use **Optional.get()** method unless we're sure that the Optional is not empty.

- Generally, we should not use Optional in fields.

    - The Optional class is not serializable.
    - **For truly optional fields, have a getter method returns Optional.**

- The use of Optional as a method argument is discouraged because it can cause conditional logic inside their methods.

    - Use methods of the Optional type itself.

- Do use optional as a return value.

- The best way to use Optional is through composition such as filter, map, flatMap.

    Always start from an optional, apply a chain of methods with some methods such as filter(), map(), flatMap(), and at the end, unwrap the value with orElse() or orElseGet() methods.

- Optional does not address cases such as partially-initialized objects.

<br>

Refer:

[Extream Java - Concurrency and Performance for Java 8 course]()

[https://dzone.com/articles/using-optional-correctly-is-not-optional](https://dzone.com/articles/using-optional-correctly-is-not-optional)
