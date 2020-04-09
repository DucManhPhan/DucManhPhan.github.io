---
layout: post
title: Common commands in Angular CLI
bigimg: /img/path.jpg
tags: [Front-End, Angular]
---

When we work with Aungular, we usually have to create some componenets, build, run project, ... So, to reduce our time considering to do wasted thing, we must use Angular CLI.

So, in this article, we will find some common commands to manage our Angular project with Angular CLI.

## Table of contents
- [Setup node.js and npm](#setup-node.js-and-npm)
- [Setup Angular CLI](#setup-angular-cli)
- [Create new Angular project](#create-new-angular-project)
- [Generate new parts](#generate-new-parts)
- [Generting a route](#generating-a-route)
- [Build our project](#build-our-project)
- [Run project](#run-project)
- [Some useful commands](#some-useful-commands)

<br>

## Setup node.js and npm
The first thing we have to do is to download node.js. You can visit the node.js [website](https://nodejs.org/en/download/) to fetch suitable version.

The installation may take a while.

To check the existence or the version of node.js, npm, we use command:

```
node -v
npm -v
```

<br>

## Setup Angular CLI
Use command:

```
npm install -g @angular/cli
```

<br>

## Create new Angular project

```
ng new our_name_project
```

This command will generate a new project. Inside of that folder, it will create all the files for a basic but already executable angular application.   

It will also install all required external dependencies. It can actually take some time.

In ```ng new``` command, there are many additional flags. So, the below table will have description about these flags.

|          Additional flags          |            Description            |
| ---------------------------------- | --------------------------------- |
| ```--dry-run``` or ```-d```        | It will stop the CLI from making any changes to the file system. Instead, it will print everything it would have done to console. |
| ```--skip-install```               | skips the installation of external dependencies when we do not want to install or do not have a internet connection. |
| ```--style scss```                 | using CSS pre-processor such as SASS. Because the CLI creates normal CSS-files for every component by default. |
| ```--force``` or ```-f```          | creates project with force when having some issues. |
| ```--verbose``` or ```-v```        | list all the details of generating project. |
| ```-c``` or ```--collection```     | |
| ```--inline-style``` or ```-s```   | |
| ```--inline-template``` or ```-t```| |
| ```--routing```                    | |
| ```--prefix```                     | |
| ```--skip-tests```                 | |
| ```--skip-package-json```          | |

<br>

## Generate new parts
There are some parts that we need to create:
- Class
- Component
- Directive
- Enum
- Guard
- Interface
- Module
- Pipe
- Service
- Application
- Universal
- Library

To create a new component, we can use the following command:

```
ng generate component header  
```

The below table will describe commands that need to make our parts:

|      Scaffold       |                Usage                |
| ------------------- | ----------------------------------- |
| Component           | ```ng g componenet my-new-componenet``` |
| Directive           | ```ng g directive my-new-directive``` |
| Pipe                | ```ng g pipe my-new-pipe``` |
| Service             | ```ng g service my-new-service``` |
| Class               | ```ng g class my-new-class``` |
| Interface           | ```ng g interface my-new-interface``` |
| Enum                | ```ng g enum my-new-enum``` |
| Module              | ```ng g module my-module``` |

<br>

## Generting a route




<br>

## Build our project
Use command:

```
ng build
```

This command will do some steps:
- build application, compress and encapsulate source code.

- Using this command, the app is still in an development state. So, it means the certain optimizations where not perform and the app is still using the development environment variables.

    To change this situation, use the ```--prod``` flag:

    ```
    ng build --prod
    ```

- It will cause the CLI to build our application and places the output in a directory called ```dist``` (by default).

- Resource in CSS such as images, fonts will be embedded inline if size < 10KB.

<br>

## Run project
Use command: 

```
ng serve -o
```

Some following character in this command: 
- start our application in development mode at local.
- It will watch the directory of our application for changes. So if it detects a change, it will recompile the application (partly) and automatically update the application in the browser.
- default port: 4200

It will have some options:
- Prod
- Configuration
- Port
- Host
- Open
- Live-reload
- Source-map
- Common-chunk
- Vendor-chunk
- Base-href
- Deploy-url
- Watch

<br>

## Some useful commands 
- ```ng test```: the source code will be tested within development.
- ```ng e2e```: start application and run test script.
- ```ng lint```: the source code have to be clean code to follow the standard of project (using tslint).
- ```ng update```: update application to the newest version.
- ```ng doc [search term]```: open API document of Angular.
- ```ng config```: get/set some values of configuration.

Thanks for your reading.

<br>

Refer:

[https://www.npmjs.com/package/angular-cli#generating-components-directives-pipes-and-services](https://www.npmjs.com/package/angular-cli#generating-components-directives-pipes-and-services)