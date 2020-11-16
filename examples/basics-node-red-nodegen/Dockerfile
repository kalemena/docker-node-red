FROM kalemena/node-red:latest

USER root

ADD [ "*.yaml", "/apis/" ]

# PetStore
RUN cd /apis \
    && node-red-nodegen http://petstore.swagger.io/v2/swagger.json --category samples \
    && cd node-red-contrib-swagger-petstore \
    && npm link \
    && cd /opt/node-red \
    && npm link node-red-contrib-swagger-petstore \
    && chown -R nodered:nodered /opt/node-red/node_modules/node-red-contrib-swagger-petstore 


USER nodered
