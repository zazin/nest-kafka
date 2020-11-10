FROM nurzazin/kafka:base

WORKDIR /home/kafka

USER kafka

EXPOSE 2181

CMD /bin/sh -c '/home/kafka/kafka/bin/zookeeper-server-start.sh /home/kafka/kafka/config/zookeeper.properties'
