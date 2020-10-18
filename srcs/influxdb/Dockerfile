FROM alpine:latest

RUN apk add --no-cache bash wget influxdb openrc \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

COPY srcs/script /root/script
COPY srcs/config /root/config

RUN /root/script/config.sh

EXPOSE 8086

CMD /root/script/setup.sh
