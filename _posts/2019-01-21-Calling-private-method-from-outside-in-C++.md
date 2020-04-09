---
layout: post
title: Calling private method from outside in C++
bigimg: /img/image-header/home-office-1.jpg
tags: [C++]
---

When you see the title of this article, you can think that it do not absolutely happen. I also had the same thought with you. But going deeper to find out that I realize it can do. 

In this article, we will learn how to do it and how many ways to call the private method in C++.

<br>

## Table of Contents
- [Private method of class](#private-method-of-class)
- [Use Vtable in OOP](#use-vtable-in-oop)
- [Use assembly code](#use-assembly-code)
- [Get the signature of private method](#get-the-signature-of-private-method)
- [Important note](#important-note)

<br>

## Private method of class
In Object Oriented Programming, it gives you four important concepts. It contains: 
- Inheritance
- Abstraction
- Encapsulation
- Polymorphism

The inheritance and encapsulation help you restrict the action from outside to your variable member, method of its class and classes that is derived from the parent class through some keywords such as private, protected, and public.

With private method, objects can not access to it. They do not know about the existance of private method and private variable member. They only know about public parts in class.

For example: 

```C++
class Person
{
public:
    void liftSthUp();

private:
    void doSomething(int num);

private:
    int              m_age;
    std::string      m_name;
}

Person p;
p.liftSthUp();       // work
p.doSomething(10);     // do not work
```

As you can see, person object - p can not access to the private method - doSomething().

So, you can ask yourself about question: "How do you access the private method when the OOP theory can not do it?"

But to be calm down, a function is a set of instruction to solve the specific problem. And a function is always have the specific address in memory. 

Therefore, to access the private function you have to get its address of a function.

There are two ways to get this address.

<br>

## Use Vtable in OOP
In fact, we can not access the private method directly. We will find the other way to get it.

In this part, you have to understand about vtable concept. You can search vtable on the internet. 

vtable is created when in your class, there are at least one method uses virtual keyword. 

When compiler detects one or some method have virtual keyword in the parent class or derived classes, it will create the vtable that contains all function pointers that are as same as the signature of virtual function.

Each class (includes the derived class) that have one vtable.

So, in your derived class, you override the method from the parent class in the private area. Vtable will still contains the function pointer that refer to this private method.

This is the key for our to access this private method.

For example:

```C++
class Person
{
public:
    virtual void doSomething(int num);
    virtual void liftSthUp();

private:
    int              m_age;
    std::string      m_name;
};

class Student : public Person
{
private:
    void doSomething(int num);

public:
    void liftSthUp();
};

Person* p = new Student();
p->doSomething();   // work!!
```

<br>

## Use assembly code
In your program, there is always an function pointer table that contains addresses of all functions, that includes methods in classes. The compiler will not appear this table for our. 

This table is an array of the continuous jmp far instructions. The first element of this array is a jmp far instruction to jump to the main of program. 

In Visual C++, the number bytes of jmp far instruction is 5 in 32-bit system. With 64-bit, it can be 10.

So, to calculate the address of function in the above table, you have to know about the index of private method in this table. Then, the address of private method is equal to (index_in_table * num_bytes_jmp_far_instruction).

Because our function is a private method, therefore, we will have to push the address of class's object into **ecx** register.

In order to use assembly code in C++, insert assembly code into the scope of **_asm**. If your private method has some parameters, we will use the **push** instruction to put data into stack. Finally, we will **call** (function) the private method.

For example:

```C++
int main()
{
    Person p;
    long lObjAddress = (long)&p;

    // use _asm to call private method
    long addrMain = (long)main;
    long indexInTable = 2;
    long numBytesJmpFar = 5;
    long addrPrivateMethod = addrMain + (indexInTable * numBytesJmpFar);
    long parameter = 8;

    _asm 
    {
         push parameter; 
         mov ecx, lObjAddress;
         call addrPrivateMethod;
    }

    return 0;
}
```

<br>

## Get the signature of private method
The third way is to read the PE file in **.code** segment. And this private method have to be detected easily.

This way do not depend the compiler, but it's really arduous, because actually we only have classes in static library, shared library or header files.

<br>

## Important note
- If our private method is an virtual method, use the way - vtable in oop.
- Use asm code is extremly difficult because of depending on the compiler and version of compiler.
- With method that do not have virtual keyword, C++ compiler will make machine code as same as the other functions, and push the address of **this** pointer through **ecx** pointer. 

<br>

Refer: 

[http://diendan.congdongcviet.com/threads/t13568::cach-goi-mot-private-method-cua-mot-class-trong-cpp.cpp/page4/](http://diendan.congdongcviet.com/threads/t13568::cach-goi-mot-private-method-cua-mot-class-trong-cpp.cpp/page4/)

