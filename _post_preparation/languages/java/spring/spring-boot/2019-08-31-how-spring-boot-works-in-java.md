---
layout: post
title: How does Spring Boot works in Java
bigimg: /img/image-header/home-office-1.jpg
tags: [Java, Spring]
---

To be able to work with project that uses Spring boot, we have to understand all stuff things of Spring boot such as the work flow, classes, annotation, ... 

In this article, we will delve deeper into the work flows and the relationship between classes in Spring boot with Servlet / JSP. Now, let's go.

<br>

## Table of Contents
- [Introduction to Spring Boot](#introduction-to-spring-boot)
- [How Spring Boot works](#how-spring-boot-works)
- [The difference between Spring MVC and Spring Boot](#the-difference-between-spring-mvc-and-spring-boot)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to Spring Boot
Spring Boot is a standalone application which reduces several tedious development steps and boilerplate code and configuration. It helps us to create a web application as a standalone JAR file with zero XML configuration and embedded web server. It also bundles the application with all the necessary dependencies.

<br>

## How Spring Boot works



<br>

## The difference between Spring MVC and Spring Boot



<br>

## Wrapping up
- Spring Boot supports auto-configuration for some template engines:
    - FreeMarker
    - Groovy
    - Thymeleaf
    - Mustache

    When we are using one of the above template engines with default configuration, be default, our template will be got from ```src/main/resources/templates```.

- We should not use JSP in Spring Boot, simply because we will encounter some limitations when utilizing them with embedded servlet containers.
    - With Jetty and Tomcat, it should work if we use war packaging. An executable war will work when launched with java -jar, and will also be deployable to any standard container. JSPs are not supported when using an executable jar.

    - Undertow does not support JSPs.

    - Creating a custom error.jsp page does not override the default view for error handling. Custom error pages should be used instead.


<br>

Refer:

[https://dzone.com/articles/how-spring-boot-initialize-the-spring-mvc-applicat](https://dzone.com/articles/how-spring-boot-initialize-the-spring-mvc-applicat)

[https://stackoverflow.com/questions/44172261/how-spring-boot-application-works-internally](https://stackoverflow.com/questions/44172261/how-spring-boot-application-works-internally)