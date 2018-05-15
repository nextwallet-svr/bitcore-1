FROM node:4
MAINTAINER Han Haofu <gtxx3600@gmail.com>

EXPOSE 8080 8332 18333

RUN npm install -g bitcore

ENTRYPOINT [ "bitcored" ]
