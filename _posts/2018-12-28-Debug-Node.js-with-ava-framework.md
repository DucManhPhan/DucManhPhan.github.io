---
layout: post
title: Debug Node.js using AVA framework
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Ava, Testing, Node.js]
---

Before you go into debugging test case that use ava in Node.js, you can read up on knowledge about AVA framework at the following link: [Ava test](https://ducmanhphan.github.io/2018-12-17-ava-test-framework/)

The first thing to do is you have to configure file **launch.json** in Visual studio code. You can reference to the article [Debug in C++ with VS Code](https://ducmanhphan.github.io/2018-10-17-Debug-in-C++-with-VS-Code/) to know parameter in file lauch.json.

The nex thing is the content of file **launch.json**. 

```Javascript
{  
  "version": "0.2.0",
  "configurations": [    
    {
      "type": "node",
      "request": "launch",
      "name": "Debugging test case use AVA in Node.js",
      "program": "${workspaceRoot}/node_modules/ava/profile.js",
      "args": [
        "--serial",
        "${file}"           // file test case that you want to debug.
      ]
    }
  ]
}
```


Thanks for your reading.