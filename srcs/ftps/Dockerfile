FROM alpine:latest

RUN apk add --no-cache --upgrade bash openrc \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

COPY srcs/script /root/script
COPY srcs/config /root/config
COPY srcs/files /root/files

RUN /root/script/config.sh

EXPOSE 21 21000

CMD /root/script/setup.sh