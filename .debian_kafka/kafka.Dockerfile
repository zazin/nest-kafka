FROM nurzazin/kafka:base

WORKDIR /home/kafka

USER kafka

EXPOSE 9092

CMD /bin/sh -c '/home/kafka/kafka/bin/kafka-server-start.sh /home/kafka/kafka/config/server.properties'
