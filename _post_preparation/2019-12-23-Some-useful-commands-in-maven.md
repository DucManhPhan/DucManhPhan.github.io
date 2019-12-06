---
layout: post
title: Some useful commands in Maven
bigimg: /img/image-header/yourself.jpeg
tags: [Maven]
---




<br>

## Table of contents





<br>

## Creating project
1. Generate project in batch mode

    A couple of meaningful properties are then required:
    - The ```archetypeGroupId```, ```archetypeArtifactId``` and ```archetypeVersion``` defines the archetype to use for project generation.
    - The ```groupId```, ```artifactId```, ```version``` and ```package``` are the main properties to be set. Each archetype require these properties. Some archetypes define other properties; refer to the appropriate archetype's documentation if needed.

    ```bash
    mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.1 -DgroupId=com.company -DartifactId=project -Dversion=1.0-SNAPSHOT -Dpackage=com.company.project
    ```

    To create war file, we have to use ```-DarchetypeArtifactId=maven-archetype-webapp```.

    The meaning of some above attributes:

    |              Name              |                  Description                  |
    | ```groupId```                  | Defines a unique base name of the organization or group that created the project. This is normally a reverse domain name. For the generation the groupId also defines the package of the main class. |
    | ```artifactId```               | Defines the unique name of the project. If you generate a new project via Maven this is also used as root folder for the project. |
    | ```packaging```                | Defines the packaging method. This could be e.g. a jar, war or ear file. If the packaging type is pom, Maven does not create anything for this project, it is just meta-data. |
    | ```version```                  | This defines the version of the project. |

<br>

## Build project
1. Clean project

    ```bash
    # Clears the target directory into which Maven normally builds your project.
    mvn clean
    ```

2. Compile project

    ```bash
    mvn compile
    ```

3. Run unit tests

    ```bash
    # it also compile a project
    mvn test
    ```

3. Build a package

    ```bash
    # Builds the project and packages the resulting JAR file into the target directory
    # also execute unit tests
    mvn package
    ```

4. Run integration test

    ```bash
    # also build a package
    mvn verify
    ```

5. Install a package into a local repository

    ```bash
    # Builds the project described by your Maven POM file and installs the resulting artifact (JAR) into your local Maven repository
    # also executes integration tests
    mvn install
    ```

6. Install an artifact into local repository

    ```bash
    # skip integration test execution
    mvn -DskipITs=true install

    # skip unit and integration test execution
    mvn -DskipTests=true install

    # skip compiling test and test execution
    mvn -Dmaven.test.skip=true
    ```

7. Deploy artifact into enterprise repository

    ```bash
    mvn deploy
    ```


<br>

## 




<br>

## 




<br>

## Wrapping up




<br>

Refer:

[ducmanhphan.github.io/2019-01-24-Understanding-about-project-lifecycle-in-Maven](ducmanhphan.github.io/2019-01-24-Understanding-about-project-lifecycle-in-Maven)

[http://maven.apache.org/archetype/maven-archetype-plugin/examples/create-multi-module-project.html](http://maven.apache.org/archetype/maven-archetype-plugin/examples/create-multi-module-project.html)

[http://maven.apache.org/archetype/maven-archetype-plugin/](http://maven.apache.org/archetype/maven-archetype-plugin/)

[https://loda.me/huong-dan-tao-spring-boot-voi-nhieu-modules-bang-gradle-loda1553919997213/](https://loda.me/huong-dan-tao-spring-boot-voi-nhieu-modules-bang-gradle-loda1553919997213/)

<br>

**Build fat jar file**

[http://tutorials.jenkov.com/maven/maven-build-fat-jar.html](http://tutorials.jenkov.com/maven/maven-build-fat-jar.html)