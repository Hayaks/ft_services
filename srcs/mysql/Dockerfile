FROM alpine:latest

RUN apk add --no-cache --upgrade bash mariadb mariadb-client mysql mysql-client openrc \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

COPY srcs/ /root/srcs

RUN /root/srcs/config.sh

EXPOSE 3306

CMD /root/srcs/setup.sh