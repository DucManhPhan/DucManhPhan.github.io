---
layout: post
title: How to configure C++ addon in Node.js
bigimg: /img/path.jpg
tags: [C++, Node.js]
---


## Tablel of Contents
- [Make the package.json file.](#make-the-package.json-file)
- [Setup NAN (Native Abstraction of Node.js).](#setup-nan-native-abstraction-of-node.js)
- [Setup the node.gyp and make the binding.gyp file.](#setup-the-node.gyp-and-make-the-binding.gyp-file)
-[Build project with node.gyp.](#build-project-with-node.gyp)
- [Run the program in the \*.js file.](#run-the-program-in-the-*.js-file)


## Make the package.json file.
In Node.js, we have to set up the package.json. We can use the command: 
The most important part in package.json is "name" and "version".

```
npm init
```


## Setup NAN (Native Abstraction of Node.js). 
Nan is considered as the thin abstraction layer between V8 library and Node.js. 

We need Nan because when the V8 library has some updated parts, we do not want to recompile all project. 

Inorder to download Nan, we use the command line with npm:

```
npm install -g nan@latest
```


## Setup the node.gyp and make the binding.gyp file.

- Make binding.gyp file. 
  
  Binding.gyp file is used to configure the output of the compiled process, such as: name of file (Ex: hello.node) and the source files is need to build. 
  
  And then, we have to add the part '"gypfile": true" into package.json, inorder to confirm for npm to know about binding.gyp file.

  Ex: The content of Binding.gyp file has: 
  
  ```javascript
  {
    "targets": [
      {
        "target_name": "hello",
        "sources": [ "hello.cc" ],
        "include_dirs": [
          "<!(node -e \"require('nan')\")"
        ]
      }
    ]
  }
  ```

- Install the node-gyp tool. 

  Inorder to build the C++ addon, we need the node-gyp and download with command line: 

  ``` 
  npm install -g node-gyp
  ```
  
- Check whether npm have the windows-build-tool or not. 
  
  We can install windows-build-tool with command: 
  
  ```
  npm install --global --production windows-build-tools
  ```
  
  Or
  
  When we had installed the visual studio 2015, we can add the windows-build-tools of VS2015 into nody-gyp.
  
  ```
  node-gyp configure --msvs_version=2015
  ```


## Build project with node.gyp. 

- The first step, we call the command: 

  ```
  node-gyp configure
  ```
  
  This "configure step" will look for a binding.gyp file in the current directory to process. 
  
  When having this binging.gyp file, it will generate the appropriate project build files for the current platform. 
  
  Now you will have either a Makefile (on Unix platforms) or a vcxproj file (on Windows) in the build/ directory. 
 
- Second step
  
  Call the command: 
  
  ``` 
  node-gyp build
  ```
  
  At this step, we have the file "\*.node". This \*.node will be in the directory ./build/Release or ./build/Debug. 
  
  
## Run the program in the \*.js file. 
In the \*.js file, we use the function require() to implement with the C++ Addons.


Thanks for your reading.