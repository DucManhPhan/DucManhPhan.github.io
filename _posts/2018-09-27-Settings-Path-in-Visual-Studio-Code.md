---
layout: post
title: Setting Paths in Vs Code
bigimg: /img/path.jpg
tags: [VsCode]
---


In order to improve the configuration of files such as ```c_cpp_properties.json```, ```launch.json```, and ```tasks.json```, you should use the ```predefined variables```. 

Assuming that you have: 
- The directory that you open with "Open with VS Code": ```/home/your-username/your-project```
- The file opened in your editor: ```/home/your-username/your-project/folder/file.ext```

The meaning of each predefined variables is: 
- ```${workspaceFolder}``` - /home/your-username/your-project
- ```${workspaceFolderBaseName}``` - your-project
- ```${file}``` - /home/your-username/your-project/folder/file.ext
- ```${relativeFile}``` - folder/file.ext
- ```${fileBasename}``` - file.ext
- ```${fileBasenameNoExtension}``` - file
- ```${fileDirname}``` - /home/your-username/your-project/folder
- ```${fileExtname}``` - .ext
- ```${lineNumber}``` - 5
- ```${selectedText}``` - Text selected in your code editor

Refer: 

[https://code.visualstudio.com/docs/editor/variables-reference](https://code.visualstudio.com/docs/editor/variables-reference)

