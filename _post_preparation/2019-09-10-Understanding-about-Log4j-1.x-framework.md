---
layout: post
title: Understanding about Log4j 1.x framework
bigimg: /img/image-header/home-office-1.jpg
tags: [java]
---




<br>

## Table of contents



<br>

## The structure of Log4j

[https://www.roseindia.net/tutorials/log4j/log4-Architecture.shtml](https://www.roseindia.net/tutorials/log4j/log4-Architecture.shtml)

[https://blog.eduonix.com/java-programming-2/learn-architecture-log4j-framework/](https://blog.eduonix.com/java-programming-2/learn-architecture-log4j-framework/)

<br>

## Some packages that need for Log4j 1.x



```
<dependency>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
    <version>1.2.17</version>
</dependency>

<dependency>
    <groupId>log4j</groupId>
    <artifactId>apache-log4j-extras</artifactId>
    <version>1.2.17</version>
</dependency>

```



<br>

## Configure Log4j 1.x with properties file
Below is an log4j.properties file that we need to configure when utilizing Log4j 1.x.

```python
# Define the root logger with appender file
log4j.rootLogger=INFO, file

# Define the file appender
log4j.appender.file=org.apache.log4j.RollingFileAppender
#log4j.appender.file.datePattern='.'yyyy-MM-dd-HH-mm

# Set the append to false, overwrite
#log4j.appender.file.Append=false

# Set the name of the file
log4j.appender.file.File=${log}/sample.log

# Set the maximum file size before rollover
#log4j.appender.file.MaxFileSize=10KB

# Set the the backup index
#log4j.appender.file.MaxBackupIndex=20

log4j.appender.file.rollingPolicy=org.apache.log4j.rolling.TimeBasedRollingPolicy
log4j.appender.file.rollingPolicy.FileNamePattern=worker-.%d{yyyy-MM-dd'T'HH:mm:ss.SSS}.gz

# Define the layout for file appender
log4j.appender.file.layout=org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} %-5p - %m%n

# Define encoding for output file
log4j.appender.file.encoding=UTF-8

```

Then, it is an test file for using log4j.properties file.

```java
public class App 
{
    private static Logger logger = LogManager.getLogger(App.class);

    public static void main( String[] args ) throws InterruptedException {
        for(int i = 0; i < 2000; i++) {
            System.out.println("Logging.\n");
            logger.info("This is the " + i + " time I say 'Hello World'.");
            Thread.sleep(100);
        }
    }
}

```


<br>


## Wrapping up





<br>

Refer:

[https://huongdanjava.com/overview-about-log4j-1-x.html](https://huongdanjava.com/overview-about-log4j-1-x.html)

[https://github.com/eugenp/tutorials/tree/master/logging-modules](https://github.com/eugenp/tutorials/tree/master/logging-modules)

[https://www.mkyong.com/logging/log4j-log4j-properties-examples/](https://www.mkyong.com/logging/log4j-log4j-properties-examples/)

[https://www.dev2qa.com/how-to-configure-log4j-in-java-project-examples/](https://www.dev2qa.com/how-to-configure-log4j-in-java-project-examples/)

[https://jazz.net/help-dev/clm/index.jsp?topic=%2Fcom.ibm.jazz.repository.web.admin.doc%2Ftopics%2Ft_customizing_log_file.html](https://jazz.net/help-dev/clm/index.jsp?topic=%2Fcom.ibm.jazz.repository.web.admin.doc%2Ftopics%2Ft_customizing_log_file.html)

[https://www.codejava.net/coding/common-conversion-patterns-for-log4js-patternlayout](https://www.codejava.net/coding/common-conversion-patterns-for-log4js-patternlayout)

[https://www.tutorialspoint.com/log4j/log4j_patternlayout.htm](https://www.tutorialspoint.com/log4j/log4j_patternlayout.htm)

[https://www.tutorialspoint.com/log4j/log4j_logging_files.htm](https://www.tutorialspoint.com/log4j/log4j_logging_files.htm)

[http://2min2code.com/articles/log4j_intro/rolling_archiving_file_per_day_prop](http://2min2code.com/articles/log4j_intro/rolling_archiving_file_per_day_prop)

[https://examples.javacodegeeks.com/enterprise-java/log4j/log4j-date-format-example/](https://examples.javacodegeeks.com/enterprise-java/log4j/log4j-date-format-example/)

[https://logging.apache.org/log4j/2.x/manual/layouts.html](https://logging.apache.org/log4j/2.x/manual/layouts.html)