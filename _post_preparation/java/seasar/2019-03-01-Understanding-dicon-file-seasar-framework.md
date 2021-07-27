---
layout: post
title: Understanding dicon file in Seasar framework
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Java]
---




<br>

## Table of contents
- [S2Container in Seasar framework](#s2container-in-seasar-framework)
- [Source code using Seasar framework](#source-code-using-seasar-framework)
- [Structure of dicon file](#structure-of-dicon-file)
- [Convention over Configuration](#convention-over-configuration)
- [Namespace](#namespace)
- [Wrapping up](#wrapping-up)



<br>

## S2Container in Seasar framework
Seasar2 is a light weight container for Dependency Injection operations.

There are two methods of creating S2Container.
- Use SingletonS2ContainerFactory

    We will use the following method when utilizing SingletonS2ContainerFactory: ```org.seasar.framework.container.factory.SingletonS2ContainerFactory#init()```

    ```app.dicon``` located in the directory as defined in CLASSPATH is used.

    The created S2Container can be obtained by the following method from any location: ```org.seasar.framework.container.factory.SingletonS2ContainerFactory#getContainer()```

    ```java
    SingletonS2ContainerFactory.init();
    ...
    S2Container container = SingletonS2ContainerFactory.getContainer();
    ```

    Use the following method before calling init() if specifying a path to the definition file: ```org.seasar.framework.container.factory.SingletonS2ContainerFactory#setConfigPath(String Path)```

    The arguments path is an absolute path of the definition file referencing the directory defined in CLASSPATH as root. For example, ```WEB-INF/classes/aaa.dicon``` is ```aaa.dicon```. ```WEB-INF/classes/aaa/bbb/ccc.dicon``` becomes ```aaa/bbb/ccc.dicon```. The separator is ?/? in both Windows and UNIX systems.

    ```java
    private static final String PATH = "aaa/bbb/ccc.dicon";
    ...
    SingletonS2ContainerFactory.setConfigPath(PATH);
    SingletonS2ContainerFactory.init();
    ...
    S2Container container = SingletonS2ContainerFactory.getContainer();
    ```

- Use S2ContainerFactory

    We will use the following method when utilizing S2ContainerFactory: ```org.seasar.framework.container.factory.S2ContainerFactory#create(String path)```

    We will call the following method after creating S2Container: ```org.seasar.framework.container.S2Container#init()```

    ```java
    private static final String PATH = "aaa/bbb/ccc.dicon";
    ...
    S2Container container = S2ContainerFactory.create(PATH);
    container.init();
    ```



<br>

## Source code using Seasar framework
The following is the structure of project's folder. We create ```Java Application``` project in eclipse or e Builder.

![](../img/Java-Common/seasar-framework/structure-folder-hello-world.png)

- In ```Greeting.java``` file:

    ```java
    package examples1.impl;

    public interface Greeting {
	    String greet();
    }
    ```

- In ```GreetingClient.java``` file:

    ```java
    package examples1.impl;

    public interface GreetingClient {
	    void execute();
    }
    ```

- In ```GreetingImpl.java``` file:

    ```java
    package examples1.impl;

    public class GreetingImpl implements Greeting {        
        @Override
        public String greet() {
            return "Hello world with Seasar framework";
        }
    }
    ```

- In ```GreetingClientImpl.java``` file:

    ```java
    package examples1.impl;

    public class GreetingClientImpl implements GreetingClient {        
        private Greeting greeting;
        
        public void setGreeting(Greeting greeting) {
            this.greeting = greeting;
        }
        
        @Override
        public void execute() {
            System.out.println(greeting.greet());
        }
        
    }
    ```

- In ```examples1.dicon``` file:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE components PUBLIC "-//SEASAR//DTD S2Container 2.3//EN"
        "http://www.seasar.org/dtd/components23.dtd">
    <components>
    <component name="greeting" class="examples1.impl.GreetingImpl">
    </component>
    <component name="greetingClient" class="examples1.impl.GreetingClientImpl">
        <property name="greeting">greeting</property>
    </component>
    </components>
    ```

- In ```HelloWorldSeasar.java``` file:

    ```java
    package examples1;

    import org.seasar.framework.container.S2Container;
    import org.seasar.framework.container.factory.S2ContainerFactory;
    import org.seasar.framework.exception.ResourceNotFoundRuntimeException;

    import examples1.impl.GreetingClient;

    public class HelloWorldSeasar {
        public static void main(String[] args) {
            // TODO Auto-generated method stub
            String configure_path = "examples1/dicon/examples1.dicon";
            
            try {
                S2Container container = S2ContainerFactory.create(configure_path);
                container.init();	// add to initialize components
                try {
                GreetingClient greetingClient = (GreetingClient)container.getComponent("greetingClient");
                greetingClient.execute();
                } finally {
                    container.destroy();
                }
            } catch (ResourceNotFoundRuntimeException e){
                System.out.println("Configuration file \"" + configure_path + "\" not found.");
            }
        }
    }
    ```

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

    <component name="greeting"
        class="examples.di.impl.GreetingImpl">
        <aspect>aop.traceInterceptor</aspect>
    </component>

    <component name="greetingClient"
        class="examples.di.impl.GreetingClientImpl">
        <property name="greeting">greeting</property>
        <aspect>aop.traceInterceptor</aspect>
    </component>
</components>
```
All our objects are declared in ```componenets``` tags. Each object is ```component``` tag that contains ```property```, and ```initMethod```, ```arg```.

We use the ```include``` tag to instruct seasar2 that utilize AOP modules predefined within aop.dicon.

```xml
<include path="aop.dicon"/>
```

## Convention over Configuration
Think about the below code:

```xml
<component name="greetingClient" class="examples.di.impl.GreetingClientImpl">
    <property name="greeting">greeting</property>
</component>
```

As long as the property type is interface and there is a component impementing interface in the container, S2Container has a function to automatically DI. This means S2Container will automatically process components as long as they follow the DI convention of defining property type by interface.

We can simplify the configuration from above as follows.

```xml
<component name="greetingClient" class="examples.di.impl.GreetingClientImpl"></component>
```

Actually, "Convention over Configuration" is used in the AOP example from earlier. Normally, where (or which method) the AOP module is applied is defined in pointcut. All methods defined by interface have the AOP module applied without the use of pointcut in S2AOP as long as they follow the convention of using interface. This is how there was no need to define a module in pointcut in the earlier example.

Using Convention over Configuration will simplify the configuration of DI and AOP. However, component registration itself becomes a burden as the number of components increase. The automation of this component registration is Component auto-registration functionality. 

```xml
<component class="org.seasar.framework.container.autoregister.FileSystemComponentAutoRegister">
    <initMethod name="addClassPattern">
        <arg>"examples.di.impl"</arg>
        <arg>".*Impl"</arg>
    </initMethod>
</component>
```

This FileSystemComponentAutoRegister component searches classes defined in addClassPattern from the file system and auto-registers them in S2Container.

The first argument of addClassPattern method is the package name of the component to be auto-registered. Child packages are also recursively searched. The second argument is the class name, which may be a regular expression. Multiple definitions are separated by commas.

Auto-registration of components decreases the overall amount of work, as the programmer is not required to configure anything for new components.

<br>

## Namespace







<br>

## Wrapping up




<br>


Refer: 

[http://s2container.seasar.org/en/DIContainer.html#Lifecycle](http://s2container.seasar.org/en/DIContainer.html#Lifecycle)