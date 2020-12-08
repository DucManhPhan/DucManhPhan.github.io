---
layout: post
title: Encapsulation in Object Oriented Programming
bigimg: /img/image-header/factory.jpg
tags: [OOP]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Encapsulation](#solution-with-encapsulation)
- [Some replacement ways for Encapsulation](#some-replacement-ways-for-encapsulation)
- [Some code smells that are relevant to Encapsulation](#some-code-smells-that-relevant-to-encapsulation)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)


<br>

## Given problem






<br>

## Solution with Encapsulation

1. The meaning of Encapsulation

    Encapsulation is the process of protecting data from the outside changes directly. It is related to the security in OOP. From these points of view, we can see them that appears in multiple documents, websites. But we need to ask lots of question to make these points clearer.
    - What does using **public** access specifier for all fields happen ?

        For example:

        ```java
        public class Student {
            public String name;
            public String age;
            public String address;
            
            public Student() {}
        }
        ```

        From the outside, we can access directly to its fields. It looks like the below source code:

        ```java
        public static void main(String[] args) {
            Student student = new Student();
            student.name = "something";
            student.age = 12;
        }
        ```

        From the above code, it is easy to find that Student instance's fields can be changed implicitly. When we know the address of their fields, other people can be get its value. It violates the security rules.

        Solution for this problem is that using **private** access specifier.

    - Using **private** access specifier and providing **public** services of these objects, can it violate encapsulation?

        It depends on our situations.
        - If we use DTO pattern, we can use getter/setter methods. Because this class simply contains data without behaviors.
        - Otherwise, we should use getter/setter methods improperly.

            For example:

            ```java
            public class Rectange {
                private int height;
                private int width;

                public Rectange() {}

                public int getHeight() {
                    return this.height;
                }

                public int setHeight(int height) {
                    this.height = height;
                }

                public int getWidth() {
                    return this.width;
                }

                public int setWidth(int width) {
                    this.width = width;
                }
            }
            ```


    - When our system becomes complex, which benefits does encapsulation provide?



2. How to implement encapsulation in OOP



<br>

## Some replacement ways for Encapsulation

1. Modularisation

    Grouping elements with higher internal coupling and lower external coupling.

2. Local simplicity

    Each element should have only one responsibility.

<br>

## Some code smells that are relevant to Encapsulation

1. Getter/setter methods - accessors




2. 



3. 



<br>

## Benefits and Drawbacks

1. Benefits

    - By using encapsulation properly, it can make our application easy to maintain, scalability, having less bug because isolating other objects from local state changes, so we do not change states of lots of objects from the outside. And if code changes can be made independently without effecting other classes.

    - Loose coupling between components/classes.


2. Drawbacks


<br>

## CRC process to avoid violating encapsulation




<br>

## Wrapping up

- Don't ask for the information you need to do the work; ask for the object that has the information to do the work for you.


<br>

Refer:

[https://martinfowler.com/bliki/GetterEradicator.html](https://martinfowler.com/bliki/GetterEradicator.html)

[https://www.infoworld.com/article/2073723/why-getter-and-setter-methods-are-evil.html](https://www.infoworld.com/article/2073723/why-getter-and-setter-methods-are-evil.html)

[http://www.cems.uwe.ac.uk/~jsa/UMLJavaShortCourse09/CGOutput/Unit3/unit3(0809)/page_09.htm](http://www.cems.uwe.ac.uk/~jsa/UMLJavaShortCourse09/CGOutput/Unit3/unit3(0809)/page_09.htm)

[https://www.quora.com/What-is-the-primary-benefit-of-Encapsulation](https://www.quora.com/What-is-the-primary-benefit-of-Encapsulation)

[http://www.cems.uwe.ac.uk/~jsa/UMLJavaShortCourse09/CGOutput/Unit3/unit3(0809)/page_12.htm](http://www.cems.uwe.ac.uk/~jsa/UMLJavaShortCourse09/CGOutput/Unit3/unit3(0809)/page_12.htm)
