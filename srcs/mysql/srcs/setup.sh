mv /root/srcs/telegraf.conf /etc/telegraf.conf

until mysql
do
	&> /dev/null
done
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'%' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "DROP DATABASE test" | mysql -u root --skip-password
mysql -u root --skip-password < /root/srcs/wordpress.sql

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld/

openrc
touch /run/openrc/softlevel
rc-update add telegraf

/etc/init.d/telegraf start
mysql_install_db --user=root --datadir="/var/lib/mysql"
/usr/bin/mysqld --user=root