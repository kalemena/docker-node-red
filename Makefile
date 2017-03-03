default: build

run: build
	docker run --restart=always --name nodered --hostname nodered \
		-d -p 1880:1880 -p 1883:1883 \
		-v ./data:/data \
		--device=/dev/ttyUSB0:/dev/ttyRfxTrx \
		--device=/dev/ttyUSB1:/dev/ttyJeeLink \
		--device=/dev/ttyUSB2:/dev/ttyCurrenCost \
		kalemena/node-red
	
build: Dockerfile.centos
	docker build -t kalemena/node-red -f Dockerfile.centos .
