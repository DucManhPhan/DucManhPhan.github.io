---
layout: post
title: Understanding about Kafka
bigimg: /img/path.jpg
tags: [Kafka]
---




<br>

## Table of contents
- [The definition of Kafka and Zookeeper](#the-definition-of-kafka-and-zookeeper)
- [Structure of Kafka and Zookeeper](#structure-of-kafka-and-zookeeper)
- [The meaning of parameters in consumer](#the-meaning-of-parameters-in-consumer)
- [Coordinator in Kafka](#coordination-in-kafka)
- [Rebalancing in kafka](#rebalancing-in-kafka)
- [Heartbeat thread in Kafka](#heartbeat-thread-in-kafka)
- [Some problems when running kafka](#some-problems-when-using-kafka)
- [Wrapping up](#wrapping-up)

<br>

## The definition of Kafka and Zookeeper
According to [wikipedia.com](https://en.wikipedia.org/wiki/Apache_Kafka), we have:

```
Apache Kafka is an open-source stream processing software platform developed by Linkedln and donated to the 

```

<br>

## Structure of Kafka and Zookeeper






<br>

## The meaning of parameters in consumer 





<br>

## Coordinator in Kafka

[https://jaceklaskowski.gitbooks.io/apache-kafka/kafka-consumer-internals-ConsumerCoordinator.html](https://jaceklaskowski.gitbooks.io/apache-kafka/kafka-consumer-internals-ConsumerCoordinator.html)


<br>

## Rebalancing in kafka




<br>

## Heartbeat thread in Kafka




<br>

## Thread-safty with consumer
According to [https://www.oreilly.com/library/view/kafka-the-definitive/9781491936153/ch04.html](https://www.oreilly.com/library/view/kafka-the-definitive/9781491936153/ch04.html), we have:

```
You can't have multiple consumers that belong to the same group in one thread and you can't have multiple threads safely use the same consumer. One consumer per thread is the rule. To run multiple consumers in the same group in one application, you will need to run each in its own thread. It is useful to wrap the consumer logic in its own object and then use Java's ExecutorService to start multiple threads each with its own consumer. The Confluent blog has a tutorial that shows how to do just that.
```


<br>

## Some problems when running kafka
1. ```attempt to heartbeat failed since group is rebalancing```

[https://stackoverflow.com/questions/40162370/heartbeat-failed-for-group-because-its-rebalancing](https://stackoverflow.com/questions/40162370/heartbeat-failed-for-group-because-its-rebalancing)


<br>

## Wrapping up




<br>

Refer:

[https://linuxhint.com/install-apache-kafka-ubuntu/](https://linuxhint.com/install-apache-kafka-ubuntu/)

[https://www.coretechnologies.com/products/AlwaysUp/Apps/RunApacheKafkaAsAWindowsService.html](https://www.coretechnologies.com/products/AlwaysUp/Apps/RunApacheKafkaAsAWindowsService.html)

[https://kafka.apache.org/quickstart](https://kafka.apache.org/quickstart)

[http://kafka.apache.org/intro](http://kafka.apache.org/intro)

[https://chrzaszcz.dev/2019/05/26/kafka-101/](https://chrzaszcz.dev/2019/05/26/kafka-101/)

<br>

**Hearbeat thread**

[http://javierholguera.com/2018/01/01/timeouts-in-kafka-clients-and-kafka-streams/](http://javierholguera.com/2018/01/01/timeouts-in-kafka-clients-and-kafka-streams/)

[https://stackoverflow.com/questions/39730126/difference-between-session-timeout-ms-and-max-poll-interval-ms-for-kafka-0-10-0/39759329#39759329](https://stackoverflow.com/questions/39730126/difference-between-session-timeout-ms-and-max-poll-interval-ms-for-kafka-0-10-0/39759329#39759329)

[https://devguli.com/heartbeat-thread-in-kafka-consumer/](https://devguli.com/heartbeat-thread-in-kafka-consumer/)

[https://cwiki.apache.org/confluence/display/KAFKA/KIP-62%3A+Allow+consumer+to+send+heartbeats+from+a+background+thread](https://cwiki.apache.org/confluence/display/KAFKA/KIP-62%3A+Allow+consumer+to+send+heartbeats+from+a+background+thread)

[https://chrzaszcz.dev/2019/06/kafka-heartbeat-thread/](https://chrzaszcz.dev/2019/06/kafka-heartbeat-thread/)

[https://stackoverflow.com/questions/40162370/heartbeat-failed-for-group-because-its-rebalancing](https://stackoverflow.com/questions/40162370/heartbeat-failed-for-group-because-its-rebalancing)

<br>

**Rebalancing**

[https://stackoverflow.com/questions/43991845/kafka10-1-heartbeat-interval-ms-session-timeout-ms-and-max-poll-interval-ms](https://stackoverflow.com/questions/43991845/kafka10-1-heartbeat-interval-ms-session-timeout-ms-and-max-poll-interval-ms)

[https://www.slideshare.net/ConfluentInc/everything-you-always-wanted-to-know-about-kafkas-rebalance-protocol-but-were-afraid-to-ask-matthias-j-sax-confluent-kafka-summit-london-2019](https://www.slideshare.net/ConfluentInc/everything-you-always-wanted-to-know-about-kafkas-rebalance-protocol-but-were-afraid-to-ask-matthias-j-sax-confluent-kafka-summit-london-2019)