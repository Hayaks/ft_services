FROM alpine:latest

RUN apk update && apk add --no-cache --upgrade bash nginx openrc openssl openssh \
telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

RUN rm -rf /var/cache/apk/*
RUN mkdir -p /var/run/nginx/ && mkdir -p /var/run/sshd

#redirection https
RUN openssl req -x509 -newkey rsa:2048 -nodes -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt -days 365 -subj "/"

#serveur nginx
RUN adduser -D "user42"
RUN echo "user42:password42" | chpasswd
RUN chown -R user42 /var/lib/nginx

COPY srcs/ /root/srcs
COPY srcs/nginx.html /www/index.html

#connexion ssh
RUN ssh-keygen -A
RUN adduser -D "userSSH"
RUN echo "userSSH:passwordSSH" | chpasswd
RUN echo "Welcome to the SSH of ft_services. Have fun!" > /etc/motd

RUN /root/srcs/config.sh

EXPOSE 80 443 22

CMD /root/srcs/setup.sh
