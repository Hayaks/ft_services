mv /root/srcs/telegraf.conf /etc/telegraf.conf

/root/srcs/database.sh > /dev/null 2>&1 &

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld/

openrc
touch /run/openrc/softlevel
rc-update add telegraf

/etc/init.d/telegraf start
mysql_install_db --user=root --datadir="/var/lib/mysql"
/usr/bin/mysqld --user=root
