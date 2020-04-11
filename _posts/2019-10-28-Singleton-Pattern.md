---
layout: post
title: Singleton Pattern
bigimg: /img/image-header/california.jpg
tags: [Creational Pattern, Design Pattern]
---

In this article, we will learn about Singleton pattern. This pattern is very common, used in many frameworks such as Spring beans ... 

So, let's get started.

<br>

## Table of contents
- [Given Problem](#given-problem)
- [Solution of Singleton Pattern](#solution-of-singleton-pattern)
- [When to use](#when-to-use)
- [Why not to use](#why-not-to-use)
- [Benefits & Drawback](#benefits-&-drawback)
- [Replace singleton pattern with single instance](#replace-singleton-pattern-with-single-instance)
- [Code C++ /Java / Javascript](#code-c++-/java-/-javascript)
- [Relations with other Patterns](#relations-with-other-patterns)
- [Some thoughts about Singleton](#some-thoughts-about-singleton)
- [Application & Examples](#application-&-examples)
- [Wrapping up](#wrapping-up)


<br>

## Given Problem 
When we only need one instance for a class and global access for this instance, simply because this class is responsible for managing one state, or single functionality, ... So we do not need to make many instances for their case. 

For example: setting part in programming software, logging, ...

<br>

## Solution of Singleton Pattern
Singleton pattern is a creational design pattern that restricts the instantiation of a class to one object.

In Singleton, there are two ways to create instance.
- pre-initialized - it means that this instance will be instantiate before somecone call the method ```getInstance()```.
- lazy-initialized - it means that this instance will be instantiate during the first call of the method ```getInstance()```.


![Singleton Pattern with UML](../img/design-pattern/singleton-pattern/singleton.png)

In this UML diagram, Singleton pattern has some parts:
- ```instance: Singleton```: Singleton class has the unique instance.
- ```getInstance(): Singleton```: This is a public method to provide the only way to get the unique instance of Singleton. This method can be called from anywhere since it's a class method.
- ```Singleton()```: It is a private constructor to prevent someone creating additional an object of this Singleton class.
- In Singleton, there are some methods to implement business logic.


<br>

## When to use
- When we need only one resources (a database connection, a socket connection, ...)
- To avoid multiple instances of a stateless class to avoid memory waste.
- For business reasons.


<br>

## Why not to use
- Singleton hides the dependencies between classes instead of exposing them through the interface. This means we need to read the code of each method to know if a class is using another class.

- Singleton violates the ```Single Responsibility Principle```, they control their own creation and lifecycle (using lazy initialization, the Singleton chose when it is created). A class should only focus on what it is used to do.

    If we have Singleton that manages people, it should only manage people and not how/when it is created. 

- They inherently cause code to be tightly coupled. This makes faking or mocking them for unit testing very difficult.

- They carry states around for the lifetime of the application (for stateful singletons).
    - It makes unit testing difficult since we can end up with a situation where tests need to be ordered which is a piece of nonsence. By definition, each unit test should be independent from each other. 
    - Moreover, it makes the code less predictable. 

- We should not use singleton for sharing variables / data between different objects since it produces a very tight coupling.

To replace the usage of Singleton, we can [use a single instance](#replace-singleton-pattern-with-single-instance).

<br>

## Benefits & Drawback
1. Benefits
- It is easy to configure an instance of an application that extends the functionality of singleton at run-time.

- Improvement over global variable.


2. Drawback
- Singleton permits the creation only one instance of the class, while most pratical applications require multiple instances to be initialized.

- The system threads fight to access the single instance thereby degrading the performance of the applications.

- Often overused --> Although there are not generally performance problems with singletons, if we make everything a singleton, it will slow our application down.

- Difficult to unit test because Singleton does not expose interface and have private constructors as well as private member variables.

- If not careful, not thread-safe.

- Sometimes confused for Factory because oftentimes people start off with a singleton that's static, and it ends up morphing into something else. They start making the getInstance() method take parameters. A rule of thumb is that as soon as it needs an argument in that method, it is not a singleton anymore, but rather a factory.

<br>

## Replace singleton pattern with single instance

Below is structure of this project. It talks about connections between databases.

![](../img/design-pattern/singleton-pattern/factory-method_singleton.png)

In order to implement single instance, we can refer to this [link](https://github.com/DucManhPhan/Design-Pattern/tree/master/2-combination-patterns/factory-method_singleton).


<br>

## Code C++ /Java / Javascript
- C++

    Version 1: pre-initialize instance

    ```C++
    class Singleton 
    {
    public:
        static Singleton& getInstance() 
        {
            static Singleton instance;

            return instance;
        }

    }

    private:
        Singleton() {}

        // C++ 03
        // ========
        // Don't forget to declare these two. You want to make sure they
        // are unacceptable otherwise you may accidentally get copies of
        // your singleton appearing.
        Singleton(Singleton const&);                // Don't Implement
        void operator=(Singleton const&);           // Don't implement

    public:
        // C++ 11
        // =======
        // We can use the better technique of deleting the methods
        // we don't want.
        S(S const&)               = delete;
        void operator=(S const&)  = delete;

        // Note: Scott Meyers mentions in his Effective Modern
        //       C++ book, that deleted functions should generally
        //       be public as it results in better error messages
        //       due to the compilers behavior to check accessibility
        //       before deleted status
    ```

    Version 2:

- Java

    We can see source code in this [link](https://github.com/DucManhPhan/Design-Pattern/tree/master/Creational-Pattern/singleton-pattern/src/Java).

    Notes:
    - In multithreading, use ```synchronized``` in ```getInstance()``` method, it can decrease system performance by a factor of 100.

        ```Java
        public static synchronized getInstance() {
            ...
        }
        ```

    - Use an Eagerly created instance rather than lazy one.
        --> Disadvantage: Memory may be allocated and not used.

<br>

## Relations with other Patterns
- Factory method and Singleton patterns

    Normally, we only need single instance, instead of utilizing singleton pattern.

- Abstract Factory, Builder, and Prototype can use Singleton in their implementation.

- Facade objects are often Singletons because only one Facade object is required.

- State objects are often Singletons.


<br>

## Some thoughts about Singleton
- In defense of Singleton:

    - **They are not as bad as globals** because globals have no standard-enforced initialization order, and you could easily see non-deterministic bugs due to naive or unexpected dependency orders. Singleton (assuming they're allocated on the heap) are created after all globals, and in a very predictable place in the code.

    - **They're very useful for resource-lazy / -caching systems** such as an interface to a slow I/O device. If you intelligently build a singleton interface to a slow device, and no one ever calls it, you won't waste any time. If another piece of code calls it from multiple places, your singleton can optimize caching for both simultaneously, and avoid any double look-ups. You can also easily avoid any deadlock condition on the singleton-controlled resource.

- Against singletons:

    - **In C++, there's no nice way to auto-clean-up after singletons.** There are work-arounds, and slightly hacky ways to do it, but there's just no simple, universal way to make sure your singleton's destructor is always called. This isn't so terrible memory-wise -- just think of it as more global variables, for this purpose. But it can be bad if your singleton allocates other resources (e.g. locks some files) and doesn't release them.

<br>

## Application & Examples
- Good situations to use Singleton:

    - Logging framework.
    - Thread recycling pools.

<br>

## Wrapping up
- Writing a Singleton is easier than writing a single instance using Dependency Injection.

- For a quick and dirty solution, we should use a Singleton. For a long and durable solution, we should use a single instance.

- Singleton pattern has two important properties:
    - single instance
    - global access

- Version of Java earlier that 1.2 automatically clear singletons that are not being accessed as part of garbage collection.

- Singleton pattern has some problem with multithreading.

- Singleton returns same instance, and one constructor method has no arguments. Singleton has no interface.

<br>

Thanks for your reading.

<br>

Refer: 

[https://howtodoinjava.com/design-patterns/creational/singleton-design-pattern-in-java/](https://howtodoinjava.com/design-patterns/creational/singleton-design-pattern-in-java/)

[https://stackoverflow.com/questions/70689/what-is-an-efficient-way-to-implement-a-singleton-pattern-in-java?rq=1](https://stackoverflow.com/questions/70689/what-is-an-efficient-way-to-implement-a-singleton-pattern-in-java?rq=1)

[http://www.yolinux.com/TUTORIALS/C++Singleton.html](http://www.yolinux.com/TUTORIALS/C++Singleton.html)

[https://stackoverflow.com/questions/1008019/c-singleton-design-pattern](https://stackoverflow.com/questions/1008019/c-singleton-design-pattern)

[https://stackoverflow.com/questions/11831/singletons-good-design-or-a-crutch](https://stackoverflow.com/questions/11831/singletons-good-design-or-a-crutch)

[https://testing.googleblog.com/2008/08/by-miko-hevery-so-you-join-new-project.html](https://testing.googleblog.com/2008/08/by-miko-hevery-so-you-join-new-project.html)

[https://testing.googleblog.com/2008/08/where-have-all-singletons-gone.html](https://testing.googleblog.com/2008/08/where-have-all-singletons-gone.html)

[https://testing.googleblog.com/2008/08/root-cause-of-singletons.html](https://testing.googleblog.com/2008/08/root-cause-of-singletons.html)

<br>

**When to use Singleton**

[https://stackoverflow.com/questions/86582/singleton-how-should-it-be-used](https://stackoverflow.com/questions/86582/singleton-how-should-it-be-used)

<br>

**Initialization order and how to cope**

[https://stackoverflow.com/questions/211237/static-variables-initialisation-order/211307#211307](https://stackoverflow.com/questions/211237/static-variables-initialisation-order/211307#211307)

[https://stackoverflow.com/questions/335369/finding-c-static-initialization-order-problems/335746#335746](https://stackoverflow.com/questions/335369/finding-c-static-initialization-order-problems/335746#335746)

<br>

**Lifetime of static variable**

[https://stackoverflow.com/questions/246564/what-is-the-lifetime-of-a-static-variable-in-a-c-function](https://stackoverflow.com/questions/246564/what-is-the-lifetime-of-a-static-variable-in-a-c-function)

<br>

**Some threading implications to Singleton**

[https://stackoverflow.com/questions/449436/singleton-instance-declared-as-static-variable-of-getinstance-method-is-it-thre/449823#449823](https://stackoverflow.com/questions/449436/singleton-instance-declared-as-static-variable-of-getinstance-method-is-it-thre/449823#449823)

<br>

**Explain why double checked locking will not work on C++**

[https://stackoverflow.com/questions/367633/what-are-all-the-common-undefined-behaviours-that-a-c-programmer-should-know-a/367690#367690](https://stackoverflow.com/questions/367633/what-are-all-the-common-undefined-behaviours-that-a-c-programmer-should-know-a/367690#367690)

[http://www.drdobbs.com/cpp/c-and-the-perils-of-double-checked-locki/184405726](http://www.drdobbs.com/cpp/c-and-the-perils-of-double-checked-locki/184405726)

<br>

**Combines Singleton and Factory method pattern**

[https://designpatternsinjava.wordpress.com/2012/12/18/factory-method-and-singleton-patterns/](https://designpatternsinjava.wordpress.com/2012/12/18/factory-method-and-singleton-patterns/)

[https://stackoverflow.com/questions/20105914/how-do-you-combine-abstract-factory-with-singleton-pattern](https://stackoverflow.com/questions/20105914/how-do-you-combine-abstract-factory-with-singleton-pattern)

[https://blog.ilardi.com/singleton-and-factories-of-singleton](https://blog.ilardi.com/singleton-and-factories-of-singleton)

[https://softwareengineering.stackexchange.com/questions/280362/factory-for-creating-a-singleton-instance](https://softwareengineering.stackexchange.com/questions/280362/factory-for-creating-a-singleton-instance)
