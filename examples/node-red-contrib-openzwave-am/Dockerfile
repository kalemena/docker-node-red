FROM kalemena/node-red:latest

RUN \
  apt-get update -y \
# ZWave
  && apt-get install -y \
    build-essential \
    libudev-dev \
    openzwave libopenzwave1.5-dev \
    software-properties-common \
# Cleanup (reduce size)
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ZWAVE https://github.com/OpenZWave/node-openzwave-shared
# RUN git clone https://github.com/OpenZWave/node-openzwave-shared.git
#   openzwave-shared \
#   node-red-contrib-openzwave-am