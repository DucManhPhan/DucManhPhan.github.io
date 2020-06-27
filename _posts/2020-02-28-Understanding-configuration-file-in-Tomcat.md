---
layout: post
title: Understanding configuration files in Tomcat
bigimg: /img/path.jpg
tags: [Tomcat]
---

Before going deeper the meaning of configuration file in Tomcat server, we can visit the other article about [Configure Tomcat for Java web](http://ducmanhphan.github.io/2019-02-18-Configure-Tomcat-for-Java-web).

Let's get started.

<br>

## Table of contents
- [Starting, Stopping and Restarting Tomcat](#starting,-stopping-and-restarting-tomcat)
- [Configuration files of Catalina](#configuration-files-of-catalina)
- [Understanding about catalina.properties file](#understanding-about-catalina.properties-file)
- [Understanding context.xml file](#understanding-context.xml-file)
- [Wrapping up](#wrapping-up)


<br>

## Starting, Stopping and Restarting Tomcat

In order to start, stop, and restart Tomcat, we need to visit the ***bin*** directory of Tomcat. The script file can be terminated with .sh, shell script files for Unix and .bat, batch files for Windows.

Below is a table that describe the meaning of each file in ***bin*** directory that we need to know.

|       Script      |                        Purpose                         |
| ----------------- | ------------------------------------------------------ |
| catalina          | The main Tomcat script. This runs the **java** command to invoke the Tomcat startup and shutdown classes. |
| cappend           | This is used internally, and then only on Windows systems, to append items to Tomcat classpath environment variables. |
| digest            | This makes a crypto digest of Tomcat passwords. Use it to generate encrypted passwords. |
| service           | This script installs and uninstalls Tomcat as a Windows service. |
| setclasspath      | This is also only used internally and sets the Tomcat classpath and several other environment variables. |
| shutdown          | This runs catalina stop and shutdown Tomcat. |
| startup           | This runs catalina start and starts up Tomcat. |
| tool-wrapper      | This is a generic Tomcat command-line tool wrapper script that can be used to set environment variables and then call the main method of any fully qualified clas that is in the classpath that is set. This is used internally by the digest script. |
| version           | This runs the catalina version, which outputs Tomcat's version information. |

The **conf** directory also contains a sub-directory for each engine such as **Catalina**, ... which in turn contains a sub-directory for each of its host such as localhost by default, ... In each host, we can place the context file for each our project such as **sample.xml**, ...

1. ```catalina.bat``` script file

    The catalina script goes with some arguments such as **start**, **stop**, or **run**, ...
    - When invoked with **start** (as same as when calling **startup** script), it starts up Tomcat with the stardard output and standard error streams directed into the file **CATALINA_HOME/logs/catalina.out**.
    - When invoked with **run**, it causes Tomcat to leave the standard output and error streams means that it doesn't use console window to display output and errors.
    - When invoked with **stop** (as same as when calling **shutdown** script), it causes Tomcat to connect to the default port specified in our **Server** element of **server.xml** file and send it to shutdown message.
    - When invoked with **-security**, it enables the use of **catalina.policy** file.
    - When invoked with **debug**, it start Tomcat in debugging mode.

2. Some environment variables that we need to know when using Tomcat

    - ```JAVA_OPTS```

        In Tomcat, the running servlets can begin to take up a lot of memory in our Java environment.In order to configure the maximum size of heap memory in Tomcat, we can configure it by using ```JAVA_OPTS```. By default, the heap memory's value was 32MB for JDK 1.3.

        This environment variable will be set by command line.

        ```python
        # Korn and Bourne shell
        export JAVA_OPTS="-Xmx256M"

        # MS-DOS
        set JAVA_OPTS="-Xmx256M"

        # C-shell
        setenv JAVA_OPTS="-Xmx256M"
        ```

<br> 

## Configuration files of Catalina

Catalina is a component of Tomcat that implements the servlet specification. The default behavior of Catalina can be directly configured through all files in Tomcat's ```%CATALINA_BASE%/conf``` directory or ```conf``` of Tomcat directory.

Below is a table that describe the meaning of each file in ```conf``` directory.

|        File's name        |                    Purpose                  |
| ------------------------- | ------------------------------------------- |
| catalina.policy           | contains the Tomcat security policy for the Catalina java class, expressed in standard Security Policy syntax, as defined in the JEE specification. This is Tomcat's core security policy, and includes permissions definitions for system code, web applications, and Catalina itself. |
| catalina.properties       | This file is a standard Java properties file for the Catalina class. It contains information such as security package lists and class loader paths. This file can also contains some String cache settings, that we might edit when tuning our server for best Tomcat performance. |
| logging.properties        | This file configures the way that Catalina's built-in logging functions, including things such as threshold and log location. Note that all the entries in this log refer to JULI, the modified commons-logging implementation that Tomcat automatically uses in place of your JDK's logging implementation. |
| context.xml               | This XML configuration file is used to define Tomcat Context information that will be loaded for every web application running on a given instance of Tomcat. In general, you should configure your Context information elsewhere, but there are a few entries in this file that can be uncommented to alter the way that Tomcat handles session persistence and Comet connections. |
| server.xml                | This is Tomcat's main configuration file, which uses the hierarchical syntax specified in the Java Servlet specification to configure Catalina's initial state, as well as define the order in which Tomcat boots and builds its various components. This file is quite complex, but comprehensive documentation is available on the Apache website. |
| tomcat-users.xml          | This file contains information about the various users, passwords, and user roles on a given Tomcat server, as well as information about trusted Realms (JNDI, JDBC, etc.) where this data can be accessed. |
| web.xml                   | This file configures options and values that will be applied to all applications loaded into a given instance of Tomcat, including servlet definitions such as buffer sizes, debugging levels, Jasper options like classpath, MIME types, and default welcome files for directories that do not have their own "index" files. Although you can technically configure options for specific web applications in this file, this will require you to restart your entire server to propagate these changes, so it is not recommended. |


<br>

## Understanding about catalina.properties file

To understand about catalina.properties, we will reference about its content:

```C++
package.access=sun.,org.apache.catalina.,org.apache.coyote.,org.apache.jasper.,org.apache.tomcat.

package.definition=sun.,java.,org.apache.catalina.,org.apache.coyote.,\
org.apache.jasper.,org.apache.naming.,org.apache.tomcat.

common.loader="${catalina.base}/lib","${catalina.base}/lib/*.jar","${catalina.home}/lib","${catalina.home}/lib/*.jar"

server.loader=

shared.loader=

tomcat.util.scan.StandardJarScanFilter.jarsToSkip=\

tomcat.util.scan.StandardJarScanFilter.jarsToScan=\

tomcat.util.buf.StringCache.byte.enabled=true
#tomcat.util.buf.StringCache.char.enabled=true
#tomcat.util.buf.StringCache.trainThreshold=500000
#tomcat.util.buf.StringCache.cacheSize=5000
```

This properties provides some important class loader paths, security package lists, and some tunable performance properties. Another feature of the catalina.properties file is that we can set custom properties in this file and reference them as variables in Tomcat's **server.xml** file.

- Security component

    By default, if the Tomcat's security manager is enabled by passing **-security** argument to **catalina** script file, then the following properties will be used - **package.access**, and **package.definition**.

- Jar Scanner component

    The **Jar Scanner** element represents the component that is used to scan the web application for JAR files and directories of class files. It is typically used during web application start to identify configuration files such as TLDs or web-fragment.xml files that must be processed as part of the web application initialization.

    If a **Jar Scanner** element is not included, a default Jar Scanner configuration will be created automatically, which is sufficient for most requirements.

    The **Jar Scan Filter** element represents the component that filters results from the **Jar Scanner** before they are passed back to the application. It is typically used to skip the scanning of JARs that are known not to be relevant to some or all types of scan.

    A **Jar Scan Filter** element MAY be nested inside a Jar Scanner component.

    ```xml
    <Context>
    ...
    <JarScanner>
        <JarScanFilter
            pluggabilityScan="${tomcat.util.scan.StandardJarScanFilter.jarsToScan},
                        my_pluggable_feature.jar"/>
    </JarScanner>
    ...
    </Context>
    ```

    The standard implementation of **Jar Scan Filter** is ```org.apache.tomcat.util.scan.StandardJarScanFilter```.

    Some attributes of Java Scan Filter component that we need to know.
    - **pluggabilitySkip**: The comma separated list of JAR file name patterns to skip when scanning for pluggable features introduced by Servlet 3.0 specification. If not specified, the default is obtained from the **tomcat.util.scan.StandardJarScanFilter.jarsToSkip** system property.

    - **pluggabilityScan**: The comma separated list of JAR file name patterns to scan when scanning for pluggable features introduced by Servlet 3.0 specification. If not specified, the default is obtained from the **tomcat.util.scan.StandardJarScanFilter.jarsToScan** system property.

    Excluding a JAR from the pluggability scan will prevent a **ServletContainerInitializer** from being loaded from a web application JAR (i.e. one located in **/WEB-INF/lib**) but it will not prevent a **ServletContainerInitializer** from being loaded from the container (Tomcat). To prevent a **ServletContainerInitializer** provided by container from being loaded, use the **containerSciFilter** property of the **Context**.

    So, Jar Scanner is used to identity configuration files such as TLDs, ... What is TLDs file? A tag library descriptor is an XML document that contains information about a library as a whole and about each tag contained in the library. TLDs are used by a web container to validate the tags and by JSP page development tools. Normally, TLD files are used with JSP files.

    Then, if Jar Scanner do not find the TLD file in jar file, it will throw an exception about it. Finally, we can skip these JARs file to improve startup time and JSP compilation time. 

<br>

## Understanding context.xml file

Before going to the content of **context.xml** file of Tomcat, we need to understand context path concept.

Context path refers to the location which is relative to the server's address and represent the name of the web application. For example, if our web application is put under the **%CATALINA_HOME%\webapps\myapp** directory, it will be accessed by the URL **http://localhost/myapp**, and its context path will be **/myapp**.

Then, below is the content of **context.xml** file in **%CATALINA_HOME%\conf**.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- The contents of this file will be loaded for each web application -->
<Context>
    <!-- Default set of monitored resources. If one of these changes, the    -->
    <!-- web application will be reloaded.                                   -->
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>${catalina.base}/conf/web.xml</WatchedResource>

    <!-- Uncomment this to disable session persistence across Tomcat restarts -->
    <!--
    <Manager pathname="" />
    -->
</Context>
```

In this file, the **WatchedResource** property contains the **web.xml** file's path of our project and **%CATALINA_HOME%\conf**.

In the **%CATALINA_BASE%/conf/context.xml** file, the Context element information will be loaded by all web applications.

In the **%CATALINA_BASE%/conf/[enginename]/[hostname]/context.xml.default** file, the Context element information will be loaded by all web applications of that host.

After loading the content of context.xml file in global or default configuration file, configuration of individual web application will override anything configured in one of these defaults.

Then, we have:
- In an individual file at **/META-INF/context.xml** inside the application files. Optionally (based on the **Host**'s **copyXML** attribute) this may be copied to **%CATALINA_BASE%/conf/[enginename]/[hostname]/** and renamed to application's base file name plus a **.xml** extension.

    **enginename** can be Catalina or someone else, ...

- In individual files (with a **.xml** extension) in the **%CATALINA_BASE%/conf/[enginename]/[hostname]/** directory. The context path and version will be derived from the base name of the file (the file name less the **.xml** extension). This file will always ***take precedence over*** any **context.xml** file packaged in the web application's **META-INF** directory.

- Inside a Host element in the main **conf/server.xml**.

<br>

## Wrapping up
- The Glassfish Java EE server is the new reference implementation, and the web container component of Glassfish is based heavily on Tomcat. All open source Java EE application server implementations include Tomcat, in whole or in part.

<br>

Refer:

[https://examples.javacodegeeks.com/enterprise-java/tomcat/tomcat-server-xml-configuration-example/](https://examples.javacodegeeks.com/enterprise-java/tomcat/tomcat-server-xml-configuration-example/)

[https://www.mulesoft.com/tcat/tomcat-catalina](https://www.mulesoft.com/tcat/tomcat-catalina)

[https://www.mulesoft.com/tcat/understanding-apache-tomcat](https://www.mulesoft.com/tcat/understanding-apache-tomcat)

[https://www.oreilly.com/library/view/tomcat-the-definitive/9780596101060/ch07s05.html](https://www.oreilly.com/library/view/tomcat-the-definitive/9780596101060/ch07s05.html)

[https://tomcat.apache.org/tomcat-8.5-doc/config/jar-scanner.html](https://tomcat.apache.org/tomcat-8.5-doc/config/jar-scanner.html)

<br>

**TLD - Tag Library Descriptor**

[https://www.javatpoint.com/example-of-jsp-custom-tag](https://www.javatpoint.com/example-of-jsp-custom-tag)

[https://docs.oracle.com/javaee/5/tutorial/doc/bnamu.html](https://docs.oracle.com/javaee/5/tutorial/doc/bnamu.html)

<br>

**Performance with Tomcat**

[http://www.skybert.net/java/improve-tomcat-startup-time/](http://www.skybert.net/java/improve-tomcat-startup-time/)

<br>

**Context of Tomcat**

[https://tomcat.apache.org/tomcat-8.0-doc/config/context.html](https://tomcat.apache.org/tomcat-8.0-doc/config/context.html)