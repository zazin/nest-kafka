FROM kafka_custom:base

#RUN ls -alth /home/kafka/kafka/config

#COPY system/kafka.service /etc/systemd/system/
#COPY system/zookeeper.service /etc/systemd/system/

COPY docker-entrypoint.sh /home/kafka/
RUN chmod +x /home/kafka/docker-entrypoint.sh

WORKDIR /home/kafka

USER kafka

#EXPOSE 2181
EXPOSE 9092

CMD sh docker-entrypoint.sh

#CMD '/home/kafka/kafka/bin/zookeeper-server-start.sh /home/kafka/kafka/config/zookeeper.properties'
#CMD /bin/sh -c '/home/kafka/kafka/bin/kafka-server-start.sh /home/kafka/kafka/config/server.properties > /home/kafka/kafka/kafka.log 2>&1'

#RUN useradd zk -m
#RUN usermod --shell /bin/bash zk
#RUN usermod -aG sudo zk
#RUN mkdir -p /data/zookeeper
#RUN chown zk:zk /data/zookeeper
#WORKDIR /opt
#COPY apache-zookeeper-3.6.2-bin.tar.gz /opt
#RUN tar -xvf apache-zookeeper-3.6.2-bin.tar.gz
#RUN mv apache-zookeeper-3.6.2-bin zookeeper
#RUN chown zk:zk -R zookeeper
#COPY config/zoo.cfg /opt/zookeeper/conf/
#WORKDIR /opt/zookeeper
#RUN bin/zkServer.sh start
