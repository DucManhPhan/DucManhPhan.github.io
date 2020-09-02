---
layout: post
title: How to setup Kafka in Linux
bigimg: /img/path.jpg
tags: [Kafka]
---

In this article, we will learn how to setup Kafka in Ubuntu. Let's get started.

<br>

## Table of contents
- [Environment that Kafka need to work](#environment-that-kafka-need-to-word)
- [Setup Kafka service](#setup-kafka-service)
- [Create producer and consumer to test connection between Kafka cluster and Zookeeper](#create-producer-and-consumer-to-test-connection-between-kafka-cluster-and-zookeeper)
- [Create script file](#create-script-file)
- [Wrapping up](#wrapping-up)

<br>

## Environment that Kafka need to work
- Ubuntu 18.4.0 LTS.

- Use Putty instead of command line of WinSCP.

- kafka_2.11-2.3.1

- The latest version of JDK

    - Download jdk

        ```bash
        sudo apt insall default-jdk

        # hoặc
        sudo apt install default-jre
        ```

    - Check JDK's version in Ubuntu

        Normally, we will find the installed path of JDK with below steps:

        ```bash
        # update databse of ubuntu
        sudo updatedb

        # determine whether jdk is installed
        locate openjdk
        ```

    - Add Path of JDK into ```.bashrc```.

        ```bash
        export JAVA_HOME="usr/lib/jvm/java-11-openjdk-amd64"
        export PATH=$PATH:$JAVA_HOME/bin
        ```

        Cập nhật lại thay đổi trong file ```.bashrc``` file.

        ```bash
        source ~/.bashrc
        ```

<br>

## Setup Kafka service
1. Run zookeeper service

    - Create file ```zookeeper.service``` in Ubuntu's ```systemd```.

        ```bash
        sudo nano /etc/systemd/system/zookeeper.service
        ```

    - Content of ```zookeeper.service``` file.

        ```java
        [Unit]
        Requires=network.target remote-fs.target
        After=network.target remote-fs.target

        [Service]
        Type=simple
        User=root
        ExecStart=/home/kafka/kafka_2.11-2.3.1/bin/zookeeper-server-start.sh /home/kafka/kafka_2.11-2.3.1/config/zookeeper.properties
        ExecStop=/home/kafka/kafka_2.11-2.3.1/bin/zookeeper-server-stop.sh
        Restart=on-abnormal

        [Install]
        WantedBy=multi-user.target
        ```
    
    - Check whether zookeeper server is running.

        ```bash
        # setup net-tools package
        sudo apt-get install net-tools

        # zookeeper server run default at port 2181
        netstat -tulpn | grep 2181

        # stop zookeeper service
        systemctl stop zookeeper

        # if we do not install net-tools package, we can use other way to check
        telnet ip_addr port
        ```

    - Run ```zookeeper.service``` file.

        ```bash
        # run as root user
        sudo su

        # use systemctl
        systemctl start zookeeper

        # run zookeper service automatically when starting system
        systemctl enable zookeeper
        ```


2. Run kafka service

    - Create file ```kafka.service``` in ```systemd``` of Ubuntu.

        ```bash
        sudo nano /etc/systemd/system/kafka.service
        ```

    - Content of ```kafka.service```.

        ```bash
        [Unit]
        Requires=zookeeper.service
        After=zookeeper.service

        [Service]
        Type=simple
        User=root
        ExecStart=/bin/sh -c '/home/kafka/kafka_2.11-2.3.1/bin/kafka-server-start.sh /home/kafka/kafka_2.11-2.3.1/config/server.properties > /home/kafka/kafka_2.11-2.3.1/kafka-logs/kafka-service-log.txt 2>&1'
        ExecStop=/home/kafka/kafka_2.11-2.3.1/bin/kafka-server-stop.sh
        Restart=on-abnormal

        [Install]
        WantedBy=multi-user.target
        ```

    - Check whether kafka server is running.

        ```bash
        # setup net-tools package
        sudo apt-get install net-tools

        # zookeeper server  run default at port 9092
        netstat -tulpn | grep 9092

        # stop zookeeper service
        systemctl stop kafka
        ```

    - Run ```kafka.service```.

        ```bash
        # run as root user
        sudo su

        # use systemctl
        systemctl start kafka

        # run kafka service automatically when starting system
        systemctl enable kafka
        ```

3. Remove services that have status is failed

    ```bash
    sudo systemctl reset-failed

    # or
    systemctl disable service_name
    rm /etc/systemd/system/service_name
    systemctl daemon-reload
    ```

<br>

## Create producer and consumer to test connection between Kafka cluster and Zookeeper
1. Create test topic

    ```bash
    # create test topic
    bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test

    # check whether the test topic is created or not
    bin/kafka-topics.sh --list --zookeeper localhost:2181
    ```

2. Create producer

    ```bash
    bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
    ```

3. Create consumer

    ```bash
    bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic test
    ```

<br>

## Create script file

    ```bash
    sudo nano start.sh

    # fill content for start.sh file
    sudo systemctl reload-or-restart zookeeper.service
    sudo systemctl reload-or-restart kafka.service
    ```

<br>

## Operations for consumer groups
1. List all consumer groups across all topics

    ```bash
    bin/kafka-consumer-groups.sh --list --bootstrap-server localhost:9092
    ```

2. Show information about specific consumer group

    ```bash
    bin/kafak-consumer-groups.sh --describe --bootstrap-server localhost:9092 --group group_name
    ```

3. Delete specific consumer group

    ```bash
    bin/kafka-consumer-groups.sh --delete --bootstrap-server localhost:9092 --group group_name
    ```

<br>

## Operations for topics
1. List all topics

    ```bash
    bin/kafka-topics.sh --list --zookeeper localhost:2181
    ```

2. Create new topic
    
    - First way, use ```kafka-topics.sh```

        ```bash
        bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
        ```

    - Second way, create new topic with specific consumer group name based on kafka-console-consumer.sh

        ```bash
        # 1. create a new consumer.properties file, such as consumer1.properties
        
        # 2. change group.id=new_group_name in consumer1.properties file

        # 3. run below command
        bin/kafka-console-consumer.sh --new-consumer --bootstrap-server localhost:9092 --topic topic_name --from-beginning --consumer.config config/consumer1.properties --delete-consumer-offsets
        ```

    - Other way

        ```bash
        # or other way
        bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --group test-consumer --topic test --from-beginning
        ```

3. Delete specific topic

    - First, we can use ```kafka-topics.sh``` to delete topic. But it only marks specific topic with ```marked for deletion```.

        ```bash
        # In server.properties, set below the property
        delete.topic.enable=true

        # Then, use kafka-topics.sh to delete
        bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic topic_name
        ```

    - Second, delete topic completely.

        ```bash
        # Use Zookeeper CLI console to check whether topic will be deleted
        get /brokers/topics/topic_name

        # delete
        rmr /brokers/topics/topic_name
        rmr /admin/delete_topics/topic_name
        ```

<br>

## Wrapping up
- Understanding about how many steps to run kafka.
- Take care of commands about consumer groups, topics, producer.

<br>

Refer:

[https://kafka.apache.org/documentation/#basic_ops_consumer_group](https://kafka.apache.org/documentation/#basic_ops_consumer_group)

[https://stackoverflow.com/questions/33537950/how-to-delete-a-topic-in-apache-kafka](https://stackoverflow.com/questions/33537950/how-to-delete-a-topic-in-apache-kafka)

[https://jaceklaskowski.gitbooks.io/apache-kafka/kafka-topic-deletion.html](https://jaceklaskowski.gitbooks.io/apache-kafka/kafka-topic-deletion.html)

**Install Kafka for common service in Ubuntu**

[https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units)

[https://www.digitalocean.com/community/tutorials/how-to-install-apache-kafka-on-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-apache-kafka-on-ubuntu-18-04)

[https://www.letscloud.io/community/how-install-apache-kafka-ubuntu-18-04](https://www.letscloud.io/community/how-install-apache-kafka-ubuntu-18-04)