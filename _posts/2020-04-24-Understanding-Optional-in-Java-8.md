---
layout: post
title: Understanding Optional in Java 8
bigimg: /img/image-header/california.jpg
tags: [Functional Programming]
---

In this article, we will learn how to use Optional functionality in Java 8. Let's get started.

<br>

## Table of contents
- [Why do we need to use Optional in Java](#why-do-we-need-to-use-optional-in-java)
- [Introduction to Optional concept](#introduction-to-optional-concept)
- [How to use Optional right way](#how-to-use-optional-right-way)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Why do we need to use Optional in Java

In Java, all instances are the reference types, except primitive types such as int, long, boolean, ... So, in our methods, with reference types, we need to check null before calling something in it. Because if we use an instance has null value, **NullPointerException** are Runtime exceptions which are thrown by the JVM at the runtime.

For example:

```java
public void display(List<Person> persons) {
    if (persons == null) {
        throw new IllegalArgumentException("The list of person is null");
    }

    // do something
}
```

The implementation with check null value for reference types creates boilerplate code. It makes our code annoyed because we do not concentrate on the business logic in our methods.

So, how do we deal with this problem?

<br>

## Introduction to Optional concept

**Optional** is a concept that is introduced in Java 8 based on the idea of functional programming. Internally, **Optional** is a class with generic type that wraps our real object and it provides multiple useful methods that we need to solve null check.

Next, we will go into the definition of **Optional** class.

```java
// since Java 8
public final class Optional<T> {
    private static final Optional<?> EMPTY = new Optional<>();
    private final T value;

    private Optional() {
        this.value = null;
    }

    private Optional(T value) {
        this.value = Objects.requireNonNull(value);
    }
    
    public static<T> Optional<T> empty() {
        @SuppressWarnings("unchecked")
        Optional<T> t = (Optional<T>) EMPTY;
        return t;
    }

    public static <T> Optional<T> of(T value) {
        return new Optional<>(value);
    }

    public static <T> Optional<T> ofNullable(T value) {
        return value == null ? empty() : of(value);
    }

    public T get() {
        if (value == null) {
            throw new NoSuchElementException("No value present");
        }
        return value;
    }

    public boolean isPresent() {
        return value != null;
    }

    public boolean isEmpty() {
        return value == null;
    }

    public void ifPresent(Consumer<? super T> action) {
        if (value != null) {
            action.accept(value);
        }
    }

    // since Java 9
    public void ifPresentOrElse(Consumer<? super T> action, Runnable emptyAction) {
        if (value != null) {
            action.accept(value);
        } else {
            emptyAction.run();
        }
    }

    public Optional<T> filter(Predicate<? super T> predicate) {
        Objects.requireNonNull(predicate);
        if (!isPresent()) {
            return this;
        } else {
            return predicate.test(value) ? this : empty();
        }
    }

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

    // since Java 9
    public Optional<T> or(Supplier<? extends Optional<? extends T>> supplier) {
        Objects.requireNonNull(supplier);
        if (isPresent()) {
            return this;
        } else {
            @SuppressWarnings("unchecked")
            Optional<T> r = (Optional<T>) supplier.get();
            return Objects.requireNonNull(r);
        }
    }

    // since Java 9
    public Stream<T> stream() {
        if (!isPresent()) {
            return Stream.empty();
        } else {
            return Stream.of(value);
        }
    }

    public T orElse(T other) {
        return value != null ? value : other;
    }

    public T orElseGet(Supplier<? extends T> supplier) {
        return value != null ? value : supplier.get();
    }

    // since Java 10
    public T orElseThrow() {
        if (value == null) {
            throw new NoSuchElementException("No value present");
        }
        return value;
    }

    public <X extends Throwable> T orElseThrow(Supplier<? extends X> exceptionSupplier) throws X {
        if (value != null) {
            return value;
        } else {
            throw exceptionSupplier.get();
        }
    }
}
```

Take a closer look at Optional class's definition, we can understand how **Optional**'s methods is implemented and how to use it correctly.

Some methods are added to Optional in JDK's versions:
- Java 9 - **or()**, **ifPresentOrElse()**, **stream()**
- Java 10 - **orElseThrow()**
- Java 11 - **isEmpty()**


<br>

## How to use Optional right way
1. Use **of()** static method

    If we use **of()** method with null value, it will throw **NullPointerException**. So, the solution for it is to utilize **ofNullable()** method.

    ```java
    String probablyNullValue = null;
    Optional<String> optString = Optional.ofNullable(probablyNullValue);
    ```

2. Use **isPresent()** method

    If we check whether our instances of Optional class have value or not, we usually use **isPresent()** method and **get()** method, but we can find that it is as same as with checking null for these instances. It means that it also creates boilerplate code.

    So, our solution is to use **ifPresent()** method or **ifPresentOrElse()** method that accept **Consumer** functional interface to overcome it.

    ```java
    public void displayContent(Optional<String> optContent) {
        // 1st way - use ifPresent() method
        // optContent.ifPresent(content -> System.out.println("The value of core is: " + content));

        // 2nd way - use ifPresentOrElse() method
        optContent.ifPresentOrElse(content -> System.out.println("The value of core is: " + content),
                             () -> System.out.println("Do not contain value."))
    }
    ```

3. Use **orElse()** method

    If we want to get value of **Optional** instance, normally, we will choose **get()** method, but when it has null value, **get()** method will throw **NoSuchElementException**.

    To deal with this problem, we can use **orElse()** method.

    ```java
    public void displayContent(Optional<String> optContent) {
        System.out.println("The content is: " + optContent.orElse("No exist content"));
    }
    ```

<br>

## Lift method - lacked method of Optional type

Lifting is a concept that allows us to transform a function of plain types to a function of the same types wrapped in a container type.

For example:

```java
public static <T, U> Function<Optional<T>, Optional<U>> lift(Function<T, U> f) {
    return optional -> optional.map(f);
}

public static <T, U> Function<T, Optional<U>> liftOne(Function<T, U> f) {
    return val -> {
        try {
            return Optional.ofNullable(val).map(f);
        } catch(Exception ex) {
            return Optional.empty();
        }
    };
}

public static void main(String[] args) {
    Function<Integer, Integer> doubler = x -> x * 2;
    Function<Optional<Integer>, Optional<Integer>> doublerOptional = lift(doubler);

    System.out.println(doublerOptional.apply(Optional.of(1)));
    System.out.println(doublerOptional.apply(Optional.empty()));

    Function<Integer, Optional<Integer>> doublerOptional2 = liftOne(doubler);

    System.out.println(doublerOptional2.apply(2));
    System.out.println(doublerOptional2.apply(null));
}
```
<br>

## Benefits and Drawbacks
1. Benefits

    - Do not check null -> reduce boilerplate code
    - Our code makes concise and easy to understand.


2. Drawbacks

    - If we do not use Optional correctly, we still create boilerplate code such as using **isPresent()** method.
    - Beside Optional class to validate our code, we can use some other libraries to deal with it such as Objects class in JDK, guava libraries.
    - Optional can make our code harder to read because it makes our code more verbose.

        - Types: **Optional<Book>** and **Book**
        - Checking: **opt.isPresent()** and **obj != null**

    - Optional can convert a NullPointerException into another exception that can make our application crash.

<br>

## Wrapping up

- Optional explicitly indicates the potential absence of a value. It is based on the Maybe type in functional languages. It's not a full implementation, but it has some methods that allow us to code in a declarative and functional style.

- The Optional's main methods are filter(), map(), flatMap(), and orElse(), orElseGet methods.

    - It can be useful to think of an Optional as a stream with one element.

    The best way to use Optional is through composition.
    - Always start from an Optional.
    - Apply a chain of filter, map, or flatMap methods.
    - At the end, use orElse or orElseGet to unwrap the value.

- Don't use Optional as a method argument. It's not necessary. However, one of the biggest limitations of the Optional and Maybe types is that they cannot hold information about errors.

<br>

Refer:

[https://dzone.com/articles/functional-programming-in-java-8-part-2-optionals?fromrel=true](https://dzone.com/articles/functional-programming-in-java-8-part-2-optionals?fromrel=true)

[Applying Functional Programming Techniques in Java by Esteban Herrera](https://app.pluralsight.com/library/courses/applying-functional-programming-techniques-java/table-of-contents)