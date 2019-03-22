---
layout: post
title: Understanding configuration in QT
bigimg: /img/image-header/california.jpg
tags: [QT]
---



<br>

## Table of contents
- [Problems in QT](#problems-in-qt)


<br>

## 




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

- Creating QNetworkAccessManager in another thread


- Hide concole ```qtcreator_process_stub.exe```



<br>

## Wrapping up




Refer:

[https://stackoverflow.com/questions/45228238/qt-5-8-msvc-2015-compile-error](https://stackoverflow.com/questions/45228238/qt-5-8-msvc-2015-compile-error)

[https://stackoverflow.com/questions/26771047/qobjectconnectionconst-qobject-const-char-const-char-qtconnectiontype](https://stackoverflow.com/questions/26771047/qobjectconnectionconst-qobject-const-char-const-char-qtconnectiontype)

