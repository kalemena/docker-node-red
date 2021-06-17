
###############################
# Prepare for first time usage
###############################
init: images-pull images-build init-influxdb2 init-grafana

images-pull:
	docker-compose pull

images-build:
	docker-compose build

init-influxdb2:
	echo "Initialize: Setup InfluxDB ..."
	# For information only
	mkdir -p etc/influxdb2
	docker run --rm influxdb:2.0.7 influxd print-config > etc/influxdb2/config-default.yml
	cp -n etc/influxdb2/config-default.yml etc/influxdb2/config.yml
	# Volumes
	#docker-compose up -d influxdb2
	#sleep 10s
	#docker-compose influxdb2 down
	
init-grafana:
	echo "Initialize: Setup Grafana ..."
	# mkdir -p var/lib/grafana
	# mkdir -p var/log/grafana

############################
# Manages life cycle
############################
start: 
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down

clean:
	docker-compose down --volumes

############################
# Troubleshoot
############################

logs:
	docker logs -f integration-node-red-contrib-influxdb2_influxdb2_1

