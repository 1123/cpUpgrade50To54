SERVERS=kafka-0:9092,kafka-1:9092,kafka-2:9092,kafka-3:9092,kafka-4:9092,kafka-5:9092

confluent-rebalancer execute \
  --bootstrap-server $SERVERS \
  --metrics-bootstrap-server $SERVERS \
  --throttle 100000 --remove-broker-ids 0,1,2

confluent-rebalancer proposed-assignment \
  --bootstrap-server $SERVERS \
  --metrics-bootstrap-server $SERVERS \
  --zookeeper zookeeper:2181

echo '{"topics": [{"topic": "test"}], "version":1 }' > topics-to-move.json

kafka-reassign-partitions \
  --topics-to-move-json-file topics-to-move.json \
  --broker-list "3,4,5" \
  --generate \
  --zookeeper zookeeper:2181

kafka-reassign-partitions \
  --reassignment-json-file reassignment.json \
  --execute \
  --zookeeper zookeeper:2181 \
  --throttle 10000000

kafka-reassign-partitions \
  --reassignment-json-file reassignment.json \
  --verify \
  --zookeeper zookeeper:2181 

