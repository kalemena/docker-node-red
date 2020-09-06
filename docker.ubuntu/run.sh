#!/bin/bash

cd /home/nodered
# mosquitto&

# nodejs red.js
node $NODE_OPTIONS red.js -v $FLOWS
