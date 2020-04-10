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

