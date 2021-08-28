---
layout: post
title: How to use JUnit framework
bigimg: /img/image-header/yourself.jpeg
tags: [Testing]
---



<br>

## Table of contents
- [Introduction to JUnit framework]()
- []()
- []()
- [Wrapping up](#wrapping-up)


<br>

## Introduction to JUnit framework

1. 



2. Configure JUnit in Spring or Maven project

    - In Spring project

        - JUnit 4

            By default, JUnit 4 is embedded into **spring-boot-starter-test** dependency.

            It means that in order to use JUnit 4, we only need to add **spring-boot-starter-test** dependency into **pom.xml** file.

            ```xml
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter-test</artifactId>
                <scope>test</scope>
            </dependency>
            ```

        - JUnit 5

            To use JUnit 5, we can follow settings in the below pom.xml file.

            ```xml
            <dependencies>
                <dependency>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-test</artifactId>
                    <scope>test</scope>

                    <!-- exclude junit 4 -->
                    <exclusions>
                        <exclusion>
                            <groupId>junit</groupId>
                            <artifactId>junit</artifactId>
                        </exclusion>
                    </exclusions>
                </dependency>

                <!-- junit 5 -->
                <dependency>
                    <groupId>org.junit.jupiter</groupId>
                    <artifactId>junit-jupiter-api</artifactId>
                    <scope>test</scope>
                </dependency>
                <dependency>
                    <groupId>org.junit.jupiter</groupId>
                    <artifactId>junit-jupiter-engine</artifactId>
                    <scope>test</scope>
                </dependency>
            </dependencies>
            ```


    - In Maven project

        - JUnit 4

            To use JUnit 4 in maven project, we need to insert this dependency in pom.xml file.

            ```xml
            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>4.12</version>
            </dependency>
            ```

        - JUnit 5

            ```xml
            
            ````

3. How to create class for unit test in Intellij

    Belows are some steps that we need to folow to create Unit Test class automatically.

    ![](../img/Testing/junit/create-class-unit-test-1.png)

    ![](../img/Testing/junit/create-class-unit-test-2.png)

    ![](../img/Testing/junit/create-class-unit-test-3.png)

    Click OK button, it will create a unit test class for us.

<br>

## 






<br>

## 





<br>

## Wrapping up




<br>

Refer:

[https://www.baeldung.com/junit-4-rules](https://www.baeldung.com/junit-4-rules)