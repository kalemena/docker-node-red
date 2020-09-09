default: build

pull:
	docker pull kalemena/node-red:latest

build: 
	cd docker.ubuntu \
	&& docker pull ubuntu:18.04 \
	&& docker build -t kalemena/node-red:latest -f Dockerfile .

up: 
	docker-compose up -d

stop: 
	docker-compose stop

down:
	docker-compose down -v
