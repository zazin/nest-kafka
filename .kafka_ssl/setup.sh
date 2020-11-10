#!/bin/bash

################################## Set Variables ##############################
CLUSTER_NAME_1=broker1  # Alias name (3 private name of the 3 brokers)
CLUSTER_NAME_2=broker2
CLUSTER_NAME_3=broker3
CLUSTER_IP=192.168.18.60 # Public IP, Change if needed
BASE_DIR=/tmp/kafka # Path
CERT_OUTPUT_PATH="$BASE_DIR/certificates" # certificates path
PASSWORD=Aa123456! # password
KEY_STORE_1="$CERT_OUTPUT_PATH/kafka.keystore"   # Kafka keystore path
TRUST_STORE="$CERT_OUTPUT_PATH/kafka.truststore" # Kafka truststore path
KEY_PASSWORD=$PASSWORD # keystore password
STORE_PASSWORD=$PASSWORD # keystore password
TRUST_KEY_PASSWORD=$PASSWORD  # truststore key password
TRUST_STORE_PASSWORD=$PASSWORD # truststore store password
CERT_AUTH_FILE="$CERT_OUTPUT_PATH/ca-cert" # CA path
CLUSTER_CERT_FILE="$CERT_OUTPUT_PATH/kafka-cert" # Cluster certificate path
DAYS_VALID=730 # Key vaild days
DNAME_1="CN=broker1, OU=Company, O=Company, L=Singapore, ST=Singapore, C=SG" 
DNAME_2="CN=broker2, OU=Company, O=Company, L=Singapore, ST=Singapore, C=SG"
DNAME_3="CN=broker3, OU=Company, O=Company, L=Singapore, ST=Singapore, C=SG" # distinguished name
##############################################################################

mkdir -p $CERT_OUTPUT_PATH

echo "1. Creating keystore......"
keytool -keystore $KEY_STORE_1 -alias $CLUSTER_NAME_1 -validity $DAYS_VALID -genkey -keyalg RSA \
-storepass $STORE_PASSWORD -keypass $KEY_PASSWORD -dname "$DNAME_1" 
keytool -keystore $KEY_STORE_1 -alias $CLUSTER_NAME_2 -validity $DAYS_VALID -genkey -keyalg RSA \
-storepass $STORE_PASSWORD -keypass $KEY_PASSWORD -dname "$DNAME_2" 
keytool -keystore $KEY_STORE_1 -alias $CLUSTER_NAME_3 -validity $DAYS_VALID -genkey -keyalg RSA \
-storepass $STORE_PASSWORD -keypass $KEY_PASSWORD -dname "$DNAME_3" 

echo "2. Creating CA......"
openssl req -new -x509 -keyout $CERT_OUTPUT_PATH/ca-key -out "$CERT_AUTH_FILE" -days "$DAYS_VALID" \
-passin pass:"$PASSWORD" -passout pass:"$PASSWORD" \
-subj "/C=SG/ST=Singapore/L=Singapore/O=Company/CN=Company"
echo "3. Import CA to truststore......"
keytool -keystore "$TRUST_STORE" -alias CARoot \
-import -file "$CERT_AUTH_FILE" -storepass "$TRUST_STORE_PASSWORD" -keypass "$TRUST_KEY_PASS" -noprompt

echo "4. Export Certificate Request file from keystore......"
keytool -keystore "$KEY_STORE_1" -alias "$CLUSTER_NAME_1" -certreq -file "$CLUSTER_CERT_FILE"_1 -storepass "$STORE_PASSWORD" -keypass "$KEY_PASSWORD" -noprompt -ext "SAN=DNS:broker1,DNS:broker2,DNS:broker3,IP:$CLUSTER_IP"

keytool -keystore "$KEY_STORE_1" -alias "$CLUSTER_NAME_2" -certreq -file "$CLUSTER_CERT_FILE"_2 -storepass "$STORE_PASSWORD" -keypass "$KEY_PASSWORD" -noprompt -ext "SAN=DNS:broker1,DNS:broker2,DNS:broker3,IP:$CLUSTER_IP"

keytool -keystore "$KEY_STORE_1" -alias "$CLUSTER_NAME_3" -certreq -file "$CLUSTER_CERT_FILE"_3 -storepass "$STORE_PASSWORD" -keypass "$KEY_PASSWORD" -noprompt -ext "SAN=DNS:broker1,DNS:broker2,DNS:broker3,IP:$CLUSTER_IP"

echo "5. Sign Certifiate by CA......"
openssl x509 -req -CA "$CERT_AUTH_FILE" -CAkey $CERT_OUTPUT_PATH/ca-key -in "$CLUSTER_CERT_FILE"_1 \
-out "${CLUSTER_CERT_FILE}_1-signed" \
-CAcreateserial \
-extfile ./openssl.cnf -extensions v3_req \
-days "$DAYS_VALID" -CAcreateserial -passin pass:"$PASSWORD"

openssl x509 -req -CA "$CERT_AUTH_FILE" -CAkey $CERT_OUTPUT_PATH/ca-key -in "$CLUSTER_CERT_FILE"_2 \
-out "${CLUSTER_CERT_FILE}_2-signed" \
-CAcreateserial \
-extfile ./openssl.cnf -extensions v3_req \
-days "$DAYS_VALID" -CAcreateserial -passin pass:"$PASSWORD"

openssl x509 -req -CA "$CERT_AUTH_FILE" -CAkey $CERT_OUTPUT_PATH/ca-key -in "$CLUSTER_CERT_FILE"_3 \
-out "${CLUSTER_CERT_FILE}_3-signed" \
-CAcreateserial \
-extfile ./openssl.cnf -extensions v3_req \
-days "$DAYS_VALID" -CAcreateserial -passin pass:"$PASSWORD"

echo "6. Import CA to keystore......"
keytool -keystore "$KEY_STORE_1" -alias CARoot_1 -import -file "$CERT_AUTH_FILE" -storepass "$STORE_PASSWORD" \
 -keypass "$KEY_PASSWORD" -noprompt

echo "7. Import Signed Certificates to keystore......"
keytool -keystore "$KEY_STORE_1" -alias "${CLUSTER_NAME_1}" -import -file "${CLUSTER_CERT_FILE}_1-signed" \
 -storepass "$STORE_PASSWORD" -keypass "$KEY_PASSWORD" -noprompt
 
keytool -keystore "$KEY_STORE_1" -alias "${CLUSTER_NAME_2}" -import -file "${CLUSTER_CERT_FILE}_2-signed" \
 -storepass "$STORE_PASSWORD" -keypass "$KEY_PASSWORD" -noprompt
 
keytool -keystore "$KEY_STORE_1" -alias "${CLUSTER_NAME_3}" -import -file "${CLUSTER_CERT_FILE}_3-signed" \
 -storepass "$STORE_PASSWORD" -keypass "$KEY_PASSWORD" -noprompt
