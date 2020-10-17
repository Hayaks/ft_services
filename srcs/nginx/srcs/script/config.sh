mkdir -p /var/run/nginx
mkdir /www

adduser -D -g 'www' www
chown -R www:www /var/lib/nginx /www

openssl req \
	-x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=FR/L=Paris/CN=gsharony" \
	-config /etc/ssl/openssl.cnf \
	-keyout /etc/ssl/private/self-signed.key \
	-out /etc/ssl/certs/self-signed.crt

chmod 600 root/sshd/ssh_host*

rm /etc/nginx/nginx.conf

mv /root/config/nginx.conf /etc/nginx/nginx.conf
mv /root/config/telegraf.conf /etc/telegraf.conf
mv /root/sshd/ssh_host_* /etc/ssh/

openrc
touch /run/openrc/softlevel
rc-update add sshd
rc-update add telegraf

adduser -D "admin"
echo "admin:admin" | chpasswd
