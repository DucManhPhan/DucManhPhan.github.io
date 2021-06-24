---
layout: post
title: Some important principles of OOP
bigimg: /img/image-header/factory.jpg
tags: [OOP]
---

In this article, we want to find something out about important principles of OOP. It's really crucial for us because it influences what we think about object oriented analysis and design.

Let's get started.

<br>

## Table of contents
- [Common principles](#common-principles)
- [Principles of Inter-Module/Class](#principles-of-inter-module/class)
- [Principle of Module/Class](#principle-of-module/class)
- [Wrapping up](#wrapping-up)

<br>

## Common principles
1. YAGNI - You Aren't Going To Need It

    ```
    Always implement things when you actually need them, never when you just foresee that you need them.
    ```

    It means that we should implement only the functionality we need in this particular moment. We shouldn't try to anticipate the future needs, because most of the functionality we develop just in case turns out to be unused and thus, just a waste of time.

    Benefits:
    - it saves our time because we do not use this functionality.
    - Our code is short, concise, do not cause confused to the reader **What does it mean?** when reviewing our code.


2. DRY - Don't Repeat Yourself

    ```
    Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.
    ```

    Benefits:
    - It do not take so much time to refactor code.
    - Avoid duplication code makes us easily change to apply all places where it utilizes.
    - Do not make strange feeling when modifying something.

3. KISS - Keep It Short and Simple 

    ```
    Most systems work best if they are kept simple rather than made complicated.
    ```

    This principle is about making the implementation of the remaining functionality as simple as possible. The point here is that the simpler our code is, the more readable, and thus more maintainable it becomes.

    Benefits:
    - Take less time for the maintainer.
    - It's easy to follow/maintain our system.
    - It increases readability, understandability, and changeability. Furthermore writing simple code is less error prone.

4. Separation of Concerns

    This principle was probably coined by Edsger W. Dijkstra in his 1974 paper **On the role of scientific thought**.

    ```
    It is what I sometimes have called "the separation of concerns", which, even if not perfectly possible, is yet the only available technique for effective ordering of one's thoughts, that I know of. This is what I mean by "focusing one's attention upon some aspect": it does not mean ignoring the other aspects, it is just doing justice to the fact that from this aspect's point of view, the other is irrelevant.
    ```

    It means that we should break our problem into smaller problems that we can deal with it. Each small problem have specific meaning, not relevant to other problem.

    Benefits:
    - When we have specific concerns that we need to solve, we can code each concern into one module, so our team can develop it in parallel --> fast development.
    - easily to maintain because change something of one module do not affect to other modules.

<br>

## Principles of Inter-Module/Class
1. Minimise Coupling



2. Law of Demeter



3. Composition Over Inheritance



4. Orthogonality



5. Robustness Principle



6. Inversion of Control



<br>

## Principle of Module/Class

1. Maximise Cohesion

    Cohesion is a property that is relevant to the relationships between parts of class or module or component internally.
    
    In OOP, classes has high cohesion means that it has high strength relationship between methods and fields. If classes has low cohesion, it means that we have some weird cases:
    - redundancy methods/fields because we do not completely use these fields/methods.
    - these methods is not related to the functionalities of class itself. So, when we need to change these methods, it violates the SRP of SOLID principles.

    Benefits:
    - Reduced module complexity (they are simpler, having fewer operations).
    - Increased system maintainability, because logical changes in the domain affect fewer modules, and because changes in one module require fewer changes in other modules.
    - Increased module reusability, because application developers will find the component they need more easily among the cohesive set of operations provided by the module.

2. Encapsulate what changes

    If something such as fields or methods is always modified by customer requirements, so we need to encapsulate them into classes/modules.

    It means that:
    - We should make fields private by default because when we put it with ```public``` keyword, it can be changed by the other factors. So it makes us surprise this behavior, difficult to fix bug, follow to the program's flow.
    - We should use composition over inheritance such as Behavioral pattern.

    Benefits:
    - It makes our code easy to maintain, test.
    - More flexible.


3. Command Query Separation

    ```
    Each method should be either a command that performs an action or a query that returns data to the caller but not both.
    ```

    Benefits:
    - It takes less time to understand the flow of system because we can easily predict what method can do something, without jump into it to read code.
    - It has readability, easy to maintain.

4. Hide Implementation Details

    ```
    A software module hides information (i.e. implementation details) by providing an interface, and not leak any unnecessary information.
    ```

    Information hiding protects other parts of the program from extensive modification if the design decision is changed. The protection involves providing a stable interface which protects the remainder of the program from the implementation (the details that are most likely to change).

    Written another way, information hiding is the ability to prevent certain aspects of a class or software component from being accessible to its clients, using either programming language features (like private variables) or an explicit exporting policy.

    Benefits:
    - protect the integrity of the component, by preventing users from setting the internal data of the component into an invalid or inconsistent state.
    - reduces system complexity and thus increases robustness, by limiting the interdependencies between software components.


5. Curly's Law

    According to [Tim Ottinger](https://blog.codinghorror.com/curlys-law-do-one-thing/), we have:

    ```
    A variable should mean one thing, and one thing only. It should not mean one thing in one circumstance, and carry a different value from a different domain some other time. It should not mean two things at once. It must not be both a floor polish and a dessert topping. It should mean One Thing, and should mean it all of the time.
    ```

    Benefits:
    - easy to maintain software.

6. SOLID principles

    To understand about SOLID principles, we can refer some articles in this blog.

    - [Single Responsibility Principle](https://ducmanhphan.github.io/2020-01-17-Understanding-about-SOLID-part-1/)

    - [Open Close Principle](https://ducmanhphan.github.io/2020-01-07-Understanding-about-SOLID-part-2/)

    - [Liskov Substitution Principle](https://ducmanhphan.github.io/2020-01-13-Understanding-about-SOLID-part-3/)

    - [Interface Segregation Principle](https://ducmanhphan.github.io/2020-01-15-Understanding-about-SOLID-part-4)

    - [Dependency Inversion Principle](https://ducmanhphan.github.io/2020-01-15-Understanding-about-SOLID-part-5/)

<br>

## Wrapping up



<br>

Refer:

**Common Principles**

[https://java-design-patterns.com/principles/](https://java-design-patterns.com/principles/)

[https://en.wikipedia.org/wiki/KISS_principle](https://en.wikipedia.org/wiki/KISS_principle)

[http://c2.com/xp/YouArentGonnaNeedIt.html](http://c2.com/xp/YouArentGonnaNeedIt.html)

[http://c2.com/xp/DoTheSimplestThingThatCouldPossiblyWork.html](http://c2.com/xp/DoTheSimplestThingThatCouldPossiblyWork.html)

[http://wiki.c2.com/?DontRepeatYourself](http://wiki.c2.com/?DontRepeatYourself)

[http://principles-wiki.net/principles:keep_it_simple_stupid](http://principles-wiki.net/principles:keep_it_simple_stupid)

[https://en.wikipedia.org/wiki/Separation_of_concerns](https://en.wikipedia.org/wiki/Separation_of_concerns)

[http://www2.cs.uh.edu/~svenkat/SoftwareDesign/slides/ObjectOrientedDesignPrinciples.pdf](http://www2.cs.uh.edu/~svenkat/SoftwareDesign/slides/ObjectOrientedDesignPrinciples.pdf)


<br>

**Principle of Module/Class**

[https://thesoftwarelife.wordpress.com/2016/06/09/design-principle-encapsulate-what-changes/](https://thesoftwarelife.wordpress.com/2016/06/09/design-principle-encapsulate-what-changes/)

[https://en.wikipedia.org/wiki/Information_hiding](https://en.wikipedia.org/wiki/Information_hiding)

<br>

**Principles of Inter-Module/Class**

[https://medium.com/@amitkma/understanding-inversion-of-control-ioc-principle-163b1dc97454](https://medium.com/@amitkma/understanding-inversion-of-control-ioc-principle-163b1dc97454)

[https://en.wikipedia.org/wiki/Law_of_Demeter](https://en.wikipedia.org/wiki/Law_of_Demeter)