---
layout: post
title: How to configure Hibernate correctly in our project
bigimg: /img/image-header/yourself.jpeg
tags: [Hibernate]
---

In this article, we will learn how to configure Hibernate in our normal project or Spring boot project in production environement.

Let's get started.

<br>

## Table of contents
- [Configure common properties of Hibernate](#configure-common-properties-of-hibernate)
- [Given problems of project in production environment](#given-problems-of-project-in-production-environment)
- [Some dialects of Hibernate for other databases](#some-dialects-of-Hibernate-for-other-databases)
- [Some driver of other databases](#some-driver-of-other-databases)
- [Wrapping up](#wrapping-up)


<br>

## Configure common properties of Hibernate
1. Spring boot project with Spring Data JPA

    - Configuration in properties file

        Internally, Spring Data JPA uses Hibernate as default implementation.

        ```yaml
        spring.datasource.driver-class-name=com.mysql.jdbc.Driver
        spring.datasource.url=jdbc:mysql://<ip-address>:<port>/<database-name>?useUnicode=true&characterEncoding=utf8
        spring.datasource.username=<username>
        spring.datasource.password=<password>

        #Use validation-query and test-on-borrow properties only for Tomcat connection pool
        spring.datasource.validationQuery=SELECT 1
        spring.datasource.testOnBorrow=true
        ```

    - Configuration by using code

        Firstly, we have **database.properties** file that contains configuration information:

        ```java
        driver=com.mysql.cj.jdbc.Driver
        url=jdbc:mysql://<ip-address>:<port>/<db-name>?useUnicode=true&characterEncoding=utf8
        usermysql=<username>
        password=<password>

        hibernate.dialect=org.hibernate.dialect.MySQL5InnoDBDialect
        hibernate.show_sql=false
        hibernate.ddl-auto=update

        hibernate.validationQuery=SELECT 1
        hibernate.testOnBorrow=true
        ```

        Finally, we will create DatabaseConfig class to handle all information of EntityManager that uses Hibernate:

        ```java
        @Configuration
        @EnableTransactionManagement
        @EnableJpaRepositories("com.manhpd.persistence.repository")
        @PropertySource("classpath:database.properties")
        public class DatabaseConfig {

            private final String PROPERTY_DRIVER = "driver";
            private final String PROPERTY_URL = "url";
            private final String PROPERTY_USERNAME = "usermysql";
            private final String PROPERTY_PASSWORD = "password";
            private final String PROPERTY_DIALECT = "hibernate.dialect";
            private final String PROPERTY_SHOW_SQL = "hibernate.show_sql";
            private final String PROPERTY_DDL_AUTO = "hibernate.ddl-auto";
            private final String PROPERTY_VALIDATION_QUERY = "hibernate.validationQuery";
            private final String PROPERTY_TEST_ON_BORROW = "hibernate.testOnBorrow";

            @Autowired
            private Environment env;

            @Bean
            LocalContainerEntityManagerFactoryBean entityManagerFactoryBean() {
                LocalContainerEntityManagerFactoryBean lfb = new LocalContainerEntityManagerFactoryBean();
                lfb.setDataSource(dataSource());
                lfb.setPersistenceProviderClass(HibernatePersistenceProvider.class);
                lfb.setPackagesToScan("com.manhpd.persistence.entity");
                lfb.setJpaProperties(hibernateProps());

                return lfb;
            }

            @Bean
            DataSource dataSource() {
                // use Connection Pool of Tomcat
                PoolProperties poolProperties = new PoolProperties();
                poolProperties.setUrl(this.env.getProperty(PROPERTY_URL));
                poolProperties.setUsername(this.env.getProperty(PROPERTY_USERNAME));
                poolProperties.setPassword(this.env.getProperty(PROPERTY_PASSWORD));
                poolProperties.setDriverClassName(this.env.getProperty(PROPERTY_DRIVER));
                poolProperties.setTestOnBorrow(Boolean.parseBoolean(this.env.getProperty(PROPERTY_TEST_ON_BORROW)));
                poolProperties.setValidationQuery(this.env.getProperty(PROPERTY_VALIDATION_QUERY));
                poolProperties.setValidationInterval(0);
                DataSource ds = new DataSource(poolProperties);
                return ds;
            }

            Properties hibernateProps() {
                Properties properties = new Properties();
                properties.setProperty(PROPERTY_DIALECT, this.env.getProperty(PROPERTY_DIALECT));
                properties.setProperty(PROPERTY_SHOW_SQL, this.env.getProperty(PROPERTY_SHOW_SQL));
                return properties;
            }

            @Bean
            JpaTransactionManager transactionManager() {
                JpaTransactionManager transactionManager = new JpaTransactionManager();
                transactionManager.setEntityManagerFactory(entityManagerFactoryBean().getObject());
                return transactionManager;
            }
        }
        ```

2. Normal project

    - Configuration in properties file

        When we create an instance of the Configuration class, it will look for **hibernate.cfg.xml** or **hibernate.properties** in our classpath. If we use a **.properties** file, it will get all of the property defined in a file, rather than create a Configuration object.
        
        The difference between an XML and properties file is that, in an XML file, you can directly map classes using the **<Mapping>** tag, but there is no way to configure it in a properties file. So, you can use this methodology when you use a programmatic configuration.

        So, we have the content of **hibernate.properties** file.

        ```PHP
        hibernate.connection.driver_class=com.mysql.jdbc.Driver
        hibernate.connection.url=jdbc:mysql://localhost:3306/common?useUnicode=true&characterEncoding=utf8
        hibernate.connection.username=root
        hibernate.connection.password=root
        hibernate.dialect=org.hibernate.dialect.MySQL5Dialect
        hibernate.show_sql=false
        ```

    - Configuration in xml file

        By default, Hibernate will scan resource folder to find the **hibernate.cfg.xml** file or **hibernate.properties** file.

        ```xml
        <hibernate-configuration>
            <session-factory>
                <property name="hibernate.dialect">org.hibernate.dialect.MySQLDialect</property>
                <property name="hibernate.connection.driver_class">com.mysql.jdbc.Driver</property>
                <property name="hibernate.connection.url">jdbc:mysql://localhost:3306/java_sql</property>
                <property name="hibernate.connection.useUnicode">true</property>
                <property name="hibernate.connection.characterEncoding">UTF-8</property>
                <property name="hibernate.connection.username">root</property>
                <property name="hibernate.connection.password">12345</property>
                <property name="hibernate.current_session_context_class">thread</property>
                <property name="hibernate.hbm2ddl.auto">update</property>
                <property name="hibernate.show_sql">true</property>
                <property name="hibernate.format_sql">true</property>
                <mapping class="com.manhpd.persistence.entity.Employee"/>
            </session-factory>
        </hibernate-configuration>
        ```

<br>

## Given problems of project in production environment

1. Configure timeout for each query

    In the production environment, accessing database takes so much time. It's longer than sending request to other system. So, we need to configure the timeout parameter.

    In Hibernate, we have some ways to deal with it.
    - First way, JPA 2 defines the **javax.persistence.query.timeout** hint to specify default timeout in **milliseconds**. Hibernate 3.5 (currently still in beta) will support this hint that uses for **EntityManager**.

        For example:

        ```java
        String sqlQuery = ...
        Query query = this.entityManager.createQuery(sqlQuery)
                                        .setParameter(...)
                                        .setHint("javax.persistence.query.timeout", 50)     // miliseconds
                                        .getResultList();
        ```

    - Second way, we can use **org.hibernate.timeout** that is similar in the first way.

        For example:

        ```java
        String sqlQuery = ...
        Query query = this.entityManager.createQuery(sqlQuery)
                                        .setParameter(...)
                                        .setHint("org.hibernate.timeout", 1)    // seconds
                                        .getResultList();
        ```
    
    - Third way, we can use **setTimeout()** method.

        For example:

        ```java
        String sqlQuery = ...
        Query query = this.entityManager.createQuery(sqlQuery)
                                        .setParameter(...)
                                        .setTimeout(1)    // seconds
                                        .getResultList();
        ```

2. Use connection pool to improve performance of application

    For each request to database, we need to open a new connection to operate with database. It takes so much time to create new connection, and destroy when connection is closed. If our application creates many connections, it can make our system hang out, less resource for other services.
    
    So, using connection pool is a right away to boost performance of system. A connection pool is used to minimize the number of connections opened between application and database, and we can reuse connections.

    If we use application server such as Wildfly, Oracle WebLogic, JBoss, Websphere, we can use built-in connection pool (typically a connection is obtain using JNDI). Otherwise, Hibernate supports some other connection pools.

    Hibernate is designed to use a connection pool by default, an internal implementation. However, Hibernate's built-in connection pooling isn't designed for production use. Below is a table that lists some external connection pools.

    | Library     |             Link                        | Vendor                     |
    | ----------- | --------------------------------------- | -------------------------- |                      
    | c3p0        | http://sourceforge.net/projects/c3p0    | Distributed with Hibernate |
    | Apache DBCP | http://jakarta.apache.org/commons/dbcp/ | Apache Pool                |
    | Proxool     | http://proxool.sourceforge.net/         | JDBC Pooling Wrapper       |
    | HikariCP    |                                         |                            |

    In order to configure some external connection pools in our Hibernate project, we can reference to [our project](https://github.com/DucManhPhan/J2EE/tree/master/src/Java_Spring/Hibernate/connection-pool-hibernate).

3. Setting **validation-query** and **test-on-borrow** properties to DataSource

    - Given problem

        Normally, some databases can find connections that are idle. These will be killed. So, our appliation always tries to connect to these database, because all connections died.

        It makes our application that does not run smoothly.

    - Solution

        To solve this problem, we will set some properties. From the documentation of [Tomcat Apache](https://tomcat.apache.org/tomcat-8.0-doc/jdbc-pool.html), we will have.
        - validation-query

            The SQL query that will be used to validate connections from this pool before returning them to the caller. If specified, this query does not have to return any data, it just can't throw a **SQLException**. The default value is null. If not specified, connections will be validation by the **isValid()** method.

            For example:
            - With MySQL: **SELECT 1**
            - With Oracle: **SELECT 1 FROM DUAL**
            - With Ms SQL Server: **SELECT 1**

        - test-on-borrow

            The indication of whether objects will be validated before being borrowed from the pool. If the object fails to validate, it will be dropped from the pool, and we will attempt to borrow another. In order to have a more efficient validation, see **validationInterval**. Default value is **false**.

        - validation-interval

            avoid excess validation, only run validation at most at this frequency - time in milliseconds. If a connection is due for validation, but has been validated previously within this interval, it will not be validated again. The default value is 3000 (3 seconds).

        These above properties only exist in the Tomcat connection pool. They are unknown properties to [Hikari connection pool](https://github.com/brettwooldridge/HikariCP).

<br>

## Some dialects of Hibernate for other databases

Below is a table that lists all dialects that Hibernate will use.

|        RDBMS       |              Dialect                       |
| ------------------ | ------------------------------------------ |
| DB2	             | org.hibernate.dialect.DB2Dialect           |
| DB2 Express-C      | org.hibernate.dialect.DB2Dialect           |
| DB2 AS/400	     | org.hibernate.dialect.DB2400Dialect        |
| DB2 OS390	         | org.hibernate.dialect.DB2390Dialect        |
| PostgreSQL	     | org.hibernate.dialect.PostgreSQLDialect    |
| PostgreSQL	     | org.hibernate.dialect.PostgreSQL95Dialect  |
| MySQL	             | org.hibernate.dialect.MySQLDialect         |
| MySQL 8            | org.hibernate.dialect.MySQL8Dialect        |
| MySQL with InnoDB	 | org.hibernate.dialect.MySQLInnoDBDialect   |
| MySQL 5 with InnoDB| org.hibernate.dialect.MySQL5InnoDBDialect  |
| MySQL with MyISAM	 | org.hibernate.dialect.MySQLMyISAMDialect   |
| Oracle (any version) | org.hibernate.dialect.OracleDialect      |
| Oracle 9i	         | org.hibernate.dialect.Oracle9iDialect      |
| Oracle 10g	     | org.hibernate.dialect.Oracle10gDialect     |
| Oracle 12c	     | org.hibernate.dialect.Oracle12cDialect     |
| Sybase             | org.hibernate.dialect.SybaseDialect        |
| Sybase Anywhere	 | org.hibernate.dialect.SybaseAnywhereDialect|
| SQL Server         | org.hibernate.dialect.SQLServerDialect   |
| SQL Server 2012    | org.hibernate.dialect.SQLServer2012Dialect |
| SAP DB             | org.hibernate.dialect.SAPDBDialect         |
| Informix	         | org.hibernate.dialect.InformixDialect      |
| HypersonicSQL	     | org.hibernate.dialect.HSQLDialect          |
| Ingres             | org.hibernate.dialect.IngresDialect        |
| Progress           | org.hibernate.dialect.ProgressDialect      |
| Mckoi SQL          | org.hibernate.dialect.MckoiDialect         |
| Interbase	         | org.hibernate.dialect.InterbaseDialect     |
| Pointbase	         | org.hibernate.dialect.PointbaseDialect     |
| FrontBase	         | org.hibernate.dialect.FrontbaseDialect     |
| Firebird	         | org.hibernate.dialect.FirebirdDialect      |
| MariaDB	         | org.hibernate.dialect.MariaDB53Dialect     |
| SAP HANA	         | org.hibernate.dialect.HANAColumnStoreDialect |
| HSQLDB	         | org.hibernate.dialect.HSQLDialect          |
| H2                 | org.hibernate.dialect.H2Dialect            |
| Derby              | org.hibernate.dialect.DerbyTenSevenDialect |


<br>

## Some driver of other databases

Below is a table that list all drivers that Hibernate supports.

|         RDBMS         |                 Driver               |              JDBC URL                          |
| --------------------- | ------------------------------------ | ---------------------------------------------- |
| Oracle                | oracle.jdbc.OracleDriver             | jdbc:oracle:thin:@<ip-address>:<port>:orclpdb1 |
| MySQL                 | com.mysql.cj.jdbc.Driver             | jdbc:mysql://<ip-address>:<port>/<db-name>     |  
| MySQL                 | com.mysql.jdbc.Driver                | jdbc:mysql://<ip-address>:<port>/<db-name>     |
| PostgreSQL            | org.postgresql.Driver                | jdbc:postgresql://<ip-address>:<port>/<db-name>|
| SQL Server            | com.microsoft.sqlserver.jdbc.SQLServerDriver | jdbc:sqlserver://<ip-address>:<port>;instance=SQLEXPRESS;databaseName=<db-name> |
| MariaDB               | org.mariadb.jdbc.Driver              | jdbc:mariadb://<ip-address>:<port>/<db-name>   |
| DB2 Express-C         | com.ibm.db2.jcc.DB2Driver            | jdbc:db2://<ip-address>:<port>/<db-name>       |
| SAP HANA              | com.sap.db.jdbc.Driver               | jdbc:sap://<ip-address>:<port>/<db-name>       |
| Informix              | com.informix.jdbc.IfxDriver          | jdbc:informix-sqli://<ip-address>:<port>/sysuser:INFORMIXSERVER=hpjp |
| HSQLDB                | org.hsqldb.jdbc.JDBCDriver           | jdbc:hsqldb:mem:<db-name>                      |
| H2                    | org.h2.Driver                        | jdbc:h2:mem:<db-name>                          |
| Derby                 | org.apache.derby.jdbc.EmbeddedDriver | jdbc:derby:target/tmp/derby/hpjp;databaseName=<db-name>;create=true |


<br>

## Wrapping up
- Understand how configure Hibernate in properties file or xml file.

- How to apply some features in the production environment.

<br>

Refer:

**Properties of Spring Boot**

[https://docs.spring.io/spring-boot/docs/1.1.2.RELEASE/reference/html/common-application-properties.html](https://docs.spring.io/spring-boot/docs/1.1.2.RELEASE/reference/html/common-application-properties.html)

[Java Hibernate cook book](https://www.amazon.com/Java-Hibernate-Cookbook-Yogesh-Prajapati-ebook/dp/B012B1H8J6)

[https://stackoverflow.com/questions/10684244/dbcp-validationquery-for-different-databases](https://stackoverflow.com/questions/10684244/dbcp-validationquery-for-different-databases)

[https://docs.spring.io/spring-boot/docs/1.1.2.RELEASE/reference/html/common-application-properties.html](https://docs.spring.io/spring-boot/docs/1.1.2.RELEASE/reference/html/common-application-properties.html)

[https://stackoverflow.com/questions/28821521/configure-datasource-programmatically-in-spring-boot](https://stackoverflow.com/questions/28821521/configure-datasource-programmatically-in-spring-boot)

[https://www.informit.com/articles/article.aspx?p=353736&seqNum=4](https://www.informit.com/articles/article.aspx?p=353736&seqNum=4)

<br>

**Query timeout in Hibernate**

[https://docs.jboss.org/hibernate/stable/entitymanager/reference/en/html/objectstate.html#d0e1215](https://docs.jboss.org/hibernate/stable/entitymanager/reference/en/html/objectstate.html#d0e1215)

[https://blog.e-zest.com/transaction-and-query-timeout/](https://blog.e-zest.com/transaction-and-query-timeout/)

[https://stackoverflow.com/questions/2101455/how-to-set-a-default-query-timeout-with-jpa-and-hibernate](https://stackoverflow.com/questions/2101455/how-to-set-a-default-query-timeout-with-jpa-and-hibernate)

[https://www.baeldung.com/hibernate-exceptions](https://www.baeldung.com/hibernate-exceptions)

[https://vladmihalcea.com/query-timeout-jpa-hibernate/](https://vladmihalcea.com/query-timeout-jpa-hibernate/)

[https://stackoverflow.com/questions/50367279/connection-timeout-spring-boot-application-and-mysql](https://stackoverflow.com/questions/50367279/connection-timeout-spring-boot-application-and-mysql)

[https://docs.jboss.org/hibernate/orm/3.3/reference/en/html/session-configuration.html](https://docs.jboss.org/hibernate/orm/3.3/reference/en/html/session-configuration.html)

<br>

**Configure connection pool**

[https://www.mchange.com/projects/c3p0/#configuration](https://www.mchange.com/projects/c3p0/#configuration)

[https://developer.jboss.org/wiki/HowToConfigureTheC3P0ConnectionPool](https://developer.jboss.org/wiki/HowToConfigureTheC3P0ConnectionPool)

[https://stackoverflow.com/questions/53870473/hikari-and-test-on-borrow-option](https://stackoverflow.com/questions/53870473/hikari-and-test-on-borrow-option)

[https://github.com/brettwooldridge/HikariCP/issues/181](https://github.com/brettwooldridge/HikariCP/issues/181)