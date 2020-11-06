---
layout: post
title: OOP in Python
bigimg: /img/image-header/yourself.jpeg
tags: [Python]
---



<br>

## Table of contents
- [How to define a class](#how-to-define-a-class)
- [How to define abstract class](#how-to-define-abstract-class)
- [Wrapping up](#wrapping-up)


<br>

## How to define a class

1. private, protected, public fields in Python's class

    By default, all things in class are public. But Python use conventions for defining private, protected, public fields.
    - public field

        The field's name does not start with underscore _, but its first character is a letter.

        For example:

        ```python
        class Foo:
            def __init__(self, name):
                self.name = name

            def getName(self):
                print(self.name)

        print(Foo().getName())
        ```

    - protected field

        In Python, the protected field does not exist. So, in the nature, it is still public field. But we apply below convention for it.

        The field's name must start with underscore _ character.

        ```python
        class Foo:
            def __init__(self, name):
                self._name = name

            def _getName(self):
                print(self._name)
        ```

    - private field

        The field's name must start with the double underscore __ character.

        ```python
        class Foo:
            def __init__(self, name):
                self.__name = name

            def __getName(self):
                print(self.__name)
        ```

2. Inheritance in Python

    Like C++, Python supports the multiple inheritance. Belows are some problems that we will encounter:
    - Syntax of the multiple inheritance

        ```python
        class SubClass(BaseClass1, BaseClass2):

            # define its methods
        ```

    - From a derived class, to call a method of a base class, use **super().methodName()**.

    - To define a static field in a class

        ```python
        class Employee:
            # attribute for all employees
            empCount = 0

            def __init__(self, name, salary):
                self._name = name
                self._salary = salary

                Employee.empCount += 1

            # define getter/setter for name, salary fields
            @property
            def name(self):
                return self._name

            @name.setter
            def name(self, name):
                self._name = name

            @property
            def salary(self):
                return self._salary

            @salary.setter
            def salary(self, salary):
                self._salary = salary

            def displayCount(self):
                print('Total Employee %d' %Employee.empCount)

            def displayEmployee(self):
                print('Name: ', self._name, ', Salary: ', self._salary)


        class Director(Employee):
            def __init__(self, name, salary, grant):
                # add properties 
                Employee.__init__(self, name, salary)
                self._grant = grant

            @property
            def grant(self):
                return self._grant

            @grant.setter
            def grant(self, grant):
                self._grant = grant

            def displayEmployee(self):
                # print('Name: ' + self.name, ', Salary: ', self.salary, ', Grant: ', self.grant)
                super().displayEmployee()
                print(', Grant: ' + self._grant)

            def displayName(self):
                print("Director's name: ", self._name)


        employee = Employee('Sugar', 600)
        director = Director('Bill Gate', 10000, 'CTO')

        print('The number of employee in company: ' + str(Employee.empCount))

        print('Name of employee: {}'.format(employee.name))

        print('Salary of director: ' + str(director.salary))

        print('About director: \n')
        #director.displayEmployee()
        director.displayName()

        print('About employee: \n')
        employee.displayEmployee()

        print('About director: \n')
        director.displayEmployee()
        ```
    
3. Some decorators in Python's class

    - **@classmethod** decorator

        This decorator that applied to a method will accept its first argument is class name. And It used for factory methods that return class objects for different use cases.

        ```python
        class Employee:
            somethingGlobal = 'Hello, world'

            def __init__(self, name):
                self._name = name

            @classmethod
            def displayGlobalContent(cls):
                print('Its content: ', str(cls.somethingGlobal))

        Employee.displayGlobalContent()
        ```

    - **@staticmethod** decorator

        It define a static method in a class. This method does not receive a specific argument like the class method.

        This method will define a utility task.

        ```python
        class Employee:
            @staticmethod
            def show():
                print('Hello, world')
        ```

    - **@property** decorator

        It is used to define the getter method.

<br>

## How to define abstract class

Belows are some steps that we will follow to define abstract class.

1. Import the abstract base class module

    ```python
    import abc
    ```

2. Define an abstract base class in Python 3.x

    Use the **metaclass** property in the class definition.

    ```python
    class MyAbsClass(metaclass=abc.ABCMeta):
        @abc.abstractproperty
        def myproperty(self):
            pass

        @abc.abstractmethod
        def mymethod(self, value):
            pass

    # define an abstract class in Python 2.x
    class MyAbsClass2_x(object):
        __metaclass__ = abc.ABCMeta
    ```

3. Implement the abstract class

    ```python
    class MyConcreteClass(MyAbsClass):

        @property
        def myproperty(self):
            return 10

        def mymethod(self, value):
            assert 10 == 10

    # use in main
    c = MyConcreteClass()
    print(c.myproperty)
    ```

<br>

## Wrapping up

- Understanding how to work with class in Python.

- Take advantage of OOP in Python to implement the GOF's design patterns.
