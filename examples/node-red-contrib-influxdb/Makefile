
###############################
# Prepare for first time usage
###############################
init: images-pull images-build init-influxdb init-grafana

images-pull:
	docker-compose pull

images-build:
	docker-compose build

init-influxdb:
	mkdir -p var/lib/influxdb/meta
	mkdir -p etc/influxdb
	# generates a default config (to be customized if needed)
	docker run --rm influxdb influxd config | tee etc/influxdb/influxdb.conf > /dev/null
	touch var/lib/.influx_history
	# Imports schema (if available)
	docker run --rm \
		--user 1000:1000 \
		-e INFLUXDB_HTTP_AUTH_ENABLED=true \
        -e INFLUXDB_ADMIN_USER=default \
        -e INFLUXDB_ADMIN_PASSWORD=password \
        -v $(CURDIR)/var/lib/influxdb:/var/lib/influxdb \
        -v $(CURDIR)/etc/influxdb/scripts:/docker-entrypoint-initdb.d \
        influxdb /init-influxdb.sh

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