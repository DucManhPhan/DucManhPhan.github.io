---
layout: post
title: Some points to remember when using Lambda in Java
bigimg: /img/image-header/home-office-2.jpg
tags: [Functional Programming]
---



<br>

## Table of Contents
- [Given problem](#given-problem)
- [Solution of Lambda expression](#solution-of-lambda-expression)
- [The performance of Lambda in Java](#the-performance-of-lambda-in-java)
- [When to use](#when-to-use)
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Given problem

Assuming that we have a list of students, we want to get all students that have score is greater or equal than 7.

Then, this is our method that is defined as below:

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Student {
    private String name;
    private int age;
    private int score;
}

public List<Student> getStudentsScoreLessThan7(List<Student> students) {
    List<Student> filteredStudents = new ArrayList<>();

    for (Student s : students) {
        if (s.getScore() >= 7) {
            filteredStudents.add(s);
        }
    }

    return filteredStudents;
}
```

The drawbacks of an above solution are:
- Our code is not object-oriented

    Because if we change the condition, it will break our code. Then we need to write a new method.

    If our customer's requirement modifies, we have to change our code.

- Do not maintain and verbose code.

So, to fix these above issues, we will make conditions into objects. So, it can change dynamically depends on customer's requirements.

```java
public interface StudentCondition {
    boolean filter(Student s);
}

public class LessThan7Condition implements StudentCondition {
    public boolean filter(Student s) {
        return s.getScore() < 7;
    }
}

public List<Student> getStudentsScoreLessThan7(List<Student> students, StudentCondition condition) {
    List<Student> filteredStudents = new ArrayList<>();

    for (Student s : students) {
        if (condition.filter(s)) {
            filteredStudents.add(s);
        }
    }

    return filteredStudents;
}
```

The drawbacks of this solution:
- We will create a seperate class for each different condition. So it is a heavyweight solution.

But if our condition classes does not need to reuse somewhere, so these condition classes is redundancy.

How to deal with this problem?

<br>

## Solution of Lambda expression

1. Lambda expression

    In order to solve an above problem, we can have two options:
    - Use anonymous classes.
    - Use lambda expression.

    But using lambda expression is prefered in this case.

    ```java
    public List<Student> getStudents(List<Student> students, Predicate<Student> condition) {
        List<Student> filteredStudents = new ArrayList<>();

        for (Student s : students) {
            if (condition.test(s)) {
                filteredStudents.add(s);
            }
        }

        return filteredStudents;
    }

    getStudents(students, s -> s.getScore() >= 7);
    ```

    Below is the syntax of lambda expression.

    ```java
    (params) -> {
        // implementations
    };
    ```

    Lambda is an implementation of a functional interface. So, in the next section, we will continue to work with Functional Interface.

2. Functional Interface

    Belows are some important points of a functional interface.
    - A functional interface is an interface.
    - What does make an interface to become a functional interface?

        There's only one thing that does make it. It's the fact that a functional interface has only one abstract method. It means that the default methods, which are instance methods, and the static methods that we can define in interfaces, do not count in the total. Only the abstract methods do count.

        And there's something a little odd, is that if we add abstract methods from the **Object** class, methods like **toString()**, **equals()**, and **hashCode()**, then those abstract methods do no count in the total.

        So a functional interface may have one abstract method, as many default methods as we need, as many static methods as we need, and it can also define the method from the **Object** class.

        But sometimes we will wonder that Why would we put methods from the **Object** class in an interface?

        Any implementation of an interface will be a class that extends Object class because every class extends Object class in Java. So this class is bound to have **toString()**, **equals()**, and **hashCode()** methods.
        
        So why would we bother adding them to an interface?

        In fact, if we check the JDK, we will see that several interfaces are adding those methods in their interfaces. And the reason is simple. It's that those interfaces are changing the documentation of those methods.
        
        For instance, if we check the **Collection** interface, there is the **equals()** method defined in it. Because the semantic of this **equals()** method is changing in the case of Collection interface.
        
        It has to be more precise than the general contract defined in the **Object** class. That's the reason why we will find those methods in interfaces.

    - A functional interface may be annotated with the special annotation called **@FunctionalInterface**.

        This annotation's not mandatory. But if we add this annotation, we are just telling the compiler that "if this interface that we've written is not functional, then give us an error", so that we can fix that.

<br>

## The performance of Lambda in Java

1. How fast Lambda expressions are

    Lambdas are not instances of anonymous classes. But we can exchange the position of a lambda and an instance of anonymous classes. So we can have an equivalent return in an lambda expression and in an instance of an anonymous class. And this is very useful if we want to make some comparisons.

    ```java
    Predicate<Student> greaterThan7 = (Student s) -> s.getScore() > 7;

    // OR
    Predicate<Student> greaterThan7 = new Predicate<Student>() {
        @Override
        public boolean test(Student s) {
            return s.getScore() > 7;
        }
    }
    ```

    The first thing we may want to compare is what did the compiler generate for us, and it turns out that the code generated by the compiler is really different in the case of the lambda and in an instance of an anonymous class that does the same job as the lambda expression.

    Lambda expressions are compiled using specific bytecode instructions called **invokedynamic** that is introduced in Java 7. So if the compiled code is not the same in both cases, we can expect the performances to be very different, and indeed they are very different.

    If we compare precisely and measure the differences in performance between lambda and anonymous classes, we will see 60x difference in the execution of our code, and that's really a lot.

2. Estimate the performance cost of auto boxing

    What we want to avoid when writing lambda expressions is a mechanism introduced in Java 5 called **autoboxing**.

    Auto boxing is a trick used by the compiler to automatically convert a primitive type to an object.

    For example, the auto boxing for the int is an Integer. An Integer is an object, it has a method, it extends the object class, and it is just a wrapper on an int, which is a primitive type, which is only a value.

    On the other hand, we have the auto unboxing that opens this wrapper and returns the primitive type contained it.

    For instance, take the comparator interface. The comparator interface is a functional interface, it has only one abstract method called **compare()** that takes two objects, and this is going to compare them. Now suppose we need to create a comparator of integer.

    ```java
    Comparator<Integer> cmp = (i1, i2) -> Integer.compare(i1, i2);
    ```

    Now, if we take a closer look at how we're going to invoke this comparator, we can see that we're going to call the **compare()** method, passing, in this example, 10 and 20, as primitive types.

    ```java
    int compared = cmp.compare(10, 20);
    ```

    So, to conduct the comparison, the compiler is going to box those primitive values to be able to compare them in this **compare()** method that takes integers as a parameter, thus the boxing. And to do the comparison, we'll have to unbox those two values because the **compare()** static method from the **Integer** class takes ints as parameters. So, we box on the first step, and unbox on the second step to return the value result of the comparison of those two ints.

    The problem is that in our code, it's completely transparent. This boxing and unboxing, we do not write it, we do not see it, this is something the compiler gives us, and in that case, it's not a gift we want in our code.

    The problem is that in our application, this boxing and unboxing stuff has a cost because we are moving from the primitive type space to the object space.

    But we may think that we're comparing 10 and 20, and in that case, this cost will be very small, it will not be seen in the overall performance of our application. This is probly true.

    But remember what comparators are for. They are passed to a **sort()** method, and if we need to sort a huge list of Integers, suppose a million integers, this comparator is going to be called roughly 20 million times. And even a small amount of performance lost x 20 millions may become a performance loss that is going to be seen in the overall performance of our application.

3. The specialized interfaces for Primitive types

    To solve an above problem, Java provides **java.util.function** package, we can find a specialized version of the **function**, **predicate**, **consumer** and **supplier**, tailored to work with primitive types, instead of wrapping types.

    For example:
    - **IntPredicate** that takes an int as a primitive type and returns a Boolean.
    - **LongSupplier** does the same, produces long as primitive types.
    - **IntFunction<T>** takes int as a primitive type and returns an object of type T.
    - **LongToIntFunction** takes long primitive types and return ints as primitive types.

    So we have multiple specialization of **Suppliers**, **Consumers**, **Predicates** and **Functions** for ints, longs, and double primitive types.

    Finally, if we want to improve the performance of our application, we need to remember that and to use those specialized versions accordingly.

<br>

## When to use

- Use lambda expression in Stream API such as filter, map, reduce operations.


<br>

## Benefits and Drawbacks

1. Benefits

    - Lambda expression will compatible with the old interfaces has became functional interface at right now.
    
        If we have all parts of our application code that have been returned years ago before the days of Java 8 with interfaces that become functional now that we're using Java 8 or 11, then we can implement them using lambda expressions without having to recompile them.


<br>

## Wrapping up

- A lambda expression is an implementation of functional interface.

- A lambda expression is not another way of writing instances of anonymous classes.

- Using lambda will lead to very performant code.

- When we're dealing with the primitive types, we need to remember that we have specialized lambda expressions that are going to be much faster than the regular ones.

    It's faster to use an int predicate rather than a Predicate of Integer because we do not have to pay the price of boxing and unboxing.

<br>

Refer:

[Using Lambda Expressions in Java Code by Jose Paumard](https://app.pluralsight.com/library/courses/lambda-expressions-java-code/table-of-contents)

[https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html#lambda-expressions-in-gui-applications](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html#lambda-expressions-in-gui-applications)