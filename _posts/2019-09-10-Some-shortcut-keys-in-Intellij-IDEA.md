---
layout: post
title: Some shortcut keys in Intellij IDEA
bigimg: /img/path.jpg
tags: [Intellij]
---

In oder to improve performance when coding in Intellij IDEA, we need to know more about shortcut keys. So, in this article, we will learn something about it.

Let's get started.

<br>

## Table of contents
- [Operations with line](#operation-with-line)
- [Search and Replace](#search-and-replace)
- [Operations with tabs](#operations-with-tabs)
- [Compile and Run](#compile-and-run)
- [Debug](#debug)
- [Some useful statements](#some-useful-statements)
- [Creating something](#creating-something)
- [Wrapping up](#wrapping-up)

<br>

## Operations with line

|       Command          |                             Action                              |
| ---------------------- | --------------------------------------------------------------- |
| Alt + Enter            | Complete instruction of our code such as import class           |
| Ctrl + Shift + Enter   | Insert any necessary trailing symbol and put '\n' symbol to typing the next statement. |
| Ctrl + Alt + L         | Format code                                                     |
| Ctrl + Space           | Completes names of classes, methods, fields, and keywords within the visibility scope. |
| Ctrl + /               | Comment code                                                    |
| Ctrl + Shift + /       | Remove comment code                                             |
| Ctrl + Shift + F7      | Highlight all occurrences of the select fragment in the current file |
| Ctrl + Y               | Remove one or more lines                                        |
| Alt + Shift + Up/Down  | Move lines up or down                                           |
| Ctrl + D               | Duplicate lines in current file                                 |
| Alt + Insert           | Insert basic code such as Constructor, getter/setter, override method, hash/toString() ... |
| Alt + F7               | To find all places where a particular class, method or variable is used in the whole project by positioning the caret at the symbol's name or at its usage in code. |
| Ctrl + O               | Override method                                                 |
| Ctrl + I               | Implements method                                               |
| Ctrl + Alt + T         | Surround with… (if..else, try..catch, for, synchronized, etc.)  |
| Ctrl + Alt + O         | Optimize imports                                                |
| Ctrl + Alt + I	     | Auto-indent line(s)                                             |
| Ctrl + Delete          | Delete to word end                                              |
| Ctrl + Backspace       | Delete to word start                                            |
| Ctrl + G               | Go to line                                                      |
| Ctrl + B/Ctrl + Click	 | Go to declaration                                               |
| Ctrl + Alt + B	     | Go to implementation(s)                                         |
| Ctrl + Shift + I	     | Open quick definition lookup                                    |
| Ctrl + Shift + B	     | Go to type declaration                                          |
| Ctrl + U	             | Go to super-method/super-class                                  |
| Alt + Arrow Up/Arrow Down	| Go to previous/next method                                   |
| Ctrl + ]/[	         | Move to code block end / move to code start                     |
| Ctrl + Shift + Alt + Insert	| Create new scratch file                                  |
| Ctrl + Alt + Left Arrow / Right Arrow | Go back to the previous location; Go forward     |

<br>

## Search and Replace

|       Command          |                             Action                              |
| ---------------------- | --------------------------------------------------------------- |
| Ctrl + Shift + A       | find action that is a command and execute it                    |
| Ctrl + N               | find classes in our project                                     |
| Ctrl + Shift + N       | find files                                                      |
| Ctrl + Shift + Alt + N | find symbols that are methods in classes                        |
| Ctrl + R               | open replace functionality                                      |
| Alt + Shift + Mouse Click	 | add/remove a selection                                      |
| Alt + J	             | Select the next occurrence                                      |
| Shift + Alt + J	         | Unselect the next occurrence                                |
| Shift + Ctrl + Alt + J | Select all occurrences                                          |
| Esc	                 | Remove all selections                                           |
| Shift + Shift          | Search everywhere                                               |
| Alt + F7               | Search all places where something is used                       | 
| Ctrl + B               | Go to the declaration of a symbol                               |                                             
| Ctrl + Alt + B         | Go to the implementation of a symbol                            |                                             

<br>

## Operations with tabs

|       Command           |                            Action                               |
| ----------------------- | --------------------------------------------------------------- |
| Alt + Left/Right arrow  | switches between tabs                                           |
| Ctrl + F4               | closes active tab                                               |
| Ctrl + E                | Recent files popup                                              |
| Ctrl + Tab              | Switch between tabs and tool window                             |

<br>

## Compile and Run

|       Command           |                            Action                               |
| ----------------------- | --------------------------------------------------------------- |
| Ctrl + F9	              | Make project (compile modifed and dependent)                    |
| Ctrl + Shift + F9	      | Compile selected file, package or module                        |
| Alt + Shift + F10	      | Select configuration and run                                    |
| Alt + Shift + F9	      | Select configuration and debug                                  |
| Shift + F10             |	Run                                                             |
| Shift + F9              |	Debug                                                           |
| Ctrl + Shift + F10      |	Run context configuration from editor                           |


<br>

## Debug 

|       Command           |                            Action                               |
| ----------------------- | --------------------------------------------------------------- |
| F8	                  | Step over                                                       |
| F7	                  | Step into                                                       |
| Shift + F7	          | Smart step into                                                 |
| Shift + F8	          | Step out                                                        |
| Alt + F9	              | Run to cursor                                                   |
| Alt + F8	              | Evaluate expression                                             |
| F9	                  | Resume program                                                  |
| Ctrl + F8	              | Toggle breakpoint                                               |
| Ctrl + Shift + F8	      | View breakpoints                                                |


<br>

## Some useful statements

|       Short keys        |                 Statement                     |            Description           |
| ----------------------- | --------------------------------------------- | -------------------------------- |
| Ctrl + J                |                                               | Shows all shortcuts              |
| sout                    | System.out.println()                          | Prints                           |
| soutm                   | System.out.println("$CLASS_NAME$.$METHOD_NAME$"); | Prints current class and method names to System.out |
| soutp                   | System.out.println($FORMAT$);                 | Prints method parameter names and values to System.out |
| soutv                   | System.out.println("$EXPR_COPY$ = " + $EXPR$); | Prints a value to System.out |
| variable.sout           | System.out.println(variable);                 | variable exists in our scope     |
| Shift + Ctrl + Enter    |                                               | Add semicolon to the end of the code; add curly braces to for, if statements, then place cursor inside the block |


<br>

## Creating something

|       Command           |                            Action                               |
| ----------------------- | --------------------------------------------------------------- |
| Alt + F + J             | Close project                                                   |
| Alt + 1                 | Go to Project View                                              |
| Alt + Insert            | Create file in the Project View                                 |
| Ctrl + Alt + Insert     | Create a new file in the same directory as the current one      |


<br>

## Wrapping up

- Take advantages of the shortcut key in Intellij makes us coding smoothly.


<br>

Thanks for your reading.

<br>

Refer:

[https://www.jetbrains.com/help/idea/mastering-keyboard-shortcuts.html](https://www.jetbrains.com/help/idea/mastering-keyboard-shortcuts.html)

[https://shortcutworld.com/IntelliJ-IDEA/win/IntelliJ_Shortcuts](https://shortcutworld.com/IntelliJ-IDEA/win/IntelliJ_Shortcuts)