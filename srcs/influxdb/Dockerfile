FROM    alpine:latest

RUN     apk add --no-cache --upgrade bash wget influxdb

COPY    setup.sh .

EXPOSE	8086

CMD	    ./setup.sh