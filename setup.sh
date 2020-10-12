# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jsaguez <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/12 16:55:22 by jsaguez           #+#    #+#              #
#    Updated: 2020/10/12 11:09:36 by jsaguez          ###   ########.fr        #
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
	if docker build -t services/$1 srcs/$1/ &> /dev/null 2>>errlog.txt
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
        	
}

#for linux (stop automatic nginx)
FILE=/run/nginx.pid
if [ -e "$FILE" ]; then 
	sudo nginx -s stop
fi

minikube delete
rm -rf ~/.minikube
mkdir -p ~/goinfre/.minikube
ln -s ~/goinfre/.minikube ~/.minikube

:> errlog.txt
:> log.log

echo "Minikube starting..."
minikube start --cpus=2 --memory=3000 --disk-size=8000mb --vm-driver=docker

#if start didn't work then restart minikube
minikube status
if [ "$?" -ne 0 ]; then
	minikube start --cpus=2 --memory=3000 --disk-size=8000mb --vm-driver=docker
fi

minikube addons enable metrics-server
minikube addons enable dashboard

#metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# CONFIGURATION
kubectl apply -f srcs/metallb.yaml

eval $(minikube docker-env)
export MINIKUBE_IP=$(minikube ip)

printf "Building and deploying ftps:\t\t"
docker build -t ftps_alpine ./srcs/ftps > /dev/null 2>>errlog.txt && { printf "[${grn}OK${end}]\n"; kubectl apply -f ./srcs/ftps.yaml >> log.log 2>> errlog.txt; } || printf "[${red}NO${end}]\n"

echo "Server IP : $MINIKUBE_IP"
minikube dashboard