---
layout: post
title: Learn batch programming - Part 2 - some useful commands
bigimg: /img/image-header/ravashing-beach.jpg
tags: [batch programming]
---

In this article, you will find something out about some useful commands such as cd, copy, del, move, md, find and processing the argument that you pass.

## CD - Change directory

Syntax: 
    CD [/D] [drive:][path]
    CD [..]

with: 
  - /D : change the current DRIVE in addition to changing folder. 

Ex: 

```
::change to the parent directory
cd ..

::change to the ROOT directory
cd \

::change to the grand-parent directory
cd ..\..

::change the current drive
C:> E:
E:>
```


## 