FROM ubuntu:18.04

MAINTAINER Kalemena

ARG NODERED_VERSION=1.1.0

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
  mkdir -p /home; cd /home; \
  wget https://github.com/node-red/node-red/releases/download/${NODERED_VERSION}/node-red-${NODERED_VERSION}.zip; \
  unzip node-red-${NODERED_VERSION}.zip; \
  rm /home/node-red-${NODERED_VERSION}.zip; \
  mv /home/node-red-${NODERED_VERSION} /home/node-red; \
  cd /home/node-red; \
  npm install --production;

WORKDIR /home/node-red

# https://github.com/OpenZWave/node-openzwave-shared
# RUN git clone https://github.com/OpenZWave/node-openzwave-shared.git
RUN npm i \
      openzwave-shared \
# workaround docker
  && mv ./node_modules ./node_modules.tmp \
  && mv ./node_modules.tmp ./node_modules \
  && npm i \
      node-red-contrib-openzwave-am

ADD [ "test2.js", "/root/" ]
      
EXPOSE 1880 1883

ENV TZ=Europe/Paris
ENV FLOWS=/data/flows.json

ADD [ "run.sh", "/run.sh" ]
CMD ["bash", "/run.sh"]
