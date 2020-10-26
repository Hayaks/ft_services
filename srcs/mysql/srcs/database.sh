#!/bin/bash
until mysql
do
	&> /dev/null
done
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'%' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "DROP DATABASE test" | mysql -u root --skip-password
mysql -u root --skip-password < /root/srcs/wordpress.sql