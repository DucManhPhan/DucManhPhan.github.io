---
layout: post
title: OOP in Python
bigimg: /img/image-header/yourself.jpeg
tags: [Python]
---




<br>

## Table of contents





<br>

## How to define a class






<br>

## How to use Abstract Base Classes

Belows are some steps that we will follow to use Abstract Base Classes.

1. Import the abstract base class module

    ```python
    import abc
    ```

2. Define an abstract base class in Python 3.x

    Use the metaclass property in the class definition.

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

## 





<br>

## Wrapping up




<br>

Refer:

[]()