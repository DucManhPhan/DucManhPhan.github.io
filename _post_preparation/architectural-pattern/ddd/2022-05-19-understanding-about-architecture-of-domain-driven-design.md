---
layout: post
title: Understanding about the architecture of Domain-Driven Design
bigimg: /img/image-header/yourself.jpeg
tags: [DDD]
---




<br>

## Table of contents





<br>

## Given problem






<br>

## Solution with Domain-Driven Design

Each bounded context is a separate solution. It's likely that a different development team is going to be working on each individual bounded context even if it doesn't start out that way. They'll be working for different product owners and on different schedules, and by keeping them in separate solutions we give each of the teams the flexibility they need to brach, version, and release their own code.

We've created a separate solution for Performance, Rebates, and Sales.

![](../img/Architecture-pattern/Domain-driven-design/layered-architecture/contexts-ex.png)

While we put them all in the same source code repository, it's equally likely that we'll put each one in separate repository. This will make it even easier for the individual teams to branch them independently. Let us dive into the Performance solution so that we can take a closer look.

![](../img/Architecture-pattern/Domain-driven-design/layered-architecture/Performance-context-ex.png)

One thing that we should notice is that each of the projects within the solution is completely owned by its bounded context. We don't have any references to projects outside of this context. That's just another benefit of having separate solution for each bounded context. It discourages interdependencies between them. A bounded context should be just that, bounded. It should have strict boundaries so that it remains unaffected. Keeping the solutions separate makes it abundantly clear when we've crossed those context boundaries. Within each solution, the projects are organized into layers.

Eric Evan talks about four layers in his book, and we have three of them represented here. These are Domain, Application, and Presentation.
- The Domain layer contains the model. It has all of the entities and value objects of the problem domain. All of these objects are expressed in terms of the ubiquitous language. A business owner looking at this model will be able to verify whether it's accurate or not.

- Above the Domain layer we have the Application layer. This layer contains all of the business services. These are the behaviors that don't necessarily belong to a specific entity. For example, PerformanceCalculator is a service that creates ReportCard entities.

    ![](../img/Architecture-pattern/Domain-driven-design/layered-architecture/ex-Performance-ctx-Application-layer.png)

    It would be inappropriate to make this a responsibility of the ReportCard itself because that's the product of this factory. So this service, PerformanceCalculator, is separated from the Domain and moved up into the Application layer.
    
- At the top above the application layer, we have the Presentation layer. This exposes all of the services and domain objects to the outside users. The Presentation for some bounded context is a user interface. For example, the Performance.

    Presentation layer is a web application that displays ReportCards to members or the Presentation layer might be an API that some client application or external system uses in order to access the bounded context. For example, the Rebates.
    
    ![](../img/Architecture-pattern/Domain-driven-design/layered-architecture/Rebates-context-ex.png)

    Presentation layer is a WCF service that the rich client application can use to setup the Rebates. Now remember that Eric Evans talked about four layers in his book. We've only seen three. The fourth layer that he talks about is infrastructure. We didn't represent that here inside of the Domain solution because infrastructure is not domain specific. Any sort of infrastructure components that we'll need to build, we'll build off in a separate solution and bring those in as external dependencies.




<br>

## When to use





<br>

## Benefits and Drawbacks




<br>

## Wrapping up




<br>

Refer:

[Domain-Driven Design in Practice by Vladimir Khorikov](https://app.pluralsight.com/library/courses/domain-driven-design-in-practice/table-of-contents)

[Practical Domain-Driven Design in Enterprise Java](http://file.allitebooks.com/20200217/Practical%20Domain-Driven%20Design%20in%20Enterprise%20Java.pdf)

[https://blog.sapiensworks.com/tags.html](https://blog.sapiensworks.com/tags.html)

**Series about Domain Driven Design**

[https://blog.fedecarg.com/2009/03/11/domain-driven-design-and-mvc-architectures/](https://blog.fedecarg.com/2009/03/11/domain-driven-design-and-mvc-architectures/)

[https://blog.fedecarg.com/2009/03/12/domain-driven-design-and-data-access-strategies/](https://blog.fedecarg.com/2009/03/12/domain-driven-design-and-data-access-strategies/)

[https://blog.fedecarg.com/2009/03/15/domain-driven-design-the-repository/](https://blog.fedecarg.com/2009/03/15/domain-driven-design-the-repository/)

[https://blog.fedecarg.com/2009/03/22/domain-driven-design-sample-application/](https://blog.fedecarg.com/2009/03/22/domain-driven-design-sample-application/)

<br>

**Best practice - An Inroduction to Domain Driven Design**

[https://msdn.microsoft.com/en-us/magazine/dd419654.aspx](https://msdn.microsoft.com/en-us/magazine/dd419654.aspx)

<br>

[https://edwardthienhoang.wordpress.com/2017/04/08/domain-drive-development-ddd-first-thought-part-1/](https://edwardthienhoang.wordpress.com/2017/04/08/domain-drive-development-ddd-first-thought-part-1/)

[https://www.infoq.com/minibooks/domain-driven-design-quickly](https://www.infoq.com/minibooks/domain-driven-design-quickly)

[https://www.slideshare.net/nikitakova/domain-driven-design-introduction](https://www.slideshare.net/nikitakova/domain-driven-design-introduction)

[https://www.slideshare.net/manatok/refactoring-for-domain-driven-design](https://www.slideshare.net/manatok/refactoring-for-domain-driven-design)

[https://www.slideshare.net/mathiasverraes/why-domaindriven-design-matters](https://www.slideshare.net/mathiasverraes/why-domaindriven-design-matters)

[https://www.slideshare.net/PascalLaurin/implementing-ddd-with-c](https://www.slideshare.net/PascalLaurin/implementing-ddd-with-c)

[https://labs.septeni-technology.jp/design-2/domain-driven-design/domain-driven-design-cho-moi-nguoi/](https://labs.septeni-technology.jp/design-2/domain-driven-design/domain-driven-design-cho-moi-nguoi/)
