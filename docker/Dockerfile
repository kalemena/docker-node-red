FROM ubuntu:20.04

ARG NODERED_VERSION=2.1.4

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.docker.dockerfile="docker/Dockerfile" \
      org.label-schema.license="MIT" \
      org.label-schema.name="Kalemena Node-RED" \
      org.label-schema.description="Kalemena packaged Node-RED used in home automation" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/kalemena/docker-node-red" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=${NODERED_VERSION} \
      org.label-schema.arch="amd64" \
      org.label-schema.schema-version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

#########
### TOOLS
RUN \
  apt-get update -y \
  && apt-get install -y \
    tzdata \
    git-core \
    wget curl \
    unzip \
    openssl openssh-client ca-certificates \
    build-essential python-dev python3 \
# Node-Red 12+ pre-requisits
  && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get install -y nodejs \
# Cleanup (reduce size)
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
# RUN \
#  npm install -g node-red-nodegen api-spec-converter

RUN npm i \
  node-red-node-serialport \
  node-red-node-ping \
  node-red-contrib-credentials

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