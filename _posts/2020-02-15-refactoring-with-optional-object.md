---
layout: post
title: Refactoring with Optional Object
bigimg: /img/image-header/yourself.jpeg
tags: [Refactoring]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using Null Object Pattern](#using-null-object-pattern)
- [Using Optional Object in Java 8](#using-optional-object-in-java-8)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Assuming that we have a simple example about checking null object.

```java
private void display(String value) {
    String printout = value == null ? "Nothing to show ..."
                                    : value.toUpperCase();
    System.out.println(printout);
}

public void run() {
    this.display(null);
    this.display("Something");
    this.display("Hello, world!");
}
```

How can we remove our branches that we need to check null value?


<br>

## Using Null Object Pattern

Belows are some steps that we need to follow.
1. Define an abstract class **MayBeString**

    ```java
    public abstract class MayBeString {
        public abstract MayBeString toUpperCase();

        public abstract String orElse(String substitute);
    }
    ```

2. Define an inherited **Some** class

    ```java
    public class Some extends MayBeString {
        private String content;

        public Some(String content) {
            this.content = content;
        }

        @Override
        public MayBeString toUpperCase() {
            return new Some(this.content.toUpperCase());
        }

        @Override
        public String orElse(String substitute) {
            return this.content;
        }
    }
    ```

3. Define an inherited **None** class

    ```java
    public class None extends MayBeString {
        public None() {}


        @Override
        public MayBeString toUpperCase() {
            return this;
        }

        @Override
        public String orElse(String substitute) {
            return substitute;
        }
    }
    ```

4. Final Result

    ```java
    private void display(MayBeString value) {
        MayBeString upperCase = value.toUpperCase();
        String printout = upperCase.orElse("Nothing to show...");
        System.out.println(printout);
    }

    public void run() {
        this.display(new None());
        this.display(new Some("Something"));
        this.display(new Some("Hello world!"));
    }
    ```

<br>

## Using Optional Object in Java 8

Assuming that in **MayBeString** class, we want to perform other operations like turning the string to lowercase, or appending, or calculating a substring.

```java
public abstract class MayBeString {
    public abstract MayBeString toUpperCase();

    public abstract MayBeString toLowerCase();

    public abstract MayBeString append(String suffix);

    public abstract MayBeString substring(int start, int length);

    public abstract String orElse(String substitute);
}
```

So, why not condense all of them into a single **map()** method, which receives a transformation? It means that we have:

```java
public abstract class MayBeString {
    public abstract MayBeString map(Function<String, String> transform);
    public abstract String orElse(String substitute);
}
```

But if we want to access the raw content, we need to import some supported methods for it.

```java
public abstract class MayBeString {
    public abstract MayBeString map(Function<String, String> transform);
    public abstract String orElse(String substitute);
    public abstract boolean isPresent();
    public abstract String get();
```

Then, in **Some**, **None** classes, we have:

```java
public class Some extends MayBeString {
    // ...

    @Override
    public MayBeString map(Function<String, String> transform) {
        return new Some(transform.apply(this.content));
    }

    @Override
    public boolean isPresent() {
        return true;
    }

    @Override
    public String get() {
        return this.content;
    }
}

public class None extends MayBeString {
    // ...

    @Override
    public MayBeString map(Function<String, String> transform) {
        return this;
    }

    @Override
    public boolean isPresent() {
        return false;
    }

    @Override
    public String get() {
        // bad deign --> violate Liskov Substitution Principle
        // design flaw in the interface
        throw new IllegalStateException();
    }
}

private void display(MayBeString value) {
    // this code uses branching around null.
    if (value.isPresent()) {
        System.out.println(value.get().toUpperCase());
    } else {
        System.out.println("Nothing to show ...");
    }
}
```

Then, our **None** class will not be able to implement the **get()** method. There is no way to get the content, because there is none. This subclass can only fail. Design based on **isPresent()** and **get()** methods is not consistent. In Java, our classes should never allow a call which is bound to fail.

To remove the utilization of **isPresent()**, **get()** methods, we will use the below way:

```java
private void display(MayBeString value) {
    // the code is shorter, and it will never cause an exception
    System.out.println(value.map(String::toUpperCase).orElse("Nothing to show ..."));
}
```

Now, we will use generic for our MyBeString class for the other types.

```java
public class MayBe<T> {
    public abstract <TResult> MayBe<TResult> map(Function<T, TResult> transform);
    public abstract <TResult> MayBe<TResult> flatMap(Function<T, MayBe<TResult>> transform);
    public abstract T orElse(T substitute);
    public abstract boolean isPresent();
    public abstract T get();
}

public class Some<T> extends MayBe<T> {
    private T content;

    public Some(T content) {
        this.content = content;
    }

    @Override
    public <TResult> MayBe<TResult> map(Function<T, TResult> transform) {
        return new Some(transform.apply(this.content));
    }

    @Override
    public <TResult> MayBe<TResult> flatMap(Function<T, MayBe<TResult>> transform) {
        return transform.apply(this.content);
    }

    @Override
    public T orElse(T substitute) {
        return this.content;
    }

    @Override
    public boolean isPresent() {
        return true;
    }

    @Override
    public T get() {
        return this.content;
    }
}

public class None extends MayBeString {
    public None() {}

    @Override
    public <TResult> MayBe<TResult> map(Function<T, TResult> transform) {
        return new None<TResult>();
    }

    @Override
    public <TResult> MayBe<TResult> flatMap(Function<T, MayBe<TResult>> transform) {
        return new None<TResult>();
    }

    @Override
    public T orElse(T substitute) {
        return substitute;
    }

    @Override
    public boolean isPresent() {
        return false;
    }

    @Override
    public T get() {
        throw new IllegalStateException();
    }
}

public void display(MayBe<String> value) {
    System.out.println(value.map(String::toUpperCase).orElse("Nothing to show ..."));
}
```

Look at carefully the MayBe<T> generic class, we can find that it is as same as the Optional class in Java 8. So, we can use Optional for solving our problem.

```java
public void display(Optional<String> optValue) {
    System.out.println(optValue.map(String::toUpperCase).orElse("Nothing to show ..."));
}
```

<br>

## Wrapping up

- To remove the null checking, we can use the Special Case pattern or Optional class in Java 8.

<br>

Refer:

[Making Your Java Code More Object-oriented](https://app.pluralsight.com/library/courses/object-oriented-java-code/table-of-contents)