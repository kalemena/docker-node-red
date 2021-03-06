FROM ubuntu:20.04

MAINTAINER Kalemena

ARG NODERED_VERSION=1.3.5

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

ENV DEBIAN_FRONTEND=noninteractive

#########
### TOOLS
RUN \
  apt-get update -y \
  && apt-get install -y \
    tzdata \
# Node-Red pre-requisits
    nodejs npm \
    git-core \
    wget curl \
    unzip \
# ZWave
    build-essential \
    libudev-dev \
    openzwave libopenzwave1.5-dev \
    software-properties-common \
# Cleanup (reduce size)
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# BUG with npm < 4 ==> https://github.com/npm/npm/issues/9863
RUN npm install -g npm@5.1.0

#########
### NODE-RED
RUN \
  mkdir -p /opt \
  && cd /opt \
  && wget https://github.com/node-red/node-red/releases/download/${NODERED_VERSION}/node-red-${NODERED_VERSION}.zip \
  && unzip node-red-${NODERED_VERSION}.zip \
  && rm /opt/node-red-${NODERED_VERSION}.zip \
  && cd /opt/node-red \
  && npm install --production \
# formatted flows
  && sed -i 's+//flowFilePretty: .*+flowFilePretty: true,+g' settings.js

WORKDIR /opt/node-red

### NODE RED MODULES
RUN \
  npm install -g node-red-nodegen api-spec-converter

RUN npm i \
      node-red-node-serialport \
      node-red-node-ping \
      node-red-node-suncalc \
      node-red-contrib-simpletime \
      node-red-contrib-credentials \
# ZWAVE https://github.com/OpenZWave/node-openzwave-shared
# RUN git clone https://github.com/OpenZWave/node-openzwave-shared.git
#      openzwave-shared \
      node-red-contrib-openzwave-am
    
EXPOSE 1880

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  && dpkg-reconfigure tzdata

ENV FLOWS=/data/flows.json

#########
### USER nodered
RUN useradd -ms /bin/bash -u 1000 nodered \
  && chown -R nodered:nodered /opt/node-red \
  && usermod -a -G dialout nodered

# Default rights to /data
RUN mkdir /data \
  && chown nodered:nodered /data

USER nodered

ADD [ "run.sh", "/run.sh" ]

# no ENTRYPOINT
CMD [ "bash", "/run.sh" ]