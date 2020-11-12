FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash openrc \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

COPY srcs/ /root/srcs

RUN /root/srcs/config.sh

EXPOSE 20 21 21000

CMD /root/srcs/setup.sh