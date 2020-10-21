rm /etc/nginx/nginx.conf

mv /root/srcs/nginx.conf /etc/nginx/nginx.conf
mv /root/srcs/telegraf.conf /etc/telegraf.conf

openrc
touch /run/openrc/softlevel
rc-update add telegraf