---
layout: post
title: Create a Typescript project in Node.js
bigimg: /img/image-header/yourself.jpeg
tags: [Node.js, Typescript]
---

In this article, we will find something out about creating typescript project in Node.js. It makes us actively demo small project when working with Angular, React.js, ...

Let's get started.

<br>

## Table of contents
- [Creating a typescript project in Node.js](#creating-a-typescript-project-in-node.js)
- [Wrapping up](#wrapping-up)


<br>

## Creating a typescript project in Node.js
1. Initialize node.js project

    We will create our own project with

    ```js
    npm init -y
    ```

2. Install some necessary packages

    - Use ```typescript``` package

        ```javascript
        npm install --save-dev typescript
        ```

        Node.js is an engine that runs Javascript and not Typescript. The node Typescript package allows us to transpile our .ts file to .js scripts.

        Inside our package.json, we will put a script called tsc:

        ```javascript
        "script": {
            "tsc": "tsc"
        }
        ```

        This modification allows us to call typescript functions from the command line in the project's folder. So, we can use the following command:

        ```javascript
        npm run tsc -- --init
        ```

        This command initializes the typescript project by creating the ```tsconfig.json``` file. Within this file, we will uncomment the ```outDir``` option and choose a location for the transpiled ```.js``` files to be delivered.
        
    - Use ```@types/node``` package

        So, ```@types/node``` package is an type declaration package for Node.js, it has the same name as the package on npm, but prefixed with @types/, but if we need, we can check out https://aka.ms/types to find the package for our favorite library.

        ```javascript
        npm install --save-dev @types/node
        ```

3. Scripts for ```package.json``` file

    ```javascript
    "scripts": {
        "tsc": "tsc",
        "prod": "tsc && node ./build/index.js",
        "build": "tsc"
    }
    ```

4. Debugging in typescript project with Node.js

    - Contents of ```tsconfig.json``` file

        ```javascript
        {
            "compilerOptions": {
                "target": "es5",
                "module": "commonjs",
                "outDir": "./build",
                "sourceMap": true
            }
        }
        ```

    - Contents of ```lauch.json``` file

        ```javascript
        {
            "version": "0.2.0",
            "configurations": [
                {
                "type": "node",
                "request": "launch",
                "name": "Launch Program",
                "program": "${workspaceFolder}/src/index.ts",
                "preLaunchTask": "tsc: build - tsconfig.json",
                "outFiles": ["${workspaceFolder}/build/**/*.js"]
                }
            ]
        }
        ```

    - If we encounter some errors such as ```"preLaunchTask": "tsc: build - tsconfig.json"``` or ```... is not recognized as an internal or external command, operable program or batch file. The terminal process terminated with exit code: 1```

        We can fix this problem with the solution that is to createan npm script that run tsc, and then run that script in the vs code launch.json.

        In ```package.json``` file, we have:

        ```javascript
        "script": {
            "debug": "tsc --sourcemap"
        }
        ```

        In ```.vscode/launch.json``` file, we have:

        ```json
        {
            "type": "node",
            "request": "launch",
            "name": "Debugger",
            "program": "${workspaceFolder}/src/index.ts",
            "preLaunchTask": "npm: debug",
            "outFiles": [
                "${workspaceFolder}/build/*.js"
            ]
        }
        ```

<br>

## Wrapping up
- Understanding about task in vs code.


<br>

Thanks for your reading.

<br>

Refer:

[https://stackoverflow.com/questions/49910024/vscode-path-generation-failure-in-run-build-task-tsc-build](https://stackoverflow.com/questions/49910024/vscode-path-generation-failure-in-run-build-task-tsc-build)

[https://github.com/Microsoft/vscode/issues/35593](https://github.com/Microsoft/vscode/issues/35593)