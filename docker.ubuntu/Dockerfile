FROM ubuntu:18.04

MAINTAINER Kalemena

ARG NODERED_VERSION=1.1.2

 # Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena NodeRed" \
      org.label-schema.description="Kalemena NodeRed for use in home automation" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/docker-node-red" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=$NODERED_VERSION \
      org.label-schema.schema-version="1.0"

#########
### TOOLS
RUN \
  apt-get update -y \
  && apt-get install -y \
# Node-Red pre-requisits
    nodejs npm \
    git-core \
    wget \
    unzip \
# ZWave
    build-essential \
    libudev-dev \
    openzwave libopenzwave1.5-dev \
    software-properties-common \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#########
### NODE-RED
RUN \
  mkdir -p /home \
  && cd /home \
  && wget https://github.com/node-red/node-red/releases/download/${NODERED_VERSION}/node-red-${NODERED_VERSION}.zip \
  && unzip node-red-${NODERED_VERSION}.zip \
  && rm /home/node-red-${NODERED_VERSION}.zip \
  && cd /home/node-red \
  && npm install --production \
# formatted flows
  && sed -i 's+//flowFilePretty: .*+flowFilePretty: true,+g' settings.js

WORKDIR /home/node-red

### NODE RED MODULES
RUN \
  npm install -g node-red-nodegen

RUN npm i \
      node-red-node-serialport \
      node-red-node-ping \
      node-red-node-suncalc \
      node-red-contrib-simpletime \
      node-red-contrib-credentials  

### ZWAVE
# https://github.com/OpenZWave/node-openzwave-shared
# RUN git clone https://github.com/OpenZWave/node-openzwave-shared.git
# WARNING: folder workaround docker to enable next build !
RUN mkdir /tmp/node.install \
    && cd /tmp/node.install \
    && npm i \
#      openzwave-shared \
      node-red-contrib-openzwave-am \
    && cp -r node_modules /home/node-red/ \
    && rm -rf node_modules
    
# ADD [ "test2.js", "/root/" ]

EXPOSE 1880

ENV TZ=Europe/Paris
ENV FLOWS=/data/flows.json

ADD [ "run.sh", "/run.sh" ]
CMD ["bash", "/run.sh"]
