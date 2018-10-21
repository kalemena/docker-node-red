#!/bin/bash

cd /home/node-red
# mosquitto&

# nodejs red.js
node $NODE_OPTIONS red.js -v $FLOWS
