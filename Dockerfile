FROM nurzazin/nest-kafka:builder AS builder

WORKDIR /apps

COPY . /apps

RUN npm install

RUN npm run build
RUN mv dist dist-tmp

RUN npm run build user
RUN cp -rv dist-tmp/apps/api-gateway/ dist/apps/ && rm -rfv dist-tmp
RUN ls -alth
RUN ls -alth dist

CMD ["pm2-runtime", "ecosystem.config.js"]
