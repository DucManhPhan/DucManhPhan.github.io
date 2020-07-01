---
layout: post
title: Front controller pattern
bigimg: /img/image-header/california.jpg
tags: [Enterprise Pattern]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution for this problem](#solution-for-this-problem)
- [Front Controller Pattern](#Front-controller-pattern) 
- [Source code](#source-code)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Given problem





<br>

## Solution for this problem





<br>

## Front Controller Pattern

According to [martinfowler.com](https://martinfowler.com/eaaCatalog/frontController.html), we have:

```
A controller that handles all requests for a website.
```




<br>

## Source code






<br>

## When to use





<br>

## Benefits and Drawbacks






<br>

## Relations with other design patterns

- ```Mediator pattern```

    The Front controller pattern is a specialized kind of Mediator pattern.

- ```Page Controller pattern```

    It's an alternative to Front Controller pattern in MVC model.

    |              |                      Page Controller                 |                          Front Controller                   |
    | ------------ | ---------------------------------------------------- | ----------------------------------------------------------- |
    | Base class   | Base class is needed and will grow simultaneously with the development of the application. | The centralization of solving all requests is easier to modify than base class method. |
    | Security     | Low security because various objects react differently without consistency. | High. The controller is implemented in coordinated fashion, making the application safer. |
    | Logical Page | Single object on each logical page | Only one controller handles all requests |
    | Complexity   | Low | High |

- ```View Helper```

    The Front Controller pattern, in conjunction with the View Helper pattern, describes factoring business logic out of the view and providing a central point of control and dispatch. Flow logic is factored forward into the controller and data handling code moves back into the helpers.

- ```Intercepting Filter```

    Both Intercepting Filter and Front Controller describe ways to centralize control of certain types of request processing, suggesting different approaches to this issue.

- ```Dispatcher View and Service to Worker```

    The Dispatcher View and Service to Worker patterns are another way to name the combination of the View Helper pattern with a dispatcher, and Front Controller pattern. Dispatcher View and Service to Worker, while structurally the same, describe different divisions of labor among components.

<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer:

[https://www.oracle.com/technetwork/java/frontcontroller-135648.html](https://www.oracle.com/technetwork/java/frontcontroller-135648.html)

[https://en.wikipedia.org/wiki/Front_controller](https://en.wikipedia.org/wiki/Front_controller)

[https://www.baeldung.com/java-front-controller-pattern](https://www.baeldung.com/java-front-controller-pattern)

[https://www.javaguides.net/2018/08/front-controller-design-pattern-in-java.html](https://www.javaguides.net/2018/08/front-controller-design-pattern-in-java.html)

[https://www.geeksforgeeks.org/front-controller-design-pattern/](https://www.geeksforgeeks.org/front-controller-design-pattern/)

