---
layout: post
title: Annotations in Java
bigimg: /img/image-header/ravashing-beach.jpg
tags: [Java]
---

I were a beginner in programming with Java web, especially Spring MVC, Spring Boot. When I saw about **@Configuration**, **@PropertySource**, **@Component**, ..., it makes me confused to understand what it is doing here.

After searching about some above words enormously, I got the **Annotations** keyword and read about its objective is **To spend less time on unhappy code-writing and focus more on business logic rules**. So, in this article, we will find out about **Annotations** in Java web.

All of informations in this article it will refer from the website [developer.com](https://www.developer.com/java/other/article.php/3556176/An-Introduction-to-Java-Annotations.htm)

<br>

## Table of Contents
- [Introduction about Annotation](#introduction-about-annotation)
- [Annotation Basic](#annotation-basic)
- [Annotation Types](#annotation-types)
- [Rule of thumbs for defining annotation type](#rule-of-thumbs-for-defining-annotation-type)
- [Common annotation in Spring MVC](#common-annotation-in-spring-mvc)
- [Wrapping up](#wrapping-up)

<br>

## Introduction about Annotation
Annotations, firstly, were introduced in Java 5.0. This JDK version transfered/shifted the responsibility for writing boilerplate Java code from the programmer to the compiler. It makes the programmer's life easier to breath because the source codes contain less bugs and they only take care of the business of software.

Annotations can be added to the source code, and apply to the package declarations, type declarations,constructors, methods, fields, parameters and variables. 

They are used to indicate whether our methods are dependent on other methods, whether they are incomplete, whether our classes have references to other classes, ...

<br>

## Annotation Basic
In annotations, there are two traits that we will need to note. They are **annotation** ifself and **annotation type**.

- An annotation is the meta-tag used in source code.
- Annotation type is used for defining an annotaion. You can use **Annotation type** to create our own custom annotation. The type is the actual construct used, and the annotation is the specific usage of that type.
    
    An annotation type definition takes an @ sign, followed by the **interface** keyword plus the annotation name. We can also put data within parenthesis after the annotation name.

```java
// define annotation type
public @interface OurAnnotation {
    String doSomthing();
}

// use annotation
OurAnnotation (doSomething="To do")
public void ourMethod() {
    // nothing to do
}
```

## Annotation Types
There are 3 annotation types:
- marker: it has no elements, except the annotation name ifself.

    For instance:

    ```java
    // define annotation type
    public @interface itsAnnotation {
        // nothing to do
    }

    // use annotation
    @itsAnnotation 
    public void useMethod() {
        // do something
    }
    ```

- single-element: Single-element, or single-value type, annotations provide a single piece of data only. 

    This can be represented with a data=value pair or, simply with the value (a shortcut syntax) only, within parenthesis. 

    For instance:

    ```java
    // define annotation type
    public @interface OurAnnotation {
        String doSomthing();
    }

    // use annotation
    OurAnnotation ("To do")
    public void ourMethod() {
        // nothing to do
    }
    ```

- full-value or multi-value: full-value type annotations have multiple data members. Therefore, you must use a full data=value parameter syntax for each member.

    For instance: 

    ```java
    public @interface istAnnotation {
        String doSomething();
        int count;
        String date();
    }

    @itsAnnotation (doSomething="To do", count = 1, date = "01-16-2019")
    public void ourMethod() {
        // nothing to do
    }
    ```

<br>

## Rule of thumbs for defining annotation type
- Annotation declaration should start with an 'at' sign like @, following with an ```interface``` keyword, following with the annotation name.
- Method declarations should not have any parameters.
- Method declarations should not have any throws clauses.
- Return types of the method should be one of the following:
    - primitives
    - String
    - Class
    - enum
    - array of the above types

<br>

## Common annotation in Spring MVC
- ```@Override``` annotation

    This annotation indicates the annotated method is required to override a method in a super class. If a method with this annotation does not require its super class's method, the compiler will generate an error. 

- ```@Bean``` annotation

    The objects that are managed by the Spring IoC container are called **beans**.

    Check this example to understand deeper about ```@Bean``` and ```@Autowired```.

    For instance: 

    ```java
    @SpringBootApplication
    public class Application {
        @Autowired
        BookingService bookingService;

        @Bean
        BookingService bookingService() {
            return new BookingService();
        }

        public static void main(String[] args) {
            bookingService.book("Alice", "Bob", "Carol");
        }
    }
    ```    

    It will tell Spring that "here is an instance of this class, please keep hold of it and give it back to me when I ask". 

    So, we will explain how to use ```@Bean``` and ```@Autowired``` annotation in the above code:
    - Firstly, with 
        ```java
        @Autowired 
        BookingService bookingService
        ```      
        JVM will throw BookingService object in the core Spring container into this field - bookingService.

    - Secondly, with 

        ```java
        @Bean
        BookingService bookingService() {
            return new BookingService();
        }
        ```

        JVM will create the BookingService object as bean, and this bean will be pushed into the Spring container. When JVM see the ```@Autowired```, it will check in the Spring container, if it detect the image of BookingService object, then it will take this object, and put this object into the object that ```@Autowired``` has been there.

        But we will have some question about this case: *How will the function ```bookingService()``` be called?*, and *What is something that call the function ```bookingService()```*. 

        So, two questions will be answered in the next days.

    ```@Bean``` annotation will tell that method produces a bean to be managed by the core Spring container. It is a method-level annotation. **During Java configuration ```(@Configuration)```, the method is executed and its return value is registered as a bean within a BeanFactory.**

    So, with ```@Bean``` annotation, we will have some concludes:
    - ```@Bean``` annotation will be used to indicate a method that is initialized a bean or return an instance of bean). 
    - A name of bean is a name of method in default. But we can set a bean's name throughout ```name``` property of ```@Bean```.
    - All methods that are marked by ```@Bean``` annotation, have to utilize in a class with ```@Componenent``` annotation or ```@Configuration``` annotation, but usually it is ```@Configuration``` annotation.

- ```@Autowired``` annotation

    It says "please give me an instance of this class, for example, one that I created with an @Bean annotation earlier". And ```@Bean``` and ```@Autowired``` is a pair that is as same as ```try, catch``` in managing exception.    

- ```@PropertySource("classpath:name_file_extension)``` annotation



- ```@ComponentScan("source_path")``` and ```@EnableWebMvc``` annotations

    They are required for Spring to find and configure all annotated classes. Spring will search for annotations on classes specified in the value parameter that is passed to ```@ComponentScan``` i.e "com.company.project". Therefore, if you've spedified root package, ajust accordingly.

- ```@Controller``` annotation

    It will notify for Spring that the below class is a controller. Then, this class can receives requests direct to the corresponding method identified by the ```@RequestMapping``` annotation. 

    And ```@Controller``` is simply a specialization of the ```@Component``` class and allows implementation classes to be auto-detected through the classpath scanning.

    In typical Spring MVC application, ```@Controller``` classes are responsible for preparing a model map with data and selecting a view to be rendered. This model map allows for the complete abstraction of the view technology and, in the case of Thymeleaf, it is transformed into a Thymeleaf context object (part of the Thymeleaf template execution context) that makes all the defined variables available to expressions executed in templates.

- ```@RequestMapping(value="/", method=RequestMethod.GET)``` annotation

    When a controller receives the requests with the specific path, it will route to the method that is determined by the ```@RequestMapping``` annotation.

- ```@Configuration``` annotation

    It will identify the class that is accompanied with it, as a configuration class.

    These classes consist principally of ```@Bean-annotated``` methods that define instantiation, configuration, and initialization logic for objects that are managed by the Spring IoC container.

    Annotating a class with the ```@Configuration``` indicates that the class can be used by the Spring IoC container as a source of bean definitions.

- ```@ModelAttribute``` annotation

    This annotation is used to push data into View. You can refer this [link](https://ducmanhphan.github.io/2019-02-06-Some-ways-to-add-data-into-view-int-Spring) to understand deeper.

- ```@GetMapping``` annotation

    It is a composed annotation that acts as shortcut for ```@RequestMapping(value="/", method=RequestMethod.GET)```. Below is the definition of ```@GetMapping```.

    ```java
    @Target(value=METHOD)
    @Retention(value=RUNTIME)
    @Documented
    @RequestMapping(method=GET)
    public @interface GetMapping
    ```

    But ```@RequestMapping``` can be used at class level and method level. And ```@GetMapping``` only used at method level. 

    ```@RequestMapping``` on class makes that URL to be base for all ```@RequestMapping``` on methods. So, it makes your controller easy to understand and readable.

    ```java
    @RestController
    @RequestMapping("books-rest")
    public class SimpleBookRestController {
        
        @GetMapping("/{id}")        // => URL: localhost:8080/books-rest/id 
        public Book getBook(@PathVariable int id) {
            return findBookById(id);
        }
    
        private Book findBookById(int id) {
            // ...
        }
    }
    ```

- ```@SpringBootApplication``` annotation

    When implementing with ```@SpringBootApplication```, it will do the following steps:
    - ```@Configuration``` tags the class as a source of bean definitions for the application context. 
    - ```@EnableAutoConfiguration``` tells Spring Boot to start adding beans based on classpath settings, other beans, and various property settings.
    - Normally, we would add ```@EnableWebMvc``` for a Spring MVC App, but Spring Boot adds it automatically when it sees **spring-webmvc** on the classpath. This flags the application as a web application and activates key behaviours such as setting up a ```DispatcherServlet```.
    - ```@ComponentScan``` tells Spring to look for other components, configurations, and services in the our package, allowing it to find the controllers.

- ```@Data``` and ```@Entity``` annotations

    When using Spring Data JPA, the above annotations are some useful annotations that we need to know:
    - ```@Data``` is Lombok annotation to create all the getters, setters, **equals()**, **hash()**, and **toString()** methods, based on the fields.
    - ```@Entity``` is a JPA annotation to make this object ready for storage in a JPA-based data store.
    - Note: **create custom constructor when we need a new instance, but don't yet have an id.**

- Annotation for HTTP operations

    Corresponding to HTTP GET, POST, PUT, and DELETE calls, they are some operations such as ```@GetMapping```, ```@PostMapping```, ```@PutMapping``` and ```@DeleteMapping```.

    - ```@PostMapping``` annotation
    - ```@PostMapping``` annotation
    - ```@PutMapping```  annotation
    - ```@DeleteMapping``` annotation

- ```@RestController``` annotation

    Is is a convenince annotation for creating Restful controller. It is specialization of ```@Component``` and is autodetected through classpath scanning. It adds the ```@Controller``` and ```@ResponseBody``` annotations. It converts the response to JSON or XML. 

    It does not work with the view technology, so the methods cannnot return **ModelAndView**. It is typically in combination with annotated handler methods based on the ```@RequestMapping``` annotation.

    The ```@Controller``` annotation is used with the view technology.

    Consider this code:

    ```java
    @RestController
    @RequestMapping("books-rest")
    public class SimpleBookRestController {
        
        @GetMapping("/{id}")        // => URL: localhost:8080/books-rest/id 
        public Book getBook(@PathVariable int id) {
            return findBookById(id);
        }
    
        private Book findBookById(int id) {
            // ...
        }
    }
    ```

    The above code will be corresponding to:

    ```java
    @Controller
    @RequestMapping("books")
    public class SimpleBookController {
    
        @GetMapping("/{id}")
        public @ResponseBody Book getBook(@PathVariable int id) {
            return findBookById(id);
        }
    
        private Book findBookById(int id) {
            // ...
        }
    }
    ```
- ```@EnableWebSecurity``` annotation

    It enables the Spring Security in our application.

- ```@EnableJdbcHttpSession``` annotation

    The ```@EnableJdbcHttpSession``` annotation creates a Spring Bean with the name of **springSessionRepositoryFilter**  that implements the filter. The filter is what is in charge of replacing the HttpSession implementation to be backed by Spring Session. In this instance, Spring Session is backed by a relational database. By default, the session timeout is 1800 seconds (30 minutes).

- ```@RequestParam``` annotation

    


- ```@PathVariable``` annotation

<br>

## Wrapping up
- An annotation is a mechanism for associating a meta-tag with program elements and allowing the compiler or the VM to extract program behaviors from these annotated elements and generate interdependent code when necessary.
- It helps us avoid writing boilerplate code under many circumstances by enabling tools to generate it from annotations in the source code.
- Annotations do not directly affect the semantics of a program.
- The important note about ```@Bean``` is always to use ```@Bean``` in a ```@Configuration``` annotated class. 

<br>

Thanks for reading.

<br>

Refer: 

[https://www.baeldung.com/spring-bean-annotations](https://www.baeldung.com/spring-bean-annotations)

[https://www.developer.com/java/other/article.php/3556176/An-Introduction-to-Java-Annotations.htm](https://www.developer.com/java/other/article.php/3556176/An-Introduction-to-Java-Annotations.htm)

[https://en.wikipedia.org/wiki/Java_version_history](https://en.wikipedia.org/wiki/Java_version_history)

[https://www.journaldev.com/721/java-annotations](https://www.journaldev.com/721/java-annotations)

[http://spring.io/blog/2010/07/22/spring-mvc-3-showcase/](http://spring.io/blog/2010/07/22/spring-mvc-3-showcase/)

[http://outbottle.com/spring-4-web-mvc-hello-world-using-annotation-configuration-with-netbeans/](http://outbottle.com/spring-4-web-mvc-hello-world-using-annotation-configuration-with-netbeans/)

[https://stackoverflow.com/questions/34172888/difference-between-bean-and-autowired](https://stackoverflow.com/questions/34172888/difference-between-bean-and-autowired)

[http://zetcode.com/articles/springbootbean/](http://zetcode.com/articles/springbootbean/)

[https://docs.spring.io/spring/docs/current/spring-framework-reference/#beans-java-basic-concepts](https://docs.spring.io/spring/docs/current/spring-framework-reference/#beans-java-basic-concepts)

[https://stackoverflow.com/questions/38088977/spring-component-bean-annotation](https://stackoverflow.com/questions/38088977/spring-component-bean-annotation)

[https://docs.spring.io/spring/docs/3.0.0.M4/reference/html/ch03s11.html](https://docs.spring.io/spring/docs/3.0.0.M4/reference/html/ch03s11.html)

[https://dzone.com/articles/playing-sround-with-spring-bean-configuration](https://dzone.com/articles/playing-sround-with-spring-bean-configuration)

[https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/bind/annotation/GetMapping.html](https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/web/bind/annotation/GetMapping.html)


**Repositories**

[https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#repositories](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#repositories)

[https://spring.io/guides/tutorials/rest/](https://spring.io/guides/tutorials/rest/)

[http://zetcode.com/springboot/restcontroller/](http://zetcode.com/springboot/restcontroller/)


**Custom Annotations**

[https://www.logicbig.com/tutorials/spring-framework/spring-web-mvc/request-mapping-variants.html](https://www.logicbig.com/tutorials/spring-framework/spring-web-mvc/request-mapping-variants.html)

[http://appsdeveloperblog.com/spring-mvc-postmapping-getmapping-putmapping-deletemapping/](http://appsdeveloperblog.com/spring-mvc-postmapping-getmapping-putmapping-deletemapping/)

