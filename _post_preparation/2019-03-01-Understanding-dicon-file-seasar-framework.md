---
layout: post
title: Understanding dicon file in Seasar framework
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Java]
---




<br>

## Table of contents
- [S2Container in Seasar framework](#s2container-in-seasar-framework)
- [Structure of dicon file](#structure-of-dicon-file)
- [Namespace](#namespace)
- [Wrapping up](#wrapping-up)



<br>

## S2Container in Seasar framework






<br>

## Structure of dicon file 

To understand structure of dicon file, we can see the following xml code.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE components PUBLIC "-//SEASAR//DTD S2Container 2.3//EN" 
    "http://www.seasar.org/dtd/components23.dtd">
<components>
    <include path="aop.dicon"/>

    <component
      class="org.seasar.framework.container.autoregister.FileSystemComponentAutoRegister">
        <initMethod name="addClassPattern">
            <arg>"examples.di.impl"</arg>
            <arg>".*Impl"</arg>
        </initMethod>
    </component>

    <component
      class="org.seasar.framework.container.autoregister.AspectAutoRegister">
        <property name="interceptor">aop.traceInterceptor</property>
        <initMethod name="addClassPattern">
            <arg>"examples.di.impl"</arg>
            <arg>".*Impl"</arg>
        </initMethod>
    </component>
</components>
```

All our objects are declared in ```componenets``` tags. Each object is ```component``` tag that contains ```property```, and ```initMethod```, ```arg```.

<br>

## Namespace







<br>

## Wrapping up




<br>


Refer: 

[http://s2container.seasar.org/en/DIContainer.html#Lifecycle](http://s2container.seasar.org/en/DIContainer.html#Lifecycle)