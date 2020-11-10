FROM  wurstmeister/kafka
RUN echo "ssl.keystore.location=/certificates/kafka.keystore" >> /opt/kafka/config/server.properties && \
    echo "ssl.keystore.password=Aa123456!" >> /opt/kafka/config/server.properties && \
    echo "ssl.truststore.location=/certificates/kafka.truststore"  >> /opt/kafka/config/server.properties && \
    echo "ssl.truststore.password=Aa123456!"  >> /opt/kafka/config/server.properties && \
    echo "ssl.key.password=Aa123456!"  >> /opt/kafka/config/server.properties && \
    echo "ssl.client.auth=required"  >> /opt/kafka/config/server.properties

# Authentication
#COPY kafka_jaas.conf /opt/kafka/config/

# Define env vars for authentication
#ENV CUSTOM_INIT_SCRIPT="export KAFKA_OPTS=-Djava.security.auth.login.config=/opt/kafka/config/kafka_jaas.conf"
#ENV KAFKA_OPTS="-Djava.security.auth.login.config=/opt/kafka/config/kafka_jaas.conf"
