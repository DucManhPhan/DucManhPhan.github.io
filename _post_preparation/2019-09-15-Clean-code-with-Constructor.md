---
layout: post
title: Clean code with Constructor
bigimg: /img/image-header/yourself.jpeg
tags: [Clean code]
---



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

<br>

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

<br>

## Constructor chaining
1. Given problem

    ```java
    public class BankAccount {

        private double balance;

        private double interest;

        BankAccount() {}

        BankAccount(double balance) {
            this.balance = balance;
        }

        BankAccount(double balance, double interest) {
            this.balance = balance;
            this.interest = interest;
        }

    }
    ```

    With this above code, we already have some duplication. 

2. Solution

<br>

## Constructor Telescoping
1. Given problem



2. Solution

<br>

<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer:

[Java: Writing readable code and maintainable code](https://app.pluralsight.com/library/courses/java-writing-readable-maintainable-code/table-of-contentshttps://www.pluralsight.com/courses/java-writing-readable-maintainable-code)

[Effective Java of Joshual Bloch]()
