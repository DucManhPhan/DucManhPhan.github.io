---
layout: post
title: Routing in Angular
bigimg: /img/image-header/california.jpg
tags: [Angular]
---


<br>

## Table of contents
- [Introduction to Routing in Angular](#introduction-to-routing-in-angular)
- [Route](#route)
- [RouterModule](#routermodule)

<br>

## Introduction to Routing in Angular
Routing in Angular is completely implemented in the client side. When we have specific endpoints, the current component will be transformed to the corresponded component. All essential things is contained in the ```@angular/router``` package. 

```@angular/router``` package defines the ```Route``` object that maps a URL path to a component, and the ```RouterOutlet``` directive that we use to place a routed view in a template, as well as a complete API for configuring, querying, and controlling the router state.

Then, Angular Router has a plethora of feature such as:
- The support for multiple Router outlets which helps us easily add complex routing scenario like nested routing. 
- Various path matching strategies (```prefix``` and ```full```) to tell the Router how to match a specific path to a component.
- Easy access to route parameters and query parameters. 
- Resolvers
- Lazy loading of modules
- Route guards for adding client side protection and allow or disallow access to component or modules, ...

Routing in Angular is also referred to as component routing because the Router maps a single or a herarchy of components to a specific URL.

<br>

## Route






<br>

## RouterModule
It is used to add router directives and providers. And ```RouterModule``` can be imported multiple times: once per lazily-loaded bundle. Since the router deals with a global shared resource-location, we cannot have more than one router service active.

 There are two methods in ```RouterModule```. 

```javascript          
class RouterModule {
  static forRoot(routes: Route[], config?: ExtraOptions): ModuleWithProviders<RouterModule>

  static forChild(routes: Route[]): ModuleWithProviders<RouterModule>
}    
```

```forRoot()``` and ```forChild()``` are used to create a module with all the router providers and directives. But: 
- ```forRoot()``` contains the router service itself and ```forRoot()``` also includes some optional parameters to set up an application listener to perform an initial navigation.
- ```forChild()``` does not include the router service.

When registered at the root, the module should be used as follows:

```javascript
@NgModule({
  imports: [RouterModule.forRoot(ROUTES)]
})
class MyNgModule {}
```

For submodules and lazy loaded submodules, the module should be used as follows:

```javascript
@NgModule({
  imports: [RouterModule.forChild(ROUTES)]
})
class MyNgModule {}
```

In order to understand how to use it, we can refer to this [link](https://github.com/DucManhPhan/Learn-Javascript/tree/master/src/Angular/src/use-routing-module).

<br>

## Some directives in RouterModule
- RouterLink





Refer:

[https://www.techiediaries.com/angular-router/](https://www.techiediaries.com/angular-router/)

[https://angular.io/guide/router](https://angular.io/guide/router)

[https://angular.io/api/router/Route](https://angular.io/api/router/Route)

[https://angular.io/api/router/ActivatedRoute](https://angular.io/api/router/ActivatedRoute)

[https://angular.io/api/router/ParamMap](https://angular.io/api/router/ParamMap)