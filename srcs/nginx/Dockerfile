FROM alpine:latest

RUN apk add --no-cache --upgrade bash nginx openrc openssl openssh telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

COPY srcs/script /root/script
COPY srcs/config /root/config
COPY srcs/sshd /root/sshd

RUN /root/script/config.sh

EXPOSE 80 443 22

CMD /root/script/setup.sh
