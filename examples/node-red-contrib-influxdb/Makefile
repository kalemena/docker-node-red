
###############################
# Prepare for first time usage
###############################
init: images-pull images-build init-influxdb init-grafana

images-pull:
	docker-compose pull

images-build:
	docker-compose build

init-influxdb:
	mkdir -p $(CURDIR)/var/lib/influxdb
	# mkdir -p $(CURDIR)/etc/influxdb/scripts
	# generates a default config (to be customized if needed)
	docker run --rm influxdb influxd config | tee etc/influxdb/influxdb.conf > /dev/null
	touch var/lib/.influx_history
	# Imports schema (if available)
	docker run --rm \
		--user 1000:1000 \
		-e INFLUXDB_HTTP_AUTH_ENABLED=true \
        -e INFLUXDB_ADMIN_USER=admin \
        -e INFLUXDB_ADMIN_PASSWORD=password \
		-e INFLUXDB_USER=default \
	   	-e INFLUXDB_USER_PASSWORD=password \
		-v $(CURDIR)/var/lib/influxdb:/var/lib/influxdb \
        -v $(CURDIR)/etc/influxdb/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
		-v $(CURDIR)/etc/influxdb/scripts:/docker-entrypoint-initdb.d \
        influxdb /init-influxdb.sh
	# -e INFLUXDB_DB=db0

init-grafana:
	mkdir -p var/lib/grafana
	mkdir -p var/log/grafana

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