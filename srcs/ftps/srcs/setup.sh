mkdir -p /ftps/admin
adduser -h /ftps/admin -D "admin"

echo "admin:admin" | chpasswd
/etc/init.d/telegraf start
pure-ftpd -j -Y 2 -p 21000:21000 -P "172.17.0.9"