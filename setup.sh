# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/12 16:55:22 by jsaguez           #+#    #+#              #
#    Updated: 2020/09/10 15:16:36 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

minikube delete
rm -rf ~/.minikube
mkdir -p ~/goinfre/.minikube
ln -s ~/goinfre/.minikube ~/.minikube

:> errlog.txt
:> log.log

echo "Minikube starting..."
minikube start --cpus=2 --memory=3000 --disk-size=8000mb --vm-driver=docker
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