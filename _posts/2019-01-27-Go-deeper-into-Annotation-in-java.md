---
layout: post
title: Go deeper into Annotation - @Configuration
bigimg: /img/image-header/home-office-1.jpg
tags: [Spring]
---

Before you read about this article, I think that you should reference to the previous [article](https://ducmanhphan.github.io/2019-01-09-Annotations-in-java/).

So, in this article, we will find out the inside part of the way ```@Configuration``` annotation works.

<br>

## Table of Contents
- [How @Configuration annotation work](#how-@configuration-annotation-work)
- [Use MVC model in Java web application](#use-mvc-model-in-java-web-application)
- [The difference between @Configuration and @Component](#the-difference-between-@configuration-and-@component)
- [Wrapping up](#wrapping-up)

<br>

## How @Configuration annotation work
Before going deeper it, we will glance at a little bit about declaration of ```@Configuration``` at Spring MVC.

```java
@Target(value=TYPE)
  @Retention(value=RUNTIME)
  @Documented
  @Component
public @interface Configuration

@Configuration
@PropertySource("classpath:application.properties")
@ComponentScan("com.manhpd.exspringmvc")
@EnableWebMvc
  public class AppConfig extends WebMvcConfigurerAdapter{
      @Bean
      public MyBean myBean() {
         // instantiate, configure and return bean ...
         return new MyBean();
      }
}
```

According to the documentation of [spring.io](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/context/annotation/Configuration.html), ```@Configration``` indicates that a class declares one or more ```Bean``` methods and may be processed by the Spring container to generate bean definitions and service requests for those bean at runtime.

So, from this definition, we have two things that we need to mark:
- ```@Configuration``` annotation indicates that the class has ```@Bean``` definition methods.
- Spring container can process the class and generate Spring Beans to be used in the application. And beans are the objects that return from the above methods such as **myBean()**.

Next, we have some questions:
- When does Bean objects create?
- After created, where will Bean objects be contained? and What is it?
- When will Bean objects be popped from something?

<br>
Now, we will answer each question:

1. First question - When does Bean objects create?

    In Spring MVC, we have a segment code:

    ```java
    public class WebInitializer implements WebApplicationInitializer {
        @Override
        public void onStartup(ServletContext servletContext) throws ServletException {
            // Create the root Spring application context
            AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
            rootContext.register(AppConfig.class);
            rootContext.setServletContext(servletContext);        
            
            // Manage the lifecycle of the root application context
            servletContext.addListener(new ContextLoaderListener(rootContext));

            // Create the dispatcher servlet's Spring application context
            AnnotationConfigWebApplicationContext dispatcherContext = new AnnotationConfigWebApplicationContext();
            dispatcherContext.register(DispatcherConfig.class);

            // Register and map the dispatcher servlet
            ServletRegistration.Dynamic servlet = servletContext.addServlet("dispatcher", new DispatcherServlet(rootContext));
            servlet.addMapping("/");    
            servlet.setLoadOnStartup(1);
        }
    }
    ```

    We will see that we're using the ```onStartup()``` function in  ```WebApplicationInitializer``` interface. An implementation of the WebApplicationInitializer interface configures the ServletContext programmatically. In particular, it allows for the creation, configuration, and registration of the DispatcherServlet programmatically. So, the web.xml file will be removed from modern Spring MVC applications.

    In Spring 3.1, the DispatcherServlet, in Servlet Container, had to be registered via web.xml file.

    ```xml
    <servlet>
    <servlet-name>dispatcher</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet
    </servlet-class>
    </servlet>
    <servlet-mapping>
    <servlet-name>dispatcher</servlet-name>
    <url-pattern>*.request</url-pattern>
    </servlet-mapping>
    ```

    Back to your article, ```onStartup``` method will be called to initialize our application.

    **AnnotationConfigWebApplicationContext** implementation which accepts annotated classes as input - in particular ```@Configuration``` - annotated classes, but also plain ```@Component``` classes.

    It allows for registering classes one by one (specifying class names as a config location) as well as for classpath scanning (specifying base package as config location).

    So, ```@Configuration``` class is typically bootstrapped using **AnnotationConfigWebApplicationContext**.

    ```java
    rootContext.register(AppConfig.class);
    ```

    After registering ```AppConfig.class``` into **AnnotationConfigWebApplicationContext**, it will load all of Beans that is defined in ```@Configuration``` class.

    Assumed that we have custom configurations that are spread across multiple classes, now, we want to use all of these configurations. Spring WebApplicationInitializer provides a way to specify root package to be scanned for configuration classes.

    ```java
    rootContext.setConfigLocation("com.manhpd.app.config");
    ```

    The next step is to add ```ContextLoaderListener``` to the ```ServletContext``` which will be responsible to load the context.

    ```java
    // Manage the lifecycle of the root application context
    servletContext.addListener(new ContextLoaderListener(rootContext));
    ```

    The final step is creating and registering Dispatcher servlet, which is the entry point of our application.

    ```java
    // Register and map the dispatcher servlet
    ServletRegistration.Dynamic dispatcher =
            servletContext.addServlet("dispatcher", new DispatcherServlet(rootContext));
    dispatcher.setLoadOnStartup(1);
    dispatcher.addMapping("/");
    ```

    Therefore, Beans object will be created at the first time of an application. In Bean objects, we will set a scope for them, refer to the [link](https://ducmanhphan.github.io/2019-01-30-Using-@Autowired-@Bean-annotation-in-Spring).


2. Second question - Where will Bean objects be contained? and What is it?

    From the above section 1, we see that Spring loads beans into **AnnotationConfigWebApplicationContext** before we have even requested it. This is to make sure all the beans are properly configured and application fail-fast if something goes wrong.

    So, application context will contain all Bean objects. 

    **ApplicationContext** is one of the Spring container in Spring framework. It is the central interface within a Spring application for providing configuration information to the application. It is read-only at runtime, but can be reloaded if necessary and supported by the application.

    Some derived class from **ApplicationContext** are:
    - **AnnotationConfigApplicationContext**: loads a Spring application context from one or more Java-based configuration classes.

        ```java
        ApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        ```

    - **AnnotationConfigWebApplicationContext**: loads a Spring web application context from one or more Java-based configuration classes.

        ```java
        ApplicationContext context = new AnnotationConfigWebApplicationContext(WebAppConfig.class);
        ```

    - **ClassPathXMLApplicationContext**: Loads a context definition from one or more XML files located in the classpath.

        ```java
        ApplicationContext context = new ClassPathXMLApplicationContext("springConfig.xml");
        ```

    - **FileSystemXMLApplicationContext**: Loads a context definition from one or more XML files located in the filesystem. 

        ```java
        ApplicationContext context = new FileSystemXMLApplicationContext("C:/springConfig.xml");
        ```

    - **XMLWebApplicationContext**: Loads a context definition from one or more XML files contained in the web application. 

        ```java
        ApplicationContext context = new XMLWebApplicationContext("/WEB-INF/config/springConfig.xml");
        ```

3. Third question - When will Bean objects be popped from something?

    This queston is easy to answer. You can reference to this [link](https://ducmanhphan.github.io/2019-01-09-Annotations-in-java/).

<br>

## Use MVC model in Java web application
To notify for our project that use Spring MVC, we will use ```@EnableWebMvc``` [annotation](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/servlet/config/annotation/EnableWebMvc.html) in ```@Configuration``` class.

```java
@Retention(value=RUNTIME)
  @Target(value=TYPE)
  @Documented
  @Import(value=DelegatingWebMvcConfiguration.class)
public @interface EnableWebMvc
```

It will import the Spring MVC configuration from WebMvcConfigurationSupport.

<br>

## The difference between @Configuration and @Component
This part is refer from [link](http://dimafeng.com/2015/08/29/spring-configuration_vs_component/).

Consider the below two code segments:

```java
@Configuration
public static class Config {

    @Bean
    public SimpleBean simpleBean() {
        return new SimpleBean();
    }

    @Bean
    public SimpleBeanConsumer simpleBeanConsumer() {
        return new SimpleBeanConsumer(simpleBean());
    }
}
```

```java
@Component
public static class Config {

    @Bean
    public SimpleBean simpleBean() {
        return new SimpleBean();
    }

    @Bean
    public SimpleBeanConsumer simpleBeanConsumer() {
        return new SimpleBeanConsumer(simpleBean());
    }
}
```

The first piece of code works fine. ```SimpleBeanConsumer``` will get a link to singleton ```SimpleBean```. 

The second piece of code is totally incorrect because Spring will create a singleton bean of ```SimpleBean```, but ```SimpleBeanConsumer``` will obtain another instance of ```SimpleBean``` which is out of the Spring context control.

If we use ```@Configuration```, all methods marked as ```@Bean``` will be wrapped into a [CGLIB wrapper](https://docs.spring.io/spring/docs/current/spring-framework-reference/core.html#aop) which works as if it's the first call of this method, then the original method's body will be executed and the resulting object will be registered in the Spring context. All further calls just return the bean retrieved from the context. 

In the second piece of code, ```new SimpleBeanConsumer(SimpleBean())``` just calls a pure java method. 

To fix this mistake in the second piece of code, we do:

```java
@Component
public static class Config {
    @Autowired
    SimpleBean simpleBean;

    @Bean
    public SimpleBean simpleBean() {
        return new SimpleBean();
    }

    @Bean
    public SimpleBeanConsumer simpleBeanConsumer() {
        return new SimpleBeanConsumer(simpleBean);
    }
}
```


<br>

## Wrapping up
- Understanding why configuration in Spring MVC and some parts in framework.
- ```@Configuration``` annotation will wrap all ```@Bean``` methods into CGLIB wrapper.

<br>

Refer: 

[https://docs.spring.io/spring/docs/4.0.x/spring-framework-reference/html/index.html](https://docs.spring.io/spring/docs/4.0.x/spring-framework-reference/html/index.html)

[https://blog.codeleak.pl/2013/11/controlleradvice-improvements-in-spring.html](https://blog.codeleak.pl/2013/11/controlleradvice-improvements-in-spring.html)

[https://blog.codeleak.pl/2014/09/using-configurationproperties-in-spring.html](https://blog.codeleak.pl/2014/09/using-configurationproperties-in-spring.html)

[https://blog.codeleak.pl/2013/04/spring-mvc-pathvariable-tips.html](https://blog.codeleak.pl/2013/04/spring-mvc-pathvariable-tips.html)

[https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/context/annotation/Configuration.html](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/context/annotation/Configuration.html)

[https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/servlet/config/annotation/EnableWebMvc.html](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/servlet/config/annotation/EnableWebMvc.html)

**The difference between ```@Configuration``` and ```@Component```**

[http://dimafeng.com/2015/08/29/spring-configuration_vs_component/](http://dimafeng.com/2015/08/29/spring-configuration_vs_component/)

[https://stackoverflow.com/questions/12704891/how-does-spring-3-1-java-based-configuration-work](https://stackoverflow.com/questions/12704891/how-does-spring-3-1-java-based-configuration-work)

[https://www.journaldev.com/21033/spring-configuration-annotation](https://www.journaldev.com/21033/spring-configuration-annotation)

**Use web.xml and WebApplicationInitializer class**

[https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/WebApplicationInitializer.html](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/WebApplicationInitializer.html)

[https://www.javadevjournal.com/spring/spring-webapplicationinitializer/](https://www.javadevjournal.com/spring/spring-webapplicationinitializer/)

[https://spring.io/blog/2008/03/27/spring-java-configuration-what-s-new-in-m3/](https://spring.io/blog/2008/03/27/spring-java-configuration-what-s-new-in-m3/)

**@EnableWebMvc annotation**
[https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/servlet/config/annotation/EnableWebMvc.html](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/servlet/config/annotation/EnableWebMvc.html)

**WebApplicationContext**

[http://dimafeng.com/2015/07/22/web-app-context/](http://dimafeng.com/2015/07/22/web-app-context/)

**CGLIB**
[https://stackoverflow.com/questions/38089200/what-is-cglib-in-spring-framework](https://stackoverflow.com/questions/38089200/what-is-cglib-in-spring-framework)

[http://dimafeng.com/2015/08/16/cglib/](http://dimafeng.com/2015/08/16/cglib/)