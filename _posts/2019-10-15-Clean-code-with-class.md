---
layout: post
title: Clean code with class
bigimg: /img/image-header/california.jpg
tags: [Clean Code]
---

In this article, we will learn about cohesion and coupling in OOP. It completely help us to write readable, maintainable code.

All of this information is referred from [Java: Writing Readable and Maintainable Code](https://app.pluralsight.com/course-player?clipId=fc61cebf-e85a-4c5f-86ba-2a9306406a6f).

Let's get started.

<br>

## Table of contents
- [Single Responsibility Principle](#single-responsibility-principle)
- [Cohesion](#cohesion)
- [Coupling](#coupling)
- [Wrapping up](#wrapping-up)

<br>

## Single Responsibility Principle
Single Responsibility principle applies to both methods and classes.

Let's get an example about how to apply Single Responsibility Principle into a method.

```java
void getSalesData() {
    // query DB
    ...

    // format data
    ...

    // precalculate
    ...
}
```

With the above code, we find that getSalesData() method does 3 things:
- query database to get results.
- Get above results, we should format data based on our criteria.
- Precalculate them.

But SRP says that:

```
Each software module should have one and only one reason to change.

---
Robert C. Martin
```

Martin defines a responsibility as a reason to change. So, in our getSalesData() method, it does three things, so when we want to change query database or format data or precalculate. We have to change getSalesData() method.

It is not robust for our program and it does not abide by Single Responsibility Principle. Therefore, we will divide our getSalesData() method into three smaller methods.

```java
List<Data> getSalesData() {
    // do something about sale data
}

void formatSalesData(List<Data> data) {
    // format data
}

void preCalcSalesData(List<Data> data) {
    // precalculate data
}
```

Step back to SRP applied for classes, we apply SRP in method for SRP in class. We have - ```A class should do one thing```. But that would result in terribly tiny classes doing almost nothing. A class with two methods would already break this rule, so that's misleading. Robert C.Martin defines SRP as a class should only one reason to change.

Image that we have an employee class. An employee has a name, a salary and a role, for example: developer, tester, manager, ...

```java
class Employee {

    String getName();
    double getSalary();
    Role getRole();

    void sendEmail();
    void calculateYearBonus();
}
```

What do the most office employees do? They send email, a bit too frequently, but in a big organization, that's just life. And the company also has yearly bonuses, so we have a calculation method.

But from a technical perspective, the employee is not the one who sends the email, it's an email service, for example, Microsoft Outlook that does the sending. And employees do not calculate their own bonuses, it's the deparment's responsibility to do this.

So, we will split Employee class into three classes. This way, each class has a separate technical functional scope, but not just that, each class is now a separate unit from a business perspective.

Employee would belong to the domain of human resources, email service to the IT administration, and payroll calculation belongs to account.

```java
class Employee {
    // get / set properties
}

class EmailService {
    void sendEmail() {
        // do something
    }
}

class PayrollCalculator {
    void calculateYearBonus(Employee emp) {
        // do something
    }
}
```

So SRP naturally leads to higher cohesion.

<br>

## Cohesion
Cohesion in general context simply means a tendency to unite, meaning things are grouped or logically connected together. So cohesion happens when things put together make sense and work well.

If we take all of the separate parts of a car and put them together, we get a funtional car, that's cohesive. If we want a police car, we might add a siren on top of that. That's still cohesive.

In the context of programming, cohesion refers to the degree to which the elements inside a class or a module belong together. To achieve high cohesion inside a class, we should keep related things, fields, and methods together.

So high cohesion means that the class is focused on what it should be doing, meaning fields and methods are co-dependent and hang together as a logical whole, and they all relate to the intention of the class.

How do we achieve high cohesion? 

By making sure that the methods are interrelated and they use the class fields. 
- If a method use three or four class fields, that's higher cohesion than just one field. 

- And methods use other methods inside the same class.


--> Single Responsibility Principle != Cohesion

SRP and cohesion go hand in hand, but they are not the same thing. We can have a highly-cohesive class, which is a good thing, but that class still might have multiple responsibilities, which is a bad thing.

Let's get an example.

```java
User user;

void saveChanges() {
    dbContext.save();
    logger.lgo("User table updated with: " + whatever);
    raiseEvent(new EmailNotification(user));
}

void raiseEvent(Event event) {
    // do something
}
```
In an above class, we have a field and two methods, all inside a single class. We trigger saveChanges, we delegate the saving to a database context, then we'll log it, and then we send a notification email that a new user has been created.

Notice how one method uses another method, and the other method uses the class field. There are various issues with this code but one could argue that the code is interconnected functionally, and thus is cohesive. 

But, saving to database and sending emails are definitely two different repsonsibilities. So, SRP is broken at method level, it does two things, and also at class level. The event raising should be part of a different class. It's quite difficult to think of an example that would distinguish SRP and cohesion in a clear.

One more thing to note about cohesion is that it does not only happen at class level, it also applied at higher levels such as package, module, system.

For example, at package level, do not just dump all of our classes in a single package. Group them into multiple packages. The same then applies to modules or subsystems. The interaction between these should be logical and ordered.

<br>

## Coupling
Coupling means the degree of interdependence between software modules or classes, a measure of how interconnected they are

For example, we have class A that uses class B, then A is coupled with B, that's coupling.

```java
public class A {
    private B b = new B();  // A coupled with B
}
```

A is dependent on B to work corectly. Obviously in practically any object oriented program, coupling is completely find, it's not something we need or can avoid. But there are degrees of coupling, very loose, very tight, and everything in between.

And usually we want it as loose as possible. 
- Because tight coupling means classes or modules are so tight that we cannot change one without chaning the other.
- And loose coupling means that a change in one class requires no or minimum changes in other classes.

So, with loose coupling, if we need to change one line, we really do change one line. With tight coupling, we change one line and suddenly we see ourself forced and change much more in 20 other related classes.


```
Tight coupling is maintaince hell.
```

So high cohesion and low coupling allow for better maintaince.

How do we reduce coupling?
- Adhere to Single Responsibility Principle.
- Increase cohesion. One big class coupled to 10 different classes, but 5 small classes might be coupled with only two clases each.
- Program to an interface
- Maintain strong encapsulation. It means keep things as private as possible.

    ```
    Do not make methods and fields public "just because".
    ```
- Use Dependency Injection

For example:

```java
public class Application {
    LinkedList<String> list = new LinkedList<>();

    void doSomething(LinkedList<String> list) {
        String firstElem = list.getFirst();

        // do something
    }

    void doSomethingElse(LinkedList<String> list) {
        String lastItem = list.getLast();

        // do something
    }
}
```

We can find that our program is coupled with ```LinkedList``` collection. So, if we want to use ```ArrayList```, instead of utilizing ```LinkedList```, we have to change multiple methods in multiple places such as ```getFirst()``` and ```getLast()``` methods.

If we have 1000 classes that use ```LinkedList```, we need to spend so much time to modify code in all of these classes.

Solution for this case is to use interface. In the beginning, we will use ```List``` collection for ```LinkedList```.

Next, we can get other example for coupling:

```java
public int calculateSomething(File source) {
    // open InputStream from Fiile

    return 0;
}
```

We easily find that our method is tightly coupled with File class. So, if want to call calculateSomething() method to process data from database or data from Rest API. So, we have to create additional methods, each with a unique implementation.

Therefore, solution for this problem is to use InputStream class because the InputStream can be obtained from a file, a database or a URL connection. 

```java
public int calculateSomething(InputStream source) {
    // read from InputStream

    return 0;
}
```

So, the number of dependencies is the same one, but we suddenly have much more flexibility. This does not guarantee that we can now accept input from all possible sources, but it goes to show that choosing the wrong type from the start can drastically reduce flexibility, and choosing the right option keeps a high-level of flexiility for the future.




<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

[https://blog.cleancoder.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html](https://blog.cleancoder.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html)