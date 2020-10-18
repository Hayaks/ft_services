FROM alpine:latest

RUN apk add --no-cache bash wget php7 openrc --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

RUN wget https://dl.grafana.com/oss/release/grafana-6.6.0.linux-amd64.tar.gz \
&& tar -zxvf grafana-6.6.0.linux-amd64.tar.gz \
&& mv grafana-6.6.0 grafana

COPY srcs/script /root/script
COPY srcs/config /root/config
COPY srcs/files /root/files

RUN /root/script/config.sh

EXPOSE 3000

CMD /root/script/setup.sh
