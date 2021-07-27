---
layout: post
title: Understanding about SAStruts in Seasar2 framework
bigimg: /img/path.jpg
tags: [Java, Seasar]
---

Before understanding about SAStruts framework, we need to read about configure Struts 1 framework at this [link](https://ducmanhphan.github.io/2019-03-11-How-to-configure-in-Struts-1-framework) in order to be aware of configuring with ```web.xml```, and ```struts-config.xml``` files. 

And then, we will discuss about ```Prject structure```, ```Architecture``` of SAStruts. 

<br>

## Table of contents
- [Project structure](#project-structure)




<br>

## Project structure

![Project structure of SAStruts](../img/struts-1-framework/project-structure.png)

In our SAStruts project, we need to follow some rules for creating project. SAStruts creates packages such as ```action``` under the root package and stores neccessary files there. The root package name can be any name we choose. In the above image, the root package name is ```turotial```.

Route package name is specified in ```convention.dicon```. In our project, it is specified as follows in ```src/main/resources```. Below is the content of ```convention.dicon``` file.

```xml
<components>
    <component
        class = "org.seasar.framework.convention.impl.NamingConventionImpl">
        <initMethod name = "addRootPackageName"> 
            <arg> "tutorial" </arg> 
        </initMethod>
    </component>
    <component
        class = "org.seasar.framework.convention.impl.PersistenceConventionImpl" />
</components>
```

In SAStruts project, some folders that we need to follow these paths:
- Webapp route: ```src/main/webapp```
- Main Java Source Path: ```src/main/java```
- convention.dicon: ```src/main/resources/convention.dicon```

SAStruts gets the path of the JSP file from the Webapp root as the base point, the path of the Java file from the ```Main Java Source Path``` as the base point, and the root package name as the base point from the convention.dicon path. WebServer, context is the base point of the URL accessed by the View.

Continously, we have something. 
- ```Actions``` are stored in the root package ```.action```. For example, the action class corresponding to the URL of ```http: // host name / project name / xxx /``` should be named XxxAction.

- The ```action form``` is stored in the root package ```.form```. For example, the action form used in XxxAction should be named XxxForm. The role of the action form is to manage the parameters of the request.

- ```Entities``` are stored in the root package ```.entity```. An entity is data that is persisted to a database. The name of the entity can be any name, but usually it will match the name of the table.

- A class that stores operations on entities is called a ```service```. The service is stored in the root package .service. The name should end with Service like XxxService. Xxx can specify an arbitrary name, but usually it will be an entity name.

- Utilities are stored in the root package ```.util```. We can put the class name freely. Utility classes usually consist of static methods.

- Store the JSP in the directory corresponding to the action . For example, JSP used in XxxAction should be stored in / xxx /. 

<br>

## 

Refer:

[https://viblo.asia/p/tim-hieu-ve-smart-deploy-trong-seasar-yMnKMLwD57P](https://viblo.asia/p/tim-hieu-ve-smart-deploy-trong-seasar-yMnKMLwD57P)

[http://s2container.seasar.org/2.4/ja/S2.4SmartDeploy.html](http://s2container.seasar.org/2.4/ja/S2.4SmartDeploy.html)

[http://s2container.seasar.org/2.4/ja/](http://s2container.seasar.org/2.4/ja/)

[https://www.techscore.com/tech/Java/ApacheJakarta/Struts/index/](https://www.techscore.com/tech/Java/ApacheJakarta/Struts/index/)

[http://itref.fc2web.com/java/seasar/sastruts.html](http://itref.fc2web.com/java/seasar/sastruts.html)

[https://kinjouj.github.io/2012/10/sastruts-3-s2jdbc.html](https://kinjouj.github.io/2012/10/sastruts-3-s2jdbc.html)

**Configure file in SAStruts**

[http://sastruts.seasar.org/fileReference.html#env](http://sastruts.seasar.org/fileReference.html#env)