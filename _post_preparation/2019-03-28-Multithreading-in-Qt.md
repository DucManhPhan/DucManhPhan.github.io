---
layout: post
title: Multithreading in Qt
bigimg: /img/image-header/california.jpg
tags: [Qt]
---



<br>

## Table of contents
- [Introduction to Multithreading in Qt](#introduction-to-multithreading-in-qt)
- [Passing argument to a SLOT](#passing-argument-to-a-slot)
- [How to call Slot in a thread from different thread](#how-to-call-slot-in-a-thread-from-different-thread)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Multithreading in Qt





<br>

## 





<br>

## Passing argument to a SLOT
- First way: use ```QSignalMapper``` class.

    ```C++
    QSignalMapper* signalMapper = new QSignalMapper (this) ;
    connect (action1,  SIGNAL(triggered()), signalMapper, SLOT(map())) ;
    connect (action5,  SIGNAL(triggered()), signalMapper, SLOT(map())) ;
    connect (action10, SIGNAL(triggered()), signalMapper, SLOT(map())) ;
    connect (action25, SIGNAL(triggered()), signalMapper, SLOT(map())) ;
    connect (action50, SIGNAL(triggered()), signalMapper, SLOT(map())) ;

    signalMapper -> setMapping (action1, 1) ;
    signalMapper -> setMapping (action5, 5) ;
    signalMapper -> setMapping (action10, 10) ;
    signalMapper -> setMapping (action25, 25) ;
    signalMapper -> setMapping (action50, 50) ;

    connect (signalMapper, SIGNAL(mapped(int)), this, SLOT(onStepIncreased(int))) ;
    ```

    It's worth noting that in Qt5, C++11, ```QSignalMapper``` is deprecated. From the link: "This class is obsolete. It is provided to keep old source code working. We strongly advise against using it in new code."

- Second way: With Qt5 and a C++11 compiler, the idiomatic way to do such things is to give a functor to ```connect```:

    ```C++
    connect(action1,  &QAction::triggered, this, [this]{ onStepIncreased(1); });
    connect(action5,  &QAction::triggered, this, [this]{ onStepIncreased(5); });
    connect(action10, &QAction::triggered, this, [this]{ onStepIncreased(10); });
    connect(action25, &QAction::triggered, this, [this]{ onStepIncreased(25); });
    connect(action50, &QAction::triggered, this, [this]{ onStepIncreased(50); });
    ```

    The third argument to ```connect``` is nominally optional. It is used to set up the thread context in which the functor will execute. It is always necessary when the functor uses a ```QObject``` instance. If the functor uses multiple ```QObject``` instances, they should have some common parent that manages their lifetime and the functor should refer to that parent, or it should be ensured that the objects will outlive the functor.

    On Windows, this works in MSVC2012 & newer.

    Note: If we replace ```&QAction::triggered``` by ```SIGNAL(triggered(bool))```, and something looks like the below:

    ```C++
    connect(action1,  SIGNAL(triggered(bool)), this, [this]{ onStepIncreased(1); });
    ```

    The compiler will send an error, and the error message will tell us why: there's no QObject::connect overload that takes a const char * as the 2nd argument and a functor as the third or fourth argument. The Qt4-style connect syntax doesn't mix with the new syntax. If you wish to use the old syntax, you forfeit the ease of connecting to functors (even though it could be approximated if you had a C++11 compiler but used Qt4).

- Third way: use ```QObject::sender()``` in the slot.

<br>

## How to call Slot in a thread from different thread
Assuming that we have first thread - ```OurThread``` class, second thread - ```AdditionalThread```, and slot in ```OurObject``` class, then, ```OurObject``` will be passed to the ```AdditionalThread``` class. 

Our problem is that we have to emit a signal from ```OurThread```, and slot in ```OurObject``` will be called.

Source code:

- In ```OurThread``` class

    ```C++
    #include <QThread>
    #include <iostream>

    class OurThread : public QThread
    {
        Q_OBJECT

    public:
        OurThread() {
            // nothing to do
        }

        void run() {
            std::cout << "OurThread is started.\n";

            int i = 0;
            while (1)
            {
                msleep(200);
                ++i;
                if (i == 20)
                {
                    emit OurSignal();
                }
            }
        }
    };
    ```

- In ```AdditionalThread``` class

    ```C++
    #include <QThread>
    #include <iostream>

    class AdditionalThread : public QThread
    {
        Q_OBJECT

    public:
        AdditionalThread() {
            // nothing to do
        }

        void run() {
            std::cout << "Thread 2 started.\n";
            exec();
        }
    };
    ```

- In OurObject class

    ```C++
    #include <QObject>
    #include <iostream>

    class OurObject : public QObject
    {
        Q_OBJECT

    public:
        OurObject() {
            // nothing to do
        }

    public slots:
        void OurSlot(void) {
            std::cout << "Our slot is started.\n";
        }
    };
    ```

- In ```main``` function

    ```C++
    #include <QCoreApplication>
    #include <additionalthread.h>
    #include <ourthread.h>
    #include <ourobject.h>

    int main(int argc, char *argv[])
    {
        QCoreApplication a(argc, argv);
        OurThread           firstThread;
        AdditionalThread    secondThread;

        OurObject ourobject;

        QObject::connect(&firstThread, SIGNAL(OurSignal()), &ourobject, SLOT(OurSlot()));

        secondThread.start();
        ourobject.moveToThread(&secondThread);
        firstThread.start();

        return a.exec();
    }
    ```

<br>

## Wrapping up
- Do not subclass QThread. That's the starting point for many programmers' headaches. A QThread is a thread manager, which controls one thread. A QThread is not a thread. Transfer information from thread to thread via signals and slots, using an event-driven approach.



<br>

Refer:

[https://www.oreilly.com/library/view/advanced-qt-programming/9780321701688/ch09.html](https://www.oreilly.com/library/view/advanced-qt-programming/9780321701688/ch09.html)

[https://stackoverflow.com/questions/5153157/passing-an-argument-to-a-slot](https://stackoverflow.com/questions/5153157/passing-an-argument-to-a-slot)

[https://crazybaga.blogspot.com/2017/04/handling-signal-using-qsignalmapper-in.html](https://crazybaga.blogspot.com/2017/04/handling-signal-using-qsignalmapper-in.html)

[https://hub.packtpub.com/multithreading-qt/](https://hub.packtpub.com/multithreading-qt/)

[https://nachtimwald.com/2015/05/02/effective-threading-using-qt/](https://nachtimwald.com/2015/05/02/effective-threading-using-qt/)

[https://wiki.qt.io/Threads_Events_QObjects](https://wiki.qt.io/Threads_Events_QObjects)

[https://mayaposch.wordpress.com/2011/11/01/how-to-really-truly-use-qthreads-the-full-explanation/](https://mayaposch.wordpress.com/2011/11/01/how-to-really-truly-use-qthreads-the-full-explanation/)

[https://www.slideshare.net/ICSinc/qthreads-are-you-using-them-wrong](https://www.slideshare.net/ICSinc/qthreads-are-you-using-them-wrong)