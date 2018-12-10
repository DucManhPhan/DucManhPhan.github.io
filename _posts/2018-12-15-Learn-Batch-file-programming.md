---
layout: post
title: Learn Batch programming - Part 1
bigimg: /img/image-header/ravashing-beach.jpg
tags: [batch programming]
---

Before, I think that using batch programming is something that is not needed for me. But now, I have to rethink about it. Because using batch programming makes me relax when I usually encounter the tasks about automatically running test command. 

The below things you will learn some commands that need to do with automatically tasks.

## If statement

File syntax: 
    IF [NOT] EXIST *filename command* 
    IF [NOT] EXIST *filename (command)* ELSE (*command*)

String syntax: 
    IF [/I] [NOT] *item1==item2 command*
    IF [/I] *item1 compare-op item2 command*
    IF [/I] *item1 compare-op item2 (command)* ELSE (*command*)

Use AND conditions:
    IF condition_1 (
      IF condition_2 (
        Command_if_both_are_true
      )
    )

Use OR conditions:
    SET "_tempvar="
    IF condition_1 set _tempvar=1
    IF condition_2 set _tempvar=1
    IF %_tempvar% EQU 1 Command_if_either_is_true


with: 
  - *item* : a text string or environment variable, substring (%var:~n, m%), search syntax.
  - *filename* : a file to test || a wildcard pattern.
  - /I : case Insensitive string comparison.
  - compare-op : EQU, NEQ, LSS, LEQ,  GTR, GEQ.
  - == : perform command if the two strings are equal.

Ex: Check whether folder is empty or not.

```Javascript
::Check the first passed parameter is null or not
if {%1}=={} set _empty=Syntax: %0 "" &goto :message

::Does folder exist
if not exist %1 (
  set _empty=No Such Folder
  goto :message
)

:: Is folder empty
set _TMP=
for /f "delims=" %%a in ('dir /b %1') do set _TMP=%%a

::Compare null with the path of file
IF {%_TMP%}=={} (
  set _empty=Empty
) ELSE (
  set _empty=Not Empty
)

:message
echo:
Echo %_empty%
```

## For statement with file's content, command, string

Syntax: 
    FOR /F ["options"] %%parameter IN (*filenameset*) DO *command*
    FOR /F ["options"] %%parameter IN ("Text string to process") DO *command*
    FOR /F ["options"] %%parameter IN (`command_to_process`) DO *command*

with: 
  - *filenameset* : a set of one or more files.
  - options: 
    - delims=xxx : The delimiter character (default = space)
    - skip=n : a number of lines to skip at the beginning of the file (default = 0)
    - eol=; : character at the start of each line (default = ;)
    - tokens=n : specifies which numbered items to read from each line (default = 1)
    - usebackq : Use double quotes for long file names in "filenameset"; Use single quotes for 'Text string to process'; Use back quotes for `command to process`

Notice: 
- tokens=2,4,6 will cause the second, fourth and sixth items on each line to be processed.
- tokens=2-6 will cause the second, third, fourth, fifth and sixth items on each line to be processed.
- tokens=* will cause all items on each line to be processed.
- tokens=3* will process the third token and the 4th + all subsequent items, this can also be written as tokens=3,*
- Each token specified will cause a corresponding parameter letter to be allocated. The letters used for tokens are case sensitive.If the last character in the tokens= string is an asterisk, then additional parameters are allocated for all the remaining text on the line.
- If the clause results in a multiple values then extra parameters are implicitly defined to hold each. These are automatically assigned in alphabetical order %%H %%I %%J ...(implicit parameter definition).





Refer: 

[HOWTO: Detect Process Bitness](https://blogs.msdn.microsoft.com/david.wang/2006/03/27/howto-detect-process-bitness/)

[DIR command](https://ss64.com/nt/dir.html)

[Command line arguments](https://ss64.com/nt/syntax-args.html)