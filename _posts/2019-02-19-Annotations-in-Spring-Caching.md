---
layout: post
title: Annotations in Spring Caching
bigimg: /img/image-header/california.jpg
tags: [Spring]
---

In the previous article, we has understood about [How Spring Caching works](https://ducmanhphan.github.io/2019-02-19-How-Spring-Caching-mechanism-works). So in this article, we will discuss about annotations in Spring caching, and how to use it in our source code.

<br>

## Table of contents
- [Introduction to Cache](#introduction-to-cache)
- [Annotations in Spring Caching](#annotations-in-spring-caching)
- [JCache (JSR - 107)](#jcache-jsr-107)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to Cache
In computing, a cache is a component that transparently stores data so that future requests for that data can be served faster. The data that is stored within a cache might be values that have been computed earlier or duplicates of original values that are stored elsewhere. 

If requested data is contained in the cache (cache hit), this request can be served by simply reading the cache, which is comparatively faster. 

Otherwise (cache miss), the data has to be recomputed or fetched from its original storage location, which is comparatively slower. 

Hence, the greater the number of requests that can be served from the cache, the faster the overall system performance becomes.

<br>

## Annotations in Spring Caching
- ```@EnableCaching``` annotation

    ```java
    @Configuration
    @EnableCaching
    public class AppConfig {
        
        // EhCache Manager        
        @Bean
        public CacheManager cacheManager() {
            //A EhCache based Cache manager
            return new EhCacheCacheManager(ehCacheCacheManager().getObject());
        }

        //JDK Cache Manager
        @Primary
        @Bean
        public CacheManager jdkCacheManager() {
            return new ConcurrentMapCacheManager("users");
        }

        // JSR 107 - JCache Manager
        @Bean
        public CacheManager jCacheManager() {
            return new JCacheCacheManager();
        }

        //Guava Cache Manager
    	@Bean
    	public CacheManager guavaCacheManager() {
    		return new GuavaCacheManager();
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

    This annotation will define a cache for a method's return value.

    When our application is received  multiple requests, then this annotation will not execute the method multiple times, instead it will send the result from the cached storage.

    ```java
    @Cacheable(value = "user-cache", key="#userSearchVO.name", condition="#supportUser == false")
    public User findUser(UserSearchVO userSearchVO, boolean supportUser)
    {
        User foundUser = null;
        ...
        ...
        ...
        return foundUser;
    }
    ```

    In the above example, we have;
    - ```value = "user-cache"``` indicates the name of the cache in which entries are stored.
    - ```key="#searchVO.name"``` defines the key to lookup into the cache. Here it is the name property of the UserSearchVO object
condition=”#supportUser == false” provides the condition to trigger the cache. The cache lookup and the method result caching are triggered only when the supportUser flag is set to false

    ```@Cacheable``` annotation includes some properties that is listed in the below table.

    |          Attributes         |                     Description                    |
    | --------------------------- | -------------------------------------------------- |
    | cacheManager                | The bean name of the cache manager                  |
    | cacheNames                  | The list of cache store names where the method cache has to be stored. This should be any array of strings.|
    | cacheResolver               | The name of the custom cache resolver. |
    | condition                   | This is [Spring Expression Language (SPeL)](https://javabeat.net/introduction-to-spring-expression-language-spel/) for the conditional caching for the method. |
    | key                         | Spring Expression Language for computing the key dynamically. |
    | keyGenerator                | The bean name of the custom key generator to use. |
    | unless                      | SPeL for bypassing caching for specific scenarios. |
    | value                       | It is a cache name to store the caches, and it is mandatory |

    For example:

    ```java
    // Use key: id of location
    @Cacheable(value = "concerts", key = "#location.id", cacheManager = "gemfireCacheManager")
    public List<Concert> findConcerts(Location location) {
        ...
    }

    // key: hashCode of location
    @Cacheable(value = "concerts", key = "T(someType).hash(#location)", cacheResolver = "myOwnCacheResolver")
    public List<Concert> findConcerts(Location location) {
        ...
    }

    // conditional caching if location is in Dallas in operating.
    @Cacheable(value = "concerts", condition = "#location.city == 'Dallas'", unless = "#location.outOfBusiness")
    public List<Concert> findConcerts(Location location) {
        ...
    }

    // key: generated id of result
    @Cacheable(value = "concerts", key = "#result.id") 
    public Location saveLocation(Location location) {
        ...
    }
    ```

    Belows is how to custom some properties in ```@Cacheable``` annotation as same as other annotations.
    - Create custom ```CacheResolver```.

        In the above, we have used ```myOwnCacheResolver```. Then we will create this custom class with the following code.

        ```java
        public class MyOwnCacheResolver extends AbstractCacheResolver {
            @Autowired
            public MyOwnCacheResolver(CacheManager cacheManager) {
                super(cacheManager);
            }

            protected Collection<String> getCacheNames(CacheOperationInvocationContext<?> context) {
                return getCacheNames(context.getTarget().getClass());
            }

            private getCacheNames(Class<?> businessServiceClass) {
                ...
            }
        }
        ```
    
    - Create custom ```KeyGenerator```

        ```java
        public class MyOwnKeyGenerator implements KeyGenerator {

            @Override
            public Object generate(Object target, Method method, Object... params) {
                if (params.length == 0) {
                    return new SimpleKey("EMPTY");
                }

                if (params.length == 1) {
                    Object param = params[0];
                    if (param != null && !param.getClass().isArray()) {
                        return param;
                    }
                }

                return new SimpleKey(params);
            }
        }
        ```

- ```@CachePut``` annotation

    This annotation is used to update the cache with the latest execution without stopping the method execution.

    The only difference between ```@Cacheable``` and ```@CachePut``` is that:
    - With ```@Cacheable```, the method will be executed only once and the result will be updated in cache. Subsequent calls to our method will not execute our method, it will just get the result from the cache.
    - With ```@CachePut```, the method is executed every time and the result will be updated to the cache storage.

    It is not recommended to use both the annotation for the same method which will result in an unexpected results. It is highly recommended to use either ```@Cacheable``` or ```@CachePut``` for a method.

    The list of attributes defined in this annotation is similar to the ```@Cacheable```.

- ```@CacheEvict``` annotation

    This annotation is used for removing a single cache or clearing the entire cache from the cache storage.

    This annotation supports suitable parameters to execute the condition to clear the matching set of cached from the store. If you set the ```allEntries=true``` , then the entire cache will be cleared.

    The below is a table includes some properties for this annotation:
    
    |          Attributes         |                     Description                    |
    | --------------------------- | -------------------------------------------------- |
    | allEntries                  | It indicated whether all the data in the cache has to be removed. |
    | beforeInvocation            | This attribute indicates whether the eviction has to be done before the method invocation. |
    | cacheManager                | The bean name ò the cache manager                  |
    | cacheNames                  | The list of cache store names where the method cache has to be stored. This should be any array of strings.|
    | cacheResolver               | The name of the custom cache resolver. |
    | condition                   | This is [Spring Expression Language (SPeL)](https://javabeat.net/introduction-to-spring-expression-language-spel/) for the conditional caching for the method. |
    | key                         | Spring Expression Language for computing the key dynamically. |
    | keyGenerator                | The bean name of the custom key generator to use. |
    | unless                      | SPeL for bypassing caching for specific scenarios. |
    | value                       | It is a cache name to store the caches |

- ```@Caching``` annotation

    It is used for grouping multiple annotations of the same type together when one annotaion is not sufficient for the specifying the suitable condition.

    The properties in this annotations are:

    |          Attributes         |                     Description                    |
    | --------------------------- | -------------------------------------------------- |
    | cacheable                   | This is array of ```@Cacheable``` annotation       |
    | evict                       | This is array of ```@CacheEvict``` annotation      |
    | put                         | This is array of ```@CachePut``` annotation        |

- ```@CacheConfig``` annotation

    If you have multiple operations in a class where each operation has to be given cache configuration details, this could be tedious job if the number of operations are higher.
    
    We can annotate ```@CacheConfig``` at the class level to avoid repeated mentioning in each method. 
    
    For example, in the class level you can provide the cache name and in the method you just annotate with ```@Cacheable``` annotation.

    Some properties that are supported in ```@CacheConfig``` annotation.

    |          Attributes         |                     Description                    |
    | --------------------------- | -------------------------------------------------- |
    | cacheManager                | The bean name ò the cache manager                  |
    | cacheNames                  | The list of cache store names where the method cache has to be stored. This should be any array of strings.|
    | cacheResolver               | The name of the custom cache resolver. |    
    | keyGenerator                | The bean name of the custom key generator to use. |

<br>

## JCache(JSR - 107)
Since Spring framework 4.1, Spring's caching abstraction completely supports the JCache specification and we can use JCache annotations without any special configurations. 

All annotations in Jcache is used in packge ```org.springframework.cache.jcache```. We can use Java based configuration by adding some code in our configuration class. 

```java
@Bean
public CacheManager jCacheManager() {
    return new JCacheCahceManager();
}
```

Below is the table to discribe about some properties in JCache.

|          Spring          |          JCache         |               Description              |
| ------------------------ | ----------------------- | -------------------------------------- |
| ```@Cacheable```         | ```@CacheResult```      | Similar, but ```@CacheResult``` can cache Exceptions and force method execution. |
| ```@CacheEvict```        | ```@CacheRemove```      | Simillar, but ```@CacheRemove``` supports in the case of Exceptions. |
| ```@CacheEvict(allEntries=true)``` | ```@CacheRemoveAll``` | JCache adds another annotation for removign all the cache entries. |
| ```@CachePut```          | ```@CachePut```         | Different semantic: cache content must be annotated with ```@CacheValue```. JCache brings Exception caching and caching before or after method execution. |
| ```@CacheConfig```       | ```@CachePut```         |                 |

<br>

## Wrapping up
- We need to find some ways to notify for ```CacheManager``` updating when we put new data into database.
- We do not use Caching overtimes because memory is limited. 


<br>

Thanks for your reading.

<br>

Refer:

[https://dzone.com/articles/spring-31-caching-and-0](https://dzone.com/articles/spring-31-caching-and-0)

[https://doanduyhai.wordpress.com/2012/07/01/cache-abstraction-in-spring-3/](https://doanduyhai.wordpress.com/2012/07/01/cache-abstraction-in-spring-3/)

[https://javabeat.net/enablecaching-spring/](https://javabeat.net/enablecaching-spring/)

[https://javabeat.net/spring-cache/](https://javabeat.net/spring-cache/)

[https://en.wikipedia.org/wiki/Cache_(computing)](https://en.wikipedia.org/wiki/Cache_(computing))

[https://codeboje.de/caching-spring-boot/](https://codeboje.de/caching-spring-boot/)