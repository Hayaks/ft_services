FROM alpine:latest

RUN apk add --no-cache --upgrade bash wget openrc nginx \
php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

RUN mkdir -p /run/nginx/ && mkdir -p /var/www/

RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
&& tar -C /var/www/ -xf phpMyAdmin-5.0.2-all-languages.tar.gz && rm -rf phpMyAdmin-5.0.2-all-languages.tar.gz

RUN mkdir -p /var/www/phpmyadmin/tmp && chmod 777 /var/www/phpmyadmin/tmp

COPY srcs/ /root/srcs

RUN /root/srcs/config.sh

EXPOSE 5000

CMD /root/srcs/setup.sh