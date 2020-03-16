FROM centos:7

MAINTAINER Kalemena

ARG NODERED_VERSION=1.0.4

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

# TOOLS
RUN \
  yum install -y epel-release \
  && yum update -y \
  && curl -sL https://rpm.nodesource.com/setup_10.x | bash - \
  && yum update -y \
# workaround for https://bugs.centos.org/view.php?id=13669&nbn=1
# && rpm -ivh https://kojipkgs.fedoraproject.org//packages/http-parser/2.7.1/3.el7/x86_64/http-parser-2.7.1-3.el7.x86_64.rpm \
# NodeJS
  && yum install -y nodejs \
# build tools
  && yum install -y \
    git-core \
    python \
    wget \
    unzip \
    which \
  && yum groupinstall -y "Development Tools" \
  && npm install -g grunt-cli

# NODE RED
RUN \
  mkdir -p /home; cd /home \
  && wget https://github.com/node-red/node-red/releases/download/${NODERED_VERSION}/node-red-${NODERED_VERSION}.zip \
  && unzip node-red-${NODERED_VERSION}.zip \
  && rm /home/node-red-${NODERED_VERSION}.zip \
  && cd /home/node-red \
  && npm install --production
  
WORKDIR /home/node-red

RUN \
  npm install -g node-red-nodegen

# NODE RED MODULES
RUN \
  npm i node-red-node-serialport \
    node-red-node-ping \
    node-red-node-suncalc \
    node-red-contrib-simpletime \
    node-red-contrib-credentials

EXPOSE 1880

ENV TZ=Europe/Paris
ENV FLOWS=/data/flows.json

RUN sed -i 's+//flowFilePretty: .*+flowFilePretty: true,+g' settings.js

ADD run.sh /run.sh

CMD ["bash", "/run.sh"]
