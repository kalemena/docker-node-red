#!/bin/bash

NODERED_FLOWS=${NODERED_FLOWS:-$FLOWS}
NODERED_SETTINGS=${NODERED_SETTINGS:-/home/nodered/.node-red/settings.js}
NODERED_USERDIR=${NODERED_USERDIR:-/home/nodered/.node-red}
NODERED_CREDENTIAL_SECRETS=${NODERED_CREDENTIAL_SECRETS:-}

# Defaulting UserDir
if [[ -d "${NODERED_USERDIR}" ]]
then
    echo "NODERED_USERDIR=${NODERED_USERDIR} exists."
else
    echo "NODERED_USERDIR=${NODERED_USERDIR} does not exist => creating ..."
    mkdir -p ${NODERED_USERDIR}
fi

# Defaulting settings.js
if [ -f "${NODERED_SETTINGS}" ]; then
    echo "NODERED_SETTINGS=${NODERED_SETTINGS} exists."
else 
    echo "NODERED_SETTINGS=$NODERED_SETTINGS does not exist => defaulting ..."
    cp /opt/node-red/settings.js ${NODERED_SETTINGS}
fi

# Setup credentials
if [ -n "${NODERED_CREDENTIAL_SECRETS}" ]; then
  echo "NODERED_CREDENTIAL_SECRETS specified => setting up ..."
  sed -i 's+//credentialSecret: .*+credentialSecret: process.env.NODERED_CREDENTIAL_SECRETS,+g' ${NODERED_SETTINGS}
else
  echo "NODERED_CREDENTIAL_SECRETS not specified"
fi

# nodejs red.js
node ${NODE_OPTIONS} red.js --settings ${NODERED_SETTINGS} --userDir ${NODERED_USERDIR} -v ${NODERED_FLOWS}