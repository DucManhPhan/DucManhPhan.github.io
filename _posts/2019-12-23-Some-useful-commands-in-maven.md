---
layout: post
title: Some useful commands in Maven
bigimg: /img/image-header/yourself.jpeg
tags: [Maven]
---

In this article, we will learn how to use some commands in Maven to solve some problems when encountering Java project. Using Maven helps us to concentrate on source code, do not take care about libraries, ... when changing their version. 

Let's get started.

<br>

## Table of contents
- [Creating project](#creating-project)
- [Build project](#build-project)
- [Query commands](#query-commands)
- [Wrapping up](#wrapping-up)

<br>

## Creating project
1. Generate project in batch mode

    A couple of meaningful properties are then required:
    - The ```archetypeGroupId```, ```archetypeArtifactId``` and ```archetypeVersion``` defines the archetype to use for project generation.
    - The ```groupId```, ```artifactId```, ```version``` and ```package``` are the main properties to be set. Each archetype require these properties. Some archetypes define other properties; refer to the appropriate archetype's documentation if needed.

    ```bash
    mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.1 -DgroupId=com.company -DartifactId=project -Dversion=1.0-SNAPSHOT -Dpackage=com.company.project
    ```

    With above command, we are using ```archetype``` plugin that provide the ```archetype:generate``` goal to create a simple project based upon a ```maven-archetype-quickstart``` archetype.

    Plugin is a collection of goals with a general common purpose.

    To create war file, we have to use ```-DarchetypeArtifactId=maven-archetype-webapp```.

    The meaning of some above attributes:

    |              Name              |                  Description                  |
    | ```groupId```                  | Defines a unique base name of the organization or group that created the project. This is normally a reverse domain name. For the generation the groupId also defines the package of the main class. |
    | ```artifactId```               | Defines the unique name of the project. If you generate a new project via Maven this is also used as root folder for the project. |
    | ```packaging```                | Defines the packaging method. This could be e.g. a jar, war or ear file. If the packaging type is pom, Maven does not create anything for this project, it is just meta-data. |
    | ```version```                  | This defines the version of the project. |

    Some common archetypes in Maven:
    - ```maven-archetype-quickstart```: create Java project with sample files.
    - ```maven-archetype-simple```: creates a Java project without sample files.
    - ```maven-archetype-webapp```: create a web app project.

2. Create archetype from existing project

    ```bash
    mvn archetype:create-from-project
    ```

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

## Query commands
1. Show a tree of all dependencies

    ```bash
    mvn dependency tree | less
    ```

    This command is used to resolving dependency-related issues, such as using the wrong versions. It is described in the ```dependency:tree``` goal of the ```maven-dependency-plugin```.

2. Show the relationship between dependencies

    ```bash
    mvn dependency:analyze -DfailOnWarning=true
    ```

    It is used when we want to explicitly declare dependencies, then, we can easily remove unused imports, ...

    For example, how to use dependency plugin in pom file

    ```xml
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-dependency-plugin</artifactId>
        <executions>
            <execution>
                <id>analyze-deps</id>
                <goals>
                    <goal>analyze-only</goal>
                </goals>
            </execution>
        </executions>
    </plugin>
    ```

3. Skip test during a local build

    ```bash
    # skip the running tests (recommneded)
    mvn package -DskipTests=true

    # skip the compilation and running of tests
    mvn package -Dmaven.test.skip=true
    ```

4. Running a specific test

    In this case, we are using the ```maven-surefire-plugin``` that is responsible for running unit tests.

    ```bash
    mvn clean package -Dtest=MyTest#testMethod
    ```

5. Build specific modules in multi-modules project

    ```bash
    mvn clean install -pl <module_name> -am
    ```

    With:
    - ```-pl```: 
    - ```-am```: means ```--also-make``` to tells Maven to build the projects required by the list in ```-pl```.

6. Analyze code quality

    ```bash
    mvn clean install -DskipTests=true
    mvn sonar:sonar
    ```

<br>

## Wrapping up
- By default your version of Maven might use an old version of the ```maven-compiler-plugin``` that is not compatible with Java 9 or later versions. To target Java 9 or later, you should at least use version 3.6.0 of the ```maven-compiler-plugin``` and set the ```maven.compiler.release``` property to the Java release you are targetting (e.g. 9, 10, 11, 12, etc.).

    For example, configure Maven project to use version 3.8.1 of maven-compiler-plugin and target Java 11.

    ```xml
    <properties>
        <maven.compiler.release>11</maven.compiler.release>
    </properties>
 
    <build>
        <pluginManagement>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.8.1</version>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>
    ```


<br>

Refer:

[ducmanhphan.github.io/2019-01-24-Understanding-about-project-lifecycle-in-Maven](ducmanhphan.github.io/2019-01-24-Understanding-about-project-lifecycle-in-Maven)

[http://maven.apache.org/archetype/maven-archetype-plugin/examples/create-multi-module-project.html](http://maven.apache.org/archetype/maven-archetype-plugin/examples/create-multi-module-project.html)

[http://maven.apache.org/archetype/maven-archetype-plugin/](http://maven.apache.org/archetype/maven-archetype-plugin/)

[https://loda.me/huong-dan-tao-spring-boot-voi-nhieu-modules-bang-gradle-loda1553919997213/](https://loda.me/huong-dan-tao-spring-boot-voi-nhieu-modules-bang-gradle-loda1553919997213/)

[https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)

[https://www.educba.com/maven-commands/](https://www.educba.com/maven-commands/)

[https://dzone.com/articles/10-effective-tips-on-using-maven](https://dzone.com/articles/10-effective-tips-on-using-maven)

<br>

**Build fat jar file**

[http://tutorials.jenkov.com/maven/maven-build-fat-jar.html](http://tutorials.jenkov.com/maven/maven-build-fat-jar.html)

[https://maven.apache.org/plugins/index.html](https://maven.apache.org/plugins/index.html)