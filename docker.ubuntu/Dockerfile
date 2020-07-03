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

# TOOLS
RUN \
  apt-get update -y \
  && apt-get install -y \
    nodejs npm \
    git-core \
    wget \
    unzip \
    build-essential \
    libudev-dev;

# apt-get clean && \
# 	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get install -y \
    openzwave libopenzwave1.5-dev \
    software-properties-common

WORKDIR /root

RUN npm install openzwave-shared

ADD [ "test2.js", "/root/" ]

# RUN git clone https://github.com/OpenZWave/node-openzwave-shared.git


#   && curl -sL https://rpm.nodesource.com/setup_10.x | bash - \
#   && yum update -y \
# # workaround for https://bugs.centos.org/view.php?id=13669&nbn=1
# # && rpm -ivh https://kojipkgs.fedoraproject.org//packages/http-parser/2.7.1/3.el7/x86_64/http-parser-2.7.1-3.el7.x86_64.rpm \
# # NodeJS
#   && yum install -y nodejs \
# # build tools
#   && yum install -y \
#     git-core \
#     python \
#     which \
#   && yum groupinstall -y "Development Tools" \
#   && npm install -g grunt-cli

# RUN \
#     git-core \
#     python-software-properties python \
#     g++ make software-properties-common \
#     wget unzip; \
#   yum group install "Development Tools"; \
#   ln -s /usr/bin/nodejs /usr/bin/node; \
#   npm install -g grunt-cli;  
  
# RUN \
#   mkdir -p /home; cd /home; \
#   wget https://github.com/node-red/node-red/releases/download/${NODERED_VERSION}/node-red-${NODERED_VERSION}.zip; \
#   unzip node-red-${NODERED_VERSION}.zip; \
#   rm /home/node-red-${NODERED_VERSION}.zip; \
#   mv /home/node-red-${NODERED_VERSION} /home/node-red; \
#   cd /home/node-red; \
#   npm install --production;

# WORKDIR /home/node-red
  
# RUN \
#   npm install node-red-contrib-rfxcom; \
#   npm install node-red-node-openweathermap; \
#   npm install node-red-node-ping;

# RUN \
# #  yum install -y http://mirror.my-ho.st/Downloads/OpenZWave/CentOS_7/x86_64/libopenzwave-1.4.164-2.1.x86_64.rpm; \
# #  yum install -y http://mirror.my-ho.st/Downloads/OpenZWave/CentOS_7/x86_64/openzwave-1.4.164-2.1.x86_64.rpm; \
#   cd /home; \
#   wget https://github.com/OpenZWave/open-zwave/archive/V1.5.zip; unzip V1.5.zip; rm V1.5.zip; \
#   cd open-zwave-1.5; \
#   apt-get install -y libudev-dev net-tools; \
#   make && make install; \
#   cd /home/node-red; \
#   npm install node-red-contrib-openzwave;
       
# EXPOSE 1880 1883

# ENV TZ=Europe/Paris
# ENV FLOWS=/data/flows.json

# ADD run.sh /run.sh

# CMD ["bash", "/run.sh"]
