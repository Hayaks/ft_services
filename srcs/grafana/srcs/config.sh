mv /root/srcs/telegraf.conf /etc/telegraf.conf

openrc
touch /run/openrc/softlevel
rc-update add telegraf

cd /grafana
mkdir data

mv /root/srcs/grafana.db /grafana/data/

chmod +x /root/srcs/setup.sh