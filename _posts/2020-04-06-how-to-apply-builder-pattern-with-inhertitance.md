---
layout: post
title: How to apply Builder pattern with Inheritance
bigimg: /img/image-header/yourself.jpeg
tags: [Design Pattern]
---




<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution for this problem](#solution-for-this-problem)
- [Apply Builder pattern with Template](#apply-builder-pattern-with-template)
- [Use Lombok library's annotations](#use-lombok-library's-annotations)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Supposed that we have the is-a relationship between **People** class and **Student** class.

Below is the source code looks like this.

```java
public class People {
    private String name;
    private int age;
}

public class Student {
    private String school;
}
```

How do we use Builder pattern for this problem?

<br>

## Solution for this problem

To solve this problem, there are two ways:
- Apply Builder pattern that combines template.
- Use annotations in Lombok.


<br>

## Apply Builder pattern with Template

Below is the source code for this solution:

- People class

    ```java
    public class People {

        private String name;

        private int age;

        protected People(Builder<?> builder) {
            this.name = builder.name;
            this.age = builder.age;
        }

        @Override
        public String toString() {
            return "name: " + this.name + ", age: " + this.age;
        }

        public static Builder builder() {
            return new Builder() {
                @Override
                public Builder getThis() {
                    return this;
                }
            };
        }

        public abstract static class Builder<T extends Builder<T>> {

            private String name;

            private int age;

            public abstract T getThis();

            public T name(String name) {
                this.name = name;
                return this.getThis();
            }

            public T age(int age) {
                this.age = age;
                return this.getThis();
            }

            public People build() {
                return new People(this);
            }
        }

    }

    ```

- Student class

    ```java
    public class Student extends People {

        private String school;

        public Student(Builder builder) {
            super(builder);
            this.school = builder.school;
        }

        @Override
        public String toString() {
            return super.toString() + ", school: " + this.school;
        }

        public static Builder builder() {
            return new Builder();
        }

        public static class Builder extends People.Builder<Builder> {

            private String school;

            @Override
            public Builder getThis() {
                return this;
            }

            public Builder school(String school) {
                this.school = school;
                return this;
            }

            public Student build() {
                return new Student(this);
            }

        }

    }
    ```

- Main class

    ```java
    public static void main(String[] args) {
        Student student= Student.builder()
                .name("Google.com")
                .age(30)
                .school("AlphaBet")
                .build();
        System.out.println(student.toString());

        People people = People.builder()
                .name("facebook.com")
                .age(20)
                .build();
        System.out.println(people.toString());
    }
    ```

    Then, we have our result:

    ```
    name: Google.com, age: 30, school: AlphaBet

    name: facebook.com, age: 20
    ```

    It prints what we really want.

The drawback of this solution:
- When we implement multiple inheritance such as Pupil is the subclass of Student class, then all properties of Pupil class will be used before calling fields of parent classes.

    For example:

    ```java
    Pupil pupil = (Pupil) Pupil.builder()
                .something("something with Pupil")
                .name("Pupil.com")
                .age(12)
                .school("pupil school")
                .build();
    System.out.println(pupil.toString());
    ```

    If we use the wrong order, IDE will warning some errors. Because when we call **Pupil.builder.name().age().school()** that will return Builder's instance of Student class. Then, continuously, we call **something()** method of Builder's instance of Pupil, it does not identify this fields.

<br>

## Use Lombok library's annotations

1. If we have the is-a relationship between Student and People classes

    Normally, we only want to use **@Builder** annotation with Student class like the below.

    ```java
    @Builder
    public class Student extends People {
        private String school;

        @Override
        public String toString() {
            return super.toString() + ", school: " + this.school;
        }
    }
    ```

    When creating a Student instance based on @Builder annotation, we will encounter the problem that is about name, age fields does not realize. To fix it, we have:

    ```java
    @Getter
    @AllArgsConstructor
    public class People {
        private String name;
        private int age;

        @Override
        public String toString() {
            return "name: " + this.name + ", age: " + this.age;
        }
    }

    @Getter
    public class Student extends People {
        private String school;

        @Builder
        public Student(String name, int age, String school) {
            super(name, age);
            this.school = school;
        }

        @Override
        public String toString() {
            return super.toString() + ", school: " + this.school;
        }
    }

    // main method
    Student student = Student.builder()
                .name("Google")
                .age(20)
                .school("Alphabet")
                .build();
    System.out.println(student.toString());
    ```

    The drawback of this solution:
    - In the constructor of subclass, we need all parameters of parent class and child class.
    - Do not use Builder pattern for the parent class.

        To fix this problem, we can use **builderMethodName** property in **@Builder** annotation for subclass, and only use @Builder annotation for parent class..

        ```java
        @Builder
        public class People {
            // ...
        }
        
        public class Student extends People {
            // ...

            @Builder(builderMethodName = "studentBuilder")
            Student(String name, int age, String school) {
                // ...
            }
        }

        ```

2. If we have multiple inheritance among People, Student, and Pupil classes

    ```java
    @Getter
    @SuperBuilder
    public class People {
        private String name;
        private int age;
    }

    @Getter
    @SuperBuilder
    public class Student extends People {
        private String school;
    }

    @Getter
    @SuperBuilder
    public class Pupil extends Student {
        private String something;
    }
    ```

    So, using **@SuperBuilder** annotation is the best way that satisfies our needs.

<br>

## Wrapping up

- Understanding some ways to apply Builder pattern.

<br>

Refer:

[https://www.baeldung.com/lombok-builder-inheritance](https://www.baeldung.com/lombok-builder-inheritance)

[https://stackoverflow.com/questions/17164375/subclassing-a-java-builder-class](https://stackoverflow.com/questions/17164375/subclassing-a-java-builder-class)

[https://medium.com/@GumtreeDevTeam/builder-pattern-and-inheritance-in-java-25ccd2d70c9d](https://medium.com/@GumtreeDevTeam/builder-pattern-and-inheritance-in-java-25ccd2d70c9d)

[http://www.javabyexamples.com/lets-discuss-builder-pattern](http://www.javabyexamples.com/lets-discuss-builder-pattern)

[http://kristinasherk.com/4trr1zk/using-the-builder-pattern-with-subclasses.html](http://kristinasherk.com/4trr1zk/using-the-builder-pattern-with-subclasses.html)

[https://chrononaut.org/2012/02/24/subclassing-with-blochs-builder-pattern/](https://chrononaut.org/2012/02/24/subclassing-with-blochs-builder-pattern/)