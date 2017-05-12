# docker-node-red

Packaged Node-Red for use in home automation.

Runs both mosquitto as MQTT bus and node-red with few plugins like rfxtrx com.

## Build

> $ docker build -t kalemena/node-red .

## Run

Expose ports 1880 (node-red) and 1883 (mqtt).

Mount volumes for your flows into /data using -v, and environment variable FLOWS pointing to the flows.json file. 

Attach your USB devices using --device.

> docker run --restart=always --name nodered --hostname nodered \
	-d -p 1880:1880 -p 1883:1883 \
	-v ./data:/data \
	--device=/dev/ttyUSB0:/dev/ttyRfxTrx \
	--device=/dev/ttyUSB1:/dev/ttyJeeLink \
	--device=/dev/ttyUSB2:/dev/ttyCurrenCost \
	-e FLOWS=/data/flows.json \
	kalemena/node-red

## Run with compose

Run with opening 1880 and 1883 ports, and map your flows into /data directory.

Optionaly, map USB devices used in flows.

```json
version: '2'
 services:  
  nodered:
   image: kalemena/node-red
   build: .
   restart: always
   ports:
    - "1880:1880"
    - "1883:1883"
   volumes:
    - ./data:/data
   devices:
    - "/dev/ttyUSB0:/dev/ttyCurrenCost"
    - "/dev/ttyUSB1:/dev/ttyJeeLink"
    - "/dev/ttyUSB2:/dev/ttyRfxTrx"
   environment:
    - FLOWS=/data/flows.json
```

### Start node-red

> $ docker-compose up -d

Now you can connect on http://your host:1880

### Stop node-red

> $ docker-compose stop

### Remove container node-red

> $ docker-compose down

