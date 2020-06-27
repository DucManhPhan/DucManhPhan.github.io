---
layout: post
title: Read properties file in Spring
bigimg: /img/path.jpg
tags: [Spring]
---

In this article, we will find something out about reading properties in file with Spring framework. Let's get started.

<br>

## Table of contents
- [How to use @ConfigurationProperties annotation](#how-to-use-@configurationproperties-annotation)
- [How to use @PropertySource with @Value](#how-to-use-@propertysource-with-@value)
- [Combine settings into object](#combine-settings-into-object)
- [Use Properties class](#use-properties-class)
- [The order that Spring boot setup for properties](#the-order-that-spring-boot-setup-for-properties)
- [Wrapping up](#wrapping-up)

<br>

## How to use @ConfigurationProperties annotation

We have the content of properties file.

```yaml
logging:
  level:
    org.springframework.web: ERROR
    com.mkyong: DEBUG
email: test@mkyong.com
thread-pool: 10
app:
  menus:
    - title: Home
      name: Home
      path: /
    - title: Login
      name: Login
      path: /login
  compiler:
    timeout: 5
    output-folder: /temp/
  error: /error/
```

```java
@Component
@ConfigurationProperties("app") // prefix app, find app.* values
public class AppProperties {
    private String error;
    private List<Menu> menus = new ArrayList<>();
    private Compiler compiler = new Compiler();

    public static class Menu {
        private String name;
        private String path;
        private String title;

        //getters and setters

        @Override
        public String toString() {
            return "Menu{" +
                    "name='" + name + '\'' +
                    ", path='" + path + '\'' +
                    ", title='" + title + '\'' +
                    '}';
        }
    }

    public static class Compiler {
        private String timeout;
        private String outputFolder;

        //getters and setters

        @Override
        public String toString() {
            return "Compiler{" +
                    "timeout='" + timeout + '\'' +
                    ", outputFolder='" + outputFolder + '\'' +
                    '}';
        }
    }

    //getters and setters
}
```

<br>

## How to use @PropertySource with @Value


```java
@RestController
@PropertySource(value = "classpath:/authentication.properties", ignoreResourceNotFound = true)
public class AuthenticationController {
    @Value("${session.expiration}")
	private String expirationTime;

    // ...
}
```

<br>

## Combine settings into object
1. Use **@ConfigurationProperties** annotation

    By default, **application.properties** file is read from Spring Boot. If we want to specify another properties file, we can use **@PropertySource** annotation.

    ```java
    @Component
    @PropertySource(value = "classpath:config.properties", ignoreResourceNotFound = true)
    @ConfigurationProperties(prefix="app")
    public class AppConfig {

        private String username;

        private String password;
    }
    ```

2. Use **@Value** annotation

    ```java
    @Component
    @PropertySource(value = "classpath:config.properties", ignoreResourceNotFound = true)
    public class AppConfig {

        @Value("${app.username}")
        private String username;

        @Value("$app.password")
        private String password;

    }
    ```


<br>

## Use Properties class

If we do not want to use annotation to read properties file, we can use Properties class to read file directly. But it's not recommeded way to deal with it.

```java
public static void main(String args[]) throws IOException {
    Properties prop = readPropertiesFile("credentials.properties");
    System.out.println("username: "+ prop.getProperty("username"));
    System.out.println("password: "+ prop.getProperty("password"));
}

public static Properties readPropertiesFile(String fileName) throws IOException {
    FileInputStream fis = null;
    Properties prop = null;

    try {
        fis = new FileInputStream(fileName);
        prop = new Properties();
        prop.load(fis);
    } catch(FileNotFoundException fnfe) {
        fnfe.printStackTrace();
    } catch(IOException ioe) {
        ioe.printStackTrace();
    } finally {
        fis.close();
    }

    return prop;
}
```


<br>

## The order that Spring boot setup for properties
When using Spring Boot the properties are loaded in the following order (see [Externalized Configuration](http://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html) in the Spring Boot reference guide).

1. Command line arguments.

2. Java System properties (System.getProperties()).

3. OS environment variables.

4. JNDI attributes from java:comp/env

5. A RandomValuePropertySource that only has properties in random.*.

6. Application properties outside of your packaged jar (**application. properties** including YAML and profile variants).

7. Application properties packaged inside your jar (**application.properties** including YAML and profile variants).

8. **@PropertySource** annotations on your **@Configuration** classes.

9. Default properties (specified using SpringApplication.setDefaultProperties).

When resolving properties (i.e. **@Value("${myprop}")** resolving is done in the reverse order (so starting with 9).

To add different files you can use the **spring.config.location** properties which takes a comma separated list of property files or file location (directories).

```java
-Dspring.config.location=your/config/dir/
```

The one above will add a directory which will be consulted for application.properties files.

```java
-Dspring.config.location=classpath:job1.properties,classpath:job2.properties
```

This will add the 2 properties file to the files that are loaded.

For example:

```
java -jar target/myapp.jar --spring.config.location=classpath:file:///C:/Apps/springtest/jdbc.properties,classpath:file:///C:/Apps/springtest/jdbc-dev.properties
```

The default configuration files and locations are loaded before the additonally specified **spring.config.location** ones meaning that the latter will always override properties set in the earlier ones. (See also [this section](http://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html#boot-features-external-config-application-property-files) of the Spring Boot Reference Guide).

```
If spring.config.location contains directories (as opposed to files) they should end in / (and will be appended with the names generated from spring.config.name before being loaded). The default search path classpath:,classpath:/config,file:,file:config/ is always used, irrespective of the value of spring.config.location. In that way you can set up default values for your application in application.properties (or whatever other basename you choose with spring.config.name) and override it at runtime with a different file, keeping the defaults.
```

The other way to add multiple properties files, we can use PropertyPlaceHolderConfigurer class

```java
@Configuration
public class PropertiesConfiguration {
    @Bean
    public PropertyPlaceholderConfigurer properties() {
        final PropertyPlaceholderConfigurer ppc = new PropertyPlaceholderConfigurer();
        // ppc.setIgnoreUnresolvablePlaceholders(true);
        ppc.setIgnoreResourceNotFound(true);

        final List<Resource> resourceLst = new ArrayList<Resource>();

        resourceLst.add(new ClassPathResource("myapp_base.properties"));
        resourceLst.add(new FileSystemResource("/etc/myapp/overriding.propertie"));
        resourceLst.add(new ClassPathResource("myapp_test.properties"));
        resourceLst.add(new ClassPathResource("myapp_developer_overrides.properties")); // for Developer debugging.

        ppc.setLocations(resourceLst.toArray(new Resource[]{}));

        return ppc;
    }
}
```

<br>

## Wrapping up
- Understanding about how to use **@ConfigurationProperties**, **@PropertySource**, and **@Value**.

- **@ConfigurationProperties** supports both **.properties** and **.yml** file.

<br>

Refer:

[https://memorynotfound.com/load-properties-spring-property-placeholder/](https://memorynotfound.com/load-properties-spring-property-placeholder/)

[https://memorynotfound.com/loading-property-system-property-spring-value/](https://memorynotfound.com/loading-property-system-property-spring-value/)

[https://memorynotfound.com/loading-list-from-properties-file-with-spring-value/](https://memorynotfound.com/loading-list-from-properties-file-with-spring-value/)

[https://mkyong.com/spring-boot/spring-boot-configurationproperties-example/](https://mkyong.com/spring-boot/spring-boot-configurationproperties-example/)

[https://www.baeldung.com/configuration-properties-in-spring-boot](https://www.baeldung.com/configuration-properties-in-spring-boot)

[https://www.baeldung.com/properties-with-spring](https://www.baeldung.com/properties-with-spring)

[https://memorynotfound.com/spring-boot-configurationproperties-annotation-example/](https://memorynotfound.com/spring-boot-configurationproperties-annotation-example/)

[https://docs.spring.io/spring-boot/docs/current-SNAPSHOT/reference/htmlsingle/#boot-features-external-config-typesafe-configuration-properties](https://docs.spring.io/spring-boot/docs/current-SNAPSHOT/reference/htmlsingle/#boot-features-external-config-typesafe-configuration-properties)

[https://memorynotfound.com/import-multiple-spring-xml-configuration-files/](https://memorynotfound.com/import-multiple-spring-xml-configuration-files/)

[https://mkyong.com/spring-boot/spring-boot-configurationproperties-example/](https://mkyong.com/spring-boot/spring-boot-configurationproperties-example/)

[https://javapapers.com/spring/spring-properties-with-propertysource-annotation/](https://javapapers.com/spring/spring-properties-with-propertysource-annotation/)