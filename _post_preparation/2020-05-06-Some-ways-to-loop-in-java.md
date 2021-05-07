---
layout: post
title: Some ways to loop in Java
bigimg: /img/image-header/california.jpg
tags: [Java]
---



<br>

## Table of contents
- [Using traditional for loop](#using-traditional-for-loop)
- [Using for-each loop](#using-for-each-loop)
- [Using iterator pattern](#using-iterator-pattern)
- [Using Stream API](#using-stream-api)
- [Using Reactive stream with RxJava, Reactor core](#using-reactive-stream-with-rxjava,-reactor-core)
- [Wrapping up](#wrapping-up)


<br>

## Using traditional for loop

When using traditional **for** loop means that we utilize index-based iteration, we're free to modify the list in any way.

For example:

```java
List<String> strings = Arrays.asList("Hello, ", "world", "!");

for (int i = 0; i < strings.size(); ++i) {
    System.out.println(strings.get(i));
}
```

Benefits of using traditional for loop:
- easy to apply our logic for multiple languages. 
- based on index, we can do multiple operations like in competive programming.
- take advantage of locality cache.

Drawbacks of using traditional for loop:
- verbose and error prone because we need to take care about the specific start index, and end index, if not, it easily throws an **ArrayIndexOutOfBounds** exception.

    With the small, easy tasks and business logic, this way isn't suitable.

When to use:
- When we want to our code base is suitable with multiple Java's versions, and other languages can use without any modifications.
- When coding in competitive programming

<br>

## Using for-each loop

Under the hood, the for-each loop utilizes the **Iterator** interface and calls into its **hasNext()** and **next()** methods.

For example:

```java
List<String> strings = Arrays.asList("Hello, ", "world", "!");

// 1st way
for (String tmp : strings) {
    System.out.println(tmp);
}

// 2nd way
strings.forEach(tmp -> System.out.println(tmp));
```

Benefits of using for-each loop:
- Reduce the nested loop problem when using iterator pattern

Drawbacks of using for-each loop:
- Don't remove or update an item, it can throw a ConcurrentModificationException exception.

When to use:
- 
- 
- 

<br>

## Using iterator pattern

For example:

```java
List<String> strings = Arrays.asList("Hello, ", "world", "!");

// 1st way - using ListIterator
for (ListIterator<String> iter = strings.listIterator(); iter.hasNext(); ) {
    System.out.println(iter.next());
}

// 2nd way - using Iterator
for (Iterator<String> iter = strings.iterator(); iter.hasNext(); ) {
    System.out.println(iter.next());
}
```


Benefits of using iterator pattern:
- To delete an item, we need to use **Iterator.remove()** method.

Drawbacks of using iterator pattern:
- It isn't suitable for nested loop because at each turn of the outer loop, the items in the inner loop are iterated completely. So, when advancing an iterator of the outer loop, the inner loop's iterator will throw a NoSuchElementException exception.

    Solution for this problem is to use for-each loop or traditional loop.

<br>

## Using stream API



For example:

```java

```

Benefits of using Stream API:
- 
- 
- 

Drawbacks of using Stream API:
- 
- 
- 

When to use:
- 
- 
- 

<br>

## Using reactive stream with RxJava, Reactor core






Benefits of using reactive stream:
- 
- 
- 

Drawbacks of using reactive stream:
- 
- 
- 

When to use:
- 
- 
- 



<br>

## Wrapping up
- The basic loop is not recommended as we do not know the implementation of the list.

    If that was a ```LinkedList```, each call to ```list.get(i)``` would be iterating over the list, resulting in ```N^2``` time complexity.

- The performance of each type loop depends largely on the type of the data structures.

Refer:

[https://stackoverflow.com/questions/18410035/ways-to-iterate-over-a-list-in-java](https://stackoverflow.com/questions/18410035/ways-to-iterate-over-a-list-in-java)