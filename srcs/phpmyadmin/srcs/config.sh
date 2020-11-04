mv /root/srcs/telegraf.conf /etc/telegraf.conf
mv phpMyAdmin-5.0.2-all-languages ./www
rm -rf ./www/config.sample.inc.php
mv /root/srcs/config.inc.php ./www

openrc
touch /run/openrc/softlevel
rc-update add telegraf