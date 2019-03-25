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

    The reason for this is that the arguments may need to outlive the calling thread, copying the arguments guarantees that. Instead, if we want to really pass a reference, we can use a ```std::reference_wrapper``` created by ```std::ref```.

    ```C++
    std::thread (foo, std::ref(arg1));
    ```  

    By doing this, we are promising that you will take care of guaranteeing that the arguments will still exist when the thread operates on them.

    Note that all the things mentioned above can also be applied to std::async and std::bind.

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

    or 

    ```C++
    class blub {
    private:
        void test() {}
    public:
        std::thread spawn() {
            return std::thread( [this] { this->test(); } );
        }
    };
    ```

    Since ```this->``` can be omitted, it could be shorten to:

    ```C++
    std::thread( [this]{ test(); } );
    ```

    or just

    ```C++
    std::thread( [=] { test(); } );
    ```

- With a method in class

    ```C++
    class test
    {
    public:
        void hello()
        {
            std::cout << "Hello, everyone.\n";
        }
    };

    std::thread t(&test::hello, test());

	t.join();
    ```

    So, to pass a method into a thread, we must specify what class and a object of this class that this method lie.

    The above syntax is defined in terms of the ```INVOKE``` definition:

    ```
    Define INVOKE(f, t1, t2, ..., tN) as follows:
    - (t1.*f)(t2, ..., tN) when f is a pointer to a member function of a class T and t1 is an object of type T or a reference to an object of type T or a reference to an object of a type derived from T;
    - ((*t1).*f)(t2, ..., tN) when f is a pointer to a member function of a class T and t1 is not one of the types described in the previous item;
    - t1.*f when N == 1 and f is a pointer to member data of a class T and t 1 is an object of type T or a reference to an object of type T or a reference to an object of a type derived from T;
    - (*t1).*f when N == 1 and f is a pointer to member data of a class T and t 1 is not one of the types described in the previous item;
    - f(t1, t2, ..., tN) in all other cases.
    ```

--> Once we've started our thread, we need to explicitly decide whether to wait for it to finish (by joining with it) or leave it to run on its own (by detaching it). If we don't decide before the ```std::thread``` object is destroyed, then our program is terminated (the ```std::thread``` destructor calls ```std::terminate()```).

We only have to make this decision before the ```std::thread``` object is destroyed - the thread itself may well have finished long before we join with it or detach it, and if we detach it, then the thread may continue running long after the ```std::thread``` object is destroyed.

<br>

## Transferring ownership of a thread




<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer:

[https://www.geeksforgeeks.org/multithreading-python-set-1/](https://www.geeksforgeeks.org/multithreading-python-set-1/)

[https://stackoverflow.com/questions/10673585/start-thread-with-member-function](https://stackoverflow.com/questions/10673585/start-thread-with-member-function)