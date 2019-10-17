---
layout: post
title: Debugging Node.js project with Typescript
bigimg: /img/image-header/california.jpg
tags: [Typescript, Node.js]
---

In this article, we will find something out about how to debuggin Node.js with typescript, no using webpack, babel, or ts-node, ts-node-dev to deploy in a server. It is useful when we want to demo some small functionalities for our project.

Let's get started.

<br>

## Table of contents
- [Create Node.js project](#create-node.js-project)
- [Some packages that need to install](#some-packages-that-need-to-install)
- [Setting debug mode in Visual studio code](#setting-debug-mode-in-visual-studio-code)
- [Wrapping up](#wrapping-up)

<br>

## Create Node.js project

We will use npm to initialize our project:

```js
npm init -y
```

It will create ```package.json``` file in our project. Then, we can install some necessary packages that we want.

<br>

## Some packages that need to install
1. Use ```typescript``` package

    Node.js is an engine that runs Javascript and not Typescript. The node Typescript package allows us to transpile our ```.ts``` file to ```.js``` scripts. Babel can also be used to transpile Typescript, however the market standard is to use the official Microsoft package.

    ```js
    npm install typescript --save-dev
    ```

    Inside our package.json, we will put a script called tsc:

    ```js
    "scripts": {
      "tsc": "tsc"
    }
    ```

    This modification allows us to call typescript functions from the command line in the project’s folder. So, we can use the following command:

    ```js
    npm run tsc -- --init
    ```

    This command initializes the typescript project by creating the ```tsconfig.json``` file. Within this file, we will uncomment the outDir option and choose a location for the transpiled ```.js``` files to be delivered.

    Note:
    - Typescript handles all of the ES6 and a lot of the ES7 syntax but the runtime operations. So things like ```Object.assign()```, ```Symbol()```, etc. are not polyfilled by ```TypeScript```.

2. Use ```@types/node``` package

    ```@types/node``` package is an type declaration package for ```Node.js```, it has the same name as the package on npm, but prefixed with ```@types/```, but if we need, we can check out [https://aka.ms/types](https://aka.ms/types) to find the package for our favorite library.

    ```js
    npm install @types/node --save-dev
    ```

3. Use ```tslint``` package

    TSLint is an extensible static analysis tool that checks Typescript code for readability, maintainability, and functionality errors. It is widely supported across modern editors & build systems and can be customized with our own lint rules, configurations, and formatters.

    ```js
    npm install tslint typescript --save-dev

    // then, create tslint.json
    tslint --init
    ```

So, in our ```package.json``` file will include information:

```js
"devDependencies": {
    "@types/node": "^12.7.12",
    "typescript": "^3.6.4"
}
```


<br>

## Setting debug mode in Visual studio code
1. Settings in ```tsconfig.json``` file

    The presence of a ```tsconfig.json``` file in a directory indicates that the directory is the root of a TypeScript project. The ```tsconfig.json``` file specifies the root files and the compiler options required to compile the project. A project is compiled in one of the following ways:

    - By invoking tsc with no input files, in which case the compiler searches for the tsconfig.json file starting in the current directory and continuing up the parent directory chain.

    - By invoking tsc with no input files and a --project (or just -p) command line option that specifies the path of a directory containing a tsconfig.json file, or a path to a valid .json file containing the configurations.

    When input files are specified on the command line, tsconfig.json files are ignored.

    ```js
    {
        "compilerOptions": {
            "target": "es5",
            "module": "commonjs",
            "outDir": "dist",
            "strict": true,
            "sourceMap": true
        },
        "files": [
            "core.ts",
            "sys.ts",
            "types.ts",
            "scanner.ts",
            "parser.ts",
            "utilities.ts",
            "binder.ts",
            "checker.ts",
            "emitter.ts",
            "program.ts",
            "commandLineParser.ts",
            "tsc.ts",
            "diagnosticInformationMap.generated.ts"
        ],
        "include": [
            "scr/**/*.ts"
        ],
        "exclude": [
            "node_modules",
            "**/*.spec.ts"
        ]
    }
    ```

    The meaning of some above settings:
    - ```target``` - specify ECMAScript target version: ```ES3``` (default), ```ES5```, ```ES2015```, ```ES2016```, ```ES2017```, ```ES2018```, ```ES2019``` or ```ESNEXT```.

    - ```sourceMap``` - generates corresponding ```.map``` file to help us easily debug our project.

    - ```strict``` - we should include this option into our ```tsconfig.json``` file because project that use typescript means we want to get the benefits of static type checking.

        The most important one is the ```strict``` flag, which covers four other flags that you can add independently:

        - ```--noImplicitThis```: Complains if the type of this isn't clear.

        - ```--noImplicitAny```: With this setting, we have to define every single type in our application. This mainly applies to parameters of functions and methods.

            const fn = ( worker ) => worker.name;

            If you don't turn on ```noImplicit```, any worker will implicitly be of any type.

        - ```--strictNullChecks```: null is not part of any type (other than its own type, null) and must be explicitly mentioned if it is an acceptable value.

            ```typescript
            interface Worker {
                name: string;
            }

            const getName = (worker?: Worker) => worker.name
            ```

            This code snippet won't compile because ```worker``` is an optional parameter and can be undefined.

        - ```--alwaysStrict```: Use JavaScript's ```strict``` mode whenever possible.

            For further compiler options please find them here:

            [https://www.typescriptlang.org/docs/handbook/compiler-options.html](https://www.typescriptlang.org/docs/handbook/compiler-options.html)

    - ```module``` - specify module code generation: ```none```, ```commonjs```, ```amd```, ```system```, ```umd```, ```es2015```, or ```ESNext```.

    - ```outDir``` - where all of built files will be placed.

    - ```files``` - takes a list of relative or absolute file paths.

    - ```include``` - take a list of glob-like file patterns

        If the ```files``` and ```include``` are both left unspecified, the compiler defaults to including all TypeScript ```.ts```, ```.d.ts``` and ```.tsx``` files in the containing directory and subdirectories except those excluded using the ```exclude``` property. JS files such as ```.js``` and ```.jsx``` are also included if allowJs is set to true.

        If the ```files``` or ```include``` properties are specified, the compiler will instead include the union of the files included by those two properties. Files in the directory specified using the ```outDir``` compiler option are excluded as long as ```exclude``` property is not specified.

        Files included using ```include``` can be filtered using the ```exclude``` property. However, files included explicitly using the ```files``` property are always included regardless of ```exclude```.

    - ```exclude``` - defaults to excluding the ```node_modules```, ```bower_components```, ```jspm_packages``` and ```<outDir>``` directories when not specified.

2. Settings in Visual studio code

    - In ```launch.json``` file

        ```typescript
        {
            "version": "0.2.0",
            "configurations": [
                {
                    "type": "node",
                    "request": "launch",
                    "name": "Launch Program",
                    "program": "${workspaceFolder}/src/index.ts",   // our main file
                    "sourceMaps": true,
                    "preLaunchTask": "npm: debug",
                    "outFiles": [
                        "${workspaceFolder}/build/index.js"
                    ]
                }
            ]
        }
        ```

        We also set ```sourceMaps``` property to ```true``` to support debugging. And ```preLaunchTask``` property will be referred to ```npm: debug``` in ```script``` property of ```package.json```.

        ```preLaunchTask```will be performed all other tasks.

    - In ```package.json``` file

        ```typescript
        "scripts": {
            "tsc": "tsc",
            "prod": "tsc && node ./build/index.js",
            "debug": "tsc --sourcemap"
        }
        ```

<br>

## Wrapping up
- Understand some important options in ```tsconfig.json``` file.
- Understand how to install some typescript packages for our project.

<br>

Refer:

[https://blog.bitsrc.io/best-practices-for-using-typescript-with-node-js-50907f8cc803](https://blog.bitsrc.io/best-practices-for-using-typescript-with-node-js-50907f8cc803)

[https://jobs.zalando.com/tech/blog/typescript-best-practices/?gh_src=4n3gxh1](https://jobs.zalando.com/tech/blog/typescript-best-practices/?gh_src=4n3gxh1)

[https://www.typescriptlang.org/docs/handbook/tsconfig-json.html](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html)

[https://www.typescriptlang.org/docs/handbook/compiler-options.html](https://www.typescriptlang.org/docs/handbook/compiler-options.html)