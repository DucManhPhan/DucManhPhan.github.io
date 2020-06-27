---
layout: post
title: How to get different beans from configuration xml file in the same class - Spring MVC
bigimg: /img/image-header/home-office-1.jpg
tags: [Spring]
---

This article is stem from the question on [stackoverflow](https://stackoverflow.com/questions/4462466/autowiring-two-different-beans-of-same-class). When I read about this question, immediately, I think that it is very useful for me in reality.

<br>

## Problem
Assuming that you have two configuration in xml file about connections.

```xml
<bean id="jedisConnector" class="com.legolas.jedis.JedisConnector" init-method="init" destroy-method="destroy">
    <property name="host" value="${jedis.host}" />
    <property name="port" value="${jedis.port}" />
</bean>

<bean id="jedisConnectorPOD" class="com.legolas.jedis.JedisConnector" init-method="init" destroy-method="destroy">
    <property name="host" value="${jedis.pod.host}" />
    <property name="port" value="${jedis.pod.port}" />
</bean>
```

Now, we want to create two object that achieve all informations about two connections with id are **jedisConnector** and **jedisConnectorPOD** by using annotations.

Normally, we will think about ```@Autowired``` annotation with the below example:

```java
@Autowired //bean of id jedisConnector
JedisConnector beanA;

@Autowired //bean of id jedisConnectorPOD
JedisConnector beanB;
```

But, it does not work like our thought. So how do you use annotations to make it works?

<br>

## Solution
To solve this problem, we two three solutions. 
- Use ```@Resource```
    
    ```java
    @Resource(name="jedisConnector")    
    JedisConnector beanA;

    @Resource(name="jedisConnectorPOD")
    JedisConnector beanB;
    ```

    or 

    ```java
    @Resource
    JedisConnector jedisConnector;

    @Resource
    JedisConnector jedisConnectorPOD;
    ```

- Use ```@Autowired``` with ```@Qualifier``` annotation

    ```java    
    @Autowired
    @Qualifier("jedisConnector")
    JedisConnector beanA;

    @Autowired
    @Qualifier("jedisConnectorPOD")
    JedisConnector beanB;
    ```

Thanks for your reading.