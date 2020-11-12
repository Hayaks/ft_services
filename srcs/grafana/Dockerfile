FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash wget openrc --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

RUN wget https://dl.grafana.com/oss/release/grafana-6.6.0.linux-amd64.tar.gz \
&& tar -zxvf grafana-6.6.0.linux-amd64.tar.gz \
&& mv grafana-6.6.0 grafana

COPY srcs/ /root/srcs

RUN /root/srcs/config.sh

EXPOSE 3000

CMD /root/srcs/setup.sh
