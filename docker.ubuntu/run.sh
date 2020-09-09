#!/bin/bash

NODERED_FLOWS=${NODERED_FLOWS:-$FLOWS}
NODERED_SETTINGS=${NODERED_SETTINGS:-/home/nodered/.node-red/settings.js}
NODERED_USERDIR=${NODERED_USERDIR:-/home/nodered/.node-red}

# nodejs red.js
node ${NODE_OPTIONS} red.js -v ${NODERED_FLOWS} 

#--settings ${NODERED_SETTINGS} --userDir ${NODERED_USERDIR}
