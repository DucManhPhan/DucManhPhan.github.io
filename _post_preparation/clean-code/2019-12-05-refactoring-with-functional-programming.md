---
layout: post
title: Refactoring with Functional Programming
bigimg: /img/image-header/california.jpg
tags: [Refactoring]
---



<br>

## Table of contents




<br>

## Prevent side effects in a method

Supposed that we go to a shop, and we want to buy donuts here. Below is the source code that describe it.

```java
public class DonutShop {
    public static Donut buyDonut(CreditCard creditCard) {
        Donut donut = new Donut();
        creditCard.charge(donut.getPrice());

        return donut;
    }
}
```



<br>

## 





<br>

## Wrapping up




<br>

Refer:

[Functional Programming in Java - How functional techniques improve ebook]()

[https://www.oncehub.com/blog/moving-from-functional-to-object-oriented-programming](https://www.oncehub.com/blog/moving-from-functional-to-object-oriented-programming)

[https://livebook.manning.com/book/java-8-in-action/chapter-13/4](https://livebook.manning.com/book/java-8-in-action/chapter-13/4)

[https://dzone.com/articles/functional-programming-patterns-with-java-8](https://dzone.com/articles/functional-programming-patterns-with-java-8)

[https://blogs.oracle.com/developers/refactoring-using-functional-programming](https://blogs.oracle.com/developers/refactoring-using-functional-programming)

[https://softwareengineering.stackexchange.com/questions/213345/how-to-refactor-an-oo-program-into-a-functional-one/214421](https://softwareengineering.stackexchange.com/questions/213345/how-to-refactor-an-oo-program-into-a-functional-one/214421)

[https://dev.to/grodier/a-quick-functional-refactoring-tip-4ifb](https://dev.to/grodier/a-quick-functional-refactoring-tip-4ifb)

[https://www.infoq.com/presentations/refactoring-functional-programming/](https://www.infoq.com/presentations/refactoring-functional-programming/)

[http://mir.cs.illinois.edu/~gyori/pubs/icse13tool-LambdaFicator.pdf](http://mir.cs.illinois.edu/~gyori/pubs/icse13tool-LambdaFicator.pdf)

[http://mir.cs.illinois.edu/gyori/pubs/LambdaFicator_FSE13.pdf](http://mir.cs.illinois.edu/gyori/pubs/LambdaFicator_FSE13.pdf)

[https://hadihariri.com/2013/11/24/refactoring-to-functionalwhy-class/](https://hadihariri.com/2013/11/24/refactoring-to-functionalwhy-class/)

[https://link.springer.com/chapter/10.1007/11546382_9](https://link.springer.com/chapter/10.1007/11546382_9)

[https://www.thoughtworks.com/careers/hub/martin-interview-part1](https://www.thoughtworks.com/careers/hub/martin-interview-part1)

[https://www.infoq.com/presentations/refactoring-functional-programming/](https://www.infoq.com/presentations/refactoring-functional-programming/)

[https://www.eventbrite.com/e/refactoring-to-functional-programming-yatzi-live-coding-kata-part-2-tickets-128113441753](https://www.eventbrite.com/e/refactoring-to-functional-programming-yatzi-live-coding-kata-part-2-tickets-128113441753)