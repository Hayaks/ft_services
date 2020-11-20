until mysql
do
	&> /dev/null
done
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "CREATE USER 'adminWP'@'%' IDENTIFIED BY 'adminWP';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'adminWP'@'%' WITH GRANT OPTION;" | mysql -u root --skip-password
mysql -u root wordpress < /root/srcs/wordpress.sql