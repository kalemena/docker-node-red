default: build

run: build
	docker-compose up -d
	
build: Dockerfile.centos
	docker pull centos:7
	docker build -t kalemena/node-red -f Dockerfile.centos .
