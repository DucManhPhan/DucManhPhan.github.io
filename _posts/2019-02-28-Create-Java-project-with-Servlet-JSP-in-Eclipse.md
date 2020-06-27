---
layout: post
title: Create Java project with Servlet, JSP in Eclipse
bigimg: /img/path.jpg
tags: [Servlet]
---

In this article, we will find out about how to create dynamic web project with servlet, jsp in eclipse, how to add external jar files, add new server into our project. 

<br>

## Table of contents
- [Create dynamic web project Java](#create-dynamic-web-project-java)
- [Add new server into our project](#add-new-server-into-our-project)
- [Add external libraries](#add-external-libraries)


<br>

## Create dynamic web project Java
- Select ```File``` -> ```New``` -> ```Project```.

    ![Select Project option](../img/Java-Common/create-dynamic-web-project/dynamic-web-prj-1.png)

- Go to the ```New Project``` dialog.

    ![New Project dialog](../img/Java-Common/create-dynamic-web-project/dynamic-web-prj-2.png)

    Select ```Web``` folder --> ```Dynamic Web Project```.

- Click ```Next``` button.

    ![New Dynamic Web Project dialog](../img/Java-Common/create-dynamic-web-project/dynamic-web-prj-3.png)

    Type our project name, and select ```Dynamic web module version```.

- Click ```Next``` button.

    ![New Dynamic Web Project dialog](../img/Java-Common/create-dynamic-web-project/dynamic-web-prj-4.png)

- Click ```Next``` button.

    ![New Dynamic Web Project dialog](../img/Java-Common/create-dynamic-web-project/dynamic-web-prj-5.png)

    We should select checkbox ```Generate web.xml deployment description```.

    And finally, click ```Finish``` button.

<br>

## Add new server into our project
In order to run our project, first of all, we need to add new server such as Resin, Tomcat, Glassfish.
- Right click on our project in ```Project Explorer```. Select ```New``` item, then, choose ```Other``` item.

    ![Open menu for New server](../img/Java-Common/create-server-for-project/add-server-to-project-0.png)

- Go to the ```New``` dialog. Select ```Server``` folder, choose ```Server```. Click ```Next``` button.

    ![Select Server option](../img/Java-Common/create-server-for-project/add-server-to-project-1.png)

- Go to the ```New Server``` dialog. Choose ```Resin``` and ```Resin 4.0```. 

    ![Select Server option](../img/Java-Common/create-server-for-project/add-server-to-project-2.png)

- Click ```Next``` button.

    ![Configure for server](../img/Java-Common/create-server-for-project/add-server-to-project-3.png)

    In this dialog, we can repair some information about server such as Port, username, password, ...

- Click ```Next``` button.

    ![Add project under Server](../img/Java-Common/create-server-for-project/add-server-to-project-4.png)

- Click ```Finish``` button.

<br>

## Add external libraries
- Right click on our project in ```Project Explorer```.

    ![Select option in File tab](../img/Java-Common/add-external-lib/add-external-lib-1.png)

    Select ```Build Path``` --> ```Configure Build Path ...```. 

- Go to the ```Properties for ...``` dialog. 

    ![Properties for ... dialog](../img/Java-Common/add-external-lib/add-external-lib-2.png)

    Click ```Add External JARs...``` button.

- Go to the ```JAR selection``` dialog.

    ![JAR selection dialog](../img/Java-Common/add-external-lib/add-external-lib-3.png)

    At this dialog, we will choose some jar file that we need in our project. 

- After finished to choose some jar files, we have:

    ![Properties for ...  dialog](../img/Java-Common/add-external-lib/add-external-lib-4.png)

    Click ```Apply``` button --> ```OK``` button.


<br>


Refer:

[https://www.javahelps.com/2015/04/java-web-application-hello-world.html](https://www.javahelps.com/2015/04/java-web-application-hello-world.html)

[https://www.studytonight.com/servlet/creating-servlet-in-eclipse.php](https://www.studytonight.com/servlet/creating-servlet-in-eclipse.php)

[https://stackoverflow.com/questions/2349633/doget-and-dopost-in-servlets](https://stackoverflow.com/questions/2349633/doget-and-dopost-in-servlets)

[https://stackoverflow.com/questions/11731377/servlet-returns-http-status-404-the-requested-resource-servlet-is-not-availa](https://stackoverflow.com/questions/11731377/servlet-returns-http-status-404-the-requested-resource-servlet-is-not-availa)