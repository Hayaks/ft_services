# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/12 16:55:22 by jsaguez           #+#    #+#              #
#    Updated: 2020/10/17 18:33:37 by user42           ###   ########.fr        #
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
	if docker build -t $1-image srcs/$1/. &> /dev/null 2>>errlog.txt
	then
			printf "[${grn}Creation de l'image $1 reussi${end}]\n"
        	sleep 1
	else
	        printf "[${red}Creation de l'image $1 impossible...${end}]\n"
	        exit 1
	fi

	printf "[${yel}Application du yaml $1 en cours...${end}]\n"
	if kubectl apply -f srcs/$1.yaml &> /dev/null 2>>errlog.txt
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

#metallb
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# On first install only
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# CONFIGURATION
kubectl apply -f srcs/metallb.yaml

export MINIKUBE_IP=$(minikube ip)

ft_build nginx
ft_build influxdb
ft_build grafana
ft_build ftps

echo "Server IP : $MINIKUBE_IP"
minikube dashboard