FROM alpine:latest

RUN apk add --no-cache --upgrade bash openrc mariadb mariadb-client mysql mysql-client \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

COPY srcs/ /root/srcs

EXPOSE 3306

CMD /root/srcs/setup.sh