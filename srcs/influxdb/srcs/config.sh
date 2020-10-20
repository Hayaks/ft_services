mv /root/srcs/telegraf.conf /etc/telegraf.conf

openrc
touch /run/openrc/softlevel
rc-update add telegraf