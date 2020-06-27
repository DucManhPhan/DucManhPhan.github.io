---
layout: post
title: Creating project with Spring Webflux and MongoDB
bigimg: /img/image-header/california.jpg
tags: [Spring, Reactive Programming, MongoDB]
---

Normally, we will use Spring MVC for our project, but Spring webflux was born in 2017, it makes our web application stronger and more elastic. It takes advantage of asynchronous property, non-blocking IO to reduce the number of threads when receiving multiple requests.

So, in this article, we will move on Spring Webflux and MongoDB to work. Let's get started.

<br>

## Table of contents
- [Why we choose Mongodb for this Spring webflux project](#why-we-choose-Mongodb-for-this-spring-webflux-project)
- [Some necessary-packages-for-this-project](#some-necessary-packages-for-this-project)
- [Configure information of MongoDB](#configure-information-of-mongodb)
- [Create database in MongoDB](#create-database-in-mongodb)
- [Source code for this project](#source-code-for-this-project)
- [Wrapping up](#wrapping-up)

<br>

## Why we choose Mongodb for this Spring webflux project
Actually, we want to choose ```MySQL``` for spring webflux, because ```MySQL``` is popular, and its document is really helpful, and some interesting tutorials about it.

But the reason that we do not select ```MySQL``` is that there is no reactive driver for ```MySQL```.

It has reactive driver for ```PostgreSQL```, ```Mongodb```. So, we will choose ```Mongodb``` to do with Spring webflux.

<br>

## Some necessary packages for this project

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-webflux</artifactId>
</dependency>

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
</dependency>

<dependency>
    <groupId>io.projectreactor</groupId>
    <artifactId>reactor-test</artifactId>
    <scope>test</scope>
</dependency>

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-mongodb-reactive</artifactId>
</dependency>

<dependency>
    <groupId>de.flapdoodle.embed</groupId>
    <artifactId>de.flapdoodle.embed.mongo</artifactId>
    <scope>test</scope>
</dependency>
```

Belows is the means of some above packages:
- ```spring-boot-starter-webflux``` is spring webflux, the reactive version of Spring MVC.
- ```spring-boot-starter-test``` and ```reactor-test``` is some packages for testing.
- ```spring-boot-starter-data-mongodb-reactive``` is the reactive MongoDB dependency that we need to communicate with MongoDB asynchronously.
- ```de.flapdoole.embed.mongo``` is an embedded, in-memory MongoDB database.

<br>

## Configure information of MongoDB
Below is the configuration of ```application.properties``` file. Spring Boot will automatically use this file to configure our application.

```java
# spring.data.mongodb.uri = mongodb://<user>:<passwd>@<url>:<port>/<dbname>
spring.data.mongodb.uri=mongodb://localhost:27017/webflux-mongodb
```

If we use Mongo 2.x, we can specify a host/port in ```application.properties```.

```java
spring.data.mongodb.host = mongoserver
spring.data.mongodb.port = 27017
```

If we use Mongo 3.0 Java driver, ```spring.data.mongodb.host``` and ```spring.data.mongodb.port``` are not supported. In such cases, ```spring.data.mongodb.uri``` should be used to provide all of the configuration.

To know more information about MongoDB, we can refer this [link](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-nosql.html#boot-features-connecting-to-mongodb).

All available options for ```spring.data.mongodb``` prefix are fields of ```MongoProperties```:

```java
private String host;

private int port = DBPort.PORT;

private String uri = "mongodb://localhost/test";

private String database;

private String gridFsDatabase;

private String username;

private char[] password;
```

<br>

## Create database in MongoDB
In order to start MongoDB in command line, we need to install MongoDB application, and access to the path in Windows: ```C:\Program Files\MongoDB\Server\4.0\bin```. At this path, type ```Alt + D``` and ```cmd```.

Next, typing ```mongod``` to start this application.

To know more about operations with MongoDB in command line, we can refer to this [link](https://ducmanhphan.github.io/2018-11-29-Some-common-implementation-with-MongoDB/#use-the-database-/-create-new-database).


```js
show dbs;
use webflux-mongodb;

// display all tables
show collections;

// create collection employees.
db.createCollection('employees');

// insert data into our collection
db.employees.insert({"id": "5d753f4c0b729b259d72061b", "name": "Obama", "address": "California", "phone": "012541425541", "salary": 500000});
db.employees.insert({"id": "512ad753f4c0b729b259d720", "name": "Clinton", "address": "New York", "phone": "012541421541", "salary": 250000});
```

<br>

## Source code for this project

We can refer [webflux-webservice](https://github.com/DucManhPhan/J2EE/tree/master/src/Java_Spring/Spring-Boot/webservice-webflux).

<br>

## Wrapping up
- We know about how to use Spring webflux with maven project.
- To know more about some DBMSs that support asynchronous programming.

<br>

Thanks for your reading.

<br>

Refer:

[https://www.callicoder.com/reactive-rest-apis-spring-webflux-reactive-mongo/](https://www.callicoder.com/reactive-rest-apis-spring-webflux-reactive-mongo/)

[https://stackoverflow.com/questions/22725143/what-is-the-difference-between-responseentityt-and-responsebody](https://stackoverflow.com/questions/22725143/what-is-the-difference-between-responseentityt-and-responsebody)

[https://stackoverflow.com/questions/26549379/when-use-responseentityt-and-restcontroller-for-spring-restful-applications](https://stackoverflow.com/questions/26549379/when-use-responseentityt-and-restcontroller-for-spring-restful-applications)