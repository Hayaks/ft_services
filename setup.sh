# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jsaguez <jsaguez@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/12 16:55:22 by jsaguez           #+#    #+#              #
#    Updated: 2021/03/09 11:39:28 by jsaguez          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
Default="\e[0m\n"
end=$'\e[0m'

ft_build()
{
	printf "[${yel}Creation de l'image $1 en cours...${end}]\n"
	if docker build -t $1-image srcs/$1/.
	then
			printf "[${grn}Creation de l'image $1 reussi${end}]\n"
        	sleep 1
	else
	        printf "[${red}Creation de l'image $1 impossible...${end}]\n"
	        exit 1
	fi

	printf "[${yel}Application du yaml $1 en cours...${end}]\n"
	if kubectl apply -f srcs/$1.yaml
	then
        	printf "[${grn}Application du yaml $1 reussi${end}]\n"
        	sleep 1
	else
        	printf "[${red}Application du yaml $1 impossible...${end}]\n"
			exit 1
    fi 	
}

#for linux (stop automatic nginx)
FILE=/run/nginx.pid
if [ -e "$FILE" ]; then 
	sudo nginx -s stop
fi

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo install minikube /usr/local/bin
rm minikube
sudo usermod -aG docker $(whoami)
minikube delete
rm -rf ~/.minikube

:> errlog.txt
:> log.log

echo "Minikube starting..."
minikube start --cpus=2 --memory=3000 --disk-size=8000mb --vm-driver=docker

#if start didn't work then restart minikube
minikube status
if [ "$?" -ne 0 ]; then
	minikube start --cpus=2 --memory=3000 --disk-size=8000mb --vm-driver=docker
fi

eval $(minikube docker-env)

minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb

# CONFIGURATION METALLB
export MINIKUBE_IP=$(minikube ip | grep -oE "\b([0-9]{1,3}\.){3}\b")10

sed -i.bak "s/IPex/"$MINIKUBE_IP"/g" srcs/metallb.yaml
sed -i.bak "s/IPex/"$MINIKUBE_IP"/g" srcs/nginx.yaml
sed -i.bak "s/IPex/"$MINIKUBE_IP"/g" srcs/nginx/srcs/nginx.conf
sed -i.bak "s/IPex/"$MINIKUBE_IP"/g" srcs/nginx/srcs/nginx.html
sed -i.bak "s/IPex/"$MINIKUBE_IP"/g" srcs/wordpress.yaml
sed -i.bak "s/IPex/"$MINIKUBE_IP"/g" srcs/phpmyadmin.yaml
sed -i.bak "s/IPex/"$MINIKUBE_IP"/g" srcs/grafana.yaml
sed -i.bak "s/IPex/"$MINIKUBE_IP"/g" srcs/ftps.yaml
sed -i.bak "s/IPex/"$MINIKUBE_IP"/g" srcs/ftps/srcs/setup.sh

kubectl apply -f srcs/metallb.yaml

# BUILD

ft_build nginx
ft_build mysql
ft_build wordpress
ft_build phpmyadmin
ft_build influxdb
ft_build grafana
ft_build ftps

echo "Server IP : $MINIKUBE_IP"

rm srcs/metallb.yaml && mv srcs/metallb.yaml.bak srcs/metallb.yaml
rm srcs/nginx.yaml && mv srcs/nginx.yaml.bak srcs/nginx.yaml
rm srcs/nginx/srcs/nginx.conf && mv srcs/nginx/srcs/nginx.conf.bak srcs/nginx/srcs/nginx.conf
rm srcs/nginx/srcs/nginx.html && mv srcs/nginx/srcs/nginx.html.bak srcs/nginx/srcs/nginx.html
rm srcs/wordpress.yaml && mv srcs/wordpress.yaml.bak srcs/wordpress.yaml
rm srcs/phpmyadmin.yaml && mv srcs/phpmyadmin.yaml.bak srcs/phpmyadmin.yaml
rm srcs/grafana.yaml && mv srcs/grafana.yaml.bak srcs/grafana.yaml
rm srcs/ftps.yaml && mv srcs/ftps.yaml.bak srcs/ftps.yaml
rm srcs/ftps/srcs/setup.sh && mv srcs/ftps/srcs/setup.sh.bak srcs/ftps/srcs/setup.sh

minikube dashboard