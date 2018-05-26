FROM node:4.8.7-slim
MAINTAINER Han Haofu <gtxx3600@gmail.com>

VOLUME /root/.bitcore/data

#COPY ./bitcore-node.json /root/.bitcore/
COPY ./bitcore-node/bitcore-node.template.json /root/.bitcore/
COPY ./bitcore-node/bitcore-node-entrypoint.sh /root/

EXPOSE 8080 8332 18333

RUN apt-get update
RUN apt-get -y install libzmq3-dev wget jq gettext-base g++ libzmq3 make python
RUN npm install -g bitcore
RUN sed '7 areturn;' -i /usr/local/lib/node_modules/bitcore/node_modules/insight-api/node_modules/bitcore-lib/index.js

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb && \
  dpkg -i dumb-init_*.deb

RUN apt-get purge -y \
  g++ make python gcc && \
  apt-get autoclean && \
  apt-get autoremove -y && \
  rm -rf \
  /dumb-init_*.deb \
  /root/.npm \
  /root/.node-gyp \
  /tmp/* \
  /var/lib/apt/lists/*

ENV BITCOIN_LIVENET 1
ENV API_ROUTE_PREFIX "api"
ENV UI_ROUTE_PREFIX ""

ENV API_CACHE_ENABLE 1

ENV API_LIMIT_ENABLE 0
ENV API_LIMIT_WHITELIST "127.0.0.1 ::1"
ENV API_LIMIT_BLACKLIST ""

ENV API_LIMIT_COUNT 10800
ENV API_LIMIT_INTERVAL 10800000

ENV API_LIMIT_WHITELIST_COUNT 108000
ENV API_LIMIT_WHITELIST_INTERVAL 10800000

ENV API_LIMIT_BLACKLIST_COUNT 0
ENV API_LIMIT_BLACKLIST_INTERVAL 10800000

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/root/bitcore-node-entrypoint.sh"]