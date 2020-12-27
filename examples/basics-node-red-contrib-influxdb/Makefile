
###############################
# Prepare for first time usage
###############################
init: images-pull images-build init-influxdb init-grafana

images-pull:
	docker-compose pull

images-build:
	docker-compose build

init-influxdb:
	echo "Initialize: Setup InfluxDB ..."
	# For information only
	mkdir -p etc/influxdb
	docker run --rm influxdb influxd config | tee etc/influxdb/influxdb-default.conf > /dev/null
	cp -n etc/influxdb/influxdb-default.conf etc/influxdb/influxdb.conf
	# Volumes
	# mkdir -p var/lib/influxdb
	# touch var/lib/.influx_history
	# Initialize DB (done through first run)
	docker-compose up -d influxdb
	sleep 10s
	docker-compose down
	# docker run --rm \
	# 	--user 1000:1000 \
	# 	-e INFLUXDB_HTTP_AUTH_ENABLED=true \
    #     -e INFLUXDB_ADMIN_USER=default \
    #     -e INFLUXDB_ADMIN_PASSWORD=password \
    #     -v $(CURDIR)/var/lib/influxdb:/var/lib/influxdb \
    #     -v $(CURDIR)/etc/influxdb/scripts:/docker-entrypoint-initdb.d \
    #     influxdb /init-influxdb.sh
	
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