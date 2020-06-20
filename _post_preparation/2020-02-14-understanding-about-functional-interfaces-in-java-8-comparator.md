---
layout: post
title: Understanding about Functional Interfaces in Java 8 - Comparator
bigimg: /img/path.jpg
tags: [Functional Programming]
---



<br>

## Table of contents





<br>

## Introduction to Comparator functional interface





<br>

## Chaining expression with Comparator





<br>

## When to use






<br>

## Source code

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private String name;
    private String age;
}


public static void main(String[] args) {
    User sarah = new User("Sarah", 28);
    User james = new User("James", 35);
    User mary = new User("Mary", 33);
    User john = new User("John", 26);
    User junggle = new User("James", 23);

    List<User> users = Arrays.asList(sarah, james, mary, john, junggle);

    Comparator<User> cmpName = Comparator.comparing(user -> user.getName());
    Comparator<User> cmpAge = Comparator.comparing(user -> user.getAge());
    Comparator<User> comparator = cmpName.thenComparing(cmpAge);
    Comparator<User> reversed = comparator.reversed();

    users.sort(cmpName);
    users.forEach(user -> System.out.println(user));
}
```


<br>

## Benefits and Drawbacks




<br>

## Wrapping up







<br>

Refer:

[https://www.guru99.com/controllers-in-jmeter.html](https://www.guru99.com/controllers-in-jmeter.html)