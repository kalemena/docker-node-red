FROM ubuntu:16.04

ARG NODERED_VERSION=0.15.2

RUN \
  apt-get update; apt-get upgrade -y; \
  apt-get install -y \
    nodejs npm \
    mosquitto \
    git-core \
    python-software-properties python \
    g++ make software-properties-common \
    wget unzip; \
  ln -s /usr/bin/nodejs /usr/bin/node; \
  npm install -g grunt-cli;
  
RUN \
  mkdir -p /home; cd /home; \
  wget https://github.com/node-red/node-red/releases/download/${NODERED_VERSION}/node-red-${NODERED_VERSION}.zip; \
  unzip node-red-${NODERED_VERSION}.zip; \
  rm /home/node-red-${NODERED_VERSION}.zip; \
  mv /home/node-red-${NODERED_VERSION} /home/node-red; \
  cd /home/node-red; \
  npm install --production;

WORKDIR /home/node-red
  
RUN \
  npm install node-red-contrib-rfxcom; \
  npm install node-red-node-openweathermap; \
  npm install node-red-node-ping;
        
EXPOSE 1880 1883

ENV TZ=Europe/Paris
ENV FLOWS=/data/flows.json

ADD run.sh /run.sh

CMD ["bash", "/run.sh"]
