default: build

run: build
	docker-compose up -d
	
build: 
	cd docker.ubuntu; docker pull ubuntu:18.04; docker build -t kalemena/node-red -f Dockerfile .
