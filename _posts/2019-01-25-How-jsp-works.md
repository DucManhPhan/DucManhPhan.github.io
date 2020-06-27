---
layout: post
title: How JSP works in Java
bigimg: /img/image-header/home-office-1.jpg
tags: [Servlet]
---

When we, assumed as novice programmer, work with Java web, there are so many things to understand, or to be curious. I can list something such as annotations, jsp, servlet, spring framework, hibernate, JDBC, ... 

The most important thing to find out is how JSP works. Because we have to be aware of the process of JSP work. It makes our to understand the way that Java web takes actions. 

<br>

## Table of Contents
- [Introduction about JSP](#introduction-about-JSP)
- [How JSP works](#how-jsp-works)
- [Important note](#important-note)

<br>

## Introduction about JSP
JSP - Java Servlet Pages is a **technology for developing webpages that supports dynamic content**. This helps developers insert java code in HTML pages by making use of specidal JSP tags, most of which start with ```<%``` and end with ```%>```.

A Java Servlet Pages component is a type of Java servlet that is designed to fulfill the role of a user interface for a Java web application. Web developers write JSPs as text files that combine HTML or XHTML code, XML elements, and embedded embedded JSP tags with snippets of Java code inside them. 

When you request a .jsp file in a suitable way, **the JSP file is automatically translated into a proper Java servlet**, compiled, and if successful, loaded into the servlet engine and "run" by performing a method call into the servlet class. The generated servlet code (both source and executable forms) is cached to avoid having to regenerate it unnecessarily. Just like a full blown servlet, the servlet generated from a JSP file is able to store context between invocations. 

Using JSP, you can collect input from users through Webpage forms, present records from a database or another source, and create Webpages dynamically.

JSP tags can be used for a variety of purposes, such as retrieving information from a database or registering user preferences, accessing JavaBeans components, passing control between pages, and sharing information between requests, pages etc.

<br>

## How JSP works
The above item we had introduced about JSP's concept. In this item, we will dig into How JSP works.
- As with a normal page, your browser sends an HTTP request to the web server.

- The web server recognizes that the HTTP request is for a JSP page and forwards it to a JSP engine. This is done by using the URL or JSP page which ends with .jsp instead of .html.

- The JSP engine loads the JSP page from disk and converts it into a servlet content. This conversion is very simple in which all template text is converted to println( ) statements and all JSP elements are converted to Java code. This code implements the corresponding dynamic behavior of the page.

- The JSP engine compiles the servlet into an executable class and forwards the original request to a servlet engine.

- A part of the web server called the servlet engine loads the Servlet class and executes it. During execution, the servlet produces an output in HTML format. The output is furthur passed on to the web server by the servlet engine inside an HTTP response.

- The web server forwards the HTTP response to your browser in terms of static HTML content.

- Finally, the web browser handles the dynamically-generated HTML page inside the HTTP response exactly as if it were a static page.

Typically, the JSP engine checks to see whether a servlet for a JSP file already exists and whether the modification date on the JSP is older than the servlet. If the JSP is older than its generated servlet, the JSP container assumes that the JSP hasn't changed and that the generated servlet still matches the JSP's contents. This makes the process more efficient than with the other scripting languages (such as PHP) and therefore faster.

<br>

## Important note
- In Web Container or Servlet Container or Servlet engine, we have some steps such as converting codes in jsp file into two parts, the first part contains static html code, the second part contains java code. Then translate/build the second part into the executable code. The converting code step will be responsible by JSP engine.

<br>

Refer: 

**Need to read**

[https://beginnersbook.com/2013/05/jsp-tutorial-life-cycle/](https://beginnersbook.com/2013/05/jsp-tutorial-life-cycle/)

[https://www.buggybread.com/2014/05/j2ee-jsp-java-server-pages.html](https://www.buggybread.com/2014/05/j2ee-jsp-java-server-pages.html)

[http://mrbool.com/working-with-java-server-pages-jsp/29048](http://mrbool.com/working-with-java-server-pages-jsp/29048)

[https://www.ntu.edu.sg/home/ehchua/programming/java/JavaServerPages.html](https://www.ntu.edu.sg/home/ehchua/programming/java/JavaServerPages.html)

[https://www.tutorialspoint.com/jsp/jsp_architecture.htm](https://www.tutorialspoint.com/jsp/jsp_architecture.htm)

[https://www.tutorialspoint.com/jsp/jsp_overview.htm](https://www.tutorialspoint.com/jsp/jsp_overview.htm)

[https://docs.oracle.com/javaee/5/tutorial/doc/bnafe.html](https://docs.oracle.com/javaee/5/tutorial/doc/bnafe.html)

[https://o7planning.org/vi/10263/huong-dan-lap-trinh-java-jsp#a750360](https://o7planning.org/vi/10263/huong-dan-lap-trinh-java-jsp#a750360)

[http://www.ntu.edu.sg/home/ehchua/programming/java/javaserverpages.html](http://www.ntu.edu.sg/home/ehchua/programming/java/javaserverpages.html)

[https://www.oreilly.com/library/view/head-first-servlets/9780596516680/ch11s06.html](https://www.oreilly.com/library/view/head-first-servlets/9780596516680/ch11s06.html)

