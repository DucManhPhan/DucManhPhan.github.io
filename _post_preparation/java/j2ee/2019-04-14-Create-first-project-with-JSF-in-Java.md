---
layout: post
title: Create first project with JSF in Java
bigimg: /img/image-header/california.jpg
tags: [Java]
---


<br>

## Table of contents




<br>

## Introduction to JSF framework





<br>

## Add JSF resources into JSF project
Since JSF 2.0, we can place CSS, JS files and images or other files into a resources directory in the root of our web application.

![](../img/Java-Common/jsf-framework/add-resources.jpg)

Then we can include our CSS files using the ```h:outputStylesheet```.

For example:

```html
<h:head>
        <title>JSF Application NetBeans Example</title>
</h:head>
<h:body>
    <h:outputStylesheet library="css" name="style.css" />        
            
    <input type="text" id="txtName" data-bind="value: name" />
    <h2>Hello, <span data-bind="text: name"></span></h2>
    
    <h:outputScript library="js" name="knockout-3.5.0.js" />
    <h:outputScript library="js" name="viewmodel.js" />
</h:body>
```

The ```h:outputStylesheet``` will generate a tag of this form: 

```<link href="/context-root/faces/javax.faces.resource/styles.css?ln=css" rel="stylesheet" type="text/css"/>``` 

to the header of your page.

When render CSS file via ```h:outputStylesheet``` tag, remember put the ```<h:head />``` tag as well. Otherwise, the CSS file will not be included.

- Note:

    - URL with JSF
    
        In JSF project, if we use this link: ```http://localhost:8080/WebApp/faces/login.xhtml```, it works correctly. But if we use this link: ```http://localhost:8080/WebApp/login.faces```, the browser will not load the CSS or JS files.

        Because in ```web.xml```, we have:

        ```xml
        <web-app version="3.1" xmlns="http://xmlns.jcp.org/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd">
            <context-param>
                <param-name>javax.faces.PROJECT_STAGE</param-name>
                <param-value>Development</param-value>
            </context-param>
            <servlet>
                <servlet-name>Faces Servlet</servlet-name>
                <servlet-class>javax.faces.webapp.FacesServlet</servlet-class>
                <load-on-startup>1</load-on-startup>
            </servlet>
            <servlet-mapping>
                <servlet-name>Faces Servlet</servlet-name>
                <url-pattern>/faces/*</url-pattern>
            </servlet-mapping>
            <session-config>
                <session-timeout>
                    30
                </session-timeout>
            </session-config>
            <welcome-file-list>
                <welcome-file>faces/index.xhtml</welcome-file>
            </welcome-file-list>
        </web-app>
        ```

        So, we can see that the value of ```url-pattern``` is ```/faces/*```, then, URL obviously has ```faces``` keyword.

        Based on this consequence, we can insert the image into our project such as:

        ```javascript
        background: transparent url("#{facesContext.externalContext.requestContextPath}/resources/images/bg_button_a.gif") no-repeat scroll top right;
        ```

        --> To get the path of resources, we can use JSF context to load a resource.

    - Why do you define the output within the tag an not inside the head part?

        JSF will render css output in “head” tag automatically.

<br>

## Wrapping up




<br>

Thanks for your reading.

<br>

Refer:

[https://examples.javacodegeeks.com/enterprise-java/jsf/jsf-application-netbeans-example/](https://examples.javacodegeeks.com/enterprise-java/jsf/jsf-application-netbeans-example/)