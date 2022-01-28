FROM kalemena/node-red:2.1.6

USER root

ADD [ "*.yaml", "*.json", "/apis/" ]

RUN cd /opt/node-red \
    && npm install openapi-red

# PetStore
RUN cd /apis \
    && node-red-nodegen http://petstore.swagger.io/v2/swagger.json --category samples \
    && cd node-red-contrib-swagger-petstore \
    && npm link \
    && cd /opt/node-red \
    && npm link node-red-contrib-swagger-petstore \
    && chown -R nodered:nodered /opt/node-red/node_modules/node-red-contrib-swagger-petstore 

# Tock API
RUN cd /apis \
    && api-spec-converter -f openapi_3 -t swagger_2 https://raw.githubusercontent.com/theopenconversationkit/tock/master/bot/connector-web/Swagger_TOCKWebConnector.yaml > tock-api.json \
    && node-red-nodegen tock-api.json --category samples \
    && cd node-red-contrib-tock-web-bot-connector-api \
    && npm link \
    && cd /opt/node-red \
    && npm link node-red-contrib-tock-web-bot-connector-api \
    && chown -R nodered:nodered /opt/node-red/node_modules/node-red-contrib-tock-web-bot-connector-api

RUN cd /opt/node-red \
    && npm install \
        @node-red-tools/node-red-contrib-openapi

USER nodered
