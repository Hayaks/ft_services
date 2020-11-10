/etc/init.d/telegraf start
nginx -t
php -S 0.0.0.0:5000 -t ./www/