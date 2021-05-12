---
layout: post
title: Defensive programming with consistent objects
bigimg: /img/image-header/yourself.jpeg
tags: [Clean Code]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution with Consistent Objects](#solution-with-consistent-objects)
- [Some problems with Constructors](#some-problems-with-constructors)
- [Using Builder pattern to solve Constructors's problem](#using-builder-pattern-to-solve-constructor's-problem)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Assuming that we have a Student class that looks like a below definition:

```java
public class Student {
    private String name;

    public void setName(String name) {
        this.name = name;
    }

    public void getName() {
        return this.name;
    }
}
```

But using the above code, we can find that it has some wrong approaches. So there are some questions that always appears in our mind.
- Can **name** field be empty?
- Can it be null?
- About Object's internal operation, what will happen to the object if its state is inconsistent ?

    If internal object states would probably lead to execution errors and execution errors must be prevented, which gives rise to defensive coding. If we can expect errors in data, then all operations related to data must be guarded.

    For example:

    ```java
    public class Student {
        private String name;

        // getter and setter of name field
        // ...

        public int getNameLength() {
            // fail if name field is null
            return this.name.length;
        }

        public char getInitialLetterName() {
            // fail if name is null or empty
            return this.name.charAt(0);
        }
    }
    ```

    After applying defensive coding for the above example, we have:

    ```java
    public in getNameLength() {
        if (this.name != null) {
            return this.name.lenggth;
        } else {
            return 0;
        }
    }

    public char getInitialLetterName() {
        if (this.name != null && this.name.length > 0) {
            return this.name.charAt(0);
        } else {
            return 'A';
        }
    }
    ```

    The drawbacks of the above defensive coding are:
    - it has multiple boilerplate code to guard our code.
    - it makes solution a couple of times longer.

- About Dependee's operation, what will happen to others if an object publicly exposes inconsistent state ?

<br>

## Solution with Consistent Objects

From the above example, we have some conclusions:
- If only the name field could never be null or empty, then we would have nothing to defend from.
- Introduce factory function for a stateful object.

    Factory function is the function which constructs an object and does that correctly and completely. In object-oriented languages, every class comes with an implicit factory function that is the implicit parameterless constructor.

    ```java
    public class Student {
        private String name;

        // getter and setter for name field
        // ...

        // implicit parameterless constructor
        // set numeric fields to zero, boolean field to false, references to null
        public Student() {}
    }
    ```

    With implict parameterless constructor, the **name** field will be set to null. When we allow that to happen, we would have to use defensive coding for that field. Normally, we do not want to write defensive code in multiple places where appear the **name** field. Instead, we want to recognize the sources which are making us have to defend in the first place. Then, we have to get rid of those sources.

    In our example, the sources of troubles is in the implicit constructor which is initializing the field to an impossible value. So we will use another form of Student constructor.

    ```java
    public class Student {
        private String name;

        public Student(String name) {
            this.name = name;
        }

        public String getName() {
            return this.name;
        }
    }
    ```

    In the above custom parameterized constructor, we set the **name** field to non-default values. However, the client still have a chance to pass null value to the name field. So, we need to defend in the custom parameterize constructor by throwing an exception.

    ```java
    public class Student {
        private String name;

        public Student(String name) {
            if (StringUtils.isNullOrEmpty(name)) {
                throw new RuntimeException();
            }

            this.name = name;
        }

        public String getName() {
            return this.name;
        }

        public int getNameLength() {
            return this.name.length;
        }

        public char getInitialLetterName() {
            return this.name.charAt(0);
        }
    }
    ```

    After defending the one place that can cause inconsistent state of the name field, no need to defend when accessing internal state. The above constructor ensures that only valid objects can be created. And the caller will never be able to obtain an inconsistent object. Under the idea of factory functions, every stateful object should have a factory function which constructed in complete and consistent state.


<br>

## Some problems with Constructors

1. Using factory methods for solving Constructor problems

    Constructors don't have their own names. Constructors are named after a class, and it doesn't necessarily communicate their own logic.

    For example:

    ```java
    public class Student {
        private String name;
        private Semeter enrolled;
        private boolean comesFromExchange;

        public Student(boolean comesFromExchange, String name) {
            if (StringUtils.isNullOrEmpty(name)) {
                throw new RuntimeException();
            }

            this.comesFromExchange = comesFromExchange;
            this.name = name;
        }

        public void enroll(Semeter semester) {
            if (semester == null || semester.getPredecessor() != this.enrolled) {
                throw new IllegalArgumentException();
            }

            this.enrolled = semester;
        }
    }
    ```

    One common technique to improve communication skills of the constructor is to replace it with one or more static factory methods and transform that constructor to **private**.

    ```java
    public class Student {
        // fields, getter

        private Student(boolean comesFromExchange, String name) {
            // ...
        }

        public static Student create(String name) {
            return new Student(false, name);
        }

        public static Student createFromExchange(String name) {
            return new Student(true, name);
        }
    }
    ```

    This solution with static factory methods is bringing troubles on a different places. If we have multiple factory methods indicate that the class is doing more than one thing. And this is true for this Student class. Boolean flag will affect the way it execute the enroll() method.

    ```java
    public void enroll(Semester semester) {
        if (semester == null || (!this.comesFromExchange && semester.getPredecessor() != this.enrolled)) {
            throw new IllegalArgumentException();
        }

        this.enrolled = semester;
    }
    ```

    Having a boolean flag inside an object is bad coding practice. Callers will probably need to think how to deal with an object, depending on the method which was used to construct it. In this case, the execution of enroll() method is affected by the private boolean flag. If we catch ourself making more than one factory method for one class, we better ask ourself, is it really one class we're talking about? Maybe we're talking about two classes only merged together into one piece of code.

    Below is the rules of thumb:
    - Define one factory method per class.
    - Have no discrete parameters (no enums, Booleans, ...)

    So, we need to separate Student class into two classes based on the **private comesFromExchange** boolean flag.

    ```java
    public abstract class Student {
        private String name;
        private Semester enrolled;

        protected Student(String name) {
            if (StringUtils.isNullOrEmpty(name)) {
                throw new RuntimeException();
            }

            this.name = name;
        }
        
        public void enroll(Semester semester) {
            if (!this.canEnroll(semester)) {
                throw new RuntimeException();
            }

            this.enrolled = semester;
        }

        public abstract boolean canEnroll(Semester semester);

        public Semester getEnrolled() {
            return this.enrolled;
        }

    }

    public class RegularStudent extends Student {
        public RegularStudent(String name) {
            super(name);
        }

        @Override
        public boolean canEnroll(Semester semester) {
            return semester != null && semester.getPredecessor.equals(this.getEnrolled());
        }
    }

    public class ExchangeStudent extends Student {
        public ExchangeStudent(String name) {
            super(name);
        }

        @Override
        public boolean canEnroll(Semester semester) {
            return semester != null;
        }
    }
    ```

    Then, we have a rule of thumb:
    - Never accept null argument value.

2. Drawbacks of Constructor

    - Every object should start off in a complete and consistent state. Later on, the object will move for different states. What happens to that object later during its lifetime is a different story. But again we will insist on making all other states of the object complete and consistent too. If we can make that happen, then we will never have to defend against inconsistencies in the objects internal state and how back to the entire state.

        The trick is that if consistency criteria were violated before constructing the instance, then the factory method would fail and it would not produce the object on the output. In other words, we will be prevented from laying our hands on an inconsistent or incomplete object. There will never be a reference to an inconsistent object. It requires no defensive code at all in any methods which consumes the object.

        ![](../img/clean-code/defensive-programming/consistent-objects/construction-process.png)

        Below is the object rule:
        - If you have the object, then it is fine.

            If it weren't fine, you wouldn't have the object in the first place.

    - Assuming that we have an application with:

        Constructor ExamApplication object:
        - Student - takes the exam
        - Subject - in which the exam is taken
        - Professor - administers the exam

        The rules for this application:
        - student != null
        - subject != null
        - professor != null
        - student enrolled semester of subject
        - student has not passed exam on subject
        - subject taught by professor

        The below ExamApplication's constructor can't execute if any of the rules are violated. It is common to throw exceptions in each of the cases.

        ```java
        class ExamApplication {
            private Subject onSubject;
            private Professor administeredBy;
            private Student takenBy;

            public ExamApplication(Subject onSubject, Professor administrator, Student candidate) {
                if (onSubject != null) {
                    throw new IllegalArgumentException();
                }

                if (administrator != null) {
                    throw new IllegalArgumentException();
                }

                if (candidate != null) {
                    throw new IllegalArgumentException();
                }

                this.onSubject = onSubject;
                this.administeredBy = administrator;
                this.takenBy = candidate;
            }

            public Subject onSubject() {
                return this.onSubject;
            }

            public Professor administeredBy() {
                return this.administeredBy;
            }

            public Student takenBy() {
                return this.takenBy;
            }
        }
        ```

        But what's wrong with exceptions thrown from constructors? The truth is that someone was in need of an ExamApplication object and that someone has invoked the constructor expecting to have an object after that make knowing an exception. We're actually not creating an object. That's bad thing. If we consider that the application will not be able to continue with execution of the current operation, this situtation is indicated of a limitation that comes with the concept of constructors. Constructor cannot tell in advance whether it will succeed or not. We can only invoke it and hope for the best. Defending from a constructor, which communicates rule violations by throwing exceptions, boils down to handling exceptions.

        ```java
        try {
            ExamApplication appl = new ExamApplication(student, subject, professor);
            dealWith(appl);
        } catch(Exception ex) { // try-catch is probably the heaviest if-then-else you could ever think of
            ex.printStackTrace();
        }
        ```

        One problem here is that we're employing heavy mechanism exception handling to control one tiny bit of behavior. If only we could ask the constructor if everything is all right with our arguments before invoking it. We would know that there is a problem in advance and we wouldn't even involved a construct. There would be no exception to catch in the first place. 

<br>

## Using Builder pattern to solve Constructors's problem

1. Promoting Constructor into Builder

    Based on the above example, we can find that to remove exception handling mechanism when we call the Constructor of ExamApplication, we need to define **alright()** method to validate all its fields.

    ```java
    if (alright(professor, subject, student)) {
        ExamApplication appl = new ExamApplication(student, subject, professor);
        dealWith(appl);
    } else {
        displayWarning();
    }
    ```

    The above code is the same as the process with exception handling. Only this time we're fully prepared for the negative scenario. This code segment is acknowledging that there are two ways to proceed and none of them is in any way exceptional. However, this code is indicated another subtle issue.
    - It turns out that both **alright()** method and **ExamApplication** constructor are now to contain the same validation logic.

        That is the clear case of code duplication, which is a bad idea when it comes to the main rules. We must keep rules in only one place because that is the only way to guarantee that the same rules will be observed by all objects in the system.

    - We can deal with code duplication by turning defensive part of this code into an object which would control the rules and then constructed a target object.

    After ensuring that whole rules are obeyed in perspective, that object will replace both the **alright()** method and the constructor validation in the **ExampleApplication** class, we will call the new class as ExamApplicationBuilder class.

    ```java
    public class ExamApplicationBuilder {
        private Professor administrator;
        private Subject subject;
        private Student candidate;

        public void administeredBy(Professor administrator) {
            this.administrator = administrator;
        }

        public void onSubject(Subject subject) {
            this.subject = subject;
        }

        public void takenBy(Student candidate) {
            this.candidate = candidate;
        }

        /**
         * It indicates whether it's safe to call build() or not
         */
        public boolean canBuild() {
            return this.administrator != null && this.subject != null && this.candidate != null &&
                   this.candidate.getEnrolled() == this.subject.getTaughtDuring() &&
                   !this.candidate.hasPassedExam(this.subject) &&
                   this.subject.getTaughtBy() == this.administrator;
        }

        public ExamApplication build() {
            if (!this.canBuild()) {
                throw new InvalidOperationException();
            }

            return new ExamApplication(this.subject, this.administrator, this.candidate);
        }
    }
    ```

    This code is probably the simplest way of externalizing rules that must be satisfied before an object comes into being.

    Belows are some rules that we need to know:
    - Existential Precondition

        A rule which must be satisfied before an object can be constructed.

        It means that we won't have to type any of that defensive code in the remainder of the demonstration.

    - Reinforcing the Object rule

        If we have an object, then it's fine.

        It means that we should not have to check any subsequent rules after an object has been constructed. Those checks would be the defensive coding.

2. Variations in the Builder implementation

    For example:

    ```java
    public ExamApplication build() {
        if (!this.canBuild()) {
            throw new InvalidOperationException();
        }

        return new ExamApplication(this.subject, this.administrator, this.candidate);
    }
    ```

    In the **build()** method, the builder is still instancing the **ExamApplication** object from the constructor, which is somewhat strange. It indicates that anyone else might also choose to instance the same class and leave the builder out of the equation.

    ```java
    public class Student {
        // ...

        public void enroll(Semester semester) {
            if (!this.canRoll(semester)) {
                throw new ArgumentException();
            }

            this.enrolled = semester;

            // construct ExamApplicationBuilder or ExamApplication classes
            // ...
        }
    }
    ```

    For example, in the Student class, we might try to instance it. We have accessed to both the ExamApplication and ExamApplicationBuilder classes. This may lead to confusion and bugs. The trick to use is to move the concrete class stated by the builder into a separate package. Consumer will not reference that class anymore, but, for instance, some interfaces.
    - The first step is to create something like implementation package. 

        Then move ExamApplication class to this implementation package. So consumers won't have to think about.

    - Then, we will remove any validation from its ExamApplication constructor.

        ```java
        public class ExamApplication {
            // ...

            public ExamApplication(Subject onSubject, Professor administrator, Student candidate) {
                this.onSubject = onSubject;
                this.administeredBy = administrator;
                this.takenBy = candidate;
            }
        }
        ```

        This class is now part of the infrastructure, and we don't want to perform any validation in its constructor that will all be the builder duty. On the other hand, in the same package with a builder, we will create an interface which represents IExamApplication. This interface will only declare property getters and that will be its only responsibility.

        ```java
        public interface IExamApplication {
            Subject onSubject();
            Professor administeredBy();
            Student takenBy();
        }
        ```

        The concrete ExamApplication class will implement this interface.

        ```java
        public class ExamApplication implements IExamApplication {
            // ...            
        }
        ``` 

        Then, in the ExamApplicationBuilder class's build() method, we will return the interface.

        ```java
        public IExamApplication build() {
            if (!this.canBuild()) {
                throw new InvalidOperationException();
            }

            return new ExamApplication(this.subject, this.administrator, this.candidate);
        }
        ```

        With this change, concrete class, the one which doesn't contain any validation will be removed from sight. And in the Student class, we have:

        ```java
        public class Student {
            // ...

            /**
             * Take advantage of lazy load of stream or functional interface in java
             */   
            public IExamApplication applyFor(Subject examOn, Professor administeredBy) {
                ExamApplicationBuilder builder = new ExamApplicationBuilder();
                builder.onSubject(examOn);
                builder.administeredBy(administeredBy);
                builder.takenBy(this);

                if (builder.canBuild()) {
                    return builder.build();
                } else {
                    // do somthing smarter
                    throw new ArgumentException();
                }
            }
        }
        ```

<br>

## Wrapping up

- To address complex validation rules

    - Abandon constructor validation
    - Introduce a Builder

- With the Builder concept

    - Wrap validation and construction into an object itself.
    - Builder implementation can vary in complexity.


<br>

Refer:

[Advanced Defensive Programming Techniques by Zoran Horvat](https://app.pluralsight.com/library/courses/advanced-defensive-programming-techniques/table-of-contents)