bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic test