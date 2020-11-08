FROM node:12.18.3-alpine3.9

RUN apk add git

RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev && \
    apk add --no-cache --update python && \
    apk add --no-cache --update python3 && \
    pip3 install --upgrade pip setuptools

RUN pip3 install pendulum service_identity

RUN npm install -g @nestjs/cli
RUN npm install -g pm2

RUN npm install -g node-gyp-install
