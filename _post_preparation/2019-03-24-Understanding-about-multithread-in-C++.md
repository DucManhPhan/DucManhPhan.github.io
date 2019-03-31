---
layout: post
title: Understanding about multithread in C++
bigimg: /img/image-header/california.jpg
tags: [C++, Multithread]
---



<br>

## Table of contents
- [Introduction to multithread](#introduction-to-multithread)
- [Launching a thread](#launching-a-thread)
- [Wrapping up](#wrapping-up)



<br>

## Introduction to multithread
Before going to the concept of multithread, we will need to understand about process concepts. According to the [wikipedia.org](), we have:

```

```




<br>

## Launching a thread
- With normal function

    Assuming that we have:

    ```C++
    void hello() {
        std::cout << "Hello, world with multithread.";
    }

    std::thread t(hello);
    t.join();
    //t.detach();
    ```

    or 

    ```C++
    void printSomething(const std::string& strInput) {
        std::cout << strInput << "\n";
    }

    std::thread t(printSomething, "hello");
    ```

    So, we will embed a name of function to the constructor of ```std::thread``` like the above sample. And it's important to bear in mind that by default the arguments are copied into internal storage, where they can be accessed by the newly created thread of execution, even if the correponding parameter in the function is expecting a reference. 

    The second sample, we can see that 

- With function object

    ```C++
    class background_task {
        public: 
            void operator() {
                do_something();
                do_something_else();
            }
    };

    background_task f;
    std::thread thBackgroundTask(f);
    ```

    The above function object ```f``` is copied into the storage belonging to the newly created thread of execution and invoked from there. It's therefore essential that the copy behave equivalently to the original, or the result may not be what's expected.

- With lambda expression

    Based on the sample in ```With function object```, we have:

    ```C++
    std::thread th([](){
        do_something();
        do_something_else();
    });
    ```

- With a method in class



--> Once we've started our thread, we need to explicitly decide whether to wait for it to finish (by joining with it) or leave it to run on its own (by detaching it). If we don't decide before the ```std::thread``` object is destroyed, then our program is terminated (the ```std::thread``` destructor calls ```std::terminate()```).

We only have to make this decision before the ```std::thread``` object is destroyed - the thread itself may well have finished long before we join with it or detach it, and if we detach it, then the thread may continue running long after the ```std::thread``` object is destroyed.

<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer:

[https://www.geeksforgeeks.org/multithreading-python-set-1/](https://www.geeksforgeeks.org/multithreading-python-set-1/)