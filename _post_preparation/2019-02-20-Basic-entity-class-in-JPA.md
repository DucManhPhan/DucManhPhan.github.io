---
layout: post
title: Basic entity class in JPA
bigimg: /img/path.jpg
tags: [front-end]
---

When we work with Java web development, we have to implement with database. Normally, we will use JDBC or JDBC template for doing this problem. But to make it easier, we will use the new technology called ORM - Object Relational Mapping. The standard version of ORM is JPA. JPA will help us to map POJO to each record in table of database. We will do not take care all queries to access database. This action will be sent to the JPA.

So, in this article, we will talk about how to configure an entity class with JPA in Spring Boot, specially these are annotations in JPA. 

<br>

## Table of contents
- [Introduction to JPA](#introduction-to-jpa)
- [JPA Providers](#jpa-providers)
- [JPA Entity class](#jpa-entity-class)
- []()
- [Wrapping up](#wrapping-up)


<br>

## Introduction to JPA
JPA - Java Persistence API is the Java standard for mapping Java objects to a relational database. Mapping Java objects to database tables and vice versa is called Object-relational mapping (ORM). **The Java Persistence API (JPA) is one possible approach to ORM**. Via JPA, the developer can map, store, update and retrieve data from relational databases to Java objects and vice versa. JPA can be used in Java-EE and Java-SE applications.

**JPA defines only specifications, it does not provide an implementation.**

JPA implementation is provided as a reference implementation by the vendors developing O/R Mapper such as Hibernate, EclipseLink and Apache OpenJPA.

JPA permits the developer to work directly with objects rather than with SQL statements. The JPA implementation is typically called ```persistence provider```.

<br>

## JPA Providers
JPA is an open source API, therefore various enterprise vendors such as Oracle, Redhat, Eclipse, etc. provide new products by adding the JPA persistence flavor in them. 

Some of these products include: 
- Hibernate
- EclipseLink
- TopLink 
- Spring Data JPA
- ...

<br>

## JPA Entity class
A JPA Entity class is a POJO (Plain Old Java Object) class that is annotated as having the ability to represent objects in the database. 

To be able to store ```Person``` objects in the database using JPA, we need to define an entity classs. 

The below is source code for JPA entity class.

```java
@Entity
public class Person {    
    
    // Persistent fields
    private String name;        
    private String email;        
    private String phone;        
    private String address;      
    
    // Constructor       
    public Person(String name, String email, String phone, String address) {        
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }
    
    // Persistent properties        
    public String getName() {
        return name;
    } 
    
    public void setName(String name) {
    this.name = name;
    } 
    public String getEmail() {
        return email;
    } 
    
    public void setEmail(String email) {
        this.email = email;
    } 
    
    public String getPhone() {
        return phone;
    } 
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getAddress() {
        return this.address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
}
```

With the above code, an entity is an ordinary Java class. But this Person class has ```@Entity``` annotation, which marks the class as an entity class.

Some rules of requirements to create a JPA entity class:
- The class must be annotated with the javax.persistence.Entity annotation.

- The class must have a public or protected, no-argument constructor. The class may have other constructors.

- The class must not be declared final. No methods or persistent instance variables must be declared final.

- If an entity instance is passed by value as a detached object, such as through a session bean's remote business interface, the class must implement the Serializable interface.

- Entities may extend both entity and non-entity classes, and non-entity classes may extend entity classes.

- Persistent instance variables must be declared private, protected, or package-private and can be accessed directly only by the entity class's methods. Clients must access the entity's state through accessor or business methods.

<br>

## Data types of Persistent Fields and Persistent Properties




<br>

## Persistent Fields



<br>

## Persistent Properties



<br>

## Primary Key in Entity class



<br>

## Relationship Mappings






<br>

## Cascade Opeartions and Relationships




<br>

## Orphan Removal in relationships




<br>

## Embeddable Classes in Entity



<br>

## Wrapping up




<br>


Refer:

[https://www.oracle.com/technetwork/middleware/ias/toplink-jpa-annotations-096251.html](https://www.oracle.com/technetwork/middleware/ias/toplink-jpa-annotations-096251.html)

[http://www.javaguides.net/2019/01/introduction-to-java-persistence-api.html](http://www.javaguides.net/2019/01/introduction-to-java-persistence-api.html)

[http://www.javaguides.net/2018/11/guide-to-jpa-and-hibernate-cascade-types.html](http://www.javaguides.net/2018/11/guide-to-jpa-and-hibernate-cascade-types.html)