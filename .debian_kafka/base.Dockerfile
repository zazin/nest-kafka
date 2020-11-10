FROM debian:10

RUN apt-get update && apt-get install default-jre default-jdk -y

RUN useradd kafka -m && adduser kafka sudo

USER kafka

WORKDIR /home/kafka

RUN mkdir ~/kafka

COPY kafka_2.13-2.6.0.tgz /home/kafka/kafka/

WORKDIR /home/kafka/kafka

RUN tar -xvzf kafka_2.13-2.6.0.tgz --strip 1

USER root
