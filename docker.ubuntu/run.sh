#!/bin/bash

NODERED_FLOWS=${NODERED_FLOWS:-$FLOWS}
NODERED_SETTINGS=${NODERED_SETTINGS:-/home/nodered/.node-red/settings.js}
NODERED_USERDIR=${NODERED_USERDIR:-/home/nodered/.node-red}

# Defaulting UserDir
if [[ -d "${NODERED_USERDIR}" ]]
then
    echo "${NODERED_USERDIR} exists."
else
    echo "${NODERED_USERDIR} does not exist => creating ..."
    mkdir -p ${NODERED_USERDIR}
fi

# Defaulting settings.js
if [ -f "${NODERED_SETTINGS}" ]; then
    echo "${NODERED_SETTINGS} exists."
else 
    echo "$NODERED_SETTINGS does not exist => defaulting ..."
    cp /opt/node-red/settings.js ${NODERED_SETTINGS}
fi

# nodejs red.js
node ${NODE_OPTIONS} red.js --settings ${NODERED_SETTINGS} --userDir ${NODERED_USERDIR} -v ${NODERED_FLOWS}