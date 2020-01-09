---
layout: post
title: How to use CDI in Java SE
bigimg: /img/image-header/yourself.jpeg
tags: [Java, Cdi]
---




<br>

## Table of contents





<br>

## 





<br>

## 






<br>

## 




<br>

## 




<br>

## Wrapping up
- For ```EJB``` and ```JAR``` packaging you should place the beans.xml in ```src/main/resources/META-INF/```.

    For ```WAR``` packaging you should place the beans.xml in ```src/main/webapp/WEB-INF/```.

    Remember that only ```.java``` files should be put in the ```src/main/java``` and ```src/test/java``` directories. Resources like ```.xml``` files should be in ```src/main/resources```.

    An application that uses CDI must have a file named ```beans.xml```. The file can be completely empty (it has content only in certain limited situations), but it must be present. For a web application, the beans.xml file must be in the ```WEB-INF``` directory. For EJB modules or JAR files, the ```beans.xml``` file must be in the ```META-INF``` directory.

    In Java EE 7 beans.xml is no longer mandatory. Refer [23.13 Configuring a CDI Application](https://docs.oracle.com/javaee/7/tutorial/cdi-basic013.htm).

<br>

Refer:

[https://aboullaite.me/cdi-20-java-se/](https://aboullaite.me/cdi-20-java-se/)

[https://docs.jboss.org/weld/reference/latest/en-US/html/environments.html#weld-se](https://docs.jboss.org/weld/reference/latest/en-US/html/environments.html#weld-se)

[http://www.mastertheboss.com/jboss-frameworks/cdi/building-a-cdi-2-standalone-java-application](http://www.mastertheboss.com/jboss-frameworks/cdi/building-a-cdi-2-standalone-java-application)