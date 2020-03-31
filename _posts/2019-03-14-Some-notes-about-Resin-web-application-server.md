---
layout: post
title: Some notes about Resin web application server
bigimg: /img/image-header/california.jpg
tags: [Resin]
---

In this article, we will discuss about Resin web server, simply because I have so many problems with Resin when building my own projects, especially project that is relevant to seasar framework - sastruts, ...

<br>

## Table of contents
- [Introduction to Resin server](#introduction-to-resin-server)
- [Directory layout of Resin home folder](#directory-layout-of-resin-home-folder)
- [resin-data folder layout](#resin-data-folder-layout)
- [Understanding about app-default.xml in Resin web server](#understanding-about-app-default.xml-in-resin-web-server)
- [Deploy web application with resin.xml](#deploy-web-application)
- [Some errors when deploying war file in Resin server](#some-errors-when-deploying-war-file-in-resin-server)

<br>

## Introduction to Resin server
Resin is a web server and Java application server from Caucho Technology. In addition to Resin (GPL), Resin Pro is available for enterprise and production environments with a license. Resin supports the Java EE standard as well as a mod_php/PHP like engine called Quercus.

Although a Java-based server, key pieces of Resin's core networking are written in highly optimized C. Caucho states Java is the layer that allows Resin to be "full featured" while C provides the speed. Resin, which was released in 1999, predates Apache Tomcat, and is one of the most mature application servers and web servers.

<br>

## Directory layout of Resin home folder
The below is the standard layout and locations for Resin files in Unix.

```yaml
/var/resin/            # Resin root-directory
  app-inf/             # custom app-tier cluster configuration and jars
  doc/                 # Resin documentation
  endorsed/            # Special overriding jar directory (uncommon)
  project-jars/        # Resin extensions to third-party projects
  resin-data/          # Resin working directory
  resin-inf/           # custom Resin-wide configuration and jars
  watchdog-data/       # Watchdog working directory
  webapp-jars/         # jars included for every web-app
  webapps/             # Application deployment

/var/log/resin/        # Resin runtime logs
  watchdog-manager.log # log for the watchdog
  jvm-app-0.log        # log for the server named "app-0"

/etc/resin/            # Resin configuration
  resin.properties     # configuration properties
  resin.xml            # main configuration file
  app-default.xml      # documentation for web-app default
  cluster-default.xml  # common configuration for all clusters
  health.xml           # health system rules, meters, and actions
  keys/                # openssl keys
  licenses/            # Resin licenses
  
/etc/init.d/resin      # Unix init startup service

/usr/bin/resinctl      # Resin command-line script

/usr/share/resin/      # resin-home
  bin/                 # Resin startup scripts
  lib/                 # Resin jars
  libexec64/           # Resin jni binaries

```

<br>

## resin-data folder layout
Resin will keep its operational data in a directory named resin-data. By default directory resin-data is located under Resin Root. 

All data in resin-data directory is managed internally by Resin. 

The resin-data directory contains Resin's internal data, including deployed webapps, the health system data, and distributed caches.

If Resin's internal data becomes corrupted, you can remove the resin-data directory to reset the state. If you have multiple servers in a triad hub, the reset server will restore its values from the other servers.

When Resin is deployed in a Unix environment, the resin-data will typically be in /var/resin/resin-data.

Directory structure of ```resin-data``` folder is:

```yaml
resin-data/
  app-0/          # each named server gets its own section
    .git/         # web-app deployment .git repository
    distcache/    # distributed cache directory
      data.db     # distcache value data
      mnode.db    # distcache key/value binding
    log/          # health system log
      log_data.db # log entries
      log_name.db # log names
    stat_data.db  # health statistics data
    stat_name.db  # health statistics names
    tmp/          # temp swap directory
      temp_file   
    xa.log.a      # XA log
```

The meaning of some directories in ```resin-data```:

|       folder       |             Description            |
| ------------------ | ---------------------------------- |
| .git               | contains deployed applications     |
| distcache          | Session store and distributed cache data store |
| log	             | Resin log message database for reporting recent messages to pdf report and Resin-Admin |
| stat_data.db, stat_name.db | Resin runtime statistics database. Used for reporting in pdf report and Resin-Admin |
| tmp	                     | temporary directory for large file operations |
| xa.log*	                 | Distributed transactions log |

<br>

## Understanding about app-default.xml in Resin web server

```xml
<cluster xmlns="http://caucho.com/ns/resin"
         xmlns:resin="urn:java:com.caucho.resin">

    <ear-default>
        <resin:import path="META-INF/application.xml" optional="true"/>
        <resin:import path="META-INF/resin-application.xml" optional="true"/>
    </ear-default>

    <web-app-default>
        <!-- configures the default class loader -->
        <class-loader>
            <compiling-loader path="WEB-INF/classes"/>
            <library-loader path="WEB-INF/lib"/>
        </class-loader>

        <servlet servlet-name="resin-file"
                servlet-class="com.caucho.servlets.FileServlet"/>

        <servlet servlet-name="resin-jsp"
                servlet-class="com.caucho.jsp.JspServlet">
            <init>
            <load-tld-on-init>false</load-tld-on-init>
            <page-cache-max>1024</page-cache-max>
            </init>
            <load-on-startup/>
        </servlet>

        <servlet servlet-name="resin-jspx"
                servlet-class="com.caucho.jsp.JspServlet">
            <init>
            <load-tld-on-init>false</load-tld-on-init>	   
            <page-cache-max>1024</page-cache-max>
            <xml>true</xml>
            </init>
            <load-on-startup/>
        </servlet>

        <servlet servlet-name="resin-php"
                servlet-class="com.caucho.quercus.servlet.QuercusServlet">
        </servlet>

        <servlet servlet-name="resin-xtp"
                servlet-class="com.caucho.jsp.XtpServlet"/>

        <servlet-mapping url-pattern="*.jsp"
                        servlet-name="resin-jsp"
                        default="true"/>
        <servlet-mapping url-pattern="*.jspf" 
                        servlet-name="resin-jsp"
                        default="true"/>
        <servlet-mapping url-pattern="*.jspx" 
                        servlet-name="resin-jspx"
                        default="true"/>

        <resin:if test="${! quercus_disable}">
            <servlet-mapping url-pattern="*.php" 
                            servlet-name="resin-php"
                            default="true"/>
        </resin:if>

        <servlet-mapping url-pattern="/" 
                        servlet-name="resin-file"
                        default="true"/>

        <servlet servlet-name="j_security_check"
                servlet-class="com.caucho.server.security.FormLoginServlet"/>

        <!--
            - <multipart-form enable="true"/>
            -->

        <!-- Configures the special index files to check for directory URLs -->
        <welcome-file-list>
            <welcome-file>index.jsp</welcome-file>
            <welcome-file>index.php</welcome-file>
            <welcome-file>index.html</welcome-file>
        </welcome-file-list>

        <mime-mapping extension=".html" mime-type="text/html"/>
        <mime-mapping extension=".htm" mime-type="text/html"/>
        ...
        <mime-mapping extension=".zip" mime-type="application/zip"/>

        <resin:import path="WEB-INF/resin-web-pre.xml" optional="true"/>
        <resin:import path="WEB-INF/web.xml" optional="true"/>
        <resin:import path="WEB-INF/resin-web.xml" optional="true"/>
        <resin:import path="WEB-INF/resin-web-post.xml" optional="true"/>
    </web-app-default>
</cluster>
```

The most important thing we need to note in this ```app-default.xml``` is that it configures for using servlet such as:

```xml
<servlet servlet-name="resin-file"
         servlet-class="com.caucho.servlets.FileServlet"/>

<servlet-mapping url-pattern="/" 
            servlet-name="resin-file"
            default="true"/>
```

And Resin also import some files such as ```resin-web-pre.xml```, ```web.xml```, ```resin-web.xml```, and ```resin-web-post.xml``` files.

<br>

## Deploy web application with resin.xml
```resin.xml``` file is used to describe resources, clustering, HTTP hosts, and URL dispatching, and custom CanDI configuration.

In this scenario, we want to configure a web-app with a specific root-directory and specify the location of the .war file. As usual, when Resin sees any changes in the .war file, it will expand the new data into the root-directory and restart the web-app. This capability, gives sites more flexibility where their directories and archive files should be placed, beyond the standard webapps directory.

The optional ```archive-path``` argument of the ```<web-app>``` will point to the ```.war``` file to be expanded.

Some options in web-app deployment:

|        Attribute      |           Description           |         Default        |
| --------------------- | ------------------------------- | ---------------------- |
| archive-path          | path to the .war file which contains the web-app's contents | |
| dependency-check-interval | how often Resin should check for changes in the web-app for a redeployment |   2s   |
| expand-preserve-fileset | a set of files / directories Resin should preserve on a redeploy when it deletes the expanded directory | |
| id  | unique identifier for the web-app and the default context-path value | |
| redeploy-check-interval | how often Resin should check the .war file for changes | 60s |
| redeploy-mode | how Resin should handle redeployment: automatic, lazy, or manual | automatic |
| root-directory | path to the expanded web-app directory | id as a sub-directory of the virtual-hosts's root |

Example for the content of resin.xml file

```xml
<resin xmlns="http://caucho.com/ns/resin"
       xmlns:resin="urn:java:com.caucho.resin">

    ...
    <!--
     - For production sites, change dependency-check-interval to something
     - like 600s, so it only checks for updates every 10 minutes.
    -->
  <dependency-check-interval>${dependency_check_interval?:'2s'}</dependency-check-interval>

  <!--
     - Configures the main application cluster.  Load-balancing configurations
     - will also have a web cluster.
    -->
  <cluster id="app">
    <!-- define the servers in the cluster -->
    <server-multi id-prefix="app-" address-list="${app_servers}" port="6800"/>

    <host-default>
      <!-- creates the webapps directory for .war expansion -->
      <web-app-deploy path="webapps"
                      expand-preserve-fileset="WEB-INF/work/**"
                      multiversion-routing="${webapp_multiversion_routing}"
                      path-suffix="${elastic_webapp?resin.id:''}"/>
    </host-default>

    <!-- auto virtual host deployment in hosts/foo.example.com/webapps -->
    <host-deploy path="hosts">
      <host-default>
        <resin:import path="host.xml" optional="true"/>
      </host-default>
    </host-deploy>

    <!-- the default host, matching any host name -->
    <host id="" root-directory=".">
      <!--
         - webapps can be overridden/extended in the resin.xml
        -->
      <web-app id="/" root-directory="webapps/ROOT"/>
    </host>
      
    <resin:if test="${resin_doc}">
      <host id="${resin_doc_host}" root-directory="${resin_doc_host}">
        <web-app id="/resin-doc" root-directory="${resin.root}/doc/resin-doc"/>
      </host>
    </resin:if>
  </cluster>

  <cluster id="web">
    <!-- define the servers in the cluster -->
    <server-multi id-prefix="web-" address-list="${web_servers}" port="6810"/>

    <host id="" root-directory="web">
      <web-app id="">
        <resin:LoadBalance regexp="" cluster="app"/>
      </web-app>
    </host>
  </cluster>
</resin>
```

With the above configurations, we can see that the part about deployment of ```web-app``` is appeared in cluster with ```id=app```. We have:

```xml
<web-app-deploy path="webapps"
    expand-preserve-fileset="WEB-INF/work/**"
    multiversion-routing="${webapp_multiversion_routing}"
    path-suffix="${elastic_webapp?resin.id:''}"/>
```

In default, all the *.jsp file will be contained in ```WEB-INF/work/**```. It makes our servlet container not to build them again. So, in our project, we need to create a folder has name ```work``` in ```WEB-INF``` folder.

And we have a important thing that is about ```LoadBalance``` with the below code:

```xml
<host id="" root-directory="web">
    <web-app id="">
    <resin:LoadBalance regexp="" cluster="app"/>
    </web-app>
</host>
```

Then, when we type ```localhost:8080```, it will jump to our default project ```ROOT``` in Resin. 

```xml
<!-- the default host, matching any host name -->
<host id="" root-directory=".">
    <!-- webapps can be overridden/extended in the resin.xml -->
    <web-app id="/" root-directory="webapps/ROOT"/>
</host>
```

<br>

## Some errors when deploying war file in Resin server
- When we type ```https://localhost:8080/our_name_project```, the browser will display the 404 - Not found.

    With ```404 - Not found```, it means that in Resin web server, our project did not re-deploy when we added some modules or it has no war file. So, we have to deploy it.

    There are some ways to deal with this problem.
    1. delete Resin web server and create a new other Resin web server.
    2. Delete folder ```resin-data``` in ```%RESIN_HOME%/webapps``` if possible.
    3. Delete all the files under ```%RESIN_HOME%/resin-data```. The causes we can refer to the above parts.

<br>

Refer:

[http://accel-archives.intra-mart.jp/2014-summer/document/iap/public_en/setup/iap_setup_guide/texts/appendix/resin_redeploy.html](http://accel-archives.intra-mart.jp/2014-summer/document/iap/public_en/setup/iap_setup_guide/texts/appendix/resin_redeploy.html)

[http://accel-archives.intra-mart.jp/2014-summer/document/iap/public_en/setup/iap_setup_guide/texts/appendix/resin_deploy.html](http://accel-archives.intra-mart.jp/2014-summer/document/iap/public_en/setup/iap_setup_guide/texts/appendix/resin_deploy.html)

[https://caucho.com/resin-4.0/admin/resin-directory.xtp](https://caucho.com/resin-4.0/admin/resin-directory.xtp)

[https://en.wikipedia.org/wiki/Resin_(software)](https://en.wikipedia.org/wiki/Resin_(software))

<br>

**ClassLoader**

[https://caucho.com/resin-4.0/admin/advanced-classloaders.xtp](https://caucho.com/resin-4.0/admin/advanced-classloaders.xtp)