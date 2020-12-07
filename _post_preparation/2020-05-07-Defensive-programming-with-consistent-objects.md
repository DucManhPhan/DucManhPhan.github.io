---
layout: post
title: Defensive programming with consistent objects
bigimg: /img/image-header/yourself.jpeg
tags: [Clean Code]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Consistent Objects](#solution-with-consistent-objects)
- [Some problems with Constructors](#some-problems-with-constructors)
- [Using Builder pattern to solve Constructors's problem](#using-builder-pattern-to-solve-constructor's-problem)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Assuming that we have a Student class that looks like a below definition:

```java
public class Student {
    private String name;

    public void setName(String name) {
        this.name = name;
    }

    public void getName() {
        return this.name;
    }
}
```

But using the above code, we can find that it has some wrong approaches.
- Can name field be empty?
- Can it be null?



<br>

## Solution with Consistent Objects





<br>

## Some problems with Constructors

1. Defining multiple constructors




2. Drawbacks of Constructor



<br>

## Using Builder pattern to solve Constructors's problem





<br>

## Wrapping up




<br>

Refer:

[]()