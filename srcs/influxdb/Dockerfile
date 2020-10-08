FROM    alpine:latest

RUN     apk add --no-cache bash influxdb

COPY    setup.sh .

EXPOSE	8086

CMD	    ./setup.sh