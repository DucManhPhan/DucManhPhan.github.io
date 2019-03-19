---
layout: post
title: Understanding configuration in Gradle - Java
bigimg: /img/image-header/california.jpg
tags: [Java]
---

<br>

## Table of contents
- [Introduction to gradle](#introduction-to-gradle)
- [Setup gradle in our project](#setup-gradle-in-our-project)
- [Some tasks in Gradle](#some-tasks-in-gradle)
- [Understanding build.gradle file](#understanding-build.gradle-file)
- [Setup Gradle Tomcat plugin](#setup-gradle-tomcat-plugin)
- [Build project with Gradle](#build-project-with-gradle)
- [Run project with Gradle](#run-project-with-gradle)
- [Updating claspath with the latest changes in build.gradle file](#updating-classpath-with-the-latest-changes-in-build.gradle-file)

<br>

## Introduction to gradle




<br>

## Setup gradle in our project
- First way: Download Gradle

    We can download the lastest version of Gradle at [link](https://gradle.org/releases/). After downloaded, we have ```gradle-5.2.1-all.zip``` file.

    Next, we need to create some environment variable for Gradle.
    - Let's pretend that we put gradle folder in ```C:\gradle```.
    - Create system variables ```GRADLE_HOME``` with ```C:\gradle```, and add ```C:\gradle\bin``` to ```PATH```.

- Second way: Setup Buildship for Gradle plugin in Eclipse

    Select ```Help``` --> ```Install New Software...```.

    Select ```Add``` button --> fill in some information:
    - Name: Buildship
    - Location: http://download.eclipse.org/buildship/updates/e46/releases/1.0/1.0.19.v20160830-1454

    Next, we can setup Buildship in eclipse.

<br>

## Some tasks in Gradle

|          Tasks           |                        Description                    |
| ------------------------ | ----------------------------------------------------- |
| assemble                 | Assembles the outputs of this project.                |
| build                    | Assembles and tests this project.                     |
| buildDependents          | Assembles and tests this project and all projects that depend on it. |
| buildNeeded              | Assembles and tests this project and all projects it depends on. |
| classes                  | Assembles main classes. |
| jar                      | Assembles a jar archive containing the main classes. |
| testClasses              | Assembles test classes. |
| war                      | Generate a war archive with all the compile classes, the web-app content and the libraries. |
| tomcatJasper             | Runs the JSP compiler and turns JSP pages into Java sources. |
| tomcatRun                | Uses our files and where they are and deploys them to Tomcat. |
| tomcatRunWar             | Assembles the webapp into a war and deploys it to Tomcat. |
| tomcatStop               | Stops Tomcat. |

<br>

## Understanding build.gradle file
- Declaring repositories


- Declaring dependencies

<br>

## Setup Gradle Tomcat plugin
Each time when we want to deploy our project on a server, we have to turn project into war file, and manually run it on server based on command line or something like that. I think that it is highly inconvenient. 

So, to make it automatically, we need to install a Tomcat plugin to Eclipse. Therefore, when we build a project via Gradle task, our project will be deployed on a Tomcat server.

To install Gradle Tomcat plugin, we need insert some code into ```build.gradle``` file:

```java
apply plugin: 'com.bmuschko.tomcat'
apply plugin: 'eclipse-wtp'


buildscript {
       repositories {
             jcenter()
       }
       dependencies {
             classpath 'com.bmuschko:gradle-tomcat-plugin:2.4.1'
       }
}


dependencies {
         def tomcatVersion = '8.0.46'
         tomcat "org.apache.tomcat.embed:tomcat-embed-core:${tomcatVersion}",
         "org.apache.tomcat.embed:tomcat-embed-logging-juli:${tomcatVersion}",
         "org.apache.tomcat.embed:tomcat-embed-jasper:${tomcatVersion}"
         api 'org.apache.commons:commons-math3:3.6.1'
}


tomcat {
         httpPort = 8080
         enableSSL = true
         contextPath = '/library-spring'
}
```

<br>

## Build project with Gradle
- First way: Use Gradle Tasks View

    If you do not see the ```Gradle Tasks``` View, you can get it from ```Window``` --> ```Show View``` --> ```Other``` --> Search ```gradle``` --> Select ```Gradle Tasks```.

    In ```Gradle Tasks``` View, select ```build``` tasks in folder ```build```, right click --> ```Run Gradle Tasks```.

    ![](../img/Java-Common/gradle/build-project-gradle-task.png)

<br>

## Run project with Gradle
In ```Gradle Tasks``` View, select our current project --> select ```web application``` folder --> select ```tomcatRun``` tasks --> right click --> ```Run Gradle Tasks```.

![](../img/Java-Common/gradle/run-gradle-project-Tomcat.png)


<br>

## Updating claspath with the latest changes in build.gradle file
Eclipse does not automatically update the ```classpath```, if the ```build.gradle``` file is updated. Select ```Gradle``` --> ```Refresh Gradle Project``` from the context menu of the project or from your ```build.gradle``` file for that.

![](../img/Java-Common/gradle/updating-classpath-gradle.png)

<br>

Refer:

[https://gradle.org/training/](https://gradle.org/training/)

[https://guides.gradle.org/building-java-web-applications/](https://guides.gradle.org/building-java-web-applications/)

[https://medium.com/@wkrzywiec/setting-up-gradle-spring-project-in-eclipse-on-tomcat-server-77d68454fd8d](https://medium.com/@wkrzywiec/setting-up-gradle-spring-project-in-eclipse-on-tomcat-server-77d68454fd8d)

[https://github.com/bmuschko/gradle-tomcat-plugin](https://github.com/bmuschko/gradle-tomcat-plugin)

[https://www.vogella.com/tutorials/EclipseGradle/article.html](https://www.vogella.com/tutorials/EclipseGradle/article.html)

[https://www.tutorialspoint.com/gradle/gradle_eclipse_integration.htm](https://www.tutorialspoint.com/gradle/gradle_eclipse_integration.htm)

[https://www.journaldev.com/7971/gradle](https://www.journaldev.com/7971/gradle)

[https://docs.gradle.org/current/userguide/introduction_dependency_management.html#sub:file_dependencies](https://docs.gradle.org/current/userguide/introduction_dependency_management.html#sub:file_dependencies)

[https://docs.gradle.org/current/userguide/declaring_repositories.html#declaring_repositories](https://docs.gradle.org/current/userguide/declaring_repositories.html#declaring_repositories)

