---
layout: post
title: Angular project structure
bigimg: /img/path.jpg
tags: [Front-End, Angular]
---

When using Angular CLI, it will create so many files in our folder. But some files that we can not understand that what these files will used to do.

So, in this article, we will discuss about the project structure of Angular.

<br>

## Angular project structure
In Angular project, we can see that it has some main folders such as dist, docs, e2e, node_modules, src, and different configuration files.

Belows are some different configuration files.

|              File           |               Purpose                |
| --------------------------- | ------------------------------------ |
| tslint.json                 | Used for building application with consistent code style. We can change the configuration that defines how our application should be built. |
| tsconfig.json               | ```ts``` stands for typescripts. Typescripts are used for developing angular applications since Angular 2 came out. It contains the configurations for typescripts. |
| README.md                   | Is contains basic documentation for your project, pre-filled with CLI command information. Just make sure to enhance it with project documentation so that anyone checking out the reputation can build your application. |
| package.json                | It contains all the dependency modules which are required for our application. It’s up to you which module you want to use. if you want to use _js library or any other library just add name and version of that dependency  library in package.json and execute command npm install. It will execute all the dependencies and download in node_modules folder. |
| .gitignore                  | We can define all the folders and files which we want to exclude from our repository in our git. |

<br>

In src folder, we have some main directories such as app, assets, environments, and some files.

Below is the table to describe the primary purpose of each file.

|           File          |                   Purpose                     |
| ----------------------- | --------------------------------------------- |
| favicon.ico             | Its favicon for our website or an application |
| index.html              | It contains html code with head, and body section. It is starting point of your application. |
| main.ts                 | It is starting point of typescript file in your angular application. It contains library which are imported by your angular project. |
| polyfills.ts            | It is used for browser compatibility. |
| styles.scss             | It has all the styles and css for your angular 4 project. |
| test.ts                 | This file is used to write unit tests. |
| tsconfig.app.json       | It contains the configuration about how your application should compile. | 
| app /app.module.ts 	  | It contains the entire library which are imported and used in your angular 4 application. It’s a root module that tells Angular how to assemble the application. Currently it declares only the App_componenet. |
| app/app.component.{ts,html,css,spec.ts}  | It has AppComponent with an HTML template, CSS style sheet, and a unit test. It’s the root component of what will become a tree of nested components as the application evolves. |
| assets/*                | In this folder you can put images and anything else to be copied wholesale when you build your application. |
| environments/*          |	In this folder one file for each of your destination environments, each exporting simple configuration variables to use in your application. The files are replaced on-the-fly when you build your app. You might use a different API endpoint for development than you do for production or maybe different analytics tokens. You might even use some mock services. Either way, the CLI has you covered. |

<br>

Next, we will find out the folder e2e and node_modules: 

|           File          |                 Purpose              |
| ----------------------- | ------------------------------------ |
| e2e/*                   | In this folder, all the test cases from live the End-to-End cycles covered. They shouldn’t be inside src/ because e2e tests are really a separate app that just so happens to test your main app. That’s also why they have their own tsconfig.e2e.json. |
| node_modules/           | Node.js creates this folder and puts all third party modules listed in package.json. |

<br>

## Wrapping up
- Understanding the purpose of each file which is created by Angular CLI.
- Combine with the architecture of Angular, we can easily create new modification with our Angular project.

<br>

Thanks for your reading.

Refer: 

[https://code4developers.com/angular-4-project-structure/](https://code4developers.com/angular-4-project-structure/)