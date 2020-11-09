default: build

pull:
	docker pull kalemena/node-red:latest

build: 
	cd docker \
	&& docker pull ubuntu:20.04 \
	&& docker build -t kalemena/node-red:latest -f Dockerfile .
