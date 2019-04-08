---
layout: post
title: Coupling and cohesion in OOP
bigimg: /img/image-header/home-office-1.jpg
tags: [Design Pattern]
---




<br>

## Table of contents
- [cohesion](#cohesion)
- [Coupling](#Coupling)
- [Wrapping up](#wrapping-up)


<br>

## cohesion
- Definition of cohesion

    According to [wikipedia.org](https://en.wikipedia.org/wiki/Cohesion_(computer_science)), we have definition of cohesion:

    ```
    In computer programming, cohesion refers to the degree to which the elements inside a module belong together. In one sense, it is a measure of the strength of relationship between the methods and data of a class and some unifying purpose or concept served by that class. In another sense, it is a measure of the strength of relationship between the class's method and data themselves.
    ```

    --> So, cohesion focuses on how single class is designed. Higher the cohensiveness of the class, better is the OO design.

    Modules with high cohesion tend to be preferable, simple because high cohesion is associated with several desirable traits of software including **robustness**, **reliability**, and **understandability**.

    Low cohesion is associated with undesirable traits such as being **difficult to maintain, test, reuse, or even understand**.

    Cohesion is often contrasted with coupling. High cohesion often correlates with loose coupling, and vice versa.

    Single Responsibility Principle aims at creating highly cohesive classes.

    Cohesion is increased if:
    - The functionalities embedded in a class, accessed through its methods, have much in common.
    - Methods carry out a small number of related activities, by avoiding coarsely grained or unrelated sets of data.

- The history of Cohesion concept

    The coupling and cohesion were invented by **Larry Constantine** in the late **1960s** as part of Structured Design, based on characteristics of good programming practices that reduced maintainenance and modification costs. 
    
    Structured Design, cohesion and coupling were published in the article Stevens, Myers & Constantine (1974) and the book Yourdon & Constantine (1979), the latter two subsequently became standard terms in software engineering.

- Advantages of high cohesion

    - Reduced module complexity (they are simpler, having fewer operations).
    - Increased system maintainability, because logical changes in the domain affect fewer modules, and because changes in one module require fewer changes in other modules.
    - Increased module reusability, because application developers will find the component they need more easily among the cohesive set of operations provided by the module.

- For example about cohesion

    ![](../img/design-pattern/core-oop/cohension-coupling/high-low-cohesion.png)

    We can see that in low cohesion, only one class is responsible for executing a lot of jobs which are not in common. It will reduce the chance of reusability and maintaince. 

    In high cohesion, there is a separate class for all the jobs to execute a specific job, which result better usability and maintaince.

<br>

## Coupling




<br>

## Wrapping up





<br>


Refer:

[https://gravitymodel.net/core-software-principles/](https://gravitymodel.net/core-software-principles/)

[https://en.wikipedia.org/wiki/Cohesion_(computer_science)](https://en.wikipedia.org/wiki/Cohesion_(computer_science))

[https://freefeast.info/difference-between/difference-between-cohesion-and-coupling-cohesion-vs-coupling/](https://freefeast.info/difference-between/difference-between-cohesion-and-coupling-cohesion-vs-coupling/)

[https://sanaulla.info/2008/06/26/cohesion-and-coupling-two-oo-design-principles/](https://sanaulla.info/2008/06/26/cohesion-and-coupling-two-oo-design-principles/)

[https://www.infoworld.com/article/2949579/design-for-change-coupling-and-cohesion-in-object-oriented-systems.html](https://www.infoworld.com/article/2949579/design-for-change-coupling-and-cohesion-in-object-oriented-systems.html)

[https://www.geeksforgeeks.org/cohesion-in-java/](https://www.geeksforgeeks.org/cohesion-in-java/)

[https://freefeast.info/difference-between/difference-between-cohesion-and-coupling-cohesion-vs-coupling/](https://freefeast.info/difference-between/difference-between-cohesion-and-coupling-cohesion-vs-coupling/)