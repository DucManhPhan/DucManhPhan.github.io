---
layout: post
title: Understanding about ManyToMany relationship with JPA
bigimg: /img/image-header/yourself.jpeg
tags: [JPA]
---



<br>

## Table of contents





<br>

## Given problem






<br>

## Solution for this problem


There are some ways to deal with it:
1. Using @OneToMany and @ManyToOne annotations to build the bidirectional relationship

2. Using @ManyToMany and @JoinTable annotations


<br>

## Using @OneToMany and @ManyToOne annotations

https://www.baeldung.com/jpa-many-to-many





<br>

## Using @ManyToMany and @JoinTable annotations

https://attacomsian.com/blog/spring-data-jpa-many-to-many-mapping


https://www.callicoder.com/hibernate-spring-boot-jpa-many-to-many-mapping-example/


<br>

## The meaning of parameters in annotations

1. @ManyToMany annotation




2. @JoinTable annotation



<br>

## Wrapping up




<br>

Refer:

[https://www.baeldung.com/jpa-many-to-many](https://www.baeldung.com/jpa-many-to-many)

[https://www.objectdb.com/api/java/jpa/MapsId](https://www.objectdb.com/api/java/jpa/MapsId)

[https://attacomsian.com/blog/spring-data-jpa-many-to-many-mapping](https://attacomsian.com/blog/spring-data-jpa-many-to-many-mapping)

[https://www.callicoder.com/hibernate-spring-boot-jpa-many-to-many-mapping-example/](https://www.callicoder.com/hibernate-spring-boot-jpa-many-to-many-mapping-example/)