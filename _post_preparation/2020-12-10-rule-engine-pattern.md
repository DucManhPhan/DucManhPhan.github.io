---
layout: post
title: Rules Engine Pattern
bigimg: /img/image-header/yourself.jpeg
tags: [Enterprise Pattern]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Rules Engine Pattern](#solution-with-rules-engine-pattern)
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Some related patterns with Rules Engine Pattern](#some-related-patterns-with-rules-engine-pattern)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

![](../img/design-pattern/rules-engine/problems.png)

Belows are some common examples that we need to apply rules.
1. Scoring games

    Many games include a variety of rules that can be used to calculate the optimal score. In order to determine the score, games can also be used to determine a winner in games that don't necessarily use traditional scorekeeping.

2. Calculating discounts for customer purchases

    Many organizations offer discounts to customers or partners, many of which begin simply enough, but over time, can grow very complex as new promotions are added.

3. Diagnosing health concerns

    An expert system typically includes both an inference engine, as well as a body of knowledge in the form of rules gleaned from real world experts, like doctors in the case of a medical system.


Next, we have a simple discount calculator.

```java
public class Customer {
    private Date dateOfFirstPurchase;
    private Date dateOfBirth;
    private boolean isVeteran;

    // getter, setter
    // ...
}

public class DiscountCalculator {
    public Decimal calculateDiscountPercentage(Customer customer) {
        if (customer.getDateOfFirstPurchase() == null) {
            return .15;
        } else {
            if (customer.getDateOfFirstPurchase() < Date.now().addYears(-15)) {
                return .15;
            }

            if (customer.getDateOfFirstPurchase() < Date.now().addYears(-10)) {
                return .12;
            }

            if (customer.getDateOfFirstPurchase() < Date.now().addYears(-5)) {
                return .10;
            }

            if (customer.getDateOfFirstPurchase() < Date.now().addYears(-2) && !customer.isVeteran()) {
                return .08;
            }

            if (customer.getDateOfFirstPurchase() < Date.now().addYears(-1) && !customer.isVeteran()) {
                return .05;
            }
        }

        if (customer.isVeteran()) {
            return .10;
        }

        if (customer.getDateOfBirth() < Date.now().addYears(-65)) {
            return .05;
        }

        return 0;
    }
}
```

<br>

## Solution with Rules Engine Pattern

A rules engine processes a set of rules and applies them to produce a result. The engine is one part of the pattern. The engine's responsibility is to process and apply the rules to a given context or situation, typically producing a result.

A rule may describe a condition and may calculate a value. Rules are grouped together into collections for use in rules engines. Different algorithms and approaches may involve every rule and operating on their results or ordering the rules in a particular manner based on some precedence.

The rules engine pattern is categorized as a behavioral design pattern because it can be used to model the behavior of part of a system. In some cases, companies may purchase an off-the-shell business rules system, but for the purposes of this design pattern, we're going to look at how we can easily build our own simple rules engine to improve and simplify the design of our application.

Like most design patterns, we can start out by approaching a new problem with the pattern implementation in mind. Or we can refactor existing code to make use of a pattern. The rules engine pattern lends itself particularly well to the latter scenario of refactoring some existing code to improve its design. Once we identify certain code smells that indicate there might be a problem, keep this pattern in mind as a potential solution.

1. Defining rules

    - Each rule we extract should follow Single Responsibility Principle.

        Now rules need to be evaluated somewhere in our system. When refactoring, we might evaluate them by hand in our existing method at first. But eventually, we'll want the responsibility of evaluating a result from a collection of rules to reside in its own type. That will be the rules engine class.

    - Rules are managed using an engine that chooses which rules to apply.

    - Rules may be ordered, aggregated, or filtered as appropriate.

<br>

## Source code





<br>

## When to use





<br>

## Benefits and Drawbacks

1. Benefits

    - It's greate pattern for eliminating complex, conditional logic and replacing it with modular and maintainable code.


2. Drawbacks


<br>

## Some related patterns with Rules Engine Pattern




<br>

## Wrapping up




<br>

Refer:


[C# Design Patterns: Rules Engine Pattern by Steve Smith](https://app.pluralsight.com/library/courses/c-sharp-design-patterns-rules-pattern/table-of-contents)

[]()

[]()

[]() 