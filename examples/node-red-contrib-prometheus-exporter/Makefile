
###############################
# Prepare for first time usage
###############################
init:
	cp .env-example .env

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
