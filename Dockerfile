from ubuntu:14.04
MAINTAINER Ilya Stepanov <dev@ilyastepanov.com>

RUN apt-get update && \
    apt-get install -y cron && \
    rm -rf /var/lib/apt/lists/*

ADD archive.sh /archive.sh
RUN chmod +x /archive.sh

ADD start.sh /start.sh
RUN chmod +x /start.sh

RUN mkdir /target && mkdir /backup

CMD '/start.sh'
