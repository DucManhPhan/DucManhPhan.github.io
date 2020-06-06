---
layout: post
title: Refactoring conditional complexity
bigimg: /img/path.jpg
tags: [Refactoring]
---



<br>

## Table of contents





<br>

## Given problem

Conditional code is typically expressed in two ways, either with an if/else block or a switch statement.

For example:

```java
if (condition1) {
    // do something
} else if (condition2) {
    // do something
} else {
    // do something
}

switch (value) {
    case v1: 
    case v2:
    default:
}
```

Normally conditional code is not bad in itself and it is a part of language's syntaxes. But it breaks Open-Closed Principle.

**If our conditional code is simple and short, we do not need to refactor it**. But problems start happening when such branch in code grows into a huge mess that nobody want to touch it.

For example:

```java
if (condition1) {
    if (condition3 && condition4) {
        if (condition5) {
            // do something
        }
    }
} else if (condition2) {
    if (!condition6) {
        switch (val) { ... }
    }
}
```

It's fragile and complex, it means that it's difficult to understand and that's easy to break, so refactoring of such statements should happen when they start to grow.

<br>

## Solution for refactoring conditional code

Belows are some solutions to refactor our code.
- Reduce level of code nestedness
- Replace conditional with polymorphism
- Strategy pattern
- Using functional programming

To understand deeper each solution, we will implement it.

<br>

## Reducing nested code

In order to reduce the amount of nested code in if/else statement, we can:
1. Use a guard clause

    For example:

    ```java
    if (val1 != null) {
        if (val2 != null) {
            if (val3 != null) {
                // do something
            }
        }
    }

    throw new SomeException("...");
    ```

    Using a guard clause, we will apply fail-fast for these conditions.

    ```java
    if (val1 == null || val2 == null || val3 == null) {
        throw new SomeException("...");
    }
    ```

    It might not reduce the number of checks, but it reduces the depth of our code.

2. Extract conditional

    If we have multiple checks, we can take that condition and wrap it into a seperate function or method with a descriptive name,

    For example:

    ```java
    Integer val = ...;
    if (val == null && val < 0) {
        throw new SomeException("...");
    }
    ```

    Then squeeze that condition into a method, we have:

    ```java
    Integer val = ...;
    if (check(val)) {
        throw new SomeException("...");
    }

    boolean check(Integer val) {
        // do something
    }
    ```

3. Use Java 8 Stream

    For example:

    ```java
    public static List<String> extractDefinitions(String json) {
        List<String> defs = new ArrayList<>();

        for (String line : json.split("\\n")) {
            if (line.contains("definition") && line.substring(line.lastIndexOf(":") + 3).trim().length() > 3) {
                String def = line.substring(line.lastIndexOf(":") + 3, line.length() - 2);
                defs.add(def);
            }
        }

        return defs.isEmpty() ? List.of("Nothing found") : defs;
    }
    ```

    We can find that this case has several nested levels. So, we will use **Stream** to refactor it.

    ```java
    public static List<String> extractDefinitions(String json) {
        Predicate<String> nonEmptyDefinition = line -> line.contains("definition") &&
                                                       line.substring(line.lastIndexOf(":") + 3).trim().length() > 3;

        Function<String, String> extractDefinition = line -> line.substring(line.lastIndexOf(":") + 3, line.length() - 2);

        List<String> defs = stream(json.split("\\n"))
                                    .filter(nonEmptyDefinition)
                                    .map(extractDefinition)
                                    .collect(toList());

        return defs.isEmpty() ? List.of("Nothing found") : defs;
    }
    ```

<br>

## Wrapping up







<br>

Refer:

[https://www.softwaretestingclass.com/assertions-in-jmeter-jmeter-tutorials-series-day-7/](https://www.softwaretestingclass.com/assertions-in-jmeter-jmeter-tutorials-series-day-7/)

[https://www.guru99.com/assertions-in-jmeter.html](https://www.guru99.com/assertions-in-jmeter.html)