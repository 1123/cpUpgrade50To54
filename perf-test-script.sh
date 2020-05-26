kafka-topics --zookeeper zookeeper:2181 --create --topic test --partitions 12 --replication-factor 3

kafka-producer-perf-test --producer-props bootstrap.servers=kafka-1:9092,kafka-2:9092,kafka-3:9092,kafka-4:9092,kafka-5:9092 --topic test --throughput 10 --num-records 10000000 --record-size 10
