---
layout: post
title: Some ways to use annotation for validation in Java
bigimg: /img/image-header/yourself.jpeg
tags: [Annotation]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Using customize annotation for validation](#using-customize-annotation-for-validation)
- [Using annotations from validation framework](#using-annotations-from-validation-framework)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Normally, the step that validate all our inputs is very crucial in our code. It ensures our flows that work correctly when encourtering some abnormal cases.

In the reality, we have multiple ways to overcome this problem. Belows are some articles that we need to read before using annotations.

- [Clean code with validate input](https://ducmanhphan.github.io/2019-12-22-Clean-code-with-validate-input/)
- [Using frameworks for validation in Java](https://ducmanhphan.github.io/2019-12-24-Using-frameworks-for-validation-in-Java/)
- [Working with Nulls in Java](https://ducmanhphan.github.io/2020-02-01-Working-with-Nulls-in-Java/)


<br>

## Using customize annotation for validation

Belows are some steps that is used to customize annotation.

1. Define the class that we want to apply our annotation

    Use annotation for the specific field that we want to validate.

    ```java
    @Data
    @AllArgsConstructor
    @NoArgConstructor
    public class Transaction {

        @
        private String cardNumber;

        // ...

    }

    ```

2. Define our annotation

    ```java

    ```

    This annotation uses three annotations such as **@Target**, **@Retention**, **@Constraint**. Below is the meaning of each annotation.
    - **@Target** annotation

    - **@Retention** annotation
    
    - **@Constraint** annotation

3. Define its validator class for managing the validation

    ```java

    ```


<br>

## Using annotations from validation framework






<br>

## Benefits and Drawbacks

1. Benefits



2. Drawbacks




<br>

## Wrapping up




<br>

Refer:

[http://dolszewski.com/java/custom-validation-annotation-for-multiple-types/](http://dolszewski.com/java/custom-validation-annotation-for-multiple-types/)

[https://www.baeldung.com/java-custom-annotation](https://www.baeldung.com/java-custom-annotation)

[http://dolszewski.com/java/custom-parametrized-validation-annotation/](http://dolszewski.com/java/custom-parametrized-validation-annotation/)

[http://dolszewski.com/spring/custom-validation-annotation-in-spring/](http://dolszewski.com/spring/custom-validation-annotation-in-spring/)

[https://docs.oracle.com/javaee/7/api/javax/validation/Constraint.html](https://docs.oracle.com/javaee/7/api/javax/validation/Constraint.html)

[https://web-engineering.info/tech/JavaJpaJsf/book/ch06s07.html](https://web-engineering.info/tech/JavaJpaJsf/book/ch06s07.html)