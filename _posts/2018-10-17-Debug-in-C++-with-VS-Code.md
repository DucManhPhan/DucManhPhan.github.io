---
layout: post
title: Debugging with C++ in Visual Studio Code
bigimg: /img/path.jpg
tags: [C++, VsCode]
---

When you have competitive programming on LeetCode, Hackerrank, ... the first thing you want is the IDE has some interesting features such as light-weight, the fast configuration, ... But before, I find it difficult to have the marvelous IDE. 

After spending so much time to search information about debuging, I think the Visual Studio Code is the best editor with external build tools. But using the Visual Studio Code to build source code is burdensome.

First of all, Visual Studio Code supports the compiler, debugger, intellisence mode. In this article, we will find out all of information about compiler, debugger in Vs Code. 

<br>

## Table of Contents
- [1. Debugger Extension](#1-debugger-extension)
- [2. Build source code](#2-build-source-code)
- [3. Debug source code](#3-debug-source-code)
- [4. Summarize](#4-summarize)


## 1. Debugger Extension
The first thing to do is to install the Microsoft C/C++ extension. It is used to debug our source code. 

- Open Vs Code. 
- Click the Extension view icon on the SideBar. 
- Search for C++. 
- Click **Install**, then click **Reload**.

![Install C++ debugger extension](/img/C++-debugger-extension.png)

<br>

## 2. Build source code 

In Visual Studio Code, you have to make the *task.json* file.

- Open the **Command Palette** (Ctrl + Shift + P).
- Selects the **Tasks: Configure Tasks ...** command, click **Create tasks.json file from templates**, and you see a list of task runner templates. 
- Select **Others** to create a task which runs an external command. 
- Change the *command* to the command line expression you use to build your application. 
- Add any required args. 
- Change the *label* to be more descriptive. 

After that, the followings are the code to build C++ code on Windows platform based on cl.exe of Visual C++. 

```Javascript
{
    "version": "2.0.0",
    "echoCommand": true,
    "tasks": [
        {
            "label": "compile hello",
            "command": "cmd",
            "type": "process",
            "args": [
                "/C %vcvarsall% && cl /Od /Zi /EHsc /Fd:%outpath%/vc141.pdb /Fo:%outpath%/%TargetName%.obj ./main.cpp /link /OUT:%outpath%/%TargetName%.%TargetExt% /PDB:%outpath%/%TargetName%.pdb",
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "reveal": "always", 
                "panel": "new"
            }
        }
    ],
    "options": {
        "env": {
            "outpath": "out", 
            "TargetName": "hello",
            "TargetExt": "exe",
            "vcvarsall": "\"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\vcvarsall.bat\" x64",
        }
    }
}
```

Now, we will go to find the meaning of the above keys: 

- **label**: The task's label used in the user interface. 
- **type**: The task's type. For a custom task, this can either be *shell* or *process*. If *shell* is specified, the command is interpreted as a shell command (Ex: bash, cmd, or PowerShell). If *process* is specified, the command is interpreted as a process to execute. 
- **command**: The actual command to execute.  
- **windows**: Any Windows specific properties.Will be used instead of the default properties when the command is executed on the Windows operating system. 
- **group**: Defines to which group the task belongs. If you'd like to be able to build your application with **Tasks: Run Build Task** (Ctrl + Shift + B), you can add it to the **build** group.
- **presentation**: Defines how the task output is handled in the user interface. In this example, the Integral Terminal showing, the output is *always* revealed and a *new* terminal is created on every task run. 
- **options**: Override the defaults for *cwd*, *env*, or *shell*. Options can be set per task but also globally or per platform. 

Refer: [Schema for tasks.json](https://code.visualstudio.com/docs/editor/tasks-appendix)


If you have multiple tasks or multiple project that is need to build, we will use the compound tasks.
For example: 

```Javascript
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Client Build",
            "command": "gulp",
            "args": ["build"],
            "options": {
                "cwd": "${workspaceRoot}/client"
            }
        },
        {
            "label": "Server Build",
            "command": "gulp",
            "args": ["build"],
            "options": {
                "cwd": "${workspaceRoot}/server"
            }
        },
        {
            "label": "Build",
            "dependsOn": ["Client Build", "Server Build"]
        }
    ]
}
```

When you see the **vcvarsall.bat**, you will ask for yourself: "What is vcvarsall.bat?". 

vcvarsall.bat is Visual Studio Command Prompt tool in Visual Studio. It's the tool that allows you to set varius options for the IDE as well as build, debug, and deploy projects from the command line. 

More information about vcvarall.bat: [Using vcvarall.bat in a Command Prompt window](https://msdn.microsoft.com/en-us/library/f2ccy3wt.aspx)

<br>

## 3. Debug source code 

To enable debugging, you will need to generate a launch.json file: 

- Naviagate to the Debug view by clicking the Debug icon in the SideBar. 
- In the Debug view, click the Configure icon. 
- Select C++ (GDB/LLDB) (to use GDB or LLDB) or C++ (Windows) (to use the Visual Studio Windows Debugger) from the Select Environment dropdown. This creates a launch.json file for editing with two configurations:
    - C++ Launch defines the properties for launching your application when you start debugging.
    - C++ Attach defines the properties for attaching to a process that's already running.
- Update the **program** property with the path to the program which you are debugging. 
- If you want your application to build when you start debugging, add a **preLaunchTask** property with the name of the build task you created in *tasks.json*. (Ex: "compile hello")


Then, the followings are the code to configure the launch.json file to debug our C++ source code based on Visual Studio. 

```Javascript
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(Windows) Launch",
            "type": "cppvsdbg",
            "request": "launch",
            "program": "out/hello.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": true, 
            "preLaunchTask": "compile hello"
        }
    ]
}
```

Here are the meaning of some options for the launch.json file. 

- **name**: The name of this work. 
- **type**: Indicates the underlying debugger being used. Must be *cppvsdbg* when using the Visual Studio Windows debugger, and *cppdbg* when using GDB or LLDB. This is automatically set to the correct value when the *launch.json* file is created. 
- **request**: Indicates whether the configuration sections is intended to *launch* the program or *attach* to an already running instance. 
- **program**: full path to executable the debugger will launch or attach to. 
- **args**: JSON array of command line arguments to pass to the program when it is launched. Example ["arg1", "arg2"]. If you are escaping characters you will need to double escape them. For example ["{\\\"arg\\\": true}] will send {"arg1": true} to your application.
- **stopAtEntry**: If set to true, the debugger should stop at the entry point of the target (ignored the attach). Default is false. 
- **cwd**: Sets the working directory of the application launched by the debugger. 
- **environment**: Environment variables to add to the environment for the program. (refer to the setting of tasks.json file)
- **externalConsole**: If set to true, launches an external console for the application. If false, no console is lauched and VS code's debugging console is used. 

If you want to know about the options in launch.json file, you can read the site: [Configuring launch.json for C/C++ debugging](https://github.com/Microsoft/vscode-cpptools/blob/master/launch.md)

<br>

## 4. Summarize 

The above information, you can learn to configure to build and debug C++ source code. 

The another way you can squeeze them into one file: tasks.json. 

```Javascript 
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "debug",
            "type": "shell",
            "command": "",
            "args": [
                "g++",
                "-g",
                "${relativeFile}",
                "-o",
                "a.out"
            ],
            "problemMatcher": [
                "$gcc"
            ]
        },
        {
            "label": "Compile and run",
            "type": "shell",
            "command": "",
            "args": [
                "g++",
                "-g",
                "${relativeFile}",
                "-o",
                "${fileBasenameNoExtension}.out",
                "&&",
                "clear",
                "&&",
                "./${fileBasenameNoExtension}.out"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "problemMatcher": {
                "owner": "cpp",
                "fileLocation": [
                    "relative",
                    "${workspaceRoot}"
                ],
                "pattern": {
                    "regexp": "^(.*):(\\d+):(\\d+):\\s+(warning|error):\\s+(.*)$",
                    "file": 1,
                    "line": 2,
                    "column": 3,
                    "severity": 4,
                    "message": 5
                }
            }
        }
    ]
}
```

Thanks for your reading.

<br>

Refer:

[How can i compile C++ files through Visual Studio Code](https://askubuntu.com/questions/1032647/how-can-i-compile-c-files-through-visual-studio-code)

[Integrate with External Tools via Tasks](https://code.visualstudio.com/docs/editor/tasks#vscode)

[C/C++ for Visual Studio Code (Preview)](https://code.visualstudio.com/docs/languages/cpp)

[Configure c_cpp_properties.json](https://github.com/Microsoft/vscode-cpptools/blob/master/Documentation/LanguageServer/c_cpp_properties.json.md)

[Configure launch.json](https://github.com/Microsoft/vscode-cpptools/blob/master/launch.md)

[Customizing Default Settings](https://github.com/Microsoft/vscode-cpptools/blob/master/Documentation/LanguageServer/Customizing%20Default%20Settings.md)

[Configure IntelliSense Engine for includePath and browse.path](https://github.com/Microsoft/vscode-cpptools/blob/master/Documentation/LanguageServer/IntelliSense%20engine.md)

[Configuring includePath for better IntelliSense results](https://github.com/Microsoft/vscode-cpptools/blob/master/Documentation/Getting%20started%20with%20IntelliSense%20configuration.md)

[C/C++ extension for Visual Studio Code](https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/#MSBuild)

[How do I setup VS code to compile C code](https://stackoverflow.com/questions/30269449/how-do-i-set-up-visual-studio-code-to-compile-c-code)

[Using Visual Studio Code and Building and Debugging with C++ on Mac OS X](http://www.suodenjoki.dk/us/archive/2016/vscode-cpp-mac.htm)

[Schemas for tasks.json](https://code.visualstudio.com/docs/editor/tasks-appendix)