FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash mysql openrc nginx \
php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib \
php7-curl php7-mbstring php7-json php7-session \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

RUN mkdir -p /run/nginx/

COPY srcs/ /root/srcs

RUN /root/srcs/config.sh

EXPOSE 5050

CMD /root/srcs/setup.sh