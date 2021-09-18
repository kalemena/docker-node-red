###############################
# Prepare for first time usage
###############################

init: images-pull images-build init-env init-grafana

images-pull:
	docker-compose pull

images-build:
	docker-compose build

init-env:
	cp .env-example .env

init-grafana:
	echo "Initialize: Setup Grafana ..."
	# mkdir -p var/lib/grafana
	# mkdir -p var/log/grafana

############################
# Manages life cycle
############################
build:
	docker-compose build

start: 
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down

clean:
	docker-compose down --volumes
