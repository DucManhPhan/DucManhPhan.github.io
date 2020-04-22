---
layout: post
title: Command syntax in JSP
bigimg: /img/image-header/home-office-1.jpg
tags: [Java, Servlet]
---




<br>

## Table of contents







<br>

## JSP Directives
Syntax:

```
<%@ directive name [attribute name=“value” attribute name=“value” ........]%>
```

The followings are some directives in JSP.

|        Directive      |           Description             |
| --------------------- | --------------------------------- |
| <%@page ... %>        | Used to define some attributes such as error, import, buffer, session , ... |
| <%@include ... %>     | Used to embbeded a file into JSP at compile time, from JSP to Servlet |
| <%@taglib ... %>      | Used to declare expanded tag elements in JSP, or customize tag elements |

- With ```<%@page ... %>``` directive

    |      Attribute     |      Intention         |       Sample       |
    | ------------------ | ---------------------- | ------------------ |
    | buffer             | specify the buffer size. If buffer size = none, the output would directly written to Response object by JSPWriter. If buffer size is different with none, the output first write to buffer, then, it will be available for response object. | ```<%@ page buffer="none"%>``` or ```<%@ page buffer="5kb"%>``` |
    | autoFlush          | If it's true, it means the buffer should be flushed whenever it's full. false will throw an exception when buffer overflows. | ```<@ page autoFlush="true"%>``` or ```<@ page autoFlush="false"%>``` |
    | contentType        | Used to set the content type of a JSP page. Default value: text/html | ```<% page contentType="text/html"%>``` or ```<%@ page contentType="text/xml"%>``` |
    | isErrorPage        | Used to specify whether the current JSP page can be used as an error page for another JSP page. If isErrorPage's value is true, it means that the page can be used for exception handling for another page. There is another use of isErrorPage attribute – The exception implicit object can only be available to those pages which has isErrorPage set to true. If the value is false, the page cannot use exception implicit object. Default value: false | ```<%@ page isErrorPage="true"%>``` |
    | errorPage          | when isErrorPage attribute is true for a particular page then it means that the page can be called by another page in case of an exception.  errorPage attribute is used to specify the URL of a JSP page which has isErrorPage attrbute set to true. It  handles the un-handled exceptions in the page. | ```<%@ page errorPage="ExceptionHandling.jsp"%>``` |




<br>

Refer: 

[https://beginnersbook.com/2013/05/jsp-tutorial-life-cycle/](https://beginnersbook.com/2013/05/jsp-tutorial-life-cycle/)

[https://www.tutorialspoint.com/jsp/jsp_syntax.htm](https://www.tutorialspoint.com/jsp/jsp_syntax.htm)

[https://o7planning.org/vi/10263/huong-dan-lap-trinh-java-jsp](https://o7planning.org/vi/10263/huong-dan-lap-trinh-java-jsp)

[https://beginnersbook.com/2013/05/jsp-tutorial-introduction/](https://beginnersbook.com/2013/05/jsp-tutorial-introduction/)
