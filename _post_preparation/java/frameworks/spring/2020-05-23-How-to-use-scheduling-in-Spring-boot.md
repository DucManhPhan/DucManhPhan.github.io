---
layout: post
title: How to use scheduling in Spring boot
bigimg: /img/path.jpg
tags: [Spring]
---



<br>

## Table of contents
- [Introduction to Scheduling in Spring boot](#introduction-to-scheduling-in-spring-boot)
- [How to use Scheduling](#how-to-use-scheduling)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Scheduling in Spring boot

1. Scheduling with Spring boot





2. Java Cron Expression




<br>

## How to use Scheduling

1. Use **@EnableScheduling** annnotation for our configuration class or main class with **@SpringBootApplication**

    ```java
    @Configuration
    @EnableScheduling
    public class AppConfig {
        // nothing to do
    }
    ```

    The **@EnableScheduling** annotation ensures that a background task executor is created. Without it, nothing gets scheduled.

2. Use **@Scheduled** to trigger the scheduler for a specific time period

    ```java
    @Component
    public class SchedulerTask {

        @Scheduled(cron = "")
        public void cronJob() {
            // do something
        }
    }
    ```

    Some rules for our methods that are applied to @Scheduled annotation.
    - Our methods will not have any parameters.
    - Our methods's return type is void.

    To dig deeper into the definition of **@Scheduled** annotation, we have:

    ```java
    @Target({ElementType.METHOD, ElementType.ANNOTATION_TYPE})
    @Retention(RetentionPolicy.RUNTIME)
    @Documented
    @Repeatable(Schedules.class)
    public @interface Scheduled {
        String CRON_DISABLED = "-";

        String cron() default "";

        String zone() default "";

        long fixedDelay() default -1L;

        String fixedDelayString() default "";

        long fixedRate() default -1L;

        String fixedRateString() default "";

        long initialDelay() default -1L;

        String initialDelayString() default "";
    }
    ```

    So, we will find something about the above options of @Scheduled annotation.
    - **fixedRate** is used to schedule a method trigger at a fixed period time.

        ```java
        @Scheduled(fixedRate = 1000)
        public void cronJob() {
            // do something
        }
        ```

    - **fixedDelay** is used to set the time between the last execution and the start of next execution.

        ```java
        @Scheduled(fixedDelay = 1000)
        public void cronJob() {
            // do something
        }
        ```
    
    - **initialDelay** is used to set the delay time of the first execution of the task.

        ```java
        @Scheduled(initialDelay = 3000, fixedDelay = 1000)
        public void cronJob() {
            // do something
        }
        ```

    - **cron** can be used with some expression to configure. All of cron's information is listed at the above section.

<br>

## 






<br>

## Wrapping up







<br>

Refer:

[https://docs.oracle.com/cd/E12058_01/doc/doc.1014/e12030/cron_expressions.htm](https://docs.oracle.com/cd/E12058_01/doc/doc.1014/e12030/cron_expressions.htm)

[https://www.tutorialspoint.com/spring_boot/spring_boot_scheduling.htm](https://www.tutorialspoint.com/spring_boot/spring_boot_scheduling.htm)

[https://www.javadevjournal.com/spring-boot/spring-boot-scheduler/](https://www.javadevjournal.com/spring-boot/spring-boot-scheduler/)

