---
layout: post
title: Bridge pattern
bigimg: /img/image-header/yourself.jpeg
tags: [Behavioral Pattern, Design Pattern]
---




<br>

## Table of Contents
- [Given Problem](#given-problem)
- [Solution of Template Method Pattern](#solution-of-template-method-pattern)
- [When to use](#when-to-use)
- [Code C++/Java](#code-C++/Java)
- [Application & Examples](#application-&-examples)
- [Wrapping up](#wrapping-up)

<br>

## Given Problem






<br>

## Solution of Template Method Pattern

A template method is a method in a superclass that defines the skeleton of an operation in terms of higher level steps. Subclasses implement these steps.

Basically, it's a way of locking in the steps and their sequence while allowing the details of each step to vary through inheritance. Template methods are categorized as a behavioral design pattern because they help organize the behavior of our application. They're frequently used to eliminate duplication and to provide extensibility points.

Template methods are a fundamental technique for code reuse. This is directly from the Design Pattern Gang of Four book, published in 1994, and is still just as relevant today. Template methods are particularly useful for class libraries because they provide a mechanism for factoring common code out into these libraries. Framework authors can use this pattern to provide specific extensibility points while retaining control over the overall process.

Template method is a great pattern for reducing duplicate code and enforcing design constraints. It's also frequently used to produce extensible frameworks and plugins.




<br>

## When to use





<br>

## Benefits & Drawback
1. Benefits

    

2. Drawbacks


<br>

## Code C++/Java




<br>

## Refactoring with Template method pattern

We will go straight forward to our example to understand how to apply this pattern.

```java
public class NoteDrawer {

    public void drawHalfNote() {
        this.drawNoteHead('white');
        this.drawStem();
    }

    public void drawQuarterNote() {
        this.drawNoteHead('black');
        this.drawStem();
    }
}
```

We can easily find that ```drawHalfNote()```, and ```drawQuarterNote()``` methods have the same steps. It only has one different point that is parameter of ```drawNoteHead()``` method.

So, we can refactor the above code with the following:

```java
public abstract class NoteDrawer {

    public void drawNote() {
        this.drawNoteHead(this.getHead());
        this.drawStem();
    }

    public abstract void getHead();
}

public class HalfNoteDrawer extends NoteDrawer {
    public void getHead() {
        return "white";
    }
}

public class QuarterNoteDrawer extends NoteDrawer {
    public void getHead() {
        return "black";
    }
}
```


<br>

## Application & Examples





<br>

## Relation with other patterns



<br>

## Wrapping up




<br>

Thanks for your reading.

<br>

Refer:

