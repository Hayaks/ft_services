# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jsaguez <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/12 16:55:22 by jsaguez           #+#    #+#              #
#    Updated: 2020/08/12 17:03:24 by jsaguez          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo "Minikube starting..."
minikube start --cpus=2 --memory=4096 --disk-size=8000mb --vm-driver=docker
minikube addons enable metrics-server
minikube addons enable metallb && sleep 2 && kubectl apply -f ./srcs/metallb.yaml
minikube addons enable dashboard