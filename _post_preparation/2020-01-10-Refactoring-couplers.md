---
layout: post
title: Refactoring couplers
bigimg: /img/image-header/yourself.jpeg
tags: [Java, Refactoring]
---




<br>

## Table of contents
- [Definition of couplers](#definition-of-couplers)
- [Feature Envy](#feature-envy)
- [Inappropriate intimacy](#inappropriate-intimacy)
- [Excessive exposure](#excessive-exposure)
- [Message chain](#message-chain)
- [Middle Man](#middle-man)
- [Wrapping up](#wrapping-up)

<br>

## Definition of couplers

Couplers are simply code smells that represent high coupling between classes or entire modules. In this article, we will concentrate on classes. Coupling refers to the degree to which different classes depend on each other, and low coupling suggests that they should be independent as much as possible.

Tightly coupled code means one change in one place causes a cascade of changes in other places. This is a bit different a solution sprawl code smell. With solution sprawl, we might compile our code and face an exception at runtime, but with couplers, frequently, we won't even be able to compile our code.

Things that contribute to low coupling are:
- good encapsulation.
- apply Single Responsibility Principle.
 
--> Couplers make our code fragile and cause a cascade of changes.


<br>

## Feature Envy

Feature envy means that a method of one class uses too much functionality of another class. This is what it may look like.

![](../img/refactoring/couplers/feature-envy/feature-envy.png)

We have class A and class B, and one class that has a method that uses multiple methods from the other class. What's the problem with this?

Nothing, at least until we have to change methods in class B that might lead to changes in class A. So this represents high coupling. This is also a problem because the code seems misplaced. We would expect it one class, but actually find it in different class. So, if class A needs so much the functionality from another class, then there are two things we can do about it. Move methods from one class to another since the first class seems to need them so much, or, if that can't be done for whatever reason, make class B provide the functionality in a single encapsulated call.

![](../img/refactoring/couplers/feature-envy/feature-envy-problems.png)

For example:

```java
public class Customer {
    private Membership membership;
    private Address address;
    private Phone phone;
    private int age;

    public int getInternationalPhoneNumber() {
        return Integer.valueOf(phone.getInternationalPrefix() + phone.getPrefix() + phone.getNumber());
    }

    public int getSimplePhoneNumber() {
        return Integer.valueOf(phone.getAreaCode() + phone.getNumber());
    }
}

public class Phone {
    private final String fullNumber;

    public Phone(String number) {
        this.fullNumber = number;
    }

    public String getInternationalPrefix() {
        return "00"
    }

    public String getAreaCode() {
        return fullNumber.substring(0, 3);
    }

    public String getPrefix() {
        return fullNumber.substring(3, 6);
    }

    public String getNumber() {
        return fullNumber.substring(6, 10);
    }
}
```

We can see that Customer class makes multiple calls to the Phone class's methods. Since the Customer class needs them so much, we can just move them from Phone to Customer. That's option 1.

Option 1 doesn't sound good because these methods really do belong to the Phone class. So, instead, we'll go with option 2. Implement a new, well-encapsulated method on the Phone class and let the Customer class call that single method. So we are going to create this empty public method in the Phone class and then use the good old move method technique.

```java
public class Customer {
    // ...

    public int getInternationalPhoneNumber() {
        return Integer.valueOf(phone.getInternationalFormat());
    }

}

public class Phone {
    // ...

    public String getInternationalFormat() {
        return this.getInternationalPrefix() + this.getPrefix() + this.getNumber();
    }
}
```

Move some code from one place to another. And now we want the Customer class use it. This is better because before, the Customer depended on multiple methods from another class. Now, the dependency, or couplings, still exists, but there is only one link instead of several. Also, if we make breaking changes to these methods, then we will have to make updates within the same class. Our changes would not propagate to the Customer class. So that's feature envy.

<br>

## Inappropriate intimacy

Inappropriate intimacy happens when two or several classes are interlinked with each other too much. This may manifest in several ways.

For example, this may happen when our classes reach inside the internals of some other class because it has public fields or methods that are supposed to be private. 

![](../img/refactoring/couplers/inappropriate-intimacy/inappropriate-intimacy.png)

The general rule of thumb is to make everything private and then gradually relax restrictions when we have to and when it makes sense.

For example:

```java
public class Voucher {
    public String code;

    private LocalDate startDate;
    private LocalDate expiryDate;

    public Voucher() {}

    public Voucher(String code) {
        this.code = code;
    }

    public String getCode() {return code;}

    public void setCode(String code) {
        this.code = code;
    }
}

// in client code
String voucher1 = new Voucher().code = "CHEAPER_PLEASE";
String voucher2 = new Voucher().code = "CHEAPER_!@@#$";
String voucher3 = new Voucher().code = "CHEAPER_$%$#^";
```

Let's take a look at Voucher class, and the Voucher class has code field is currently public. This means that we can set this field to whatever we want in our client code.

But no characters should be allowed. This means we now have to implement a verification for this in all of these places, which is a lot of effort and a lot of duplication. Instead, we should make this field private, then create a setter for it, and this is also the process of encapsulation. And inside, we add the validation. Now, every other class is forced to use th public method, and this setter method is the only place where this validation happens. If we want to change this validation, we will change it in a single place without forcing other classes to change.

```java
public class Voucher {
    private String code;

    // ...

    public void setCode(String code) {
        assertTrue(Pattern.compile("^[a-zA-Z0-9]+$").matcher(code).matches());
        this.code = code;
    }
}
```

Now, we have all our fields private and only the necessary methods public. And if we have two classes that have on or two links to each other, meaning they call each other's methods, that's fine.

![](../img/refactoring/couplers/inappropriate-intimacy/two-links.png)

However, if we have 5 such links or 10 links, then these classes are almost like stiched together.

![](../img/refactoring/couplers/inappropriate-intimacy/multiple-links.png)

And so changes to one are likely to lead to changes in another, even if they are communicating via public methods only. Essentially, they are like a couple. They always come together and we have to deal with them together. In a certain way, this code smell can look like a feature envy, but in both directions.

For example:

![](../img/refactoring/couplers/inappropriate-intimacy/order-customer-example.png)

Our Order and Customer classes are coupled because a customer, or at least a customer ID, must be present on an order. But also, a customer may have one or multiple orders. With time, this may lead to stronger and stronger bidirectional coupling and we would have to be careful about how that evolves. Ideally, we'd want as few links as possible, and if necessary, perhaps introduce an extra class that would act as a middle layer between two.


<br>

## Excessive exposure

Excessive exposure, also called indecent exposure, happens when a class or a module exposes too many internal details about itself. And we might be telling ourself, that sounds really similar to inappropriate intimacy code smell, so what's the difference?

|               Inappropriate Intimacy              |                     Excessive Exposure                 |
| ------------------------------------------------- | ------------------------------------------------------ |
| When we have public fields instead of getters and setters, when they should be private, and there are too many links (E.g. method calls) between any two classes. | When a class forces us to care and think about a lot of low level details. |
| " You are with each other too much " | "You make me care too much" |





<br>

## Message chain





<br>

## Middle Man





<br>

## Wrapping up




<br>

Refer:

