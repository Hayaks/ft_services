mv /root/srcs/telegraf.conf /etc/telegraf.conf
mv ./root/srcs/config.inc.php /var/www/phpmyadmin/
mv ./root/srcs/default.conf /etc/nginx/conf.d/default.conf

openrc
touch /run/openrc/softlevel
rc-update add telegraf