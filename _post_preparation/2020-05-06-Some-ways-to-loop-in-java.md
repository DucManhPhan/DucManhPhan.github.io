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

for (int i = 0; i< strings.size(); ++i) {

}
```

Benefits of using traditional for loop:
- 
- 
- 


Drawbacks of using traditional for loop:
- 
- 
- 

When to use:
- 
- 
- 

<br>

## Using for-each loop

Under the hood, the for-each loop utilizes the **Iterator** interface and calls into its **hasNext()** and **next()** methods.

For example:

```java


```

Benefits of using for-each loop:
- 
- 
- 


Drawbacks of using for-each loop:
- 
- 
- 

When to use:
- 
- 
- 

<br>

## Using iterator pattern

We can only modify the list contents by removing the current element, and then only if we do it through the ```remove()``` method of iterator itself.





Benefits of using for-each loop:
- 
- 
- 


Drawbacks of using for-each loop:
- 
- 
- 

When to use:
- 
- 
- 



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

- 



Refer:

[https://www.geeksforgeeks.org/iterator-vs-foreach-in-java/](https://www.geeksforgeeks.org/iterator-vs-foreach-in-java/)

[https://www.geeksforgeeks.org/how-to-use-iterator-in-java/](https://www.geeksforgeeks.org/how-to-use-iterator-in-java/)

[https://stackoverflow.com/questions/18410035/ways-to-iterate-over-a-list-in-java](https://stackoverflow.com/questions/18410035/ways-to-iterate-over-a-list-in-java)