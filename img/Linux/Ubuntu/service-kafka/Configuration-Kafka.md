## Môi trường
- Ubuntu 18.4.0 LTS

- Sử dụng Putty thay cho command line của WinSCP

- kafka_2.11-2.3.1

- JDK mới nhất

    - Download jdk

        ```bash
        sudo apt insall default-jdk

        # hoặc
        sudo apt install default-jre
        ```

    - Check version của JDK trong Ubuntu

        Hiện tại, khi sử dụng các command trên, tìm path của jdk như sau:

        ```bash
        # update databse of ubuntu
        sudo updatedb

        # determine whether jdk is installed
        locate openjdk
        ```

    - Add Path của JDK vào trong ```.bashrc```.

        ```bash
        export JAVA_HOME="usr/lib/jvm/java-11-openjdk-amd64"
        export PATH=$PATH:$JAVA_HOME/bin
        ```

        Cập nhật lại thay đổi trong file ```.bashrc```:

        ```bash
        source ~/.bashrc
        ```

<br>

## Setup cho Kafka service
1. Chạy zookeeper service

    - Tạo file ```zookeeper.service``` trong systemd của Ubuntu.

        ```bash
        sudo nano /etc/systemd/system/zookeeper.service
        ```

    - Tạo nội dung của ```zookeeper.service```.

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
    
    - Check zookeeper server đã chạy như service trong server chưa.

        ```bash
        # cài đặt net-tools package
        sudo apt-get install net-tools

        # zookeeper server mặc định chạy ở port 2181
        netstat -tulpn | grep 2181

        # stop zookeeper service
        systemctl stop zookeeper
        ```

    - Run zookeeper.service.

        ```bash
        # run as root user
        sudo su

        # use systemctl
        systemctl start zookeeper

        # run zookeper service automatically when starting system
        systemctl enable zookeeper
        ```


2. Chạy kafka service

    - Tạo file ```kafka.service``` trong ```systemd``` của Ubuntu.

        ```bash
        sudo nano /etc/systemd/system/kafka.service
        ```

    - Tạo nội dung của ```kafka.service```.

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

    - Check kafka server đã chạy như service trong server chưa.

        ```bash
        # cài đặt net-tools package
        sudo apt-get install net-tools

        # zookeeper server mặc định chạy ở port 9092
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

3. Xóa các service mà có status là failed

    ```bash
    sudo systemctl reset-failed

    # or
    systemctl disable service_name
    rm /etc/systemd/system/service_name
    systemctl daemon-reload
    ```

<br>

## Test
1. Tạo topic test

    ```bash
    # create test topic
    bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test

    # check whether the test topic is created or not
    bin/kafka-topics.sh --list --zookeeper localhost:2181
    ```

2. Tạo producer

    ```bash
    bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
    ```

3. Tạo consumer

    ```bash
    bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic test
    ```

<br>

## Tạo script file

    ```bash
    sudo nano start.sh

    # fill content for start.sh file
    sudo systemctl reload-or-restart zookeeper.service
    sudo systemctl reload-or-restart kafka.service
    ```