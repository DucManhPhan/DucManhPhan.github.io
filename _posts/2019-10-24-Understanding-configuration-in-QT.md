---
layout: post
title: Understanding configuration in QT
bigimg: /img/image-header/california.jpg
tags: [Qt, C++]
---

When I'm working with QT, the most difficult thing is to configure ```.PRO``` file. I do not understand about structure of this file and it makes me confused. 

So, in this article, we will discuss about all things that turn around ```.PRO``` file.

<br>

## Table of contents
- [Inroduction to QT](#introduction-to-qt)
- [Structure of PRO file](#structure-of-pro-file)
- [Problems in QT](#problems-in-qt)
- [Wrapping up](#wrapping-up)

<br>

## Inroduction to QT
According to [wiki.qt.io](https://wiki.qt.io/Qt_for_Beginners), we have:

```
QT (pronounced as **cute**, not  **cu-tee**) is a cross platform framework that is usually used as a graphical toolkit, although it is also very helpful in creating CLI applications. It runs on the three major desktop OSes, as well as on mobile OSes, such as Symbian, Nokia Belle, Meego Harmattan, MeeGo or BB10, and on embedded devices. 
```

Some common modules that use in QT:

|            Modules             |                  Description                  |
| ------------------------------ | --------------------------------------------- |
| ```QtCore```                   | a base library that provides containers, thread management, event management, and much more. |
| ```QtGui``` and ```QtWidgets```| a GUI toolkit for Desktop, that provides a lot of graphical components to design applications. |
| ```QtNetwork```                | provides a useful set of classes to deal with network communications. |
| ```QtWebkit```                 | the webkit engine that enable the use of web pages and web apps in a Qt application. |
| ```QtSQL```                    | a full featured SQL RDBM abstraction layer extensible with own drivers, support for ```ODBC```, ```SQLite```, ```MySQL``` and ```PostgreSQL``` is available out of box. |
| ```QtXML```                    | support for simple ```XML``` parsing (SAX) and ```DOM```. |
| ```QtXmlPatterns```            | support for ```XSLT```, ```XPath```, ```XQuery``` and ```Schema``` validation. |

<br>

## Structure of PRO file
```.PRO``` file is the project file. Qt will use a command line tool to parses these project files to generate ```makefiles```, files that are used by compilers to build an application. This tool is called ```qmake```. 

Project files are plain text (i.e. use an editor like notepad, vim or xemacs) and must be saved with a ```.pro``` extension. The name of the application's executable will be the same as the project file's name, but with an extension appropriate to the platform. 

For example, a project file called 'hello.pro' will produce 'hello.exe' on Windows and 'hello' on Unix.

In a project file, there is some minimal code that should always be written:

```bat
TEMPLATE = app
TARGET = name_of_the_app

QT += core gui
QT += network

greaterThan(AT_MAJOR_VERSION, 4): QT += widgets

SOURCES += \
        main.cpp \
        test.cpp

HEADERS +=  main.h \
            test.h

CONFIG += qt warn_on release
CONFIG += c++11
```

- ```TEMPLATE``` - describe the type of build. It can be an appliation - ```app```, a ```library```, or simply ```subdirectories```.

- ```TARGET``` - the name of the app or the library.

- ```QT``` - used to indicate what libraries (QT modules) are being used in our project.

    The table shows the options that can be used with the Qt variable:

    |              Option          |       Features         |
    | ---------------------------- | ---------------------- |
    | core (include by default)    | QtCore module          |
    | gui (include by default)     | QtGui module           |
    | network                      | QtNetwork module       |
    | opengl                       | QtOpenGL module        |
    | sql                          | QtSql module           |
    | svg                          | QtSvg module           |
    | xml                          | QtXml module           |
    | xmlpatterns                  | QtXmlPatterns module   |
    | qt3support                   | Qt3Support module      |

    Note that adding the ```opengl``` option to the QT variable automatically causes the equivalent option to be added to the ```CONFIG``` variable. Therefore, for Qt applications, it is not necessary to add the ```opengl``` option to both ```CONFIG``` and ```QT```.
 
- ```SOURCES``` - specifies the source files that implement the application. Most applications require multiple files; this situation is dealt with by listing all the files on the same line space separated.

    ```bat
    SOURCEs = main.cpp test.cpp
    ```

    or each file can be listed on a separate line, by escaping the newlines.

    ```bat
    SOURCES = main.cpp \
              test.cpp
    ```

    or a more verbose approach is to list each file separately.

    ```bat
    SOURCES += main.cpp
    SOURCES += test.cpp
    ```

    This approach uses ```+=``` rather than ```=``` which is safer, because it always adds a new file to the existing list rather than replacing the list.

- ```HEADERS``` - specify the header files created for use by the application.

- ```CONFIG``` - used to give ```qmake``` information about the application's configuration.

    The ```CONFIG``` variable specifies the options and features that the compiler should use and the libraries that should be link against. Anything can be added to the ```CONFIG``` variable.

    Some following options control the compiler flags that are used to build the project:

    |          Option         |               Description               |
    | ----------------------- | --------------------------------------- |
    | release                 | The project is to be built in release mode. This is ignored if debug is also specified. |
    | debug                   | 

    ```
    CONFIG += qt warn_on release
    ```

    ```+=``` - means we add our configuration options to any that are already present. This is safer than using ```=``` which replaces all options with just those specified.

    ```qt``` - tells ```qmake``` that the application is built using Qt. This means that ```qmake``` will link against the Qt libraries when linking and add in the neccesary include paths for compiling.

    ```warn_on``` - tells ```qmake``` that it should set the compiler flags so that warning are output.

    ```release``` tells that the application must be built as a release application. During development, programmers may prefer to replace ```release``` with ```debug```.

<br>

## Problems in QT
- Error: LNK1158: cannot run 'rc.exe'

    This error will happen when we have both Visual Studio 2015 and Visual Studio 2017 or more precisely, multiple version of the Window SDK installed.

    When that happens, the ```vcvars32.bat``` script (located in our Visual Studio install dir) does not correctly add the location of the resource compiler (rc.exe) to our ```PATH```. Thus, QT Creator runs ```vcvars32.bat``` (as specified in Qt Creator under Option->Build&Run->Compilers, but the tools directory for the Windows SDK Kit isn't properly added to the PATH environment).

    - First way: Add the appropriate version of rc.exe to our ```Path```.

        Do some command line:

        ```bat
        cd "c:\program files(x86)"
        dir /s rc.exe
        ```

        We'll get several versions (x86 and x64) and for several versions of the SDK. Add the ```PATH``` for where rc.exe lives for the version that corresponds to the SDK and build flavor to our vcvars32.bat startup script.

        Restart Qt Creator and that should fix it.

    - Second way: 
    
        Uninstall all versions of Visual Studio (and all those side installs of SQL, Windows SDKs, dev tools, etc...). Reboot. Then cleanly install VS 2017 again. Then cleanly uninstall and re-install all of Qt again.

- Write ```connect()``` method right way

    When we use the above method ```connect()``` like this:

    ```C++
    QObject::connect(ui->Open, SIGNAL(clicked()),
                     p,SLOT(on_action_Open_triggered()));
    ```

    It will makes our method ```on_action_Open_triggered()``` that is called multiple times. In order to remove this problem, we need to use addtional paramater:

    ```C++
    QObject::connect(ui->Open, SIGNAL(clicked()),
                     p,SLOT(on_action_Open_triggered()), Qt::UniqueConnection);
    ```

- QObject: Cannot create children for a parent that is in a different thread. (Parent is QNetworkAccessManager(0x1c2ed984210), parent's thread is QThread(0x1c2ed9489d0), current thread is QThread(0x1c2f1c58760)

    

- Hide concole ```qtcreator_process_stub.exe```

    In ```project``` setting, at ```Run``` mode, we will see the checkbox about ```Run in terminal```. 

    We can remove the tick in this checkbox to resolve this problem.

- QObject: Cannot create children for a parent that is in a different thread


<br>

## Wrapping up
- Understanding about >PRO file in Qt.

<br>

Refer:

[https://wiki.qt.io/Qt_for_Beginners](https://wiki.qt.io/Qt_for_Beginners)

[https://doc.qt.io/archives/3.3/qmake-manual-3.html](https://doc.qt.io/archives/3.3/qmake-manual-3.html)

[https://doc.qt.io/archives/qt-4.8/qmake-project-files.html](https://doc.qt.io/archives/qt-4.8/qmake-project-files.html)

[https://doc.qt.io/archives/qt-4.8/signalsandslots.html](https://doc.qt.io/archives/qt-4.8/signalsandslots.html)

[https://doc.qt.io/archives/qt-4.8/qt-widgets-calculator-example.html](https://doc.qt.io/archives/qt-4.8/qt-widgets-calculator-example.html)

[https://doc.qt.io/archives/qt-4.8/qt-widgets-imageviewer-example.html](https://doc.qt.io/archives/qt-4.8/qt-widgets-imageviewer-example.html)

[https://stackoverflow.com/questions/45228238/qt-5-8-msvc-2015-compile-error](https://stackoverflow.com/questions/45228238/qt-5-8-msvc-2015-compile-error)

[https://stackoverflow.com/questions/26771047/qobjectconnectionconst-qobject-const-char-const-char-qtconnectiontype](https://stackoverflow.com/questions/26771047/qobjectconnectionconst-qobject-const-char-const-char-qtconnectiontype)

