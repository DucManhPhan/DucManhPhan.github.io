---
layout: post
title: Implementation with layout in thymeleaf
bigimg: /img/image-header/home-office-1.jpg
tags: [Thymeleaf]
---

Thymeleaf is an engine that used to interactive with HTML in View. It supported the functionalities that is relevant with splitting web page into common page components like the header, footer, menu, ... These page components can be used by the same or different layouts. This action improves the reusability of front-end and helps coder to reduce time in designer. 

In this article, we will find out about how to structure the layout with thymeleaf.

<br>

## Table of Contents
- [Layout styles](#layout-styles)
- [Commands to structure layout with thymeleaf](#commands-to-structure-layout-with-thymeleaf)
- [Wrapping up](#wrapping-up)


<br>

## Layout styles
There are two main styles of organizing layouts:
- include style
- hierarchical style

1. Inclue-style layouts

    In this style, we can directly imbue all common page components into our appropriate view. In order to achieve its style, we will use **Thymeleaf Standard Layout System** such as ```th:insert```, ```th:replace``` and ```th:fragment```.

    - Advantage
        - provide the flexibility in developing view.

    - Disadvantage
        - when having so many common page component is used in enormous place, so modifying a specific component, it makes our views to control hard.

<br>

2. Hierarchical-style layouts

    In this style, the templates are usually created with a parent-child relation, from the more general part (layout) to the most specific ones (subview --> page content). Each component of the template may be included dynamically based on the inclusion and substitution of template fragments. This can be done using **Thymeleaf Layout Dialect**.

    - Advantage
        - the reuse of atomic portions of the view and modular design.

    - Disadvantage
        - Much more configuration is needed to use them, so the complexity of the views is bigger than with **Include-style layouts** which are more nature to use.

<br>

## Commands to structure layout with thymeleaf
- Use Thymeleaf in HTML.

    To notify that we are using Thymeleaf, use this code:

    ```html
    <html xmlns:th="http://www.thymeleaf.org">
        ...
    </html>
    ```

- Insert script / css file into html using thymeleaf

    Put this below code into ```head``` element.

    ```html
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" th:href="{/webjars/bootstrap/3.3.7/css/bootstrap.min.css}" rel="stylesheet" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" th:src="@{/webjars/jquery/1.12.4/jquery.min.js}"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" th:src="@{/webjars/bootstrap/3.3.7/js/bootstrap.min.js}"></script>        
    ```

    Before we insert these codes, use ```webjars``` package. It means we have to put the below code into pom.xml file.

    ```xml
    <!--jquery, bootstrap from webjars-->
    <dependency>
        <groupId>org.webjars</groupId>
        <artifactId>bootstrap</artifactId>
        <version>3.3.7</version>
    </dependency>

    <dependency>
        <groupId>org.webjars</groupId>
        <artifactId>jquery</artifactId>
        <version>1.12.4</version>
    </dependency>
    ```

- Mark segments used to reuse in the other view

    In order to implement reusablity, use ```th:fragment```. 
    
    Assuming that all the common page component is written in layout.html file.

    ```html
    <head th:fragment="head">
        ...
    </head>

    <nav th:fragment="header" class="navbar">
        ...
    </nav>

    <footer th:fragment="footer">
        ...
    </footer>
    ```

- Use the commom page components

    We will use ```th:replace``` and ```th:insert```.

    ```html
    <head th:replace="layout::head"></head>

    <nav th:replace="layout::header"></nav>

    <footer th:replace="layout:footer"></footer>

    <div th:insert="layout:header">
        ...
    </div>
    ```

    Because we will use common page components in layout.html, we will point specific file and the name of fragment component.

- Including with markup selectors

    Fragments do not need to be explicitly specified using ```th:fragment``` at the page they are extracted from. Thymeleaf can select an arbitrary section of a page as a fragment (even a page living on an external server) by means of its Markup Selector syntax, similar to XPath expressions, CSS or JQuery selectors.

    ```html
    <div th:insert="https://www.thymeleaf.org::section.description">
        ...
    </div>
    ```

    The above code will include a ```section``` with ```class="description"``` from ```thymeleaf.org```.

    To make it happen, the template engine must be configured with ```UrlTemplateResolver```.

    ```java
    @Bean
    public SpringTemplateEngine templateEngine() {
        SpringTemplateEngine templateEngine = new SpringTemplateEngine();    
        templateEngine.addTemplateResolver(new UrlTemplateResolver());
        ...
        return templateEngine;
    }
    ```

- Using expression

    In ```templatename::selector```, both ```template``` and ```selector``` can be fully-featured expressios.

    The interesting thing in this part is that we can choose item based on the specific condition.

    ```html
    <div th:replace="fragments/footer :: ${#authentication.principal.isAdmin()} ? 'footer-admin' : 'footer'">
        &copy; 2016 The Static Templates
    </div>
    ```

    In ```fragments/footer.html```, we will define:

    ```html
    <!DOCTYPE html>
    <html>
    <head>
        ...
    </head>
    <body>
        <!-- /*  Multiple fragments may be defined in one file */-->
        <div th:fragment="footer">
        &copy; 2016 Footer
        </div>
        <div th:fragment="footer-admin">
        &copy; 2016 Admin Footer
        </div>
    </body>
    </html>
    ```

- Parameterized inclusion

- Fragment expressions

- Thymeleaf layout dialect

<br>

## Wrapping up
- To use Thymeleaf in SpringMVC, we have to configure for Template Resolver. We can reference this [link](https://www.thymeleaf.org/doc/tutorials/3.0/usingthymeleaf.html#the-template-resolver).

<br>

Refer:

[https://www.thymeleaf.org/doc/articles/layouts.html](https://www.thymeleaf.org/doc/articles/layouts.html)

[https://www.thymeleaf.org/doc/tutorials/3.0/usingthymeleaf.html#appendix-c-markup-selector-syntax](https://www.thymeleaf.org/doc/tutorials/3.0/usingthymeleaf.html#appendix-c-markup-selector-syntax)

[https://www.thymeleaf.org/doc/tutorials/3.0/usingthymeleaf.html#parameterizable-fragment-signatures](https://www.thymeleaf.org/doc/tutorials/3.0/usingthymeleaf.html#parameterizable-fragment-signatures)

[https://github.com/thymeleaf](https://github.com/thymeleaf)

[https://www.thymeleaf.org/documentation.html](https://www.thymeleaf.org/documentation.html)

