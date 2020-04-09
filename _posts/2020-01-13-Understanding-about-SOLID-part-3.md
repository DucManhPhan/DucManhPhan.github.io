---
layout: post
title: Understanding about SOLID - Liskov Substitution Principle
bigimg: /img/image-header/home-office-1.jpg
tags: [SOLID]
---

In this article, we will learn how to use Liskov Substitution Principle for declaring correctly relationships between types, without using is-a relationship.

Let's get started.

<br>

## Table of contents
- [Liskov Substitution Principle](#liskov-substition-principle)
- [Detecting violations of the LSP](#detecting-violations-of-the-LSP)
- [Fixing incorrect relationships between types](#fixing-incorrect-relationships-between-types)
- [Wrapping up](#wrapping-up)

<br>

## Liskov Substitution Principle

The Liskov Substitution Principle states that:

```
If S is a subtype of T, then objects of type T in a program may be replaced with objects of type S without modifying the functionality of the program.
```

or 

```
Any object of a type must be substitutable by objects of a derived typed without altering the correctness of that program.
```

or 

```
Subclass objects must always be substitutable for superclass objects
```

--> The LSP is all about relationships between types.

As human, we have a tendency to think about relationships as **is a**. We say that square is a kind of rectangle or an ostrich is a bird.

However, in object-oriented terms, this **is a** relationship is not really helpful and can even make us create incorrect hierarchies of classes. Instead, we should ask ourselves if a particular type is substitutable by another type.

For example, is the class rectangle fully substitutable by the class square? Or is the class ostrich fully substituable by the class bird in the context of our application? That's the correct question that we should ask ourselves each time we create relationship between our types.

Indeed, incorrect relationships between types cause unexpected bugs or side effects. This can be pretty tricky to spot and correct. And usually correcting them involves a lot of refactoring and reengineering. To save time and effort, it's important to get them right in the first place, and the Liskov substitution principle will help us to achieve this.


<br>

## Detecting violations of the LSP
1. Empty methods / Functions

    Let's take a look at an example.

    ```java
    class Bird {
        public void fly(int altitude) {
            setAltitude(altitude);
            // fly logic
        }
    }

    class Ostrich extends Bird {
        @Override
        public void fly(int altitude) {
            // do nothing - an ostrich can't fly
        }
    }

    Bird ostrich = new Ostrich();
    ostrich.fly(1000);
    ```

    What do we think will happen when we create an ostrich like above example? Then we call the fly() method with an altitude of 1000. The application won't break, but this method won't produce any results. In other words, the program produces an unexpected result, and the problem comes with this incorrect relationship between the ostrich and the bird. In biology, an ostrich is a bird. But in OOP and particularly in our program, the class Bird is not fully substitutable by the class Ostrich.

    We created an incorrect type relationship.

2. Harden Preconditions

    ```java
    class Rectangle {
        public void setHeight(int height) { ... }
        public void setWidth(int width) { ... }

        public int calculateArea() {
            return this.width * this.height;
        }
    }

    class Square extends Rectangle {
        public void setHeight(int height) {
            this.height = height;
            this.width = height;
        }

        public void setWidth(int width) { ... } // same logic w = h
    }

    Rectangle r = new Square();
    r.setWidth(10);
    r.setHeight(20);
    r.calculateArea();  // result: 400
    ```

    In the setters of Square class, setHeight() and setWidth(), we harden the initial preconditions because for a square, the height and the width are equal. So each time we set the height, we also set the width and vice versa. 

    The result will be 400 which is correct from our program's perspective. However, if we look at these few lines of code, something doesn't feel right because we created a new Square, the base type is Rectangle, so we are able to set the width and height, but we are not expecting the harden precondition. We're not expecting that when we set the width, the height would also be set, and when we set the height, the width also be set. So, the program behaves in an unexpected way, and that's because we have an incorrect relationship between Square and Rectangle.

    A rectangle is not fully substitutable by the class Square.

3. Partial Implemented intefaces

    ```java
    interface Account {
        void processLocalTransfer(double amount);
        void processInternationalTransfer(double amount);
    }

    class SchoolAccount implements Account {
        void processLocalTransfer(double amount) {
            // business logic here
        }

        void processInternationalTransfer(double amount) {
            throw new RuntimeException("Not Implemented");
        }
    }

    Account account = new SchoolAccount();
    account.processInternationalTransfer(10000);    // will crash
    ```

    The program will crash because we have an incorrect hierarchy between the SchoolAccount class and the Account interface. Basically, an account is not fully substitutable by the SchoolAccount class. Each time we see a method that throws an exception, we are violating the Liskov substitution principle.

4. Type checking

    ```java
    for (Task t : tasks) {
        if (t instanceof BugFix) {
            BugFix bf = (BugFix)t;
            bf.initializeBugDescription();
        }

        t.setInProgress();
    }
    ```

    Imagine that we're working on an Agile board. We have various task types including a BugFix, which is a particular type of task. We want to receive a collection of tasks and set them in progress, and we can do that for all task types except bug fixes. For bug fixes, before we are able to set any progress, we need to initialize the bug description. This kind of approach, where for most subtypes, we do one thing, but for particular subtypes, we do another thing, is an indication that those subtypes cannot substitute their base type. And we are not adhering to LSP.



<br>

## Fixing incorrect relationships between types

There are two great ways to refactor code and make it respect the LSP.
- Eliminate incorrect relations between objects.

- Use "Tell, don't ask!" principle to eliminate type checking and casting.

1. Fixed Empty methods / Functions

    To solve empty methods or functions, we will use the first way. It means that we will get rid of the relationship between Bird and Ostrich - inheritance.

    ```java
    public class Bird {
        // Bird data and capabilities

        public void fly(int altitude) { ... }
    }

    public class Ostrich {
        // Ostrich data and capabilities. No fly method
    }
    ```

2. Fixed Harden Preconditions

    The above way will be applied for this problem to break the relationship between Square and Rectangle.

3. Fixed Partial Implemented intefaces

    With this problem, we will break the interface down into smaller, more focused pieces. Our SchoolAccount class implements just one method of the Account interface. It does not respect the LSP. However, we can make SchoolAccount implement the LocalAccount interface. This interface exposes a single method, processLocalTransfer.

    ```java
    public interface LocalAccount {
        void processLocalTransfer(double amount);
    }

    public class SchoolAccount implements LocalAccount {
        public void processLocalTransfer(double amount) {
            // business logic here
        }
    }
    ```

4. Fixed Type checking

    Type checking can be fixed using a principal called "Tell, don't ask!". Basically for loop, we are basically asking if t is an instance of a BugFix. Then we're creating a task to transform t from type Task to type BugFix. We initialize the bug description, and then we go on to set the task in progress.

    We could simply this and eliminate they type checking altogether by overriding the ```setInProgress()``` method on the BugFix class.

    ```java
    public class BugFix extends Task {
        @Override
        public void setInProgress() {
            this.initializeBugDescription();
            super.setInProgress();
        }
    }
    ```

<br>

## Wrapping up

- Apply the LSP in a Proactive way

    - Make sure that a derived type can substitute its base type completely.
    - Keep base classes small and focused.
    - Keep interfaces lean.

- The Liskov Substitution principle helps us to create correct hierarchies between types, which guarantee that our program will run correctly and without any undesired side effects.

<br>

Thanks for your reading.

<br>

Refer:

[SOLID Software Design Principles in Java](https://app.pluralsight.com/library/courses/solid-software-design-principles-java/table-of-contents)