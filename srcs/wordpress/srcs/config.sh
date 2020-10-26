mv ./root/srcs/telegraf.conf ./etc/telegraf.conf

mkdir -p /www

wget https://wordpress.org/latest.tar.gz \
&& tar -xvf latest.tar.gz \
&& mv wordpress/* /www \
&& rm -rf /var/cache/apk/*

mv ./root/srcs/wp-config.php ./www/

openrc
touch /run/openrc/softlevel
rc-update add telegraf