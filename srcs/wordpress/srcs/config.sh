mv ./root/srcs/telegraf.conf ./etc/telegraf.conf

mkdir -p /var/www/wordpress

wget https://wordpress.org/latest.tar.gz \
&& tar -xvf latest.tar.gz \
&& rm -rf latest.tar.gz \
&& chmod 755 -R /wordpress

mv ./root/srcs/wp-config.php /wordpress/wp-config.php

openrc
touch /run/openrc/softlevel
rc-update add telegraf