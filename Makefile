default: build

up: 
	docker-compose up -d

stop: 
	docker-compose stop

down:
	docker-compose down -v
	
build: 
	cd docker.ubuntu; docker pull ubuntu:18.04; docker build -t kalemena/node-red -f Dockerfile .
