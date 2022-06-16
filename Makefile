default: build

pull:
	docker pull kalemena/node-red:latest

build: 
	cd docker \
	&& docker build --pull -t kalemena/node-red:latest -f Dockerfile .

test:
	cd examples/node-red-node-suncalc && $(MAKE) build && $(MAKE) start