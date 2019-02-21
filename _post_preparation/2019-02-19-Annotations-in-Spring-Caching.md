---
layout: post
title: Annotations in Spring Caching
bigimg: /img/path.jpg
tags: [java]
---





<br>

## Table of contents
- [Annotations in Spring Caching](#annotations-in-spring-caching)
- [Wrapping up](#wrapping-up)

<br>

## Annotations in Spring Caching
- ```@EnableCaching``` annotation

    ```java
    @EnableCaching
    @Configuration
    public class AppConfig {
        
        @Bean
        public CacheManager cacheManager() {
            //A EhCache based Cache manager
            return new EhCacheCacheManager(ehCacheCacheManager().getObject());
        }
    
        @Bean
        public EhCacheManagerFactoryBean ehCacheCacheManager() {
            EhCacheManagerFactoryBean factory = new EhCacheManagerFactoryBean();
            factory.setConfigLocation(new ClassPathResource("ehcache.xml"));
            factory.setShared(true);
            return factory;
        }
    }
    ```

    The ```@EnableCaching``` annotation, usually applied on a ```@Configuration``` class, triggers a post processor that inspects every ```Spring bean``` for the presence of caching annotations on public methods. If such an annotation is found, a ```proxy``` is automatically created to intercept the method call and handle the caching behavior accordingly.

    The annotations that are managed by this post processor are ```@Cacheable```, ```@CachePut``` and ```@CacheEvict```.

    Spring Boot automatically configures a suitable ```org.springframework.cache.CacheManager``` to serve as a provider for the relevant cache. ```org.springframework.cache.CacheManager``` is the common Cache abstraction provided by Spring to handle all caching related activities. ```CacheManager``` controls and manages ```org.springframework.cache.Cache```s and can be used to retrieve these for storage. Since it’s an abstraction, we need a concrete implementation for cache store. Several options are available in market: JDK ```java.util.concurrent.ConcurrentMap``` based caches, ```EhCache```, ```Gemfire cache```, ```Caffeine```, ```Guava caches``` and ```JSR-107 caches```.
    
    This annotation supplies 3 parrameters:
    - ```mode```: indicates how caching advice should be applied.
    - ```order```: specifies the ordering of the execution of the caching advisor when multiple advices are applied at a specific joinpoint. 
    - ```proxyTargetClass```: indicates whether subclass-based (CGLIB) proxies are to be created as opposed to standard Java interface-based proxies.

- ```@Cacheable``` annotation


<br>

## Wrapping up





<br>

Thanks for your reading.

<br>

Refer:

[https://javabeat.net/enablecaching-spring/](https://javabeat.net/enablecaching-spring/)

