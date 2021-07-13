---
layout: post
title: Clean code with Constructor
bigimg: /img/image-header/yourself.jpeg
tags: [Clean Code]
---

In this article, we will go to clean code with constructor. This is common techniques to solve our problems when we want to create object.

Let's get started.

<br>

## Table of contents
- [Use static factory method](#use-static-factory-method)
- [Constructor chaining](#constructor-chaining)
- [Constructor Telescoping](#constructor-telescoping)
- [Wrapping up](#wrapping-up)

<br>

## Use static factory method

1. Given problem

    Before we want to create an object, we have to need calculate and validate the other things so much, then it makes our problem hard to follow, and understand.

    For example:

    ```Java
    new GregorianCalendar(new TimeZone() {
        @Override
        public int getOffset(int era, int year, int month, int day, int dayOfWeek, int milliseconds) {
            return 0;
        }

        @Override
        public void setRawOffset(int offsetMillis) {

        }

        @Override
        public int getRawOffset() {
            return 0;
        }

        @Override
        public boolean useDaylightTime() {
            return false;
        }

        @Override
        public boolean inDaylightTime(Date date) {
            return false;
        }
    }, new Locale("", "", ""));
    ```

    So, with the above example, we find it truly difficult to digest.

2. Solution

    Our solution for this problem is to use ```static factory method```. Because ```static factory method``` will hide every difficulty, we only need to focus on creating our object.

    In Java, we have some examples for static factory methods like:

    ```Java
    Calendar.getInstance();

    String.valueOf(true);

    LocalDate.of(2019, 08, 31);

    Optional.empty();
    ```

    So, ```static factory methods``` will encapsulate the construction logic, hide the verbosity and the complexity of creating object. When we want to change the creation of this object, we do it in a single class, not in the other places. It helps maintainability a lot.

    Therefore, with the example in [Given problem](#given-problem) section, we will have:

    ```Java
    GregorianCalendar.getInstance();
    ```

3. Benefits of this solution

    - hide all the details of this creation for an object, and it satisfied the Tell Don't Ask principle.

<br>

## Constructor chaining

```
Constructor chaining helps adhere to the DRY principle.
```

1. Given problem

    ```java
    public class BankAccount {

        private double balance;

        private double interest;

        BankAccount() {}

        BankAccount(double balance) {
            if (balance < 0) {
                throw new IllegalArgumentException("Starting balance can not be less than 0");
            }

            this.balance = balance;
        }

        BankAccount(double balance, double interest) {
            if (interest < 0) {
                throw new IllegalArgumentException("Starting balance can not be less than 0");                
            }

            if (balance < 0) {
                throw new IllegalArgumentException("Starting balance can not be less than 0");
            }

            this.balance = balance;
            this.interest = interest;
        }
    }
    ```

    With this above code, we already have some duplication code such as some simple checks to ensure that no one creates an account objects with invalid arguments --> we have to keep the check in each constructor.

    If we have to check for multiple arguments, it becomes mess. So, we can use chaining to reduce this problem.
   

2. Solution

    ```java
    public class BankAccount {

        private double balance;

        private double interest;

        BankAccount() {
            this(0);
        }

        BankAccount(double balance) {
            this(balance, 0.01);
        }

        BankAccount(double balance, double interest) {
            checkArgumentIsValid(interest, "Interest rate can not be less than 0");     // should refactor constant message to the other place.
            checkArgumentIsValid(balance, "Starting balance can not be less than 0");

            this.balance = balance;
            this.interest = interest;
        }

        private void checkArgumentIsValid(double arg, String message) {
            if (arg < 0) {
                throw new IllegalArgumentException(message);
            }
        }
    }
    ```

    In the above code, we have several constructors sorted in a particular order from no arguments to one argument to two arguments. Only the bottom one has validation logic, so it's all in one place, and it also sets the fields. This constructor does all of the heavy lifting. The others just ```this``` keywork and call it. 

    This could be further refactored. The *interest rate* could be refactored into a constant since it is a default value, and these argument checks could be wrapped into prettier methods.


<br>

## Constructor Telescoping

1. Given problem

    Assume that we are building a backend system for a pizza restaurant, so we start off with a single parameter that takes the base size.

    Then, we also want to add interesting thing into our pizza.

    Therefore, we should create many constructors with different arguments, our constructors have a long list argument. The problem is multiplied by the simple fact that we should mix and match any number of ingredients.

    This is called as **telescoping constructor pattern**.

    ```java
    Pizza(int size) { ... }
    Pizza(int size, boolean cheese) { ... }
    Pizza(int size, boolean cheese, boolean ham) { ... }
    Pizza(int size, boolean cheese, boolean ham, boolean mushroom) { ... }
    ```

2. Solution

    To fix this problem, we should use Builder pattern.

    The downside of this solution is to have boilerplate code such as set properties in Builder class. But it makes our constructor readable, maintainable.

    ```java
    class Pizza {

        private final int size;

        private boolean cheese;

        private boolean ham;

        public Pizza(Builder builder) {
            this.size = builder.size;
            this.cheese = builder.cheese;
            this.ham = builder.ham;
        }

        static class Builder {

            private final int size;
            private boolean cheese;
            private boolean ham;

            Builder (int size) {
                this.size = size;
            }

            Builder cheese(boolean value) {
                this.cheese = value;
                return this;
            }

            Builder ham(boolean value) {
                this.ham = value;
                return this;
            }

            Pizza build() {
                return new Pizza(this);
            }
        }
    }

    // In main method, we have
    public static void main(String[] args) {
        Pizza pizza = new Pizza.Builder(12)
                            .cheese(true)
                            .ham(true)
                            .build(); 
    }
    ```


<br>

## Wrapping up

- Understanding these above problems that we have just encountered and their solutions.


<br>

Thanks for your reading.

<br>

Refer:

[Java: Writing readable code and maintainable code](https://app.pluralsight.com/library/courses/java-writing-readable-maintainable-code/table-of-contentshttps://www.pluralsight.com/courses/java-writing-readable-maintainable-code)

[Effective Java by Joshual Bloch](https://www.amazon.com/Effective-Java-Joshua-Bloch/dp/0134685997)