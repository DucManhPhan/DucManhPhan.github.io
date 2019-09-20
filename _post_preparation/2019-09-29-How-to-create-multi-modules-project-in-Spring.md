---
layout: post
title: How to create multi-modules project in Spring
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Java, Spring]
---




<br>

## Table of contents
- [Create multi-modules project](#create-multi-modules-project)
- [Benefits and drawbacks](#benefits-and-drawbacks)
- [Some problems that we configure multi-modules projec](#some-problems-that-we-configure-multi-modules-project)
- [Deploy multi-module project](#deploy-multi-module-project)
- [Wrapping up](#wrapping-up)

<br>

## Create multi-module project
1. Structure of multi-module project

    - Parent project will configure with ```packing``` tag with ```pom```. It will consist of version for all child projects, dependencies management, plugin management for building project.

    - Child project ```main``` will contain ```static main method```. It will have all dependencies that are child projects, and we will configure it to build jar file.

    - Child project ```configuration``` will contain all configurations of program such as configurations of Spring MVC, or Webflux, and some beans ...

    - Child project ```shared``` will consist of some utility classes such as StringUtils, JsonUtils, CollectionUtils, ...

    - Child project ```webservice``` will contain all interfaces to communicate with client through Restful Api.

    - Child project ```func-employee``` will contain implementation of controller, and other services, or repositories, or dao layer, and entities for mapping between objects and records in database.

2. We will create multi-module project with two ways:
    - Use command line prompt with maven.


    - Use GUI with support of Intellij IDEA or Eclipse.



3. Deploy multi-module project
    There are some multiple ways to build multi-modules project into one fat jar file.
    - Use ```maven-shade-plugin```

        ```xml
        <properties>
            <version.root>0.1</version.root>
            <start-class>com.manhpd.vcs-lol.Application</start-class>
            <application-name>vcs-lol<application-name>
        </properties>

        <build>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-shade-plugin</artifactId>
                    <version>3.2.1</version>
                    <executions>
                        <execution>
                            <id>create-fat-jar</id>
                            <phase>package</phase>
                            <goals>
                                <goal>shade</goal>
                            </goals>
                            <configuration>
                                <transformers>
                                    <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                        <mainClass>${start-class}</mainClass>
                                    </transformer>
                                </transformers>
                                <finalName>${application-name}</finalName>
                            </configuration>
                        </execution>
                    </executions>
                </plugin>
            </plugins>
        </build>
        ```

        We can refer this [link](https://stackoverflow.com/questions/50976412/create-jar-file-as-aggregation-in-maven-multi-module-package).

    - Use ```spring-boot-maven-plugin```

<br>

## Benefits and drawbacks





<br>

## Some problems that we configure multi-modules project
- In Intellij IDEA, usually cope with the error about "java: packages do not exists"



- Create life cycle between dependencies



- RestController/Controller/Service/Component was not called when each controller/service/component in one modules.

    [https://stackoverflow.com/questions/33039774/restcontroller-in-other-package-doesnt-work](https://stackoverflow.com/questions/33039774/restcontroller-in-other-package-doesnt-work)




<br>

## Deploy multi-module project




<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer:

[https://books.sonatype.com/mvnex-book/reference/multimodule-sect-running-web.html](https://books.sonatype.com/mvnex-book/reference/multimodule-sect-running-web.html)

[https://stackoverflow.com/questions/37133210/springboot-doesnt-recognize-restcontroller-from-another-module-in-multi-module](https://stackoverflow.com/questions/37133210/springboot-doesnt-recognize-restcontroller-from-another-module-in-multi-module)

[https://github.com/NABEEL-AHMED-JAMIL/pdftest/tree/master/multi-mudule](https://github.com/NABEEL-AHMED-JAMIL/pdftest/tree/master/multi-mudule)

[https://github.com/spring-projects/spring-boot/issues/12969](https://github.com/spring-projects/spring-boot/issues/12969)

[https://www.roytuts.com/spring-boot-multi-module-project/](https://www.roytuts.com/spring-boot-multi-module-project/)

[http://www.miredot.com/docs/manual/general/project-organization/](http://www.miredot.com/docs/manual/general/project-organization/)

[https://stackoverflow.com/questions/52167511/controller-restcontroller-and-component-not-working-in-child-package-in-spr](https://stackoverflow.com/questions/52167511/controller-restcontroller-and-component-not-working-in-child-package-in-spr)

[https://stackoverflow.com/questions/37133210/springboot-doesnt-recognize-restcontroller-from-another-module-in-multi-module](https://stackoverflow.com/questions/37133210/springboot-doesnt-recognize-restcontroller-from-another-module-in-multi-module)

[https://www.mkyong.com/maven/maven-how-to-create-a-multi-module-project/](https://www.mkyong.com/maven/maven-how-to-create-a-multi-module-project/)

[http://www.rationaljava.com/2015/02/maven-tip-all-about-executable-jars.html](http://www.rationaljava.com/2015/02/maven-tip-all-about-executable-jars.html)

