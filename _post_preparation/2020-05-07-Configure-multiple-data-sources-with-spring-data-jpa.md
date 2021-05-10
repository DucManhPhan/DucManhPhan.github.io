---
layout: post
title: Configure multiple DataSources with Spring Data JPA
bigimg: /img/image-header/yourself.jpeg
tags: [Spring]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- [Solution of Spring Data JPA](#solution-of-spring-data-jpa)
- [Configure DataSource](#configure-datasource)
- [Some problems that we encounter](#some-problems-that-we-encounter)
- [Wrapping up](#wrapping-up)


<br>

## Given problem

In a large project, sometimes, we need to interact with multiple databases such as MySQL, PostgreSQL, Oracle, ... The intention of each database depends entirely on the business of each system, the technical aspect, and finally, the cost.

To manage all interactions between them, we can use Spring Data Jpa framework. It makes our life easier.

<br>

## Solution of Spring Data JPA

To utilize Spring Data Jpa, we will have two ways to configure dependencies.
1. Use spring-boot-starter-data-jpa dependencies.

    ```xml
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    ```

2. Configure multiple seperated components required by Spring Data JPA

    |        Component        |                   Description                   |
    | Data Source             | Some connection pools that we can use such as Common DBCP2, BoneCP, Hiraki, Tomcat, ... |
    | JPA Provider            | A JPA provider is a library that implements the JPA. In Spring Data JPA, Hibernate is considered as JPA Provider. |
    | Spring framework        | ... |
    | Database                | We can use multiple database such as MariaDB, MySQL, PostgreSQL, Oracle, ... And we need to use the corresponding database driver. |

    Then, we need to add these dependencies in pom.xml file.

    ```xml
    <dependency>
        <groupId>org.springframework.data</groupId>
        <artifactId>spring-data-jpa</artifactId>
        <version>1.2.0.RELEASE</version>
    </dependency>

    <!-- Hibernate -->
    <dependency>
        <groupId>org.hibernate</groupId>
        <artifactId>hibernate-core</artifactId>
        <version>4.1.4.Final</version>
    </dependency>

    <dependency>
        <groupId>org.hibernate</groupId>
        <artifactId>hibernate-entitymanager</artifactId>
        <version>4.1.4.Final</version>
    </dependency>

    <!-- H2 Database -->
    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
        <version>1.3.166</version>
    </dependency>

    <!-- BoneCP or the other connection pools-->
    <dependency>
        <groupId>com.jolbox</groupId>
        <artifactId>bonecp</artifactId>
        <version>0.7.1.RELEASE</version>
    </dependency>
    ```

    Note:
    - In Spring Boot 1.x, by default, it uses Tomcat connection pool as default.
    - But Spring Boot 2.x, by default, uses Hiraki connection pool.
    - The auto-configuration will search and configure HirakiCP. If HirakiCP exists, Spring will grab it. Otherwise, if TomcatCP is founded, it uses TomcatCP.

        If neither HirakiCP nor TomcatCP are available, Commons DBCP2 exists, it will be used.

    To understand why we need to configure for using **EntityManagerFactory**, **LocalContainerEntityManagerFactoryBean**, **DataSource**, we can refer a below image.

    ![](../img/Java-Common/jpa/Architecture-JPA-Hibernate-Spring-data-jpa.png)

    Below is the common source code java that list some steps.

    ```java
    @Slf4j
    @Configuration
    @ConditionalOnProperty(value = "app.datasource.primary.enable", havingValue = "true", matchIfMissing = true)
    @EnableTransactionManagement
    @EnableJpaRepositories(entityManagerFactoryRef = "primaryEntityManagerFactory",
                           transactionManagerRef = "primaryTransactionManager",
                           basePackages = {"com.manhpd.repository"})
    public class PrimaryDbConfig {

        @Primary
        @Bean(name = "primaryDataSource")
        public DataSource dataSource() {
            // implementations
        }

        @Primary
        @Bean(name = "primaryEntityManagerFactory")
        public LocalContainerEntityManagerFactoryBean primaryEntityManagerFactory(
                EntityManagerFactoryBuilder builder, @Qualifier("primaryDataSource") DataSource dataSource) {
            // implementations
        }

        @Primary
        @Bean(name = "primaryTransactionManager")
        public PlatformTransactionManager primaryTransactionManager(
                @Qualifier("mainEntityManagerFactory") EntityManagerFactory entityManagerFactory) {
            // implementations
        }

    }
    ```

    Then, we can explain the meaning of multiple annotations that we use.
    - @Slf4j annotation

        It will automatically generate the log field for us.

        For example, the generated code when using @Slf4j annotation for LogExample class.

        ```java
        // Use @Slf4j annotation
        public class LogExample {
            // something to do
        }

        // Generated code
        public class LogExample {
           private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LogExample.class);
        }
        ```

    - @Configuration annotation

        It indicates that this class has @Bean definition methods and may be processed by the Spring container to generate bean definitions and service requests for those beans at runtime.

        To know more about this annotation, we can read [@Configuration documentation of Spring framework](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/context/annotation/Configuration.html).

    - @ConditionalOnProperty annotation

        The definition of this annotation:

        ```java
        @Retention(value=RUNTIME)
        @Target(value={TYPE,METHOD})
        @Documented
        @Conditional(value=org.springframework.boot.autoconfigure.condition.OnPropertyCondition.class)
        public @interface ConditionalOnProperty
        ```

        **@Conditional** that checks if the specified properties have a specific value. By default the properties must be present in the Environment and not equal to false. The **havingValue()** and **matchIfMissing()** attributes allow further customizations.

        The **havingValue()** attribute can be used to specify the value that the property should have. If the property is not contained in the Environment at all, the matchIfMissing() attribute is consulted. By default missing attributes do not match.

    - @EnableTransactionManagement annotation

        To enables Spring's annotation-driven transaction management capability, similar to the support found in Spring's ```<tx:*>``` XML namespace.

    - @EnableJpaRepositories annotation

        ```java
        @Target(value=TYPE)
        @Retention(value=RUNTIME)
        @Documented
        @Inherited
        @Import(value=org.springframework.data.jpa.repository.config.JpaRepositoriesRegistrar.class)
        public @interface EnableJpaRepositories
        ```

        It will be used to enable JPA repositories. It will scan the package of the annotated configuration class for Spring Data repositories by default.

        Belows are some fields that we need to take care.
        - **basePackages**: the base packages to scan for annotated components. It is the package that contains all our repositories to interact with DB.
        - **entityManagerFactoryRef**: it will point to the name of the EntityManagerFactory bean definition.
        - **transactionManagerRef**: the name of the **PlatformTransactionManager** bean definition.

            The default implementations of this strategy interface are **JtaTransactionManager** and **DataSourceTransactionManager**, which can serve as an implementation guide for other transaction strategies.

<br>

## Configure DataSource

1. Using annotations with external file

    Below is the content of application.properties file or the other external file.

    ```java
    // configure parameters in application.properties file
    primary.datasource.default.enable=true
    primary.datasource.default.url=jdbc:mariadb://localhost:3307/employee_db
    primary.datasource.default.username=root
    primary.datasource.default.password=root
    primary.datasource.default.driver-class-name=org.mariadb.jdbc.Driver
    primary.datasource.default.configuration.maximum-pool-size=30
    ```

    There are two ways to build the **dataSource()** method.
    - Using DataSourceProperties to map all properties.

        ```java
        @Bean
        @Primary
        @ConfigurationProperties("app.datasource.default")
        public DataSourceProperties defaultDataSourceProperties() {
            return new DataSourceProperties();
        }

        @Bean(name = "mainDataSource")
        @Primary
        @ConfigurationProperties(prefix = "app.datasource.default.configuration")
        public DataSource dataSource() {
            return defaultDataSourceProperties().initializeDataSourceBuilder()
                                                .type(HikariDataSource.class)
                                                .build();
        }
        ```

        By using **@ConfigurationProperties** annotation, Spring will map each property with **prefix = app.datasource.default** into each field of **DataSourceProperties**.

        Then based on an instance of **DataSourceProperties**, we will use Builder pattern to mock with HikariCP into its DataSource.

    - Using DataSourceBuilder instance.

        Apart from using **DataSourceProperties** instance, we can have another way to build DataSource relied on DataSourceBuilder.

        ```java
        @Bean(name = "mainDataSource")
        @Primary
        @ConfigurationProperties(prefix = "app.datasource.default.configuration")
        public DataSource dataSource() {
            return DataSourceBuilder.create().build();
        }
        ```

        By default, Spring Boot 2.x will choose HirakiCP, so we do not need to setup it in **dataSource()** method here.

2. Using programming with fixed value

    ```java

    ```


<br>

## Configure EntityManagerFactory




<br>

## Some problems that we encounter

1. EntityManagerFactoryBuilder does not autowired

    The root cause of this problem is that we are configuring something wrong. We can look at some below cases.
    - Using redundancy annotation

        ```java
        @EnableAutoConfiguration (exclude = { DataSourceAutoConfiguration.class })
        ```

    - Configure to exclude some auto configurations in appliation.properties file

        ```yaml
        spring.autoconfigure.exclude=org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration,org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration,org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration
        ```


## Wrapping up




<br>

Refer:

[https://o7planning.org/11653/use-multiple-datasources-with-spring-boot-and-jpa](https://o7planning.org/11653/use-multiple-datasources-with-spring-boot-and-jpa)

[https://www.baeldung.com/spring-data-jpa-multiple-databases](https://www.baeldung.com/spring-data-jpa-multiple-databases)

[https://howtodoinjava.com/spring-boot2/datasource-configuration/](https://howtodoinjava.com/spring-boot2/datasource-configuration/)

[https://springframework.guru/how-to-configure-multiple-data-sources-in-a-spring-boot-application/](https://springframework.guru/how-to-configure-multiple-data-sources-in-a-spring-boot-application/)

[https://raymondhlee.wordpress.com/2015/10/31/configuring-multiple-jpa-entity-managers-in-spring-boot/](https://raymondhlee.wordpress.com/2015/10/31/configuring-multiple-jpa-entity-managers-in-spring-boot/)

[https://stackoverflow.com/questions/52333614/two-databases-configured-in-spring-boot-application](https://stackoverflow.com/questions/52333614/two-databases-configured-in-spring-boot-application)

[https://blog.netgloo.com/2014/10/27/using-mysql-in-spring-boot-via-spring-data-jpa-and-hibernate/](https://blog.netgloo.com/2014/10/27/using-mysql-in-spring-boot-via-spring-data-jpa-and-hibernate/)

[https://stackoverflow.com/questions/55664804/hikari-cp-properties-are-not-working-with-multiple-datasource-configuration-in-s](https://stackoverflow.com/questions/55664804/hikari-cp-properties-are-not-working-with-multiple-datasource-configuration-in-s)

[https://github.com/dijalmasilva/spring-boot-multitenancy-datasource-liquibase](https://github.com/dijalmasilva/spring-boot-multitenancy-datasource-liquibase)

[https://springframework.guru/run-spring-boot-on-docker/](https://springframework.guru/run-spring-boot-on-docker/)

[https://medium.com/@joeclever/using-multiple-datasources-with-spring-boot-and-spring-data-6430b00c02e7](https://medium.com/@joeclever/using-multiple-datasources-with-spring-boot-and-spring-data-6430b00c02e7)