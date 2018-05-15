FROM node:4
MAINTAINER Han Haofu <gtxx3600@gmail.com>

VOLUME /root/.bitcore

COPY ./bitcore-node.json /root/.bitcore/

EXPOSE 8080 8332 18333

RUN apt-get update
RUN apt-get -y install libzmq3-dev
RUN npm install -g bitcore
RUN sed '7 areturn;' -i /usr/local/lib/node_modules/bitcore/node_modules/insight-api/node_modules/bitcore-lib/index.js
ENTRYPOINT [ "bitcored" ]
