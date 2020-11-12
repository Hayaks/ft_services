apk add wget openssl /root/srcs/pure-ftpd.apk

mv /root/srcs/telegraf.conf /etc/telegraf.conf

openssl req -x509 \
	-nodes \
	-days 7300 \
	-newkey rsa:2048 \
	-subj "/C=FR/ST=FR/L=Paris/CN=jsaguez" \
	-keyout /etc/ssl/private/pure-ftpd.pem \
	-out /etc/ssl/private/pure-ftpd.pem

chmod 744 /etc/ssl/private/pure-ftpd.pem

openrc
touch /run/openrc/softlevel
rc-update add telegraf