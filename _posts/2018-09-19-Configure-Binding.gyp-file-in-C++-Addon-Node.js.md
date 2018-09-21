---
layout: post
title: Configure binding.gyp file in C++ Addon - Node.js
bigimg: /img/path.jpg
tags: [C++ Addon Node.js, Binding.gyp file]
---

Consider the binding.gyp file have common properties: 

```Javascript
{
    "targets": [
        "target_name": "name-of-builded-file", 
        ...
    ]
}
```

Now, we want to build C++ Addon in Node.js to a static library. The belows choice is the way to configure properties in binding.gyp. We need to completely understand the key - value of each property. 

Note: With outside library, we have two folder: "include" and "lib".

The following image is the structure of our folder. 
![./img/structure-folder-Binding.gyp.png]()


## Make the static library.


## Make the executable file


## Including some files to build


## Use some outside library that have extension .lib 


## Use complier of Windows Build Tools 


