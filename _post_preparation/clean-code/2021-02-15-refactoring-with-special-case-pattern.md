---
layout: post
title: Refactoring with Special Case Pattern
bigimg: /img/image-header/yourself.jpeg
tags: [Refactoring]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [First step - Using Null Object Pattern](#first-step---using-null-object-pattern)
- [Second step - Using Special Case Pattern](#second-step---using-special-case-pattern)
- [Third step - Remove boolean methods](#third-step---remove-boolean-methods)
- [Fourth step - Turning an object into a Finite State Machine](#fourth-step---turning-an-object-into-a-finite-state-machine)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Supposed that we have the Warranty interface that models warranties issued when goods are sold. The **isValidOn()** method tests whether the warranty is valid on a given date.

```java
public interface Warranty {
    boolean isValidOn(LocalDate date);
}
```

Then, we model the articles sold to a customers. It exposes two warranties, **moneyBackGuarantee** and **expressWarrranty**. We can attach warranty objects to every articles. We can even persist the object with those warranties attached, of course.

```java
public class Article {
    private Warranty moneyBackGuarantee;
    private Warranty expressWarranty;

    public Article(Warranty moneyBackGuarantee, Warranty expressWarranty) {
        this.moneyBackGuarantee = moneyBackGuarantee;
        this.expressWarranty = expressWarranty;
    }

    public Warranty getMoneyBackGuarantee() {
        return this.moneyBackGuarantee;
    }

    public Warranty getExpressWarranty() {
        return this.expressWarranty;
    }
}
```

Later a customer might return with broken stuff that we sold them with the fancy idea of claiming warranty.

Belows are some rules for the Article.
- Money-back guarantee holds if there are no visible damage.
- Repair is offered for articles that are not operational.

```java
public class Main {
    // we have two warranty, so we could offer both or one or none of them,
    // depending on conditions.
    public void claimWarranty(Article article, boolean isInGoodCondition, boolean isNonOperational) {
        LocalDate today = LocalDate.now();
        
        if (isInGoodCondition && isNonOperational &&
                article.getMoneyBackGuarantee() != null &&
                article.getMoneyBackGuarantee().isValidOn(today)) {
            System.out.println("Offer Money back");
        }

        if (isNonOperational &&
                article.getExpressWarranty() != null &&
                article.getExpressWarranty().isValidOn(today)) {
            System.out.println("Offer repair");
        }

        System.out.println("---------------------");
    }

    public void run() {

    }
}
```

One of the principal signs that we're doing something wrong is accumulation of method arguments. **Boolean method arguments are a sure sign of missing objects in OOP**. In OOP, we tell objects what to do and they choose how to do it.

In the above code, we can find that this implementation is too complicated. **Branching over boolean flags and null checks is a poor programming practice**, and it has nothing in common with OOP. Null references are especially dangerous, because if we forget to put a guard, the subsequent attempt to de-reference the variable will fail with **NullPointerException**.

So, how do we refactor the above code?

<br>

## First step - Using Null Object Pattern

In this section, to reduce the complexity of the above code, we need to do the followings:
- Boolean conditions should be removed.
- We should not branch around boolean flags and nulls.

Then our code will look likes below. It only depends on the business logic, not the boolean flags and null checks.

```java
public void claimWarranty(Article article) {
    LocalDate today = LocalDate.now();
    
    if (article.getMoneyBackGuarantee().isValidOn(today)) {
        System.out.println("Offer Money back");
    }

    if (article.getExpressWarranty().isValidOn(today)) {
        System.out.println("Offer repair");
    }

    System.out.println("---------------------");
}
```

In the above code, we define two boolean flags - **isInGoodCondition** and **isNonOperational**. They are used to express the state of our current article. In OOP, objects are responsible to know their conditions.

So, belows are things that we need to improve in this section:
- Article class also guaratees that the **getMoneyBackGuarantee()**, and **getExpressWarranty()** methods do not return null.
- Using Null Object pattern for null values.
- The Article class must be manage its state itself - **isInGoodCondition** and **isNonOperational**.

    This step will be analyze in the section []().


1. Promise the getter methods return a non-null reference

    To satisfy this conditions, we will use **Constructor Preconditions** to check its parameters.

    ```java
    public Article(Warranty moneyBackGuarantee, Warranty expressWarranty) {
        Objects.requireNonNull(moneyBackGuarantee);
        Objects.requireNonNull(expressWarranty);

        this.moneyBackGuarantee = moneyBackGuarantee;
        this.expressWarranty = expressWarranty;
    }
    ```

    Object (Constructor) precondition implies the method postcondition.

2. Create the corresponding behaviors for null values of **Warranty**'s each instance.

    In the previous thing, we need to check null for each **Warranty**'s instance, if it's null, we will throw a runtime exception. But now we do not want these behaviors when coping with null value.

    Therefore, we will replace nulls with proper objects of **Warranty** interface.

    ```java
    public class VoidWarranty implements Warranty {

        // Null Object Pattern
        // Its objects are doing nothing but object implements the expected interface.
        @Override
        public boolean isValidOn(LocalDate date) {
            return false;
        }
    }
    ```

    Null objects are normally empty classes. Their methods have trivial implementations. Methods returning void would be empty. Non-void methods would return constant (false, zero, emtpy string, ...). That's why we would normally implement them as singletons. In Java, we can expose null objects as constants on the interface they implement. Interface variables are static final by definition.

    ```java
    public interface Warranty {
        boolean isValidOn(LocalDate date);

        Warranty VOID = new VoidWarranty();
    }

    public void run() {
        Article article = new Article(Warranty.VOID, Warranty.VOID);
        this.claimWarranty(article);
    }
    ```

<br>

## Second step - Using Special Case Pattern





<br>

## Third step - Remove boolean methods

After following the above steps, we will still have some branches if/else.

```java
public void claimWarranty(Article article) {
    LocalDate today = LocalDate.now();
    
    if (article.getMoneyBackGuarantee().isValidOn(today)) {  //(1)
        System.out.println("Offer Money back");
    }

    if (article.getExpressWarranty().isValidOn(today)) {    // (2)
        System.out.println("Offer repair");
    }

    System.out.println("---------------------");
}
```

Our target is to remove these branches. The key to solve our problem is in understanding that warranty objects are not really doing anything, they are just helping us to branch, leaving us to implement operations all by ourself. This is the most common mistake in OOP. We use objects only as guides or helpers while implementing complete operations on the calling end. That is wrong. Operations should entirely be in objects they concern.

```java
public interface Warranty {
    boolean isValidOn(LocalDate date);  // boolean method is a design flaw

    Warranty VOID = new VoidWarranty();

    static Warranty lifetime(LocalDate issuedOn) {
        return new LifetimeWarranty(issuedOn);
    }
}
```

It means that we need:
1. remove **isValidOn()** method in **Warranty** interface
2. define **on()** and **claim()** methods in **Warranty** interface

    ```java
    public interface Warranty {
        default void claim(Runnable action) {
            action.run();
        }

        // functional style that usually call the filtering API
        // remove the need for boolean methods
        // return the version of an object given a condition
        Warranty on(LocalDate date);

        Warranty VOID = new VoidWarranty();

        static Warranty lifetime(LocalDate issuedOn) {
            return new LifetimeWarranty(issuedOn);
        }
    }

    public class VoidWarranty implements Warranty {
        @Override
        public boolean isValidOn(LocalDate date) {
            return false;
        }

        @Override
        public void claim(Runnable action) {
            // nothing to do
        }

        @Override
        public Warranty on(LocalDate date) {
            return this;
        }
    }

    public class LifetimeWarranty implements Warranty {
        private LocalDate issuedOn;

        public LifetimeWarranty(LocalDate issuedOn) {
            this.issuedOn = issuedOn;
        }

        @Override
        public boolean isValidOn(LocalDate date) {
            return this.issuedOn.compareTo(date) <= 0;
        }

        @Override
        public Warranty on(LocalDate date) {
            return date.compareTo(this.issuedOn) < 0 ? Warranty.VOID : this;
        }
    }

    public class TimeLimitedWarranty implements Warranty {
        private LocalDate dateIssued;
        private Duration validFor;

        public TimeLimitedWarranty(LocalDate dateIssued, Duration validFor) {
            this.dateIssued = dateIssued;
            this.validFor = validFor;
        }

        @Override
        public boolean isValidOn(LocalDate date) {
            return this.dateIssued.compareTo(date) <= 0 &&
                   this.getExpiredDate().compareTo(date) > 0; 
        }

        @Override
        public Warranty on(LocalDate date) {
            return date.compareTo(this.dateIssued) < 0 ? Warranty.VOID
                    : date.compareTo(this.getExpiredDate()) > 0 ? Warranty.VOID
                    : this;
        }

        private LocalDate getExpiredDate() {
            return this.dateIssued.plusDays(this.getValidForDays());
        }

        private long getValidForDays() {

        }
    }
    ```

    Then we have:

    ```java
    public void claimWarranty(Article article) {
        LocalDate today = LocalDate.now();

        article.getMoneyBackGuarantee().on(today).claim(this::offerMoneyBack);
        article.getExpressWarranty().on(today).claim(this::offerRepair);
    }

    private void offerMoneyBack() {
        System.out.println("Offer money back");
    }

    private void offerRepair() {
        System.out.println("Offer repair");
    }
    ```

<br>

## Fourth step - Turning an object into a Finite State Machine

In the previous section's **claimWarranty()** method, we removed the two boolean variables - **isInGoodCondition** and **isNonOperational**. Then, in this section, we will make the Article class keeps track of its state.

```java
public class Article {
    private Warranty moneyBackGuarantee;
    private Warranty expressWarranty;
    private Warranty effectiveExpressWarranty;

    public Article(Warranty moneyBackGuarantee, Warranty expressWarranty) {
        this(moneyBackGuarantee, expressWarranty, Warranty.VOID);
    }

    private Article(Warranty moneyBackGuarantee, Warranty expressWarranty,
                   Warranty effectiveExpressWarranty) {
        Objects.requireNonNull(moneyBackGuarantee);
        Objects.requireNonNull(expressWarranty);

        this.moneyBackGuarantee = moneyBackGuarantee;
        this.expressWarranty = expressWarranty;
        this.effectiveExpressWarranty = effectiveExpressWarranty;
    }

    public Warranty getMoneyBackGuarantee() {
        return this.moneyBackGuarantee;
    }

    public Warranty getExpressWarranty() {
        return this.effectiveExpressWarranty;
    }

    public Article withVisibleDamage() {
        return new Article(Warranty.VOID, this.expressWarranty, this.effectiveExpressWarranty);
    }

    public Article notOperational() {
        return new Article(this.moneyBackGuarantee, this.expressWarranty, this.expressWarranty);
    }
}
```


<br>

## Wrapping up

- From the above sections, we should not use the boolean parameters in our method. Because it will raise the **cyclomatic complexity** in our business logic.

    So, to solve this problem, we have to use **Null Object pattern** for null value, or **Special Case pattern** for the using boolean parameter cases.

- Don't branch around Boolean flags and nulls.

- Don't pass Boolean flags as method arguments.

- Don't define boolean method because it violates OOP --> Don't tell the caller when to do something.

<br>

Refer:

[Making Your Java Code More Object-oriented](https://app.pluralsight.com/library/courses/object-oriented-java-code/table-of-contents)