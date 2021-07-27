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
- [Application & Examples](#application-&-examples)
- [Wrapping up](#wrapping-up)

<br>

## Given Problem

Suppose we have a system that tracks progress of a game and determines if someone has won. If we implement it for checkers, and the again for chess, and again for battleship, we might see a lot of duplication in the logic that could be pulled up into some common classes.

Likewise, following certain kinds of recipes might have similar steps involving prep, cooking, and presentation.

Many UI frameworks, especially those with controls, make use of this pattern too.
The original ASP.NET paradigm, now known as Web Forms, used Template method heavily. Every control and page had a series of events in its lifecycle that developers could extend, but application developers didn't have control over the lifecycle itself. If data is more our thing, think about tools and diagrams for moving data between two systems. Extract, transform, load, or ETL, processes have a candidate for a simple template method in their name. Another example is a system designed to load and work with a certain kind of document, like a PDF. When we find we need to do the same thing, but now for spreadsheets and then again for images, we may find that the general process is the same across each kind of application.

Template method could be a useful pattern to consider. Consider an application that works with documents of varying formats.

```java
public Stream openDocument() {
    if (!canOpen()) throw;

    var doc = doCreateDocument();
    if (doc != null) {
        addDocument();
        preOpenDocument(); // hook
        doc.open();
        return doc.read();
    }
}
```

The basic steps involved in working with these documents might be pretty standard, regardless of whether the document was a PDF, a CSV, an XML or some other format. The specific details of what to do with each format and file would need to vary with each specific implementation, but the high-level process could be dictated by a method like the one shown here. Note that this method calls several other methods.
- It acts as a generic method in the Application class.

- The first thing it does is it tries to open the file by calling canOpen() method.

- Next, it tries to create the specific document that we need using the doCreateDocument() method. 

- After that, if it was successful, it will try and add the document, and then there's an operation called a hook. The hook is a place where we could add additional behavior if we need to in the future, but inside of this generic operation, we don't have anything that we need to do currently.

- After that, we can open and then read the document an complete the operation.

This method calls several other methods such as canOpen(), doCreateDocument(), addDocument(), and preOpenDocument(). All of these methods are defined inside of the base class along with this 

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

